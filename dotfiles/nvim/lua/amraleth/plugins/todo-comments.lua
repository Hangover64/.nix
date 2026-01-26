return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_piority = 8,
      keywords = {
        FIX = {
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          icon = "⚠",
        },
        TODO = { icon="♪", color = "info"},
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
    }
  }
}
