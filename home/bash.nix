{pkgs, ...}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      grep = "grep --color=auto";
      ls = "ls --color=tty";
      ll = "ls -l";
      l = "ls -alh";
      lt = "${pkgs.tree}/bin/tree -L 1";
      ha = "history -n";
    };
    historySize = -1;
    historyFileSize = -1;
    historyControl = ["ignoredups" "erasedups"];
    historyIgnore = [
      "ls"
      "exit"
      "history"
      "kill"
      "fg"
      "bg"
      "mpv"
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
      bind '"\e[M": kill-word'
      bind '"\C-h": backward-kill-word'
      hm() {
        sed 's/[[:space:]]*$//' $HISTFILE | tac | awk '!x[$0]++' | tac | ${pkgs.moreutils}/bin/sponge $HISTFILE
      }
      stty -ixon
    '';

    bashrcExtra = ''
      BD="\[\e[1m\]"
      N="\[\e[0m\]"
      R="\[\e[31m\]"
      Y="\[\e[33m\]"
      B="\[\e[34m\]"
      P="\[\e[35m\]"
      ARW="⤚ "
      _set_bash_prompt() {
        EXIT="$?"
        [ $EXIT -eq 0 ] && err="$B" || err="$R"
        [ $(jobs -p | wc -l) -ne 0 ] && JBV=" $Y•$N" || JBV=""
        [ -n "$IN_NIX_SHELL" ] && NIX=" $B❄-$IN_NIX_SHELL$N"
        if [ ! -d "$PWD/.git" ]; then
          PS1="$BD$P\W$N$NIX$JBV\n$err$ARW$N"
          PS2="↪︎$NC"
        else
          M=" "
          ref=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
          [[ "$ref" == "HEAD" ]] && ref='detached*'
          status="$(git status --porcelain -b 2>/dev/null)"
          [[ $status =~ ([[:cntrl:]][A-Z][A-Z\ ]\ ) ]] && M+="+"
          [[ $status =~ ([[:cntrl:]][A-Z\ ][A-Z]\ ) ]] && M+='٭'
          [[ $status =~ ([[:cntrl:]]\?\?\ ) ]] && M+='?'
          [[ -e "$PWD/.git/refs/stash" ]] && M+='≡'
          [[ $status =~ ahead\ ([0-9]+) ]] && M+=''${BASH_REMATCH[1]}'⇡'
          [[ $status =~ behind\ ([0-9]+) ]] && M+=''${BASH_REMATCH[1]}'⇣'
          PS1="$BD$P\W$N $Y$N $BD$B$ref$R$M$N$NIX$JBV\n$err$ARW$N"
          PS2="↪︎$NC"
        fi
      }
      PROMPT_COMMAND=_set_bash_prompt
    '';
  };
}
