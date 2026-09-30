{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.firefox = {
    enable = true;
    preferences."media.peerconnection.ice.obfuscate_host_addresses" = false;
  };
  environment.systemPackages = with pkgs; [
    # Browsers and editors
    chromium
    chromedriver
    google-chrome

    # Desktop applications
    gparted-full
    libreoffice
    remmina
    meld
    obsidian
    poedit

    # Communication
    halloy
    vesktop

    # Media and music
    ffmpeg
    mpv
    obs-studio
    spotify
    strawberry
    tuxguitar
    viu
    vlc
    yt-dlp

    # Files and transfer
    dufs
    file
    p7zip
    qbittorrent
    rsync
    tree
    unzip
    zip

    # Shell and CLI
    bat
    bc
    btop
    curl
    direnv
    eza
    fd
    fzf
    git
    gh
    gnupg
    htop
    just
    jq
    nix-direnv
    pre-commit
    ripgrep
    wget
    openssl
    pv
    wl-clipboard

    # System and network diagnostics
    arp-scan-rs
    dnsutils
    ethtool
    inxi
    iftop
    nettools # arp
    mtr
    nmap
    nload
    iperf3
    socat
    systemd-manager-tui
    tcpdump
    traceroute
    lsof
    witr

    # Documents and data
    cloc
    pandoc
    sqlite
    sqlcipher

    # Development and build tools
    autoconf
    automake
    ccache
    cmake
    gnumake
    libtool
    meson
    nasm
    ninja
    pkg-config
    patchelf
    shellcheck
    shfmt
    lazygit
    blender
    help2man
    pandoc

    # Debugging and profiling
    gdb
    lldb
    strace
    ltrace
    valgrind
    hyperfine

    # Languages and toolchains
    gcc
    shc
    clang
    clang-tools
    go
    rustup
    nodejs_22
    pnpm
    ruby
    typst

    # Common Lisp
    # Keep the commonly used libraries in the wrapper so ASDF can find them
    # without a per-project Quicklisp installation.
    (sbcl.withPackages (
      ps: with ps; [
        bordeaux-threads
        cl-ppcre
        qlot-cli
        slynk
        swank
      ]
    ))
    clisp
    ecl
    roswell

    # Language servers
    nil
    nixd
    gopls
    rust-analyzer

    # Nix tooling
    nixfmt
    statix
    deadnix

    # AI
    codex

    # TODO: Sort below!
    thunderbird
    keepassxc
    foliate
    gnome-commander
    steam-run
    gtk3
    wireshark
    android-studio
    gimp
    qemu
    usbutils
    bluetui
    proxychains-ng
    ghostty
    feishu
    reqable
    playwright
    distrobox
    openvpn
    poppler-utils
  ];
}
