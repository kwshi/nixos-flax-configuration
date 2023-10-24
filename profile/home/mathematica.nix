{ pkgs, ... }: {
  # some instructions taken from `https://www.balderholst.com/how-to/install-mathematica-on-nixos/`
  home.packages = [
    (pkgs.mathematica.override {
      version = "13.2.1";
      #source = let version = "13.3.1"; in
      #  pkgs.requireFile {
      #    name = "Mathematica_${version}_BNDL_LINUX.sh";
      #    message = "missing mathematica installer script";
      #    sha256 = "sha256:1xl6ji8qg6bfz4z72b8czl0cx36fzfkxhygsn0m8xd0qgkkpjqfg";
      #    hashMode = "recursive";
      #  };
    })
  ];
}
