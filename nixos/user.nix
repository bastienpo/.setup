{
  config,
  pkgs,
  ...
}: {
  users.users.h = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      ghostty
      neovim
      direnv
      gcc
      gnumake
      libnotify
      bruno
      discord
      insomnia
      code-cursor
      alejandra
      bat
      fzf
      tmux
      ripgrep
      stow
      just
      jq
    ];
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "direnv"
      ];
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
  };
}
