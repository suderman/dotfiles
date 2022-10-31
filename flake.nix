{
  description = "My personal NixOS configuration";

  inputs = {

    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS Package Management
    darwin.url = "github:lnl7/nix-darwin/master";                              
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Nix User Repository
    nur.url = "github:nix-community/NUR";                                   

  };

  outputs = inputs@{ self, nixpkgs, home-manager, darwin, nur, ... }: 

    let 
      mkPkgs = pkgs: system: import pkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHost = hostname: system: nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = mkPkgs nixpkgs system;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/${hostname}/configuration.nix ];
      };

      mkHome = system: home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs nixpkgs system;
        # specialArgs = { inherit inputs; };
        modules = [ ./home.nix ];
      };

      lib = nixpkgs.lib;
    in 
    {

      nixosConfigurations = {
        nimbus = mkHost "nimbus" "x86_64-linux";
        cog = mkHost "cog" "x86_64-linux";
        lux = mkHost "lux" "x86_64-linux";
      };

      homeConfigurations = {
        me = mkHome "x86_64-linux";
        # me = home-manager.lib.homeManagerConfiguration {
        #   # inherit pkgs;
        #   # pkgs = pkgs.x86_64-linux;
        #   pkgs = mkPkgs nixpkgs "x86_64-linux";
        #   # Specify your home configuration modules here, for example,
        #   # the path to your home.nix.
        #   modules = [
        #     ./home.nix
        #   ];
        # };
      };

    };
}
