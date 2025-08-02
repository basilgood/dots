{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "5186af7984aa8cb0550358aefe751201d7a6b5a8";
    hash = "sha256-Cw5iMljJJkxOzAGjWGIlCa7gnItvBln60laFMf6PSPM=";
  };
  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "d794614";
    sha256 = "sha256-nXBxPG6PVi5vstvVMn8dtnelfCa329CTIOCdXruOxT4=";
  };
in
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    shellWrapperName = "y";
    settings = {
      manager = {
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
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "p" ];
          run = "plugin smart-paste";
        }
        {
          on = [ "d" ];
          run = "remove --permanently";
        }
        {
          on = [ "%" ];
          run = "create";
        }
        {
          on = [
            "g"
            "p"
          ];
          run = "cd ~/Projects";
        }
        {
          on = [
            "g"
            "?"
          ];
          run = "help";
        }
        {
          on = [ "<C-n>" ];
          run = ''
            shell 'ripdrag -nabtkr -s 16 -H 20 "$1" 2>/dev/null &' --confirm
          '';
        }
        {
          on = [
            "m"
            "a"
          ];
          run = "plugin archivemount --args=mount";
        }
        {
          on = [
            "m"
            "u"
          ];
          run = "plugin archivemount --args=unmount";
        }
        {
          on = [ "C" ];
          run = "plugin ouch --args=zip";
          desc = "Compress with ouch";
        }
        {
          on = "<C-d>";
          run = "plugin diff";
          desc = "Diff the selected with the hovered file";
        }
        {
          on = "T";
          run = "plugin toggle-pane min-preview";
          desc = "Hide or show preview";
        }
      ];
    };
    plugins = {
      inherit exifaudio;
      diff = "${yazi-plugins}/diff.yazi";
      smart-enter = "${yazi-plugins}/smart-enter.yazi";
      toggle-pane = "${yazi-plugins}/toggle-pane.yazi";
    };
  };

  xdg.configFile = {
    "yazi/plugins/smart-paste.yazi/init.lua".text =
      # lua
      ''
        --- @sync entry
        return {
        	entry = function()
        		local h = cx.active.current.hovered
        		if h and h.cha.is_dir then
        			ya.mgr_emit("enter", {})
        			ya.mgr_emit("paste", {})
        			ya.mgr_emit("leave", {})
        		else
        			ya.mgr_emit("paste", {})
        		end
        	end,
        }
      '';
  };

  home.packages = with pkgs; [
    exiftool # To get exif data of files.
    ffmpegthumbnailer # For thumbnails.
    file
    glow # For previewing markdown files.
    jq # For previewing JSON files.
    poppler
    ripgrep # For fg.yazi plugin.
    ripdrag # Drag and Drop utilty
    unar # for previewing archive files.
    ouch # for previewing archive files.
    mupdf # for pdf
    archivemount
    qimgv
  ];
}
