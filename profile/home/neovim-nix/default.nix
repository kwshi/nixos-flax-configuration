{pkgs, ...}: let
  lua-config = pkgs.stdenv.mkDerivation {
    name = "ks-neovim-lua-config";
    src = ./config;
    buildInputs = [pkgs.fennel];
    buildPhase = ''
      fennel --compile 'init.fnl' > 'init.lua'

      readarray -t files < <(find 'ks' -type 'f' -name '*.fnl')
      for f in "''${files[@]}"; do
        mkdir -p "lua/$(dirname "$f")"
        fennel --compile "$f" > "lua/''${f%.fnl}.lua"
      done
    '';
    installPhase = ''
      mkdir -p "$out"
      cp -T 'init.lua' "$out/init.lua"
      cp -rT 'lua' "$out/lua"
    '';
  };
in {
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      null-ls-nvim
      neoscroll-nvim
      nvim-lspconfig
      telescope-nvim
      trouble-nvim
      nvim-web-devicons
      (nvim-treesitter.withPlugins (p:
        with p; [
          nix
          fennel
          ocaml
          typescript
        ]))
    ];

    extraPackages = with pkgs; [
      wl-clipboard

      fnlfmt
      black

      ccls
      rust-analyzer
      nodePackages.alex
      nodePackages."@prisma/language-server"
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      nodePackages.pyright
      nodePackages."@astrojs/language-server"
      ocamlPackages.ocaml-lsp
      gopls

      alejandra
      rnix-lsp
      nil

      typst-fmt
      typst-lsp

      elmPackages.elm-language-server
      elmPackages.elm-format
      elmPackages.elm-test
      elmPackages.elm-pages
    ];
  };

  xdg.configFile.nvim = {
    enable = true;
    source = lua-config;
  };
}
