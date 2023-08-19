{ config, pkgs, ... }:
let kernels = import ./kernels.nix pkgs; in
{
  services.jupyter = {
    enable = true;
    port = 9181;
    password = "open(${builtins.toJSON config.age.secrets.jupyter.path},'r',encoding='utf8').read().strip()";
    notebookDir = "~/notebook";
    inherit kernels;
  };

  users.extraUsers.jupyter.group = "jupyter";

  services.jupyterhub = {
    jupyterhubEnv = pkgs.python3.withPackages (pyPkgs: with pyPkgs; [
      jupyterhub
      jupyterhub-systemdspawner
    ]);

    # https://github.com/NixOS/nixpkgs/pull/235828
    # https://discourse.nixos.org/t/how-to-work-with-broken-jupyterhub-package-service/29663
    enable = false;
    port = 9182;
    inherit kernels;
  };
} // (
  let
    serverConfig = pkgs.writeText "jupyter_server_config.py" ''
      c.ServerApp.password = open(
        ${builtins.toJSON config.age.secrets.jupyter.path},
        'r',
        encoding='utf8'
      ).read().strip()
    '';
  in
  {
    systemd.services.jupyter-lab = {
      description = "jupyter lab server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.bash ];

      environment = {
        JUPYTER_PATH = toString (pkgs.jupyter-kernel.create {
          definitions = kernels;
        });
      };

      serviceConfig = {
        Restart = "always";
        ExecStart = ''
          ${pkgs.python3Packages.jupyterlab}/bin/jupyter-lab \
            --no-browser \
            --ip=localhost \
            --port=9180 \
            --notebook-dir='~/notebook' \
            --ServerApp.config_file='${serverConfig}'
        '';
        User = "jupyter";
        Group = "jupyter";
        WorkingDirectory = "~";
      };
    };

    system.activationScripts.makeJupyterNotebookDir = pkgs.lib.stringAfter [ "var" ] ''
      mkdir -p '${config.users.users.jupyter.home}/notebook'
      chown jupyter:jupyter '${config.users.users.jupyter.home}/notebook'
    '';
  }
)
