(local cmp (require :cmp))
(local ls (require :luasnip))

(cmp.setup {:completion {:autocomplete false}
            :snippet {:expand #(ls.lsp_expand $.body)}
            :mapping {:<C-Tab> (fn [fallback]
                                 (cmp.complete))
                      :<Tab> (fn [fallback]
                               (if (cmp.visible) (cmp.select_next_item)
                                   (ls.expand_or_locally_jumpable) (ls.expand_or_jump)
                                   (fallback)))
                      :<CR> (fn [fallback]
                              (if (cmp.visible)
                                  (if (cmp.get_active_entry)
                                      (cmp.confirm {:select true}) ; https://github.com/hrsh7th/nvim-cmp/issues/1251#issuecomment-1365229958
                                      (cmp.abort)
                                      (cmp.core:reset))
                                  (fallback)))}
            :sources (cmp.config.sources [{:name :luasnip} {:name :nvim_lsp}])})

