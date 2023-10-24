(import-macros {: snippet} :luasnip)

(icollect [k v (pairs (vim.fn.julia_latex_symbols#get_dict))]
  (snippet {:trig k :wordTrig false} [(.t v)]))
