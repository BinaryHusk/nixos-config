{ pkgs, ... }:

let
  # Keep the application and localized resources on the same release.
  # The localized asset is the non-trial, non-skip-login variant.
  termiusLocalized = pkgs.termius.overrideAttrs (oldAttrs: {
    pname = "termius-localized-skip";

    postInstall = (oldAttrs.postInstall or "") + ''
      install -Dm644 \
        ${
          pkgs.fetchurl {
            url = "https://github.com/ArcSurge/Termius-Pro-zh_CN/releases/download/v${oldAttrs.version}/app-linux-localize-skip.asar";
            hash = "sha256-UFwInp15LaT1Vfx9zByr41D/gmxd5ce0xmwwqlCfGIg=";
          }
        } \
        "$out/opt/termius/resources/app.asar"
    '';

    meta = oldAttrs.meta // {
      description = "Cross-platform SSH client with Chinese localization";
    };
  });
in
{
  environment.systemPackages = [ termiusLocalized ];
}
