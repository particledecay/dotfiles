-- force git commits to automatically wrap at 110 characters
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.git/COMMIT_EDITMSG" },
  command = "setlocal textwidth=110",
})
