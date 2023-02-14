{ pkgs, config, ... }: {
  home.packages = [
    (pkgs.python3.withPackages (pyPkgs: with pyPkgs; [
      ipython
      numpy
      sympy
      matplotlib
    ]))
  ];

  home.file.".ipython/profile_default/startup".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/flax/.ipython/profile_default/startup";
}
