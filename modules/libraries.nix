{ pkgs, ... }:

{
  # Runtime libraries for prebuilt Linux binaries (for example Flet Desktop).
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    openssl
    gtk3
    glib
    pango
    cairo
    gdk-pixbuf
    atk
    harfbuzz
    libepoxy
    libglvnd
    libxkbcommon
    libx11
    fontconfig
    freetype
    dbus
    libsecret
    zlib
    stdenv.cc.cc
    # GCC runtime output; provides libstdc++.so.6 for prebuilt binaries.
    stdenv.cc.cc.lib
  ];

  # Native extensions loaded by Nix's Python do not consult nix-ld's
  # NIX_LD_LIBRARY_PATH, so expose the GCC runtime to user sessions as well.
  environment.sessionVariables.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
}
