{ pkgs, ... }: {
  programs.sagemath = {
    enable = true;
    package = pkgs.sage.override {
      requireSageTests = false;
      extraPythonPackages = pyPkgs: with pyPkgs; [
        jupyterlab
        pyppeteer
        pandas
      ];
    };
  };
}
