{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-ssh
      ms-vsliveshare.vsliveshare
      ms-vscode.live-server
      asvetliakov.vscode-neovim
      esbenp.prettier-vscode
    ];
    mutableExtensionsDir = false;
    userSettings = {
      "editor.autoClosingBrackets" = "never";
      "editor.autoClosingComments" = "never";
      "editor.autoClosingQuotes" = "never";
    };
  };
}
