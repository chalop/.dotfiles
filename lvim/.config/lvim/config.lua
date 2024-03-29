-- Lazy
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
        dir = "~/Dev/m/freewolf.nvim",
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
                other_win_hl_color = '#FFAF00',
                hint = "floating-big-letter",
                picker_config = {
                    floating_big_letter = {
                        font = "ansi-shadow"
                    }
                }
            })
        end
    },
    { 'ThePrimeagen/harpoon' },
    { 'editorconfig/editorconfig-vim' },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
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
    { "windwp/nvim-ts-autotag" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "NoahTheDuke/vim-just" },
    { "mechatroner/rainbow_csv" },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end
    },
    {
        "kwakzalver/duckytype.nvim",
        config = function()
            require('duckytype').setup()
        end
    },
    {"stevearc/dressing.nvim"}
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
vim.opt.scrolloff = 1
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
lvim.builtin.autopairs.active = false


-- LunarVim Setup
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "freewolf"

lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.active = true

local actions = require("lir.actions")
lvim.builtin.lir.show_hidden_files = true
lvim.builtin.lir.mappings["<C-t>"] = nil
lvim.builtin.lir.mappings["<Esc>"] = actions.quit

lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections = {
    lualine_c = {
        {
            'filename',
            file_status = true, -- (readonly or modified status, etc)
            path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
        }
    }
}

lvim.builtin.treesitter.autotag.enable = true

lvim.builtin.project.exclude_dirs = { "~/Dev/w/*" }
-- lvim.builtin.indentlines.options.show_trailing_blankline_indent = true
-- require("indent_blankline").setup {
--     show_end_of_line = true,
--     space_char_blankline = "-",
-- }
-- Leap
-- require('leap').add_default_mappings()
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
vim.opt.foldmethod = "indent"
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
    layout_strategy = "vertical",
    layout_config = { width = 0.80, height = 0.80, prompt_position = "bottom" },
    hidden = true,

    path_display = { "absolute" },
    wrap_results = true
    -- file_ignore_patterns = "^.git/"
}

lvim.builtin.telescope.pickers.git_files = {
    layout_strategy = "vertical",
    layout_config = { width = 0.80, height = 0.80, prompt_position = "bottom" },
    hidden = true,

    path_display = { "absolute" },
    wrap_results = true
    -- file_ignore_patterns = "^.git/"
}


lvim.builtin.telescope.pickers.git_status = {
    layout_strategy = "vertical",
    layout_config = { width = 0.80, height = 0.80, prompt_position = "bottom" },
    hidden = true,

    path_display = {"absolute"},
    wrap_results = true
}


lvim.builtin.telescope.pickers.live_grep = {
    layout_strategy = "vertical",
    layout_config = { width = 0.80, height = 0.80, prompt_position = "bottom" },
    file_ignore_patterns = { "node_modules", "package%-lock.json" }
}

-- NvimTree
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.view.width = 35

-- Formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "prettier",
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },

    },
    { name = "black" },
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
    ["gR"] = { vim.lsp.buf.references, "References" },
    -- ["gR"] = { vim.lsp.buf.rename, "Rename" },
    ["gr"] = { "<CMD>Lspsaga rename<CR> ++project", "Rename" },
    ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
    ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
    ["gl"] = {
        function()
            local float = vim.diagnostic.config().float

            if float then
                local config = type(float) == "table" and float or {}
                config.scope = "line"

                vim.diagnostic.open_float(config)
            end
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

function Lazydocker_toggle()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazydocker = Terminal:new {
        cmd = "lazydocker",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "none",
            width = 100000,
            height = 100000,
        },
        on_open = function(_)
            vim.cmd "startinsert!"
        end,
        on_close = function(_) end,
        count = 99,
    }
    lazydocker:toggle()
end

vim.cmd("command! Lazydocker lua Lazydocker_toggle()")

lvim.builtin.which_key.mappings["x"] = {
    name = "Extra",
    u = { [[<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>]], "Undo tree" },
    x = {
        [[<cmd>!chmod +x %<CR>]]
        , "Make file executable"
    },
    f = {
        [[<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>]],
        "Open telescope file browser"
    },
    d = {
        [[<cmd>Lazydocker<CR>]],
        "Lazydocker"
    }

}

-- lvim.lsp.

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["e"] = { function() require('lir.float').toggle() end, "Explorer" }
lvim.builtin.which_key.mappings["u"] = { [[<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>]], "Undo tree" }
lvim.builtin.which_key.mappings["F"] = { [[<CMD>NvimTreeToggle<CR>]], "File Explorer" }

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

vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.definition() end)

-- Moves selected line / block of text in visual mode
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv")

vim.keymap.set("v", "s", ":BrowserSearch<CR>")
vim.keymap.set("v", "f", vim.lsp.buf.format) -- formats on visual selected lines

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

local tfvars_ft_detect = vim.api.nvim_create_augroup("tfvars_ft_detect", {})
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
    group = tfvars_ft_detect,
    callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        local match = string.find(filename, ".tfvars")
        if match then
            vim.cmd("set filetype=tf")
        end
    end,
})

local env_group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = ".env*",
    group = env_group,
    callback = function (args)
        vim.diagnostic.disable(args.buf)
    end
})

-- LSP
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "jsonls" })

-- local json_opts = {
--   settings = {
--     json = {
--       schemas = vim.list_extend(
--         {
--           {
--             description = "pyright config",
--             fileMatch = { "pyrightconfig.json" },
--             name = "pyrightconfig.json",
--             url =
--             "https://raw.githubusercontent.com/microsoft/pyright/main/packages/vscode-pyright/schemas/pyrightconfig.schema.json",
--           },
--         },
--         require('schemastore').json.schemas {
--         }
--       ),
--     },
--   },
-- }

-- local pyright_opts = {
--   single_file_support = true,
--   settings = {
--     pyright = {
--       disableLanguageServices = false,
--       disableOrganizeImports = false
--     },
--     python = {
--       analysis = {
--         autoImportCompletions = true,
--         autoSearchPaths = true,
--         diagnosticMode = "workspace", -- openFilesOnly, workspace
--         typeCheckingMode = "basic", -- off, basic, strict
--         useLibraryCodeForTypes = true
--       }
--     }
--   },
-- }

-- require("lvim.lsp.manager").setup("pyright", pyright_opts)
-- require("lvim.lsp.manager").setup("jsonls", json_opts)
