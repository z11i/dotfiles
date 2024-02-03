if [ -f "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi

if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
	. "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [ -f "$HOME/.asdf/asdf.sh" ]; then
	. "$HOME/.asdf/asdf.sh"
fi
