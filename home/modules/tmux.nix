{
  config,
  pkgs,
  ...
}:

let
  tmuxSessionizer = pkgs.writeShellApplication {
    name = "tmux-sessionizer";
    runtimeInputs = with pkgs; [
      coreutils
      fd
      fzf
      gawk
      tmux
    ];
    text = builtins.readFile ../scripts/tmux-sessionizer.sh;
  };
in
{
  home.packages = [ tmuxSessionizer ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "tmux-256color";

    extraConfig = ''
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      set -ag terminal-overrides ",xterm-256color:RGB"

      set-option -q renumber-windows on

      set-option -g status-style bg=default,fg=colour136
      set-option -g status-justify centre
      set-option -g status-interval 1
      set-option -g status-left-length 100
      set-option -g status-right-length 100
      set-option -g status-left "#[fg=green,bold] ❐ #S #[fg=white]• #[fg=blue] #H"
      set-option -g status-right "#[fg=white]%H:%M #[fg=yellow]%Y-%m-%d"
      set-option -g window-status-current-format "#[fg=cyan,bold,underscore] #I:#W "
      set-option -g window-status-format "#[fg=colour244] #I:#W "

      bind r source-file "${config.xdg.configHome}/tmux/tmux.conf" \; display-message "配置已重载!"

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "${pkgs.wl-clipboard}/bin/wl-copy"

      bind-key C-f new-window -n sessionizer "${tmuxSessionizer}/bin/tmux-sessionizer --from-binding"
      bind-key -r N new-window -n notes "${config.programs.nixvim.build.package}/bin/nvim ~/notes.md"
    '';
  };
}
