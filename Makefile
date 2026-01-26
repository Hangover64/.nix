rebuild:
	nixos-rebuild switch --flake .#nixos
update:
	nixos-rebuild switch --upgrade --flake .#nixos
