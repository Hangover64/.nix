require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "ayu_mirage",
    },
    sections = {
        lualine_a = { "filename" },
        lualine_b = { "mode" },
        lualine_c = { "branch" },
        lualine_x = { "filetype", "encoding" }
    },
}
