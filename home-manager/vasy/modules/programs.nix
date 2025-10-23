{
  inputs,
  pkgs,
  ...
}:
{
  programs.btop.enable = true;
  programs.fzf.enable = true;
  programs.gh.enable = true;
  programs.htop.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      format = "$character$jobs$directory$git_branch$git_status$nix_shell \n› ";
      character = {
        format = "$symbol";
        error_symbol = "[  ](bold fg:red bg:#19172C)";
        success_symbol = "[  ](bold fg:green bg:#19172C)";
      };

      directory = {
        format = "[   $path ](bg:#2D2B40 fg:bright-white)[](fg:#2D2B40)";
      };

      git_branch = {
        format = "[  $branch ](fg:bright-white)";
      };

      jobs = {
        symbol = " 󰠜 ";
        style = "bright-white";
      };

      hostname = {
        ssh_only = true;
        format = "[ $hostname ](italic fg:bright-white bg:#19172C)";
      };

      nix_shell = {
        format = " [❄ $state( \($name\))](bold blue)";
      };
    };
  };
  programs.brave = {
    enable = true;
    commandLineArgs = [ "--password-store=basic" ];
  };
  programs.chromium = {
    enable = true;
  };
  programs.firefox = {
    enable = true;

    profiles.default = {
      extensions = {
        packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          # multi-account-containers
          ghostery
        ];
      };
      extraConfig = ''
        ${builtins.readFile "${inputs.betterfox}/user.js"}
      '';
    };
  };
  programs.zoxide.enable = true;

  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    extraOptions = [ "--group-directories-first" ];
  };

  programs.bat = {
    enable = true;
    config.theme = "Visual Studio Dark+";
    extraPackages = with pkgs.bat-extras; [
      batman
      batdiff
      batwatch
    ];
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "basilgood";
    userEmail = "elsile69@yahoo.com";
    ignores = [ ".jj" ];
    extraConfig = {
      core.editor = "nvim";
      core.filemode = false;
      init.defaultBranch = "master";
      merge = {
        tool = "nvimdiff";
        conflictstyle = "zdiff3";
      };
      mergetool = {
        nvimdiff = {
          trustExitCode = true;
          keepBackup = false;
        };
      };
      diff.colorMoved = "default";
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        diff-so-fancy = true;
      };
    };
  };

  programs.lazygit = {
    enable = true;

    settings = {
      gui = {
        nerdFontsVersion = "3";
      };
      customCommands = [
        {
          command = "git fetch --all --tags --prune --prune-tags";
          context = "global";
          key = "F";
          output = "popup";
        }
      ];
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
        autoForwardBranches = "none";
      };
    };
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    plugins = {
      ouch = pkgs.yaziPlugins.ouch;
      glow = pkgs.yaziPlugins.glow;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      smart-paste = pkgs.yaziPlugins.smart-paste;
      mediainfo = pkgs.yaziPlugins.mediainfo;
    };
    settings = {
      mgr = {
        ratio = [
          0
          1
          1
        ];
        show_hidden = false;
        sort_by = "alphabetical";
        sort_dir_first = true;
        preview = {
          max_width = 1200;
          max_height = 1800;
        };
      };
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    shellIntegration.mode = "no-cursor";
    settings = {
      term = "xterm-256color";
      scrollback_lines = 10000;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      disable_ligatures = "never";
    };
    font = {
      size = 16;
      name = "CaskaydiaCove NF";
      package = pkgs.nerd-fonts.caskaydia-cove;
    };
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      autoload
      reload
      sponsorblock
      uosc
      cutter
      webtorrent-mpv-hook
    ];
    bindings = {
      h = "seek -5";
      l = "seek 5";
      j = "cycle sub";
      J = "cycle sub down";
      k = "cycle audio";
      K = "cycle audio down";
      H = "seek -60";
      L = "seek 60";
      "Alt+0" = "set window-scale 0.5";
      "F3" = "cycle keepaspect";
      "F4" = "cycle-values panscan 1 0";
      "F10" = "cycle-values video-rotate 90 180 270 0";
      "p" = "script-binding webtorrent/toggle-info";
      "tab" = "script-binding uosc/toggle-ui";
    };
    config = {
      gpu-context = "wayland";
      hwdec = "auto";
      osc = "no";
      profile = "gpu-hq";
      vo = "gpu";
      save-position-on-quit = "yes";
      ytdl-format = "bestvideo+bestaudio";
      ao = "pulse";
    };
  };

  programs.aria2 = {
    enable = true;
    settings = {
      dir = "\${HOME}/Downloads/aria2";
      follow-torrent = false;
      peer-id-prefix = "";
      user-agent = "";
      summary-interval = "0";
    };
  };

  programs.home-manager.enable = true;
}
