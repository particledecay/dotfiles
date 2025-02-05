return {
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      icons_enabled = true,
      theme = "catppuccin",
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
    },
  }
}
