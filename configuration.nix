{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ (if builtins.pathExists ./mounts-pc.nix
  then [ ./mounts-pc.nix ]
  else[]);

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
    };
    	kernelParams = [ 
	"amdgpu.ppfeaturemask=0xffffffff"
	"amdgpu.noretry=0"
	"amdgpu.freesync=0"
	];
    	kernelPackages = pkgs.linuxPackages_latest;
	kernelModules = [ "vboxdrv" "vboxnetadp" "vboxnetflt"];
  };

	networking = { 
		hostName = "nixos-btw";
		networkmanager.enable = true;
		nftables.enable = true;
	};
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};


	time.timeZone = "Europe/Berlin";

	i18n = {
	  defaultLocale = "en_GB.UTF-8";
	  extraLocaleSettings = {
		  LC_ADDRESS = "de_DE.UTF-8";
		  LC_IDENTIFICATION = "de_DE.UTF-8";
		  LC_MEASUREMENT = "de_DE.UTF-8";
		  LC_MONETARY = "de_DE.UTF-8";
		  LC_NAME = "de_DE.UTF-8";
		  LC_NUMERIC = "de_DE.UTF-8";
		  LC_PAPER = "de_DE.UTF-8";
		  LC_TELEPHONE = "de_DE.UTF-8";
		  LC_TIME = "de_DE.UTF-8";
		};
	};

	programs.hyprland = {
	  enable = true;
	  xwayland.enable = true;
	};
	programs.hyprlock.enable = true;
	services.displayManager.ly.enable = true;
	services.ratbagd.enable = true;


	console.keyMap = "de-latin1-nodeadkeys";

	services.printing.enable = true;
	services.firewalld.enable = true;

	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	users.users.hendrikf = {
		shell = pkgs.fish;
		isNormalUser = true;
		description = "Hendrikf";
		extraGroups = [ "networkmanager" "wheel" "input" ];
		packages = with pkgs; [
			kdePackages.kate
		];
	};

	home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "hendrikf" = import ./home.nix;
      };
  };
	nix.settings.experimental-features = ["nix-command" "flakes"];

	programs.firefox.enable = true;
	programs.steam.enable = true;
	programs.coolercontrol.enable = true;
	nixpkgs.config.allowUnfree = true;
	programs.fish.enable = true;

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [

	];
	virtualisation.virtualbox.host.enable = true;

	environment.systemPackages = with pkgs; [
		#editor and commands
		mesa
		vulkan-tools
		fish
		zsh

		wget
		zip
		unzip
		alacritty
		protonvpn-gui
		#developement
		xfsprogs
		python315
		python313Packages.pydbus
		gcc
		glibc.static
		nil
		xdg-desktop-portal
		dbus
		clang-tools
		nftables
		#Hyprland
		xdg-desktop-portal-hyprland
		hyprpaper
		hyprshot
		hyprlock
		hypridle
		wofi
		brightnessctl
		nix-ld
		smplayer
		mpv
		clang-tools
		libclang
		razergenie
		razer-cli
		diffutils
		docker
		mpvpaper
		waypaper
		ffmpeg
		rocmPackages.rocm-smi
		claude-code
		nmgui
		cava
		quickshell
    rustup

		#celestia
		swappy
		grim
		dart-sass
		app2unit
		cliphist
		fuzzel

		#screenshot shit
		flameshot
		grim
		slurp
		wl-clipboard
		swappy
		libnotify
	];
	fonts.packages = with pkgs; [
		jetbrains-mono
		nerd-fonts.jetbrains-mono
	];
	environment.variables = { 
		HYPRSHOT_DIR = "$HOME/Pictures/Screenshots";
		};

	system.stateVersion = "25.11"; 

}
