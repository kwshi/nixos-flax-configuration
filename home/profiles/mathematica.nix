{ pkgs, ... }: {
  home.packages = [
    (pkgs.mathematica.override {
      source = ../../mathematica/Mathematica_13.2.1_BNDL_LINUX.sh;
    })
  ];
}
