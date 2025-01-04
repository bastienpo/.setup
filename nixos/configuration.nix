{
  config,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  services.libinput.enable = true; # touchpad support

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

  # Gnome configuration
  services.gnome.core-utilities.enable = false; # remove defaults apps
  environment.gnome.excludePackages = [pkgs.gnome-tour];
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    nautilus
    evince
  ];

  documentation.nixos.enable = false;

  services.xserver.xkb = {
    layout = "us";
    variant = "euro";
  };

  # Audio configuration
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User configuration
  users.users.h = {
    isNormalUser = true;
    description = "h";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      git
      gcc
      gnumake
      libnotify
      ghostty
      neovim
      code-cursor
      alejandra
      direnv
      bat
      fzf
      tmux
      ripgrep
      bruno
      discord
    ];
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "direnv"
        "fzf"
      ];
      theme = "robbyrussell";
    };
  };

  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Dynamic libraries
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
}
