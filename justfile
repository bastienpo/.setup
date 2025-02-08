setup_dotfiles:
    stow -d ~/.setup/dotfiles -t ~ nvim tmux ghostty

unlink_dotfiles:
    stow -d ~/.setup/dotfiles -t ~ -D nvim tmux ghostty
