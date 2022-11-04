local nvim_lsp = require('lspconfig')
local util = require('lspconfig/util')
local null_ls = require('null-ls')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Update capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Define specific languages
local default_lspconfig = { on_attach = on_attach, capabilities = capabilities }
-- local servers = {
--   pylsp = {
--     configurationSources = { 'flake8' },
--     root_dir = function(fname)
--       local root_files = {
--         'pyproject.toml',
--         'setup.py',
--         'setup.cfg',
--         'requirements.txt',
--         'Pipfile',
--       }
--       return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
--     end,
--   },
--   terraformls = {
--     filetypes = { "terraform", "terragrunt", "tf", "hcl" },
--   },
--   bashls = {},
--   gopls = {
--     cmd = { 'gopls', 'serve' },
--     filetypes = { 'go', 'gomod', 'gotmpl' },
--     root_dir = function(fname)
--       local root_files = {
--         'go.work',
--         'go.mod',
--         '.git',
--       }
--       return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
--     end,
--     settings = {
--       gopls = {
--         analyses = {
--           unusedparams = true,
--         },
--         staticcheck = true,
--       },
--     },
--   },
--   jsonls = {
--     commands = {
--       Format = {
--         function()
--           vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
--         end
--       }
--     }
--   },
-- }

-- -- Map all the defined servers
-- for server, config in pairs(servers) do
--   nvim_lsp[server].setup { vim.tbl_deep_extend('force', default_lspconfig, config) }
-- end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local code = null_ls.builtins.code_actions
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting
local hov = null_ls.builtins.hover

null_ls.setup({
  sources = {
    code.gitrebase,
    code.gitsigns,
    code.shellcheck,
    
    diag.actionlint,
    diag.ansiblelint,
    diag.commitlint,
    diag.djlint,
    diag.eslint_d,
    diag.fish,
    diag.flake8,
    diag.jsonlint,
    diag.mypy,
    diag.revive,
    diag.shellcheck,
    diag.todo_comments,
    diag.vulture,

    fmt.autopep8,
    fmt.eslint_d,
    fmt.fish_indent,
    fmt.gofmt,
    fmt.goimports,
    fmt.isort,
    fmt.jq,
    fmt.prettierd,
    fmt.terraform_fmt,
    fmt.trim_newlines,
    fmt.trim_whitespace,

    hov.printenv,
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
