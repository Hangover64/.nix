{ config, pkgs, ... }:

{
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/43549131-039a-4410-b4e3-ecd4dc51c325";
    fsType = "xfs";
    options = [ "defaults" "x-systemd.automount" "noauto" ];
  };
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/922C2CF22C2CD2D1";
    fsType = "ntfs";
    options = [ "defaults" "x-systemd.automount" "noauto" ];
    };  
}
