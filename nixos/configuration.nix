{
  config,
  pkgs,
  ...
}: {
  imports = [./user.nix];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  services.libinput.enable = true; # touchpad support

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

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

  nix.settings.trusted-substituters = ["https://cache.flox.dev"];
  nix.settings.trusted-public-keys = ["flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="];
}
