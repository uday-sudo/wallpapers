self: {
	default = {
		options,
		config,
		lib,
		pkgs,
		...
	}: let
		cfg = config.wallpaper;
		inherit (lib) mkOption;
		inherit (lib.types) int float nullOr package;
	in {
		options = {
			wallpaper = {
				desktop = {
					dir = mkOption {
						default = "your_name";
						description = "Directory containing the wallpaper";
					};
					file = mkOption {
						default = "MitsuhaTakiFirstMeet.jpg";
						description = "Name of the Image/Wallpaper";
					};
					nixConf = mkOption {
						default = ./. + "/${cfg.desktop.dir}/${lib.strings.removeSuffix ".jpg" cfg.desktop.file}.nix";
						description = "Nix file that will imported with the wallpaper as config";
					};
					output = mkOption {
						type = nullOr package;
						description = "Resulting image";
					};
				};
				hyprland = {
					gaps = rec {
						out = mkOption {
							default = cfg.hyprland.gaps.in' * 2;
							type = int;
						};
						in' = mkOption {
							default = 3;
							type = int;
						};
						workspaces = mkOption {
							default = cfg.hyprland.gaps.in';
							type = int;
						};
					};
					blur = {
						enabled = lib.mkEnableOption "Blur";
						size = mkOption {
							default = 3;
							type = int;
						};
						passes = mkOption {
							default = 4;
							type = int;
						};
						noise = mkOption {
							default = 0.0117;
							type = float;
						};
						contrast = mkOption {
							default = 0.8916;
							type = float;
						};
						brightness = mkOption {
							default = 0.8172;
							type = float;
						};
						vibrancy = mkOption {
							default = 0.1696;
							type = float;
						};
						vibrancy_darkness = mkOption {
							default = 0.0;
							type = float;
						};
					};
					rounding = mkOption {
						default = 5;
						type = int;
					};
					opacity = {
						active = mkOption {
							default = 1.0;
							type = float;
						};
						inactive = mkOption {
							default = 0.8;
							type = float;
						};
					};
					dim = {
						enable = lib.mkEnableOption "dim";
						strength = mkOption {
							default = 0.3;
						};

						special = mkOption {
							default = 0.3;
							type = float;
						};

						around = mkOption {
							default = 0.4;
							type = float;
						};
					};
				};
			};
		};
		config = {
			wallpaper = {
				desktop.output = self.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
					inherit (cfg.desktop) dir;
					inherit (cfg.desktop) file;
				};
				hyprland = lib.mkIf (builtins.pathExists cfg.desktop.nixConf) (import cfg.desktop.nixConf);
			};
		};
	};
}
