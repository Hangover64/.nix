{ config, pkgs, inputs, ...}:
{
systemd.user.timers.wallpaper-rotation = {
  Unit = {
    Description = "Rotate wallpapers every 30 minutes";
  };
  
  Timer = {
    OnBootSec = "5min";
    OnUnitActiveSec = "30min";
    Persistent = true;
  };
  
  Install = {
    WantedBy = [ "timers.target" ];
  };
};

systemd.user.services.wallpaper-rotation = {
  Unit = {
    Description = "Rotate wallpapers automatically";
  };
  
  Service = {
    Type = "oneshot";
    ExecStart = "caelestia wallpaper -r";
  };
};
}
