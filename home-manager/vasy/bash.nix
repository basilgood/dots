{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.direnv.enable = true;
  programs.hstr.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      ns = "nh os switch -H liberty ~/Projects/dots/";
      nc = "nh clean all";
      mkdir = "mkdir -vp";
      rm = "rm -rifv";
      mv = "mv -iv";
      cp = "cp -riv";
      dedup_history = "awk '!seen[$0]++' ~/.bash_history > ~/.bash_history.tmp && mv ~/.bash_history.tmp ~/.bash_history";
    };
    historySize = -1;
    historyFileSize = -1;
    historyControl = [
      "ignoredups"
      "erasedups"
    ];
    historyIgnore = [
      "l"
      "ls"
      "ll"
      "lt"
      "cd"
      "rm"
      "rm rf"
      "hm"
      "yt"
      "exit"
      "history"
      "kill"
      "pkill"
      "fg"
      "bg"
      "mpv"
      "aria2c"
      "yazi"
    ];
    shellOptions = [
      "nocaseglob"
      "autocd"
      "dirspell"
      "cdspell"
      "cmdhist"
      "histappend"
    ];
    initExtra = ''
      set -o notify
      bind "set completion-ignore-case on"
      bind "set completion-map-case on"
      bind "set show-all-if-ambiguous on"
      bind "set menu-complete-display-prefix on"
      bind "set mark-symlinked-directories on"
      bind "set colored-stats on"
      bind "set visible-stats on"
      bind "set page-completions off"
      bind "set skip-completed-text on"
      bind "set bell-style none"
      bind 'TAB':menu-complete
      bind '"\e[Z": menu-complete-backward'
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\C-h": backward-kill-word'
      stty -ixon
    '';

    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';

    sessionVariables = {
      VLC_PLUGIN_PATH = "${pkgs.vlc-bittorrent}";
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    terminal = "\${TERM}";
    aggressiveResize = true;
    historyLimit = 500000;
    resizeAmount = 5;
    escapeTime = 0;
    mouse = true;
    prefix = "C-Space";
    plugins = [
      inputs.minimal-tmux.packages.${pkgs.system}.default
    ];
    extraConfig = ''
      unbind C-b
      bind C-Space send-prefix
      bind-key C-Space last-window
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
    '';
  };

  programs.smug = {
    enable = true;
    # package = pkgs.smug.overrideAttrs (old: {
    #   version = "0.3.10";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "ivaaaan";
    #     repo = "smug";
    #     rev = "v0.3.10";
    #     sha256 = "sha256-m6yK7WPfrItIR3ULJgnw+oysX+zlotiIZMyr4SkPPdM="; # Replace with the actual hash
    #   };
    # });
    projects = {
      # cos = {
      #   root = "~/Projects/neovici/cosmoz-frontend/";
      #   sendkeys_timeout = 5000;
      #   windows = [
      #     {
      #       name = "dev1";
      #       root = ".";
      #       layout = "main-vertical";
      #       commands = [ "echo hello" ];
      #     }
      #     {
      #       name = "dev2";
      #       root = ".";
      #       layout = "main-vertical";
      #       commands = [ "echo hello" ];
      #     }
      #   ];
      # };
    };
  };
}
