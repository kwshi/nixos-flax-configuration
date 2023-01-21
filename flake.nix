{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
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
    inputs.digga.lib.mkFlake {
      inherit (inputs) self;
      inherit inputs;
      channels = {
        nixpkgs = {};
      };
      channelsConfig = {allowUnfree = true;};
      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixpkgs";
          modules = [inputs.home-manager.nixosModules.home-manager];
        };
        #imports = [(inputs.digga.lib.importHosts ./hosts)];
        hosts = {
          flax = {
            modules = [./hardware-configuration.nix ./hosts/flax.nix];
          };
        };
        importables = rec {
          profiles = inputs.digga.lib.rakeLeaves ./profiles;
          users = inputs.digga.lib.rakeLeaves ./users;
          suites = {
            base = [users.kshi profiles.console];
          };
        };
      };
      home = {
        importables = rec {
          profiles = inputs.digga.lib.rakeLeaves ./home/profiles;
          suites = {
            base = [profiles.bat];
          };
        };
        users = {
          kshi = {
            suites,
            pkgs,
            ...
          }: {
            imports = suites.base;
            home.stateVersion = "22.11";
            programs.git.enable = true;
            home.packages = with pkgs; [neofetch];
          };
        };
      };
    }
    // {
      nixosConfigurations.flax = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.home-manager.nixosModules.home-manager
          ./hardware-configuration.nix
          ./hosts/flax.nix
          ./users/kshi.nix
          {home-manager.useUserPackages = true;}
          {
            nix.extraOptions = ''
              extra-experimental-features = flakes nix-command
            '';
          }
        ];
        specialArgs = {
          suites = {base = [];};
          hmUsers.kshi = {pkgs, ...}: {
            home.stateVersion = "22.11";
            programs.bat.enable = true;
            home.packages = with pkgs; [neofetch];
            programs.git.enable = true;
	    programs.git.userName = "Kye Shi";
	    programs.git.userEmail = "shi.kye@gmail.com";
          };
        };
      };
      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
}
