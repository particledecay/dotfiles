return {
  -- https://github.com/zbirenbaum/copilot.lua
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
        keymap = {
          accept = "<Right>",
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Right>",
          accept_word = false,
          accept_line = false,
        },
      },
      filetypes = {
        css = true,
        docker = true,
        fish = true,
        go = true,
        graphql = true,
        html = true,
        javascript = true,
        javsscriptreact = true,
        json = true,
        lua = true,
        markdown = false,
        python = true,
        ruby = true,
        rust = true,
        scss = true,
        shell = true,
        sql = true,
        terraform = true,
        typescript = true,
        typescriptreact = true,
        vim = true,
        xml = true,
        yaml = true,
      },
      copilot_node_command = vim.fn.expand("$HOME") .. "/.nodenv/versions/18.7.0/bin/node",
      -- copilot_node_command = "node",
      server_opts_overrides = {},
    },
  },
}
