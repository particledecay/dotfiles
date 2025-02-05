return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
      bg_theme = "summer",
      code_font_family = "MonoLisa",
      has_line_number = true,
      watermark = "@particledecay",
      save_path = os.getenv("HOME") .. "/Pictures/screenshots",
    },
    keys = {
      { "<leader>cs", ":CodeSnapSave<CR>",      mode = "x", desc = "Capture Snap" },
      { "<leader>ch", ":CodeSnapHighlight<CR>", mode = "x", desc = "Capture Snap with Highlight" },
    },
  },
}
