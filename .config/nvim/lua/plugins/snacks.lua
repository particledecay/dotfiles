local project_picker = {
  finder = "recent_projects",
  format = "file",
  dev = { "~/projects", "~/projects/gametime" },
  confirm = "load_session",
  patterns = { ".git", "requirements.txt", "pyproject.toml", "package.json", "Makefile", "README.md" },
  recent = true,
  matcher = {
    frecency = true,
    sort_empty = true,
    cwd_bonus = false,
  },
  sort = { fields = { "score:desc", "idx" } },
  limit = 50,
  win = {
    preview = { minimal = true },
  },
}

return {
  -- https://github.com/folke/snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true, only_scope = true, chunk = { enabled = true } },
      input = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            hidden = true,
            replace_netrw = true,
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader>.",  function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>/",  function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>e",  function() Snacks.explorer() end,                                       desc = "File Explorer" },

      -- find
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects(project_picker) end,                  desc = "Projects" },

      -- git
      { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff" },
      { "<leader>gb", function() Snacks.git.blame_line() end,                                 desc = "Git Blame" },
      { "<leader>gB", function() Snacks.gitbrowse() end,                                      desc = "Git Browse" },
      { "<leader>lg", function() Snacks.lazygit() end,                                        desc = "Lazygit" },

      -- search
      { "<leader>D",  function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },

      -- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gr",         function() Snacks.picker.lsp_references() end,                          desc = "References" },
      { "<leader>s",  function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },

      -- terminal
      { "<leader>t",  function() Snacks.terminal() end,                                       desc = "Terminal" },

    },
  },

  {
    "folke/trouble.nvim",
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<C-t>"] = { "trouble_open", mode = { "n", "i" } },
                },
              },
            },
          },
        })
      end,
    },
  },

  {
    "folke/edgy.nvim",
    ---@module "edgy"
    ---@param opts Edgy.Config
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
                and vim.w[win].snacks_win.position == pos
                and vim.w[win].snacks_win.relative == "editor"
                and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
      { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
}
