{pkgs, ...}: {
  programs.zk = {
    enable = true;
    settings = {
      note = {
        language = "en";
        default-title = "Untitled";
        filename = "{{id}}-{{slug title}}";
        extension = "md";
        id-charset = "alphanum";
        id-length = 5;
        id-case = "lower";
      };

      tool = {
        fzf-preview = "${pkgs.glow}/bin/glow --pager -s dark {-1}";
      };

      alias = {
        last = "zk edit --limit 1 --sort modified- $@";
        recent = "zk edit --sort created- --created-after 'last week' --interactive";
      };
    };
  };
}
