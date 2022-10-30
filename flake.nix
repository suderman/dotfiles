{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: 

    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in 
    {

      nixosConfigurations = {
        nimbus = nixpkgs.lib.nixosSystem {
          inherit system;
          # system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
        cog = nixpkgs.lib.nixosSystem {
          inherit system;
          # system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
        lux = nixpkgs.lib.nixosSystem {
          inherit system;
          # system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
      };


      homeManagerConfigurations = {
        me = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "me";
          homeDirectory = "/home/me";
          # stateVersion = "22.09";
          # configuartion = {
          #   imports = [
          #   ];
          # };
        };
      };

      # nixosConfigurations.nimbus = nixpkgs.lib.nixosSystem {
      #   inherit system;
      #   # system = "x86_64-linux";
      #   modules = [ ./configuration.nix ];
      # };
      # nixosConfigurations.cog = nixpkgs.lib.nixosSystem {
      #   inherit system;
      #   # system = "x86_64-linux";
      #   modules = [ ./configuration.nix ];
      # };
      # nixosConfigurations.lux = nixpkgs.lib.nixosSystem {
      #   inherit system;
      #   # system = "x86_64-linux";
      #   modules = [ ./configuration.nix ];
      # };
    };
}
