(local tectonic-opts [:--keep-logs :--synctex  :-Z :shell-escape :-Z :search-path=../.ks-latex])
(local latexmk-opts [:-verbose :-file-line-error :-synctex=1 :interaction=nonstopmode :-shell-escape])

(set vim.g.vimtex_compiler_method :tectonic)

; https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command
; doesn't work; I also need some way of detecting the "current" file, or whatever
;(set vim.g.vimtex_compiler_generic {:command "tectonic --keep-logs --synctex --outdir '_build' -Z shell-escape -Z search-path=\"$(git rev-parse --show-toplevel)/.ks-latex\""})

; TODO: try checking path to look for ks-latex and dynamically construct
; tectonic args

(set vim.g.vimtex_compiler_tectonic {:build_dir :_build :options tectonic-opts})
(set vim.g.vimtex_compiler_latexmk {:build_dir :_build :options latexmk-opts})

(set vim.g.vimtex_compiler_latexmk_engines {:_ :-lualatex})


(set vim.g.vimtex_view_method :zathura)
(set vim.g.vimtex_quickfix_open_on_warning false)
(set vim.g.vimtex_format_enabled true)
(set vim.g.vimtex_mappings_disable {:i ["]]"]})
(set vim.g.vimtex_imaps_enabled false)
(set vim.g.vimtex_indent_on_ampersands false)
(set vim.g.vimtex_indent_lists list-envs)
(set vim.g.vimtex_indent_tikz_commands false)
