{ pkgs, ... }:

{
  # Keep the host firewall enabled. Add narrowly scoped allowed ports here
  # when services are introduced.
  networking.firewall.enable = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  environment.systemPackages = with pkgs; [
    clamav
  ];
}
