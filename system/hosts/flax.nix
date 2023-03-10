# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ suites
, lib
, config
, pkgs
, ...
}: {
  imports =
    suites.base;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "flax"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #networking.networkmanager.enable = true;

  #networking.wireless.dbusControlled=true;
  #networking.wireless.enable = true;
  services.connman.enable = true;
  services.connman.wifi.backend = "wpa_supplicant";
  environment.etc."wpa_supplicant.conf".text =
    lib.mkIf config.services.connman.enable
      ''
        # dummy config file; config controls `wpa_supplicant` through dbus, but the NixOS `wpa_supplicant` module is currently nevertheless configured to expect a `/etc/wpa_supplicant.conf`.
        # see <NixOS/nixpkgs#212347>
      '';
  #networking.wireless.interfaces = ["wlp170s0"];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "workman";
    xkbOptions = "ctrl:nocaps,altwin:swap_alt_win";
    libinput = {
      enable = true;
      touchpad.accelProfile = "flat";
      mouse.accelProfile = "flat";
    };

    displayManager = {
      defaultSession = "none+xsession";
      session = [
        {
          name = "xsession";
          manage = "window";
          start = "";
        }
      ];
      lightdm = {
        enable = true;
        greeters.mini = {
          user = "kiwi";
          enable = true;
          extraConfig = ''
            [greeter]
            show-password-label = false
            [greeter-theme]
            background-image = ""
            background-image-size = cover
          '';
        };
      };
    };
  };

  users.mutableUsers = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
