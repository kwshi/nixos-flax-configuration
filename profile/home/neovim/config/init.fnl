(local options {:number true
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

(fn main []
  (each [k v (pairs options)]
    (tset vim.o k v))
  (set vim.g.mapleader " ")
  (set vim.g.maplocalleader ",")
  (vim.cmd "colorscheme gruvbox")
  (vim.api.nvim_create_autocmd [:BufEnter]
                               {:callback #(set vim.o.formatoptions :qjmMl)})
  (vim.keymap.set :n :<leader>e #(vim.diagnostic.open_float))
  (vim.loader.enable)
  (require :ks.tree-sitter)
  (require :ks.neoscroll)
  (require :ks.lspconfig)
  (require :ks.telescope)
  (require :ks.vimtex)
  (require :ks.luasnip)
  (require :ks.cmp)
  (require :ks.conform)
  (require :ks.rextify))

(if (not vim.g.vscode) (main))

