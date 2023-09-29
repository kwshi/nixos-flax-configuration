(local telescope (require :telescope))
(local builtin (require :telescope.builtin))

(vim.keymap.set :n :<leader>b #(builtin.buffers))
(vim.keymap.set :n :<leader>E #(builtin.diagnostics))
(vim.keymap.set :n :<leader>l #(builtin.find_files))
(vim.keymap.set :n :<leader>L #(builtin.git_files))
