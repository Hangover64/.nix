{
description = "Nixos config flake";


inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	


	caelestia-shell = {
		url = "github:caelestia-dots/shell";
		inputs.nixpkgs.follows = "nixpkgs";
		};
	
	home-manager = {
    		url = "github:nix-community/home-manager";
    		inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, caelestia-shell, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
