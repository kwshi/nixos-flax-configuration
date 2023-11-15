{pkgs, ...}: {
  home.packages = with pkgs; [
    solvespace
    fstl
    openscad
  ];
}
