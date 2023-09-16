vim.keymap.set(
  "",
  "<Leader>l",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)
vim.keymap.set('n', '<C-s>', "<Esc>:w<cr>")
--vim.keymap.set('i', '<C-s>', "<Esc>:w<cr>i" )
vim.keymap.set('n', '<C-f>', "<Esc>:se foldenable<cr>")
vim.keymap.set('n', '<space>e', '<Esc>:lua vim.diagnostic.open_float()<cr>')



