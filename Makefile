all: switch

switch:
	@if ! [ "$(shell id -u)" = 0 ]; then\
		home-manager switch --flake '.#me'; \
	else\
		nixos-rebuild switch --flake '.'; \
	fi
