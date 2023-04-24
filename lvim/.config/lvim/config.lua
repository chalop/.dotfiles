-- Packer
lvim.plugins = {
    { "folke/trouble.nvim", cmd = "TroubleToggle" },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        -- commit = 'dc446e87fc299475cc80205b0b91bf07180e76e3',
        config = function()
            require('lspsaga').setup({
                ui = { border = 'rounded', colors = { normal_bg = "NONE", } },
                symbol_in_winbar = { enable = false }
            })
        end,
    },
    {
        "Mofiqul/dracula.nvim",
        config = function()
            require('dracula').setup({ italic_comment = true })
        end,
    },
    { "mbbill/undotree" },
    { 'sigmasd/deno-nvim' },
    { "ggandor/leap.nvim" },
    { "uarun/vim-protobuf" },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                    "astro",
                    "css",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "scss",
                    "typescript",
                    "typescriptreact",
                    "json",
                },
                {
                    RGB = true,      -- #RGB hex codes
                    RRGGBB = true,   -- #RRGGBB hex codes
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    rgb_fn = true,   -- CSS rgb() and rgba() functions
                    hsl_fn = true,   -- CSS hsl() and hsla() functions
                    css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
                })
        end,
    },
    {
        "~/Dev/m/freewolf.nvim",
        config = function()
            require("freewolf").setup({
                transparent_bg = true,
                italic_comment = true,
                italic_code = true,
                show_end_of_buffer = true,
            })

            vim.cmd("colorscheme freewolf")
        end
    },
    { "nvim-treesitter/playground",   event = "BufRead" },
    -- { "zbirenbaum/copilot.lua",
    --     event = { "VimEnter" },
    --     config = function()
    --         vim.defer_fn(function()
    --             require("copilot").setup {
    --                 -- LunarVim users need to specify path to the plugin manager
    --                 plugin_manager_path = os.getenv "LUNARVIM_RUNTIME_DIR" .. "/site/pack/packer",
    --             }
    --         end, 100)
    --     end,
    -- },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     after = { "copilot.lua" },
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end
    -- },
    -- { "github/copilot.vim" },
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker")
        end,
    },
    {
        "gbrlsnchs/winpick.nvim",
        config = function()
            require("winpick").setup({
                border = "rounded",
                -- filter = nil, -- doesn't ignore any window by default
                prompt = "Select a window: ",
                -- format_label = require('winpick').defaults.format_label, -- formatted as "<label>: <buffer name>"
                chars = nil,
            })
        end
    },
    {
        's1n7ax/nvim-window-picker',
        -- tag = 'v1.*',
        config = function()
            require('window-picker').setup({
                selection_chars = 'HTNSAOEUGCRL"<>PXB',
                fg_color = '#1F2225',
                other_win_hl_color = '#FFAF00',
            })
        end
    },
    { 'ThePrimeagen/harpoon' },
    { 'editorconfig/editorconfig-vim' },
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = "markdown",
        config = function()
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_port = 8668
        end,
    },
    {
        "ellisonleao/glow.nvim",
        config = function()
            require("glow").setup({
                border = "rounded"
            })
        end,
        -- run = "yay -S glow"
    },
    { "AndrewRadev/tagalong.vim" },
    { "voldikss/vim-browser-search" },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },
    { "mityu/vim-applescript" },
    { "laytan/cloak.nvim" },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },
    { "windwp/nvim-ts-autotag" }
    -- { "findango/vim-mdx" }
}

require('cloak').setup({
    enabled = true,
    cloak_character = '*',
    -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
    highlight_group = 'Comment',
    cloak_length = 10,
    patterns = {
        {
            -- Match any file starting with '.env'.
            -- This can be a table to match multiple file patterns.
            file_pattern = '.env*',
            -- Match an equals sign and any character after it.
            -- This can also be a table of patterns to cloak,
            -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
            cloak_pattern = '=.+',
        },
    },
})
require('lspconfig.ui.windows').default_options.border = 'rounded'

-- lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
-- table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"
lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
    cmp.mapping.abort()
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
        fallback()
    end
end
-- Vim Setup
local blink = "blinkwait700-blinkoff200-blinkon125"
-- declares which chars should allow to go to next line, lvim defaults: "<,>,[,],h,l"
vim.opt.whichwrap = ""
vim.opt.colorcolumn = "80,120"
vim.opt.expandtab = true
vim.opt.guicursor = "n-c-sm:" .. blink .. ",i-ci-ve:ver25-" .. blink .. ",r-cr-o:hor20,v:block"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.showcmd = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 5
vim.opt.updatetime = 50
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.api.nvim_clear_autocmds { pattern = { "gitcommit", "markdown" }, group = "_filetype_settings" }
vim.b.copilot_enable = false



-- if vim.fn.exists('space_match') then
--   vim.fn.matchdelete(space_match)
-- end
-- local space_match = vim.fn.matchadd('Conceal', '\v( @<= )|(  @=)', -1, -1, {'conceal' , '·'})
-- vim.opt.listchars={tab='→ ',trail='·',precedes='←',extends='→',nbsp='·'}

lvim.builtin.indentlines.options.enabled = true
vim.opt.list = true
-- if vim.fn.exists('space_match') then
--   vim.fn.matchdelete(space_match)
-- end
-- local space_match = vim.fn.matchadd('Conceal', '\v( @<= )|(  @=)', -1, -1, {'conceal' , '·'})
vim.opt.listchars = { tab = '├─', trail = '·', space = '·', precedes = '←', extends = '→', }
-- lvim.builtin.autopairs.active = false
lvim.builtin.autopairs.active = false


-- LunarVim Setup
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "freewolf"

lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.active = true

lvim.builtin.lir.show_hidden_files = true

lvim.builtin.lualine.style = "default"

lvim.builtin.treesitter.autotag.enable = true

-- lvim.builtin.indentlines.options.show_trailing_blankline_indent = true
-- require("indent_blankline").setup {
--     show_end_of_line = true,
--     space_char_blankline = "-",
-- }
-- Leap
require('leap').add_default_mappings()
-- require('leap').leap { target_windows = { vim.fn.win_getid() } }

-- Bufferline
local function is_ft(b, ft)
    return vim.bo[b].filetype == ft
end

lvim.builtin.bufferline.options.mode = "tabs"
local function custom_filter(buf, buf_nums)
    local logs = vim.tbl_filter(function(b)
        return is_ft(b, "log")
    end, buf_nums or {})
    if vim.tbl_isempty(logs) then
        return true
    end
    local tab_num = vim.fn.tabpagenr()
    local last_tab = vim.fn.tabpagenr "$"
    local is_log = is_ft(buf, "log")
    if last_tab == 1 then
        return true
    end
    -- only show log buffers in secondary tabs
    return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
end

lvim.builtin.bufferline.options.custom_filter = custom_filter

-- Treesitter
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

lvim.builtin.treesitter.ensure_installed = {
    "astro",
    "bash",
    "c",
    "cpp",
    "go",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "prisma",
    "python",
    "rust",
    "tsx",
    "typescript",
    "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell", 'css' }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = false

-- Telescope
lvim.builtin.telescope.pickers.find_files = {
    layout_strategy = "horizontal",
    layout_config = { width = 0.80, height = 0.80, prompt_position = "bottom" },
    hidden = true,
    -- file_ignore_patterns = "^.git/"
}

lvim.builtin.telescope.pickers.git_files = {
    layout_strategy = "horizontal",
    layout_config = { width = 0.80, height = 0.80, prompt_position = "bottom" },
    hidden = true,
    -- file_ignore_patterns = "^.git/"
}

lvim.builtin.telescope.pickers.live_grep = {
    layout_strategy = "horizontal",
    file_ignore_patterns = { "node_modules", "package%-lock.json" }
}

-- NvimTree
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.view.width = 50

-- Formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "prettier",
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
}

-- removes warnings related to tailwind directives
require("lvim.lsp.manager").setup("cssls", {
    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        },
        scss = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        },
        less = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        },
    },
})

-- Keybindings

lvim.lsp.buffer_mappings.normal_mode = {
    -- ["K"] = { vim.lsp.buf.hover, "Show hover" },
    ["gh"] = { "<CMD>Lspsaga hover_doc<CR>", "Hover doc" },
    ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
    ["gD"] = { "<CMD>Lspsaga lsp_finder<CR>", "Open LSP Finder" },
    -- ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
    ["gr"] = { vim.lsp.buf.references, "References" },
    ["gR"] = { vim.lsp.buf.references, "References" },
    -- ["gR"] = { vim.lsp.buf.rename, "Rename" },
    ["gR"] = { "<CMD>Lspsaga rename<CR> ++project", "Rename" },
    ["gr"] = { "<CMD>Lspsaga rename<CR> ++project", "Rename" },
    ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
    ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
    ["gl"] = {
        function()
            local config = lvim.lsp.diagnostics.float
            config.scope = "line"
            vim.diagnostic.open_float({}, config)
        end,
        "Show line diagnostics",
    },
    ["sw"] = { "<cmd>Telescope grep_string<CR>", "Search string" },
}

local ui = require("harpoon.ui")
lvim.builtin.which_key.mappings["w"] = {
    name = "Window",
    s = {
        function()
            local winid = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
            if winid then vim.api.nvim_set_current_win(winid) end
        end, "Select a window"
    },
    a = { function() require("harpoon.mark").add_file() end, "Add file to harpoon" },
    h = { function() ui.toggle_quick_menu() end, "Toggle harpoon menu" },
    z = { function()
        require("zen-mode").toggle({
            window = {
                width = .70
            }
        })
    end, "Toggle Zen mode" }
}

lvim.builtin.which_key.mappings["x"] = {
    name = "Extra",
    u = { [[<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>]], "Undo tree" },
    x = {
        [[<cmd>!chmod +x %<CR>]]
        , "Make file executable"
    }
}

-- lvim.lsp.

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["s"] = { w = "<cmd>Telescope grep_string<CR>", "Search string under cursor" }
lvim.builtin.which_key.mappings["t"] = {
    name = "Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- lvim.keys.normal_mode["<leader>x"] = "<cmd>!chmod +x %<CR>"

-- Keymaps

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Moves selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "s", ":BrowserSearch<CR>")

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.json", "*.jsonc" },
    -- enable wrap mode for json files only
    command = "setlocal wrap",
})

-- Ex commands
vim.cmd('command! -nargs=0 W :w') -- I kept typing ":W" on accident, bye bye whichkey

-- Filetypes
local mdx_ft_detect = vim.api.nvim_create_augroup("mdx_ft_detect", {})
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
    group = mdx_ft_detect,
    callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        local match = string.find(filename, ".mdx")
        if match then
            vim.cmd("set filetype=markdown.mdx")
        end
    end,
})
