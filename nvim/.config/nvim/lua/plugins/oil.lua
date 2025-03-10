return {
    "stevearc/oil.nvim",
    opts = {
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = true,
        },
        float = {
            -- Padding around the floating window
            padding = 3,
            max_width = 100,
            max_height = 0,
        },
        keymaps = {
            ["<C-h>"] = false,
            ["<C-l>"] = false,
        },
    },
}
