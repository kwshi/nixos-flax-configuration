(import-macros {: snippet} :luasnip)

[(snippet :!dt [["<!doctype html>" /]
                [:<html> /]
                [:<head> /]
                ["  <meta charset=\"utf-8\"/>" /]
                ["  <title>" ($ 1) :</title> /]
                [:</head> /]
                [:<body> / ($ 0) / :</body> /]
                [:</html>]])
 (snippet :!c ["<!-- " ($$ 1) " -->"])]

