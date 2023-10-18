-- [tpope/vim-fugitive] define command to open in browser
vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])
