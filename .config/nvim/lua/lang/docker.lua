vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead Dockerfile.* set filetype=dockerfile
]], false)
