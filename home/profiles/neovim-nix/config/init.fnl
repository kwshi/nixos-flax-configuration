
(local options
  {:number true
   :termguicolors true
   :expandtab true
   :autochdir true
   :shiftwidth 2
   :tabstop 2
   :signcolumn :number
   :wildmode "list:longest"
   :backupcopy :yes
   :inccommand :nosplit
   :mouse :a
   :textwidth 80})

(each [k v (pairs options)]
  (tset vim.o k v))

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(vim.cmd "colorscheme gruvbox")

(vim.loader.enable)
(require :ks.tree-sitter)
(require :ks.neoscroll)
(require :ks.lspconfig)
(require :ks.telescope)
