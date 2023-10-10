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
    nixvim = {
      url = "github:nix-community/nixvim";
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
    hyprland.url = "github:hyprwm/Hyprland/v0.28.0";
  };

  outputs = inputs:
    let
      lib = import ./lib inputs.nixpkgs.lib;
      profiles = lib.crawl ./system/profiles;
      common-modules = [
        inputs.agenix.nixosModules.age
        inputs.home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
            })
            inputs.fenix.overlays.default
          ];
        }
        {
          nix = {
            extraOptions = ''
              extra-experimental-features = flakes nix-command
            '';

            settings = {
              substituters = [ "https://hyprland.cachix.org" ];
              trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
            };
          };

          home-manager.extraSpecialArgs = rec {
            ks = lib;
            profiles = lib.crawl ./home/profiles;
          };

          home-manager.sharedModules = [
            inputs.hyprland.homeManagerModules.default
          ];
        }
      ];
    in
    {
      nixosConfigurations.maki = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          common-modules
          ++ [
            ./system/hosts/maki.nix
            ./hw-maki.nix
            ./home/users/kiwi-maki.nix
          ];
      };

      nixosConfigurations.flax = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          common-modules
          ++ [
            ./hardware-configuration.nix
            ./system/hosts/flax.nix
            ./home/users/kiwi.nix
            {
              home-manager.extraSpecialArgs = rec {
                ks = lib;
                espanso-extra = { inherit (inputs) espanso-latex; };
                profiles = lib.crawl ./home/profiles;
                suites = {
                  base = [
                    profiles.vscode
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
              # plugin-files = ${
              #     inputs.nixpkgs.legacyPackages.x86_64-linux.nix-plugins.override
              #     { nix = config.nix.package; }}/lib/nix/plugins/libnix-extra-builtins.so
              #
            })
            { imports = [ ./age.nix ]; }
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
              profiles.printing
              profiles.jupyter
              profiles.dconf
              profiles.udisks2
              profiles.greetd
              profiles.home-manager
            ];
          };
        };
      };
      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
}
