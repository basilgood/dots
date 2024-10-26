{pkgs, ...}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      grep = "grep --color=auto";
      lt = "${pkgs.tree}/bin/tree -L 1";
      hm = "sed 's/[[:space:]]*$//' $HISTFILE | tac | awk '!x[$0]++' | tac | ${pkgs.moreutils}/bin/sponge $HISTFILE";
      b = "${pkgs.bartib}/bin/bartib -f ~/.bartib";
    };
    historySize = -1;
    historyFileSize = -1;
    historyControl = ["ignoredups" "erasedups"];
    historyIgnore = ["l" "ls" "ll" "lt" "cd" "rm" "rm rf" "hm" "yt" "exit" "history" "kill" "pkill" "fg" "bg" "mpv" "aria2c" "yazi"];
    shellOptions = ["nocaseglob" "autocd" "dirspell" "cdspell" "cmdhist" "histappend"];
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
      BD="\[\e[1m\]"
      N="\[\e[0m\]"
      R="\[\e[31m\]"
      Y="\[\e[33m\]"
      B="\[\e[34m\]"
      P="\[\e[35m\]"

      PROMPT_SYMBOL="› "
      JBV_SYMBOL="•"
      NIX_SYMBOL="❄-"

      _set_bash_prompt() {
        local EXIT=$?
        local ERR=$([[ $EXIT -eq 0 ]] && echo "$B" || echo "$R")
        local JBV=$([[ $(jobs -p | wc -l) -ne 0 ]] && echo " $Y$JBV_SYMBOL$N" || echo "")
        local NIX=$([[ -n "$IN_NIX_SHELL" ]] && echo " $B$NIX_SYMBOL$IN_NIX_SHELL$N" || echo "")

        if [ ! -d "$PWD/.git" ]; then
          PS1="$BD$P\W$N$NIX$JBV\n$ERR$PROMPT_SYMBOL$N"
          PS2="↪︎$N"
        else
          local M=" "
          local head=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
          local status=$(git status --porcelain -b 2>/dev/null)

          M+=$( [[ $status =~ ([[:cntrl:]][A-Z][A-Z\ ]\ ) ]] && echo "+")
          M+=$( [[ $status =~ ([[:cntrl:]][A-Z\ ][A-Z]\ ) ]] && echo "٭")
          M+=$( [[ $status =~ ([[:cntrl:]]\?\?\ ) ]] && echo "?")
          M+=$( [[ -e "$PWD/.git/refs/stash" ]] && echo "≡")
          M+=$( [[ $status =~ ahead\ ([0-9]+) ]] && echo "''${BASH_REMATCH[1]}⇡")
          M+=$( [[ $status =~ behind\ ([0-9]+) ]] && echo "''${BASH_REMATCH[1]}⇣")

          PS1="$BD$P\W$N $Y$N $BD$B$head$R$M$N$NIX$JBV\n$ERR$PROMPT_SYMBOL$N"
          PS2="↪︎$N"
        fi
      }

      PROMPT_COMMAND=_set_bash_prompt
    '';
    sessionVariables = {
      VLC_PLUGIN_PATH = "${pkgs.vlc-bittorrent}";
    };
  };
}
