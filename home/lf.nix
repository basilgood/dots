{pkgs, ...}:
with pkgs; {
  programs.lf = {
    enable = true;
    settings = {
      shell = "bash";
      shellopts = "-eu";
      ifs = "\n";
      scrolloff = 10;
      hidden = false;
      icons = false;
      ratios = "1:1";
    };
    keybindings = {
      "<enter>" = "shell";
      "<delete>" = "delete";
      x = "$$f";
      X = "!$f";
      o = "open $f";
      "." = "set hidden!";
      i = ''''${{BAT_PAGER="less -R" ${bat}/bin/bat $f}}'';
    };
    commands = {
      open = ''
        ''${{
            case $(${file}/bin/file --mime-type $f -b) in
              image/svg+xml) inkscape $fx;;
              image/*) ${feh}/bin/feh $fx .;;
              application/pdf) ${mupdf}/bin/mupdf-gl $fx;;
              text/*|application/json) $EDITOR $fx;;
              audio/*) ${mpv}/bin/mpv $fx;;
              video/*) ${mpv}/bin/mpv $fx;;
              application/epub+zip) ${mupdf}/bin/mupdf-gl $fx;;
              *) for f in $fx; do setsid $OPENER $f > /dev/null 2> /dev/null & done;;
            esac
        }}
      '';
      rename = ''%[ -e $1 ] && printf "file exists" || mv $f $1'';
      extract = ''%${atool}/bin/atool -x "$f"'';
      unrar = ''%${unrar}/bin/unrar x "$f"'';
      tar = ''%${gnutar}/bin/tar cvf "$f.tar" "$f"'';
      targz = ''%${gnutar}/bin/tar cvzf "$f.tar.gz" "$f"'';
      tarbz2 = ''%${gnutar}/bin/tar cjvf "$f.tar.bz2" "$f"'';
      zip = ''%${zip}/bin/zip -r "$f" "$f"'';
    };
    previewer.source = "${pistol}/bin/pistol";
  };

  programs.bash = {
    shellAliases = {
      lf = "lfcd";
    };

    bashrcExtra = ''
      lfcd () {
        tmp="$(mktemp)"
        lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
          dir="$(cat "$tmp")"
          rm -f "$tmp"
          if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
              pushd $@ > /dev/null "$dir"
            fi
          fi
        fi
      }
    '';
  };
}
