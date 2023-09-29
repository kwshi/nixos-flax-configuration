(local lsp (require :lspconfig))

(fn format [async]
  (vim.lsp.buf.format {: async :filter #(~= $ :tsserver)}))

(fn on_attach [client buffer]
  (let [bufopts {:noremap true :silent true : buffer}]
    (vim.keymap.set :n :<leader><leader> vim.lsp.buf.hover bufopts)
    (vim.keymap.set :n :<leader>f #(format true))
    (vim.api.nvim_create_autocmd [:BufWritePre]
                                 {: buffer :callback #(format false)})))

;(lsp.rnix.setup {: on_attach})
(lsp.nil_ls.setup {: on_attach
                  :settings 
                  {:nil {
                  :formatting {:command [:alejandra]}}}})
