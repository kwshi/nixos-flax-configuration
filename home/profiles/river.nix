{ pkgs, ... }: {
  home.packages = with pkgs;[
    river
    grim
    slurp
  ];
}
