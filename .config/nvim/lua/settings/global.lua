vim.o.mouse = 'v'                               -- Allow middle-click paste with mouse
vim.o.wildmode = 'longest,list'                 -- Get bash-like tab completions
vim.o.encoding = 'utf-8'                        -- UTF-8 encoding
vim.o.fileformat = 'unix'                       -- unix-style line formatting
vim.o.hidden = true                             -- Do not save when switching buffers
vim.o.termguicolors = true                      -- Terminal colors
vim.o.completeopt = 'menuone,noinsert,noselect' -- Allow for autocompletion
vim.o.splitbelow = true                         -- Split below (and focus)
vim.o.splitright = true                         -- Split to the right (and focus)

-- Global tab settings (overrides go in ftplugin files)
vim.cmd [[
  set expandtab
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
]]

-- Include line numbers in netrw (why isn't this the default?)
-- vim.g.netrw_bufsettings = 'noma nomod rnu nu nobl nowrap ro'
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
