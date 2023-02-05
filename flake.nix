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

  outputs = inputs: {
    nixosConfigurations.flax = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      ({nixpkgs.overlays = [(final: prev: {unstable=inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;})];})
        inputs.home-manager.nixosModules.home-manager
        ./hardware-configuration.nix
        ./system/hosts/flax.nix
        ./home/users/kshi.nix
        {
          home-manager.useGlobalPkgs= true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            suites = {
              base = [
                ./home/profiles/misc.nix
                ./home/profiles/bat.nix
                ./home/profiles/neovim
                ./home/profiles/rofi.nix
                ./home/profiles/gh.nix
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
      specialArgs = {
        suites = {base = [./system/profiles/binbash.nix ./system/profiles/console.nix];};
      };
    };
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
