{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hendrikf";
  home.homeDirectory = "/home/hendrikf";
  
  #dotfiles

  programs.neovim = {
	enable = true;
	viAlias = true;
	vimAlias = true;
  };
  xdg.configFile."nvim".source = ./dotfiles/nvim;
  
  programs.git = {
  	enable = true;
	settings.user.name = "Hangover64";
	settings.user.email = "hendrikfarnkopf@pm.me";
	};
  programs.waybar = {
  	enable = true;
	settings.main = {
	
		mainBar = {
			layer = "top";
			position = "top";
			height = 60;
			output = ["eDP-1"];
			modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
			modules-center = [ "sway/window" "custom/hello-from-waybar" ];
			modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];

			"sway/workspaces" = {
				disable-scroll = true;
				all-outputs = true;
			};
			"custom/hello-from-waybar" = {
				format = "hello {}";
				max-length = 40;
				interval = "once";
				exec = pkgs.writeShellScript "hello-from-waybar" ''
					echo "from within waybar"
					'';
			};
		};
		};
	};

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.


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


    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hendrikf/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
  ./modules/unfree.nix
  ];
}


