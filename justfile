default: 
    just --list

# Setup the dotfiles (using stow)
[working-directory: 'dotfiles']
setup_dotfiles:
    stow -t ~ nvim tmux ghostty

# Unlink the dotfiles (using stow)
[working-directory: 'dotfiles']
unlink_dotfiles:
    stow -t ~ -D nvim tmux ghostty

# Format the nixos configuration
format:
    @echo "Formatting nixos configuration..."
    @alejandra . &>/dev/null || ( alejandra . ; echo "formatting failed!" && exit 1)

# Rebuild the nixos configuration
[working-directory: 'nixos']
rebuild: format
    git diff -U0 '*.nix'
    sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)
    rm nixos-switch.log
    git commit -am "$(nixos-rebuild list-generations | grep current)"
