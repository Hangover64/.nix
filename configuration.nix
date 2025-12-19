{ config, pkgs, inputs, ... }:
{
	imports =
		[
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.default
		];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	kernelPackages = pkgs.linuxPackages_latest;
	};

	
	networking = { 
		hostName = "nixos";
		networkmanager.enable = true;
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
	
	console.keyMap = "de-latin1-nodeadkeys";

	services.printing.enable = true;

	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	users.users.hendrikf = {
		isNormalUser = true;
		description = "Hendrikf";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			kdePackages.kate
		];
	};

	home-manager = {
  # also pass inputs to home-manager modules
  extraSpecialArgs = {inherit inputs;};
  users = {
    "hendrikf" = import ./home.nix;
  };
};
	nix.settings.experimental-features = ["nix-command" "flakes"];

	programs.firefox.enable = true;
	programs.steam.enable = true;
	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
			neovim 
			wget
			zip
			unzip
			alacritty
			git
			protonvpn-gui
			python315
			python313Packages.pydbus
			dbus
			gcc
			glibc.static
			nil
			xdg-desktop-portal
			xdg-desktop-portal-cosmic
			clang-tools
			#Hyprland
			xdg-desktop-portal-hyprland
			hyprpaper
			hyprlock
			hypridle
			wofi
			waybar
			brightnessctl
					

			];
	fonts.packages = with pkgs; [
		jetbrains-mono
			nerd-fonts.jetbrains-mono
	];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true


# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# ng.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?


}
