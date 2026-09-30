{ pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      # Required for podman-compose containers to resolve each other by name.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  services.flatpak.enable = true;

  services.postgresql.enable = true;

  services.redis.servers."" = {
    enable = true;
    bind = "127.0.0.1";
    port = 6379;
    openFirewall = false;
  };

  # services.avahi = {
  #   enable = false; # abnormal, let it false
  #   nssmdns4 = true;
  #   openFirewall = true;
  # };

  environment.systemPackages = with pkgs; [
    flatpak
  ];
}
