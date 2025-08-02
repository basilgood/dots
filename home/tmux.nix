{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    terminal = "xterm-256color";
    aggressiveResize = true;
    historyLimit = 500000;
    resizeAmount = 5;
    escapeTime = 0;
    mouse = true;
    shortcut = "Space";
    extraConfig = ''
      bind-key \\ split-window -h -c "#{pane_current_path}"
      bind-key - split-window -v -c "#{pane_current_path}"
      bind-key c new-window -c "#{pane_current_path}"
      bind-key -T copy-mode 'v' send-keys -X begin-selection
      set -gq allow-passthrough on
      set -ga terminal-overrides ",*col*:Tc"
      set -g set-titles on
      set -g renumber-windows on
      set -g focus-events on
      set -g detach-on-destroy off

      set-option -g mode-style 'bg=blue, fg=black'
      set-option -g message-style 'bg=blue, fg=black'
      set-option -g status-style "bg=black"
      set-window-option -g window-status-current-format '#[fg=blue, bg=black][#I:#W]#[fg=blue, bg=black]'
      set-window-option -g window-status-format '[#I:#W]'
      set-window-option -g window-status-separator ' '
      set-window-option -g window-status-style "bg=black"
      set-window-option -g window-status-current-style "bg=blue,fg=black"
      set-option -g status-right "#[fg=yellow, bg=black]session: #S"
    '';

  };
  home.packages = [ pkgs.smug ];
}
