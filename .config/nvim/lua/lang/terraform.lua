vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead *.tf set filetype=terraform
]], false)
