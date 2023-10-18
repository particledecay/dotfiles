vim.bo.tabstop = 2       -- Number of columns occupied by tab character
vim.bo.softtabstop = 2   -- See multiple spaces as tabstops so <BS> does the right thing
vim.bo.shiftwidth = 2    -- Width for autoindents
vim.bo.autoindent = true -- Indent a new line the same amount as the line just typed

-- Bug: https://github.com/neovim/neovim/issues/12978
vim.cmd('set expandtab')

-- Don't save hidden buffers
vim.cmd('autocmd FileType netrw setl bufhidden=delete')
