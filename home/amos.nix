{ ... }:

{
  imports = [
    ./modules/nixvim.nix
    ./modules/tmux.nix
    ./modules/v2rayn.nix
    ./modules/zsh.nix
  ];

  home.sessionPath = [
    "$HOME/Scripts/Shell"
    "$HOME/Scripts/Python"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NO_SECRET_HERE = "This is the golden age";
    TMUX_TMPDIR = "\${XDG_RUNTIME_DIR:-\"/run/user/$(id -u)\"}";
    VISUAL = "nvim";
  };

  home.stateVersion = "26.05";
}
