{ config, pkgs, inputs, ... }:

{
  home.username = "hendrikf";
  home.homeDirectory = "/home/hendrikf";
  
  
  #dotfiles
  programs.bash = {
  	enable = true;
	  initExtra = ''
		eval "$(starship init bash)"
	'';
  };

  programs.alacritty = {
  	enable = true;
	};

  programs.neovim = {
	  enable = true;
	  viAlias = true;
	  vimAlias = true;
	  plugins = with pkgs.vimPlugins; [
		  lazy-nvim
		  lualine-nvim
		  presence-nvim
		];
  };
  
  
  programs.caelestia = {
  enable = true;
  systemd = {
    enable = true; # if you prefer starting from your compositor
    target = "graphical-session.target";
    environment = [];
  };
  settings = {
    bar.status = {
      showBattery = false;
      paths.wallpaperDir = "$HOME/Pictures/Pics/16:9/";
      launcher.maxWallpapers = 9;
    };
  };
  cli = {
    enable = true; # Also add caelestia-cli to path
    settings = {
      theme.enableGtk = false;
    };
  };
};





  #Programs dotfiles
  xdg.configFile."nvim".source = ./dotfiles/nvim;
  xdg.configFile."fastfetch".source = ./dotfiles/fastfetch;
  xdg.configFile."alacritty".source = ./dotfiles/alacritty;
  xdg.configFile."zed".source = ./dotfiles/zed;
  xdg.configFile."waybar".source = ./dotfiles/waybar;
  xdg.configFile."fish".source = ./dotfiles/fish;
  xdg.configFile."swaync".source = ./dotfiles/swaync;
  xdg.configFile."yazi".source = ./dotfiles/yazi;
  #hyprland
  #xdg.configFile."hypr".source = ./dotfiles/hypr;
  xdg.configFile."wofi".source = ./dotfiles/wofi;
  #xdg.configFile."quickshell".source = ./dotfiles/quickshell;

  #starship
  programs.starship = {
  	enable = true;
	  settings = builtins.fromTOML (builtins.readFile ./dotfiles/starship/starship.toml);
  };

  programs.git = {
  	enable = true;
	  settings.user.name = "Hangover64";
	  settings.user.email = "hendrikfarnkopf@pm.me";
	};
#  programs.waybar = {
# 	enable = true;
#	  settings.main = {
#	    
#		  mainBar = {
#			  layer = "top";
#			  position = "top";
#			  height = 60;
#			  output = ["eDP-1"];
#			  modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
#			  modules-center = [ "sway/window" "custom/hello-from-waybar" ];
#			  modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];
#
#			  "sway/workspaces" = {
#				  disable-scroll = true;
#				  all-outputs = true;
#			  };
#			  "custom/hello-from-waybar" = {
#				  format = "hello {}";
#				  max-length = 40;
#				  interval = "once";
#				  exec = pkgs.writeShellScript "hello-from-waybar" ''
#					echo "from within waybar"
#					'';
#			  };
#		  };
#		};
#	};

  home.stateVersion = "25.11"; 

  

  home.packages = with pkgs; [
	  htop
	  fastfetch
	  okteta
	  yazi
	  ueberzugpp
	  zed-editor
	  kdePackages.okular
	  kdePackages.dolphin
	  obsidian
	  spotify
	  discord
	  antigravity
	  kdePackages.kwin
	  kdePackages.spectacle
	  tree
	  nerd-fonts.jetbrains-mono
	  btop
	  dysk
	  gnumake
	  libreoffice
	  pavucontrol
	  networkmanagerapplet
	  file
	  imagemagick
	  vivaldi
	  coolercontrol.coolercontrold
	  coolercontrol.coolercontrol-gui
	  coolercontrol.coolercontrol-ui-data
	  linuxKernel.packages.linux_zen.virtualbox
	  tor-browser
	  swaynotificationcenter
	  playerctl
	  piper
	  libratbag
	  spicetify-cli
	  foot
  ];

  fonts.fontconfig.enable = true;

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  imports = [
    ./modules/unfree.nix
    inputs.caelestia-shell.homeManagerModules.default
    ./hyprland.nix
    ./hypr-extras.nix
  ];
}
