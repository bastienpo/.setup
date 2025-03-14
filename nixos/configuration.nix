{
  config,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  services.libinput.enable = true; # touchpad support

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];
  services.gnome.core-utilities.enable = false;

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
    variant = "intl";
  };

  # Audio configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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
  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.flatpak.enable = true;

  users.users.h = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
    packages = with pkgs; [
      oh-my-fish
      ghostty
      neovim
      direnv
      gcc
      gnumake
      just
      discord
      code-cursor
      alejandra
      bat
      ripgrep
      fzf
      tmux
      stow
      pop-launcher
    ];
  };

  programs.fish.enable = true;

  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
  };
}
