{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/python.nix
    ./modules/libraries.nix
    ./modules/proxy.nix
    ./modules/apps.nix
    ./modules/security.nix
    ./modules/services.nix
  ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  # Use GRUB for a themed multi-boot menu.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
    useOSProber = true;
    configurationLimit = 10;
    theme = inputs.nixos-grub-themes.packages.${pkgs.stdenv.hostPlatform.system}.hyperfluent;
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Run garbage collection weekly while keeping a one-month rollback window.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1month";
  };
  # Deduplicate identical files in the Nix store automatically.
  nix.settings.auto-optimise-store = true;

  networking.hostName = "N9";
  networking.networkmanager.enable = true;

  system.stateVersion = "26.05";
}
