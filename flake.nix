{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    digga = {
      url = "github:divnix/digga/v0.11.0";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    agenix = {
      url = "github:ryantm/agenix/0.13.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    espanso-latex = {
      url = "github:zoenglinghou/espanso-latex";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let lib = import ./lib inputs.nixpkgs.lib; in
    {
      nixosConfigurations.flax = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.agenix.nixosModules.age
          ({
            nixpkgs.overlays = [
              (final: prev: {
                unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
              })
              inputs.fenix.overlays.default
            ];
          })
          ({

            #nixpkgs.config.permittedInsecurePackages = [
            #  "openssl-1.1.1u"
            #];

          })
          inputs.home-manager.nixosModules.home-manager
          ./hardware-configuration.nix
          ./system/hosts/flax.nix
          ./home/users/kiwi.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = rec {
              ks = lib;
              #fenix = inputs.fenix;
              espanso-extra = { inherit (inputs) espanso-latex; };
              profiles = lib.crawl ./home/profiles;
              suites = {
                base = [
                  profiles.sagemath
                  profiles.eww
                  profiles.misc
                  profiles.bat
                  profiles.neovim
                  profiles.rofi
                  profiles.python
                  profiles.github
                  profiles.zathura
                  profiles.firefox
                  profiles.git
                  profiles.pass
                  profiles.btop
                  profiles.alacritty
                  profiles.starship
                  profiles.user-dirs
                  profiles.gammastep
                  profiles.espanso
                  profiles.bash
                  profiles.exa
                  profiles.thunderbird
                  profiles.fonts
                  profiles.gpg
                  profiles.ime
                  profiles.mpv
                  profiles.jq
                  profiles.octave
                  profiles.xournalpp
                  profiles.java
                  profiles.theme
                  profiles.mathematica
                  profiles.udiskie
                  profiles.waybar
                  profiles.foot
                  profiles.river
                  profiles.qtile
                  profiles.rust
                  profiles.safeeyes
                  profiles.haskell
                ];
              };
            };
          }
          ({ config, ... }: {
            nix.extraOptions = ''
              extra-experimental-features = flakes nix-command
            '';

            # plugin-files = ${
            #     inputs.nixpkgs.legacyPackages.x86_64-linux.nix-plugins.override
            #     { nix = config.nix.package; }}/lib/nix/plugins/libnix-extra-builtins.so
            # 
          })
          ({ imports = [ ./age.nix ]; })
        ];
        specialArgs = rec {
          profiles = lib.crawl ./system/profiles;
          suites = {
            base = [
              profiles.lightdm
              profiles.binbash
              profiles.console
              profiles.geoclue
              profiles.light
              profiles.steam
              profiles.pipewire
              profiles.podman
              profiles.docker
              profiles.printing
              profiles.jupyter
              profiles.dconf
              profiles.udisks2
              profiles.greetd
            ];
          };
        };
      };
      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
}
