{ config, pkgs, ...}:
{
systemd.user.services.wallpaper-rotation = {
	Unit = {
		Description = "Rotate wallpapers automatically";
		};
	
	Service = {
		Type = "oneshot";
		ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.caelestia-shell}/bin/caelestia wallpaper -r'";
		};
	};
systemd.user.timers.wallpaper-rotation = {
	Unit = {
		Description = "Rotate wallpapers every X minutes";
		};
	Timer = {
		OnBootSec = "5min";
		OnUnitActiveSec = "5min";
		Persistent = true;
		};
	Install = {
		WantedBy = [ "timers.target" ];
		};
	};
}
