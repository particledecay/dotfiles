vim.o.mouse = 'v'                       -- Allow middle-click paste with mouse
vim.o.wildmode = 'longest,list'         -- Get bash-like tab completions
vim.o.encoding = 'utf-8'                -- UTF-8 encoding
vim.o.fileformat = 'unix'               -- unix-style line formatting
-- vim.o.inccommand = 'nosplit'            -- Incremental live completion
vim.o.hidden = true                     -- Do not save when switching buffers
vim.o.termguicolors = true              -- Terminal colors
vim.o.completeopt = 'menuone,noselect'  -- Allow for autocompletion

-- Global tab settings (overrides go in ftplugin files)
vim.cmd [[
  set expandtab
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
]]