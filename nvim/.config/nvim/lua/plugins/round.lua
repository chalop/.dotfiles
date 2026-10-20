return {
    {
        "saghen/blink.cmp",
        opts = {
            completion = {
                menu = { border = "rounded" },
                documentation = { window = { border = "rounded" } },
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
            },
        },
    },
    {
        "folke/noice.nvim",
        opts = {
            presets = {
                lsp_doc_border = true,
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                float = {
                    border = "rounded",
                },
            },
        },
    },
}
