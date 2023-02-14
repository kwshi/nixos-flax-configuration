{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
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
  };

  outputs = inputs:
    let lib = import ./lib inputs.nixpkgs.lib; in
    {
      nixosConfigurations.flax = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ nixpkgs.overlays = [ (final: prev: { unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux; }) ]; })
          inputs.home-manager.nixosModules.home-manager
          ./hardware-configuration.nix
          ./system/hosts/flax.nix
          ./home/users/kiwi.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = rec {
              profiles = lib.crawl ./home/profiles;
              suites = {
                base = [
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
                ];
              };
            };
          }
          {
            nix.extraOptions = ''
              extra-experimental-features = flakes nix-command
            '';
          }
        ];
        specialArgs = rec {
          profiles = lib.crawl ./system/profiles;
          suites = {
            base = [
              profiles.binbash
              profiles.console
            ];
          };
        };
      };
      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
}
