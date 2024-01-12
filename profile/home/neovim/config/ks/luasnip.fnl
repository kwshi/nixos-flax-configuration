(local ls (require :luasnip))

(local snippet-types [:all :tex :markdown :html :typst])

(fn map-si [key f]
  (vim.keymap.set :s key f)
  (vim.keymap.set :i key f))

(ls.config.set_config {:update_events "TextChanged,TextChangedI"
                       :store_selection_keys :<tab>})

;;(vim.keymap.set :s :<tab> #(ls.jump 1))
;;(vim.keymap.set :s :<c-tab> #(ls.jump -1))
(map-si :<c-n> #(ls.change_choice 1))
(map-si :<c-p> #(ls.change_choice -1))
(each [_ ft (ipairs snippet-types)]
  (ls.add_snippets ft (require (.. :ks.luasnip. ft))))

