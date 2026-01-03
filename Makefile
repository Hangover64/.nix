rebuild:
	nixos-rebuild switch --flake /etc/nixos\#nixos
update:
	nixos-rebuild switch --upgrade --flake /etc/nixos\#nixos
