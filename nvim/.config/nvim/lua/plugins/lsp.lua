-- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
return {
    "neovim/nvim-lspconfig",
    init = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()

        keys[#keys + 1] = { "gh", vim.lsp.buf.hover, mode = "n", desc = "Hover docs" }
        keys[#keys + 1] = { "K", false }
    end,
}
