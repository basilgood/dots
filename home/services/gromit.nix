_: {
  services.gromit-mpx = {
    enable = true;

    tools = [
      {
        color = "red";
        device = "default";
        size = 5;
        type = "pen";
      }
      {
        color = "blue";
        device = "default";
        modifiers = [
          "SHIFT"
        ];
        size = 5;
        type = "pen";
      }
      {
        color = "yellow";
        device = "default";
        modifiers = [
          "CONTROL"
        ];
        size = 5;
        type = "pen";
      }
      {
        arrowSize = 1;
        color = "green";
        device = "default";
        modifiers = [
          "2"
        ];
        size = 6;
        type = "pen";
      }
      {
        device = "default";
        modifiers = [
          "3"
        ];
        size = 75;
        type = "eraser";
      }
    ];
  };
}
