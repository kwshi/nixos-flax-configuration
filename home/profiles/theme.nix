{pkgs, ...}: {
  gtk = {
    enable = true;
    font = {
      package = pkgs.julia-mono;
      name = "JuliaMono";
      size = 10;
    };
  };
}
