-- force .tf files to be filetype=terraform
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.tf" },
  command = "set filetype=terraform",
})
