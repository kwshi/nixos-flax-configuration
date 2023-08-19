{ pkgs, ... }: {
  home.packages = [
    (pkgs.haskellPackages.ghcWithPackages (ps: with ps; [
      stack
    ]))
  ];
}
