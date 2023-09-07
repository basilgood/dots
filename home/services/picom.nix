{
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    vSync = true;
    settings = {
      detect-rounded-corners = true;
      unredir-if-possible = true;
    };
  };
}
