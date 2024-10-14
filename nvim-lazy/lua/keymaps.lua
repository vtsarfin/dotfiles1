vim.keymap.set(
  "",
  "<Leader>l",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)
vim.keymap.set('n', '<C-s>', "<Esc>:w<cr>")
--vim.keymap.set('i', '<C-s>', "<Esc>:w<cr>i" )
vim.keymap.set('n', '<Leader>f', "<Esc>:se foldenable<cr>")
vim.keymap.set('n', '<space>e', '<Esc>:lua vim.diagnostic.open_float()<cr>')
vim.keymap.set(
"",
  "<Leader>x",
  require("conform").format,
  { desc = "Format buffer with conform" }
)
