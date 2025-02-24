{ pkgs, ... }:
let
	package = { lib, stdenv, dir, file, ... }: stdenv.mkDerivation rec {
		name = "${pname}-${dir}-${file}";
		pname = "wallpapers";
		src = ./. + "/${dir}/${file}";
		phases = [ "installPhase" ];
		installPhase = "cp ${src} $out";
	};
in rec {
	wallpapers = pkgs.callPackage package {
		dir = "your_name";
		file = "MitsuhaTakiFirstMeet.jpg";
	};
	default = wallpapers;
}
