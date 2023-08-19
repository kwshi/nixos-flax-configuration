{ pkgs, ... }: {
  home.packages = [
    (pkgs.mathematica.override {
      source = ../../mathematica/Mathematica_13.3.0_BNDL_LINUX.sh;
    })
  ];
}
