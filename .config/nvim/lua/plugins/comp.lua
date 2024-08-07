local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
        -- local copilot_keys = vim.fn["copilot#Accept"]()
        -- if copilot_keys ~= "" then
        --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
        -- else
        --   fallback()
        -- end
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump_prev()
      else
        fallback()
        -- local copilot_keys = vim.fn["copilot#Accept"]()
        -- if copilot_keys ~= "" then
        --   vim.api.nvim_feedkeys(copilot_keys, "i", true)
        -- else
        --   fallback()
        -- end
      end
    end,
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-J>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-K>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'path' },
    -- { name = 'copilot' },
    -- { name = 'codeium' },
  },
})
