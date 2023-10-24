(local ns (require :neoscroll))

(ns.setup
  {:mappings []
  :easing_function :sine})

(vim.keymap.set :n :<C-d>
    #(ns.scroll vim.wo.scroll true 100 :sine))

(vim.keymap.set :n :<C-u>
    #(ns.scroll (- vim.wo.scroll) true 100 :sine))

(vim.keymap.set :n :gg
      #(ns.gg 50))

;(vim.keymap.set :n :G
;      #(ns.G 100))
