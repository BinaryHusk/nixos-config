{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.configFile."zsh/p10k.zsh".source = ../config/p10k.zsh;
  xdg.configFile."zsh/functions.zsh".source = ../config/zsh/functions.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      path = "${config.xdg.dataHome}/zsh/history";
      size = 50000;
      save = 50000;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "extract"
        "git"
        "sudo"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      c = "clear";
      cls = "clear";
      dl = "cd ~/Downloads";
      rm = "rm -I";
      sdel = "shred -u -z -n 3";
      v = "nvim";
      zr = "exec zsh";

      smart = "systemd-manager-tui";
    };

    sessionVariables = {
      FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
      FZF_CTRL_T_COMMAND = "fd --type f --hidden --follow --exclude .git";
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        # Rootless Distrobox maps Nix store ownership to nobody, which makes
        # oh-my-zsh's ownership check report read-only directories as insecure.
        if [[ -n "$CONTAINER_ID" ]]; then
          export ZSH_DISABLE_COMPFIX=true
        fi

        # Enter tmux only from a local interactive terminal.
        if [[ -o interactive && -t 0 && -t 1 && -z "$TMUX" && -z "$SSH_CONNECTION" && "$TERM" != dumb ]]; then
          exec ${pkgs.tmux}/bin/tmux
        fi
      '')
      (lib.mkOrder 1000 ''
        [[ -r ${config.xdg.configHome}/zsh/functions.zsh ]] && source ${config.xdg.configHome}/zsh/functions.zsh
        [[ -r ${config.xdg.configHome}/zsh/p10k.zsh ]] && source ${config.xdg.configHome}/zsh/p10k.zsh
      '')
    ];
  };
}
