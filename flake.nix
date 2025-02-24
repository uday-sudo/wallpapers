{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};
	outputs = { self, nixpkgs, ... }@inputs: let
		inherit (self) outputs;
		forAllSystems = nixpkgs.lib.genAttrs [
			"aarch64-linux"
			"i686-linux"
			"x86_64-linux"
			"aarch64-darwin"
			"x86_64-darwin"
		];
	in {
		packages = forAllSystems (system:
			let pkgs = nixpkgs.legacyPackages.${system};
			in import ./packages.nix { inherit pkgs; }
		);
		nixosModules = import ./nix-module.nix self;
		homeManagerModules = import ./home-manager.nix self;
	};
}
