(local conform (require :conform))
(local conform/util (require :conform.util))

(local formatters {:fnlfmt {:command :fnlfmt :args ["-"] :stdin true}
                   :latexindent {:cwd (conform/util.root_file [:.latexindent.yaml])
                                 :prepend_args [:-m :-l]}})

(local formatters_by_ft {:python [:ruff_format]
                         :just [:just]
                         :nix [:alejandra]
                         :fennel [:fnlfmt]
                         :tex [:latexindent]
                         :typst [:typstfmt]
                         :html [:prettierd]})

(conform.setup {: formatters
                : formatters_by_ft
                :format_on_save {:timeout_ms 500 :lsp_fallback true}})

(vim.keymap.set :n :<leader>f
                #(conform.format {:timeout_ms 500 :lsp_fallback true}))

