{
  config,
  pkgs,
  ...
}: let
  sshKeyPath = "${config.home.homeDirectory}/.ssh/keys/remarkable";
in {
  # notes here: https://todo.sr.ht/~kwshi/personal/23
  home.packages = with pkgs; [
    remarkable
    rmview
    rmapi
  ];

  home.sessionVariables = {
    RMVIEW_CONF = "${config.xdg.configHome}/rmview/rmview.json";
  };

  xdg.configFile = {
    "rmview/rmview.json".text = builtins.toJSON {
      # https://github.com/bordaigorl/rmview#configuration-files
      backend = "screenshare";
      orientation = "portrait";
      forward_mouse_events = true;
      ssh = {
        auth_method = "key";
        #address = "10.11.99.1";
        #key = sshKeyPath;
      };
    };
  };

  programs.ssh.matchBlocks."remarkable" = {
    # https://unix.stackexchange.com/questions/61655/multiple-similar-entries-in-ssh-config
    host = "remarkable 10.11.99.1";
    user = "root";
    hostname = "10.11.99.1";
    identityFile = sshKeyPath;
  };
}
