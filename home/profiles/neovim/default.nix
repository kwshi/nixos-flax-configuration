{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;

    # only pre-install `hotpot.nvim` for bootstrapping;
    # rest of the plugins are managed (mutably) within
    # neovim configuration via `lazy.nvim`
    plugins = with pkgs.vimPlugins; [ hotpot-nvim ];

    extraPackages = with pkgs; [
      zig # for treesitter compilation
      fnlfmt
      black
      xsel

      rust-analyzer
      nodePackages."@prisma/language-server"
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      nodePackages.pyright
      ocamlPackages.ocaml-lsp
      rnix-lsp
      gopls
    ];
  };
  xdg.configFile.nvim.source = config.lib.file.mkDotfileSymlink "flax/neovim";
}
