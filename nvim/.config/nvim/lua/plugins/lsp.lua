-- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            ["*"] = {
                keys = {
                    { "gh", vim.lsp.buf.hover, mode = "n", desc = "Hover docs" },
                    { "K", false },
                },
            },
        },
    },
}
