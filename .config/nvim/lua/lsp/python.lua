local lspconfig = require('lspconfig')
local lspformat = require('lsp-format')
local python_dir;

-- check whether we're in a virtualenv and if so, set the python_dir
if vim.env.VIRTUAL_ENV then
  python_dir = vim.env.VIRTUAL_ENV .. "/bin/"
else
  python_dir = "$HOME/.pyenv/versions/3.8.18/bin/"
end

-- set the python binary
vim.g.python3_host_prog = python_dir .. "python"

-- rule ignores
local ignored_rules = {
  "C0114", -- missing module docstring
  "C0115", -- missing class docstring
  "C0116", -- missing function docstring
  "D100",  -- missing docstring in public module
  "D101",  -- missing docstring in public class
  "D104",  -- missing docstring in public package
  "D105",  -- missing docstring in magic method
  "D107",  -- missing docstring in __init__
}

-- pylsp configuration
local settings = {
  pylsp = {
    plugins = {
      pycodestyle = {
        enabled = true,
        ignore = ignored_rules,
        maxLineLength = 100,
      },
      pydocstyle = {
        enabled = true,
        convention = "google",
        ignore = ignored_rules,
      },
      pylint = {
        enabled = true,
        args = {
          "--disable=" .. table.concat(ignored_rules, ",")
        },
        executable = python_dir .. "pylint",
      },
      jedi_completion = {
        enabled = true,
        fuzzy = true,
      },
      rope_autoimport = {
        enabled = true,
      },
      yapf = {
        enabled = true
      },
    }
  }
}

lspconfig.pylsp.setup({
  cmd = { python_dir .. "pylsp" },
  on_attach = lspformat.on_attach,
  capabilities = lspformat.capabilities,
  init_options = settings
})
