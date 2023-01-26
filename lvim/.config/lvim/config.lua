-- Packer
lvim.plugins = {
    { "folke/trouble.nvim", cmd = "TroubleToggle" },
    { "glepnir/lspsaga.nvim", branch = "main",
        config = function()
            require('lspsaga').setup({ ui = { border = 'rounded', colors = { normal_bg = "NONE", } } })
        end,
    },
    { "Mofiqul/dracula.nvim",
        config = function()
            require('dracula').setup({ italic_comment = true })
        end,
    },
    { "mbbill/undotree" },
    { 'sigmasd/deno-nvim' },
    {
        "lervag/vimtex",
        config = function()
            vim.cmd("call vimtex#init()")
        end,
    },
    { "ggandor/leap.nvim" },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "css", "scss", "html", "javascript", "typescript", "javascriptreact",
                "typescriptreact", "lua"
            }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end,
    },
    { "ellisonleao/gruvbox.nvim",
        config = function()
            require('gruvbox').setup({ italic = false })
        end },
    { "~/Dev/m/freewolf.nvim",
        config = function()
            require("freewolf").setup({ transparent_bg = true, italic_comment = true })

            vim.cmd("colorscheme freewolf")
        end
    },
    { "nvim-treesitter/playground", event = "BufRead" },
    { "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup {
                    -- LunarVim users need to specify path to the plugin manager
                    plugin_manager_path = os.getenv "LUNARVIM_RUNTIME_DIR" .. "/site/pack/packer",
                }
            end, 100)
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
    },
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
        end,
    },
}

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- Vim Setup
local blink = "blinkwait700-blinkoff200-blinkon125"
vim.opt.colorcolumn = "80,120"
vim.opt.expandtab = true
vim.opt.guicursor = "n-c-sm:" .. blink .. ",i-ci-ve:ver25-" .. blink .. ",r-cr-o:hor20,v:block"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
-- declares which chars should allow to go to next line
-- lvim defaults: "<,>,[,],h,l"
vim.opt.whichwrap = ""

-- local augroup = vim.api.nvim_create_augroup
-- ChalopGroup = augroup("chalop", {})

-- local yank_group = augroup('HighlightYank', {})
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("TextYankPost", {
--     group = yank_group,
--     patter = "*",
--     callback = function ()
--         vim.highlight.on_yank({
--             higroup = 'IncSearch',
--             timeout = 1000
--         })
--     end
-- })

-- LunarVim Setup
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "freewolf"

lvim.leader = "space"
lvim.transparent_window = false

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.active = true

lvim.builtin.lir.show_hidden_files = true

lvim.builtin.lualine.style = "default"

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
    "css",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "prisma",
    "python",
    "rust",
    "tsx",
    "typescript",
    "yaml",
    "markdown",
    "markdown_inline"
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
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
    layout_strategy = "horizontal"
}

-- NvimTree
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true

-- Formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "prettier",
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
}

-- Keybindings

local ui = require("harpoon.ui")

lvim.lsp.buffer_mappings.normal_mode = {
    -- ["K"] = { vim.lsp.buf.hover, "Show hover" },
    ["gh"] = { "<CMD>Lspsaga hover_doc<CR>", "Hover doc" },
    ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
    ["gD"] = { "<CMD>Lspsaga lsp_finder<CR>", "Open LSP Finder" },
    -- ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
    ["gr"] = { vim.lsp.buf.references, "References" },
    -- ["gR"] = { vim.lsp.buf.rename, "Rename" },
    ["gR"] = { "<CMD>Lspsaga rename<CR>", "Rename" },
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
}

lvim.builtin.which_key.mappings["w"] = {
    name = "Window",
    s = {
        function()
            local winid = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
            if winid then vim.api.nvim_set_current_win(winid) end
        end, "Select a window"
    },
    a = { function() require("harpoon.mark").add_file() end, "Add file to harpoon" },
    h = { function() ui.toggle_quick_menu() end, "Toggle harpoon menu" }

}

lvim.keys.normal_mode["<leader>x"] = "<cmd>!chmod +x %<CR>"

-- Keymaps

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Moves selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }
--
-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO untoggle this

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
