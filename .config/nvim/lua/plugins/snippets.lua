-- [L3MON4D3/LuaSnip]
require('luasnip.loaders.from_vscode').lazy_load()

-- [rafamadriz/friendly-snippets]
local snip = require('luasnip')
snip.filetype_extend('django', { 'django' })
snip.filetype_extend('docker', { 'docker' })
snip.filetype_extend('go', { 'go' })
snip.filetype_extend('javascript', { 'javascript' })
snip.filetype_extend('kubernetes', { 'kubernetes' })
snip.filetype_extend('make', { 'make' })
snip.filetype_extend('python', { 'python' })
snip.filetype_extend('shell', { 'shell' })
snip.filetype_extend('sql', { 'sql' })
