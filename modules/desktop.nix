{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.gnomeExtensions.kimpanel
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.notification-configurator
  ];

  fonts.packages = [
    pkgs.hack-font
    pkgs.nerd-fonts.hack
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Hack" ];
    sansSerif = [ "Noto Sans CJK SC" ];
    serif = [ "Noto Serif CJK SC" ];
  };

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          pkgs.gnomeExtensions.kimpanel.extensionUuid
          pkgs.gnomeExtensions.appindicator.extensionUuid
          pkgs.gnomeExtensions.notification-configurator.extensionUuid
        ];
      };
      settings."org/gnome/desktop/interface" = {
        font-name = "Noto Sans CJK SC 11";
        document-font-name = "Noto Sans CJK SC 12";
        monospace-font-name = "Hack 11";
      };
      # GNOME on Wayland keeps keyboard options in its input-source settings;
      # services.xserver.xkb.options alone does not update this list.
      settings."org/gnome/desktop/input-sources" = {
        xkb-options = [
          "caps:escape"
          "lv3:ralt_alt"
        ];
      };
    }
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "cn";
      options = "caps:escape,lv3:ralt_alt";
      variant = "";
    };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.printing.enable = true;
  services.libinput.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
