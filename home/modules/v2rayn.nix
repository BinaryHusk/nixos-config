{
  config,
  lib,
  pkgs,
  ...
}:

let
  binDir = "${config.xdg.dataHome}/v2rayN/bin";
in
{
  home.packages = with pkgs; [
    v2rayn
    xray
    sing-box
  ];

  home.activation.deployV2raynAssets = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.coreutils}/bin/install -D -m 0755 \
      ${pkgs.xray}/bin/xray \
      ${lib.escapeShellArg "${binDir}/xray/xray"}

    run ${pkgs.coreutils}/bin/install -D -m 0755 \
      ${pkgs.sing-box}/bin/sing-box \
      ${lib.escapeShellArg "${binDir}/sing_box/sing-box"}

    run ${pkgs.coreutils}/bin/install -D -m 0644 \
      ${pkgs.v2ray-geoip}/share/v2ray/geoip.dat \
      ${lib.escapeShellArg "${binDir}/geoip.dat"}

    run ${pkgs.coreutils}/bin/install -D -m 0644 \
      ${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat \
      ${lib.escapeShellArg "${binDir}/geosite.dat"}

    if [[ -L ${lib.escapeShellArg "${binDir}/sing-box"} ]]; then
      run ${pkgs.coreutils}/bin/rm ${lib.escapeShellArg "${binDir}/sing-box"}
    fi
  '';
}
