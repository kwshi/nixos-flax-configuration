{pkgs, ...}: {
  home.packages = [(pkgs.octave.withPackages (opkgs: []))];
}
