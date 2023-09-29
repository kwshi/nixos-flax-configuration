{pkgs, ...}: {
  programs.sagemath = {
    enable = true;
    package = pkgs.sage.override {
      extraPythonPackages = pyPkgs:
        with pyPkgs; [
          pyppeteer
        ];
    };
  };
}
