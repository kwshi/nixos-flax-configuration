{
  lib,
  pkgs,
  ...
}: {
  system.activationScripts.binbash = lib.stringAfter ["binsh"] ''
    ln -sfn "${pkgs.bashInteractive}/bin/bash" '/bin/.bash.tmp' \
      && mv '/bin/.bash.tmp' '/bin/bash';
  '';
}
