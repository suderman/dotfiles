all: switch

# if root, rebuild the whole system with nixos-rebuild
# else, rebuild the home directory with home-manager
switch:
	if [ "$(shell id -u)" = 0 ]; then\
		nixos-rebuild switch --flake '.'; \
	else\
		home-manager switch --flake '.#me'; \
	fi

update:
	nix flake update

install_home_manager:
	nix build --no-link .#homeConfigurations.me.activationPackage
	"$$(nix path-info .#homeConfigurations.me.activationPackage)"/activate
