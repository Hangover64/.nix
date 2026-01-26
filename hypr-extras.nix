{ config, pkgs, ... }:

{
  # Hypridle Configuration
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
      
      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 1800;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 2500;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 3000;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
  
  # Hyprlock Configuration
  programs.hyprlock = {
    enable = true;
    settings = {
      # Dracula Color Scheme
      "$background" = "rgb(282A36)";
      "$backgroundRaw" = "282A36";
      "$foreground" = "rgb(F8F8F2)";
      "$foregroundRaw" = "F8F8F2";
      "$selection" = "rgb(44475A)";
      "$selectionRaw" = "44475A";
      "$comment" = "rgb(6272A4)";
      "$commentRaw" = "6272A4";
      "$red" = "rgb(FF5555)";
      "$redRaw" = "FF5555";
      "$orange" = "rgb(FFB86C)";
      "$orangeRaw" = "FFB86C";
      "$yellow" = "rgb(F1FA8C)";
      "$yellowRaw" = "F1FA8C";
      "$green" = "rgb(50FA7B)";
      "$greenRaw" = "50FA7B";
      "$purple" = "rgb(BD93F9)";
      "$purpleRaw" = "BD93F9";
      "$cyan" = "rgb(8BE9FD)";
      "$cyanRaw" = "8BE9FD";
      "$pink" = "rgb(FF79C6)";
      "$pinkRaw" = "FF79C6";
      "$accent" = "$purple";
      "$accentRaw" = "$purpleRaw";
      
      # Font
      "$font" = "JetBrainsMono Nerd Font";
      
      general = {
        hide_cursor = true;
      };
      
      background = [
        {
          monitor = "";
          path = "~/Pictures/Pics/16:9/frieren-frieren-beyond-journeys-end-4k-wallpaper-uhdpaper.com-172@3@a.jpg";
          blur_passes = 0;
          color = "$background";
        }
      ];
      
      # Time Label
      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "$foreground";
          font_size = 90;
          font_family = "$font";
          position = "30, 0";
          halign = "left";
          valign = "top";
        }
        # Date Label
        {
          monitor = "";
          text = ''cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"'';
          color = "$foreground";
          font_size = 25;
          font_family = "$font";
          position = "30, -150";
          halign = "left";
          valign = "top";
        }
      ];
      
      # Input Field
      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$background";
          font_color = "$foreground";
          fade_on_empty = false;
          placeholder_text = ''<span foreground="##$foregroundRaw">󰌾  Logged in as <span foreground="##$accentRaw">$USER</span></span>'';
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, -35";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
  
  # Hyprpaper Configuration
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/Pics/16:9/ARLE EYES.png"
      ];
      
      wallpaper = [
        ",~/Pictures/Pics/16:9/ARLE EYES.png"
      ];
      
      splash = true;
      ipc = "on";
    };
  };
  
  # Monitor Configuration (für Hyprland)
  # Dies muss in der hyprland.nix eingebunden werden
  # Oder du kannst es hier definieren und in hyprland.nix importieren
}
