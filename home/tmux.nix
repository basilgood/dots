{pkgs, ...}: let
  tms = pkgs.writeShellScriptBin "tms" ''
    selected=$((find ~/Projects ~/ ~/.config -mindepth 1 -maxdepth 1 -type d ) | fzf)
    if [[ -z $selected ]]; then
        exit
    fi
    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        exit 0
    fi
    if ! tmux has-session -t $selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
    fi
    if [[ -z $TMUX ]]; then
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    fi
    exit
  '';
in {
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
      unbind C-b
      bind-key | split-window -h -c "#{pane_current_path}"
      bind-key - split-window -v -c "#{pane_current_path}"
      bind-key c new-window -c "#{pane_current_path}"
      bind-key -T copy-mode 'v' send-keys -X begin-selection
      set -ga terminal-overrides ",*col*:Tc"
      set -g automatic-rename on
      set -g automatic-rename-format "#{b:pane_current_path}"
      set -g set-titles on
      set -g renumber-windows on
      set -g focus-events on
      set -g status-style bg=#1e1e1e
      set -g status-left "#[fg=magenta,bold,bg=#1e1e1e]⮊ "
      set -g status-right "#[fg=magenta,bold,bg=#1e1e1e]#S ⮈"
      set -g window-status-current-style fg=magenta,bold,bg=#1e1e1e
      set -g window-status-style fg=gray,bg=#1e1e1e,dim
      set -g message-command-style bg=default,fg=yellow
      set -g message-style bg=default,fg=yellow
      set -g mode-style bg=#223249,fg=magenta
      set -g pane-active-border-style fg=magenta,bg=default
      set -g pane-border-style fg=brightblack,bg=default
    '';
  };
  home.packages = [tms];
}
