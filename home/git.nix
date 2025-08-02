{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "basilgood";
    userEmail = "elsile69@yahoo.com";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "master";
      merge = {
        tool = "nvimdiff";
        conflictstyle = "zdiff3";
      };
      mergetool = {
        nvimdiff = {
          # layout = "LOCAL,MERGED,REMOTE";
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
      keybinding = {
        universal = {
          undo = "Z";
        };
      };
    };
  };
  home.packages = with pkgs; [
    git-filter-repo
    difftastic
    diffnav
  ];
}
