return {
  -- https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },
      messages = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      popmenu = {
        enabled = false,
      },
    },
  }
}
