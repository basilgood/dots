_: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "basilgood";
    userEmail = "elsile69@yahoo.com";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "master";
      merge.conflictstyle = "diff3";
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
        showFileTree = false;
        theme = {
          lightTheme = false;
          activeBorderColor = ["#a6e3a1" "bold"];
          inactiveBorderColor = ["#cdd6f4"];
          optionsTextColor = ["#89b4fa"];
          selectedLineBgColor = ["#37383d"];
          selectedRangeBgColor = ["#37383d"];
          cherryPickedCommitBgColor = ["#37383d"];
          cherryPickedCommitFgColor = ["#89b4fa"];
          unstagedChangesColor = ["#b15e7c"];
        };
      };

      customCommands = [
        {
          command = "git fetch --all --tags --prune --prune-tags";
          context = "files";
          key = "F";
          showOutput = true;
        }
      ];

      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };

      keybinding = {
        universal = {
          undo = "Z";
        };
      };
    };
  };
}
