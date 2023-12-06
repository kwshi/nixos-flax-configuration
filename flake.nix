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
      url = "github:ryantm/agenix/0.14.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    espanso-latex = {
      url = "github:zoenglinghou/espanso-latex";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland/v0.28.0";
    roc = {
      url = "github:roc-lang/roc";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    flakeLib = import ./flake/lib.nix inputs.nixpkgs.lib;

    systemProfiles = flakeLib.crawl ./profile/system;
    homeProfiles = flakeLib.crawl ./profile/home;

    commonModules = system: [
      inputs.agenix.nixosModules.age
      inputs.home-manager.nixosModules.home-manager
      {environment.systemPackages = [inputs.agenix.packages.${system}.default];}
      {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
            roc = inputs.roc.packages.${system}.default;
          })
          inputs.fenix.overlays.default
        ];

        nix = {
          extraOptions = "extra-experimental-features = flakes nix-command";
          settings = {
            substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
          };
        };

        home-manager = {
          extraSpecialArgs = {
            ks = import ./lib;
            profiles = homeProfiles;
          };
          sharedModules = [inputs.hyprland.homeManagerModules.default];
        };
      }
      ./age.nix
    ];

    makeHost = system: rootModule:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules system ++ [rootModule];
        specialArgs = {profiles = systemProfiles;};
      };
  in {
    nixosConfigurations = {
      maki = makeHost "x86_64-linux" ./host/maki;
      arky = makeHost "x86_64-linux" ./host/arky;
      flax = makeHost "x86_64-linux" ./host/flax;
    };
  };
}
