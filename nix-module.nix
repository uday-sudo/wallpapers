self: {
	default = { options, config, lib, pkgs, ... }: let
		cfg = config.wallpaper;
	in {
		options = {
			wallpaper = {
				desktop = {
					dir = lib.mkOption {
						default = "your_name";
						description = "Directory containing the wallpaper";
					};
					file = lib.mkOption {
						default = "MitsuhaTakiFirstMeet.jpg";
						description = "Name of the Image/Wallpaper";
					};
					nixConf = lib.mkOption {
						default = ./. + "/${cfg.desktop.dir}/${lib.strings.removeSuffix ".jpg" cfg.desktop.file}.nix";
						description = "Nix file that will imported with the wallpaper as config";
					};
					output = lib.mkOption {
						type = lib.types.nullOr lib.types.package;
						description = "Resulting image";
					};
				};
				sddm = {
					dir = lib.mkOption {
						default = "your_name";
						description = "Directory containing the wallpaper";
					};
					file = lib.mkOption {
						default = "MitsuhaTakiFirstMeet.jpg";
						description = "Name of the Image/Wallpaper";
					};
					nixConf = lib.mkOption {
						default = ./. + "/${cfg.desktop.dir}/${lib.strings.removeSuffix ".jpg" cfg.desktop.file}.nix";
						description = "Nix file that will imported with the wallpaper as config";
					};
					output = lib.mkOption {
						type = lib.types.nullOr lib.types.package;
						description = "Resulting image";
					};
				};
				grub = {
					dir = lib.mkOption {
						default = "your_name";
						description = "Directory containing the wallpaper";
					};
					file = lib.mkOption {
						default = "MitsuhaTakiFirstMeet.jpg";
						description = "Name of the Image/Wallpaper";
					};
					nixConf = lib.mkOption {
						default = ./. + "/${cfg.desktop.dir}/${lib.strings.removeSuffix ".jpg" cfg.desktop.file}.nix";
						description = "Nix file that will imported with the wallpaper as config";
					};
					output = lib.mkOption {
						type = lib.types.nullOr lib.types.package;
						description = "Resulting image";
					};
				};
				# hyprland = {
				# 	blur = {
				# 		size = lib.mkOption {
				# 			default = 0;
				# 		};
				# 		passes = lib.mkOption {
				# 			default = 0;
				# 		};
				# 	};
				# };
			};
		};
		config = {
			wallpaper = {
				desktop.output = self.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
					dir = cfg.desktop.dir;
					file = cfg.desktop.file;
				};
				sddm.output = self.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
					dir = cfg.sddm.dir;
					file = cfg.sddm.file;
				};
				grub.output = self.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
					dir = cfg.grub.dir;
					file = cfg.grub.file;
				};
				# hyprland = (if (builtins.pathExists cfg.desktop.nixConf) then
				# 		import cfg.desktop.nixConf
				# 	else {
				# 		blur = {
				# 			size = 3;
				# 			passes = 4;
				# 		};
				# 	});
			};
		};
	};
}
