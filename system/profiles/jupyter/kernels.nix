pkgs: {
  python3 = import ./kernel/python3.nix pkgs;
  sage = import ./kernel/sage.nix pkgs;
}
