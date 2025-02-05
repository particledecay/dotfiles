-- Global indentation settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Numbering
vim.wo.number = true
vim.wo.relativenumber = true

-- Misc
vim.o.mouse = "v"          -- Allow middle-click paste with mouse
vim.o.termguicolors = true -- Terminal colors
vim.o.splitbelow = true    -- Split below (and focus)
vim.o.splitright = true    -- Split to the right (and focus)
vim.o.encoding = "utf-8"   -- UTF-8 encoding
vim.o.fileformat = "unix"  -- unix-style line formatting

-- Window navigations
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { noremap = true })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { noremap = true })

-- LSP
vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
