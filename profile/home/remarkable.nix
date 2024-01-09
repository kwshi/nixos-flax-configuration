{
  config,
  pkgs,
  ...
}: let
  sshKeyPath = "${config.home.homeDirectory}/.ssh/keys/remarkable";

  rmviewSettings = {
    # https://github.com/bordaigorl/rmview#configuration-files
    backend = "screenshare";
    orientation = "portrait";
    forward_mouse_events = true;
    ssh = {
      auth_method = "key";
      address = "10.11.99.1";
      key = "${sshKeyPath}-rsa";

      # there's a number of issues with rmview's ssh handling for now: (1)
      # when specifying a key it hard-codes using RSA keys [1], which leads to
      # a "Invalid key type (public key part)" error when using my ed25519
      # keys; our workaround for now is to generate a separate RSA key just
      # for this to work. ok, fine. (2) on the other hand if I don't want to
      # do this and instead prefer to rely on `~/.ssh/config` settings and
      # other related advantages (e.g. custom host names), allegedly this is
      # achieved by omitting the key path [3], but it definitely didn't work
      # for me, and it seems like general support for `~/.ssh/config` is
      # indeed missing [4].

      # a little bit of digging suggests that the root issue is attributable
      # to `paramiko`, which is the Python library that `rmview` uses for SSH
      # authentication. from skimming the source code and following error
      # tracebacks (with `auth_method="key"` and no key path specified, we get
      # a "No authentication methods available" error) it seems like this
      # arises from `paramiko` not _actually_ handling `~/.ssh/config` at all,
      # but rather relying on some hacky detection tricks (e.g. searching for
      # hard-coded key paths at `~/.ssh/id_{rsa,dsa,ecdsa,ed25519}`) [5],
      # which is very much _not_ how my keys are located. purportedly the
      # documentation also says that we can go through an SSH agent, so maybe
      # that's another valid workaround. but it takes extra setup to get the
      # agent running, which I currently don't have the bandwidth for, so I'm
      # going with the RSA key workaround. also, there is ongoing discussion
      # about how "terribad" the SSH key handling logic is [4], so a real fix
      # is maybe in the works.

      # [1]: https://github.com/bordaigorl/rmview/blob/c254ab17dc261bd8ae859759e0b5344f3fcf4415/src/rmview/connection.py#L85
      # [2]: https://github.com/bordaigorl/rmview/issues/139
      # [3]: https://github.com/bordaigorl/rmview/issues/118#issuecomment-994886646
      # [4]: https://github.com/paramiko/paramiko/issues/387
      # [5]: https://github.com/paramiko/paramiko/blob/43980e7e4f700f78100e80c45a59b7d383af0b7b/paramiko/client.py#L652-L673
    };
  };
  #rmview = (rmview.overridePythonAttrs (_: rec {
  #  version = "3.1.3";
  #  src = pkgs.fetchFromGitHub {
  #    owner = "bordaigorl";
  #    repo = "rmview";
  #    rev = "v${version}";
  #    sha256 = "sha256-V26zmu8cQkLs0IMR7eFO8x34McnT3xYyzlZfntApYkk=";
  #  };
  #}))
in {
  # notes here: https://todo.sr.ht/~kwshi/personal/23
  home.packages = with pkgs; [
    rmview
    rmapi
    (writeShellScriptBin "rmview-landscape" ''
      rmview '${config.xdg.configHome}/rmview/rmview-landscape.json'
    '')
  ];

  home.sessionVariables = {
    RMVIEW_CONF = "${config.xdg.configHome}/rmview/rmview.json";
  };

  xdg.configFile = {
    "rmview/rmview.json".text = builtins.toJSON rmviewSettings;
    "rmview/rmview-landscape.json".text = builtins.toJSON (rmviewSettings // {orientation = "landscape";});
  };

  programs.ssh.matchBlocks."remarkable" = {
    # https://unix.stackexchange.com/questions/61655/multiple-similar-entries-in-ssh-config
    host = "remarkable 10.11.99.1";
    user = "root";
    hostname = "10.11.99.1";
    identityFile = "${sshKeyPath}-rsa";
  };
}
