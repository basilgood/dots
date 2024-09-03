{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi-unwrapped;
    enableBashIntegration = true;
    settings = {
      manager = {
        ratio = [0 1 1];
        show_hidden = false;
        sort_by = "alphabetical";
        sort_dir_first = true;
        preview = {
          max_width = 1200;
          max_height = 1800;
        };
        opener = {
          extract = {
            run = ''ouch d -y "$@"'';
          };
        };
      };
      headsup.disable_exec_warn = false;
      plugin.prepend_previewers = [
        {
          name = "*.md";
          run = "glow";
        }
        {
          mime = "application/*zip";
          run = "ouch";
        }
        {
          mime = "application/x-tar";
          run = "ouch";
        }
        {
          mime = "application/x-bzip2";
          run = "ouch";
        }
        {
          mime = "application/x-7z-compressed";
          run = "ouch";
        }
        {
          mime = "application/x-rar";
          run = "ouch";
        }
        {
          mime = "application/x-xz";
          run = "ouch";
        }
      ];
      log = {enabled = false;};
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = ["p"];
          run = "plugin --sync smart-paste";
        }
        {
          on = ["d"];
          run = "remove --permanently";
        }
        {
          on = ["%"];
          run = "create";
        }
        {
          on = [">"];
          run = ''
            shell 'brave "$@" -x 2>/dev/null &' --confirm
          '';
        }
        {
          on = ["g" "p"];
          run = "cd ~/Projects";
        }
        {
          on = ["g" "?"];
          run = "help";
        }
        {
          on = ["<C-n>"];
          run = ''
            shell 'xdragon "$@" -x 2>/dev/null &' --confirm
          '';
        }
        {
          on = ["m" "a"];
          run = "plugin archivemount --args=mount";
        }
        {
          on = ["m" "u"];
          run = "plugin archivemount --args=unmount";
        }
        {
          on = ["C"];
          run = "plugin ouch --args=zip";
          desc = "Compress with ouch";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    exiftool # To get exif data of files.
    ffmpegthumbnailer # For thumbnails.
    file
    glow # For previewing markdown files.
    jq # For previewing JSON files.
    poppler
    ripgrep # For fg.yazi plugin.
    xdragon # Drag and Drop utilty
    unar # for previewing archive files.
    ouch # for previewing archive files.
    mupdf # for pdf
    archivemount
  ];

  xdg.configFile = {
    "yazi/theme.toml".text = builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/yazi-rs/flavors/main/catppuccin-mocha.yazi/flavor.toml";
      hash = "sha256-ZjafhQCs+6pkCAU7FzW6quehFqE7DsfzvVMQaXrPhHE=";
    });

    "yazi/plugins/glow.yazi".source = pkgs.fetchFromGitHub {
      owner = "Reledia";
      repo = "glow.yazi";
      rev = "536185a4e60ac0adc11d238881e78678fdf084ff";
      hash = "sha256-NcMbYjek99XgWFlebU+8jv338Vk1hm5+oW5gwH+3ZbI=";
    };

    "yazi/plugins/archivemount.yazi".source = pkgs.fetchFromGitHub {
      owner = "AnirudhG07";
      repo = "archivemount.yazi";
      rev = "354a4d6df9df6187f811c9e24598351e3180e195";
      hash = "sha256-nRkA5fOnPAW6xhIrieLFjajWvFgyyQLsuQE4lV31y7A=";
    };

    "yazi/plugins/ouch.yazi".source = pkgs.fetchFromGitHub {
      owner = "ndtoan96";
      repo = "ouch.yazi";
      rev = "251da6930ca8b7ee0384810086c3bf644caede3e";
      hash = "sha256-yLt9aY6hUIOdBI5bMdCs7VYFJGyD3WIkmPxvWKNCskA=";
    };

    "yazi/plugins/smart-paste.yazi/init.lua".text = ''
      return {
        entry = function()
          local h = cx.active.current.hovered
          if h and h.cha.is_dir then
            ya.manager_emit("enter", {})
            ya.manager_emit("paste", {})
            ya.manager_emit("leave", {})
          else
            ya.manager_emit("paste", {})
          end
        end,
      }
    '';
  };
}
