---- Options ------
vim.o.guicursor = "" vim.g.mapleader = " " vim.o.number = true vim.o.rnu = true
vim.o.autoindent = true
--vim.o.autocomplete = true
vim.o.hlsearch = false
vim.o.expandtab = true
vim.o.incsearch = true


vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true


vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 32
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.diagnostic.config({virtual_text = true})

----- Keymaps ------

--vim.diagnostic.config({
--  virtual_text = true,
--})
-- MOVE LINES UP AND DOWN
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })

-- CTRL-C = ESC and CTRL-S save
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Esc" })
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:write<CR>", { desc = "Save" })
vim.keymap.set( {"i", "v", "s", "x", "c","n"}, "<Esc>", function()
  vim.api.nvim_echo({ { "Press CTRL C to Escape", "WarningMsg"} },
  true, {})
--  vim.notify("Press CTRL C to Escape")
end)

-- COPY TO CLIPBOARD
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to clipboard" })

-- OPEN TERMINAL WINDOW
vim.keymap.set("n", "<leader>tr", ":term<CR>i", { desc = "Open terminal Window" })
vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
--	vim.cmd.term()
--	vim.cmd.wincmd("L")
--	vim.api.nvim_win_set_width(0, 100)
end)
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>")

vim.api.nvim_set_keymap("t", "<C-l><C-l>", [[<C-\><C-N>:lua ClearTerm(0)<CR>]], {})
vim.api.nvim_set_keymap("t", "<C-l><C-l><C-l>", [[<C-\><C-N>:lua ClearTerm(1)<CR>]], {})

function ClearTerm(reset)
	vim.opt_local.scrollback = 1

	vim.api.nvim_command("startinsert")
	if reset == 1 then
		vim.api.nvim_feedkeys("reset", "t", false)
	else
		vim.api.nvim_feedkeys("clear", "t", false)
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "t", true)

	vim.opt_local.scrollback = 10000
end

----- Plugins ------
local function gh(x)
	return "https://github.com/" .. x
end

-- Markdown Preview --
vim.pack.add({ gh('MeanderingProgrammer/render-markdown.nvim') })

----- Colorscheme ------
-- Fallback, and the colorscheme used if the Omarchy theme can't be read.
--vim.pack.add({gh("kepano/flexoki-neovim")})
--vim.cmd.colorscheme("flexoki")

-- Follow the current Omarchy theme, live. :OmarchyTheme re-syncs by hand.
--require("omarchy_theme").setup()

-- aether no config
--vim.pack.add({gh("omacom/aether.nvim")})
--vim.cmd.colorscheme("aether")

--opencode 
--vim.pack.add({ gh("folke/tokyonight.nvim") })
--vim.cmd.colorscheme("tokyonight-night")

--vim.pack.add({ gh("Shatur/neovim-ayu") })
--vim.cmd.colorscheme("ayu-dark")  -- or "ayu-dark" for a darker bg

-- White Air
--vim.pack.add({
--  { src = "https://github.com/bjarneo/aether.nvim" , version = "v3"},
--})
--require("aether").setup({
--  transparent = false,
--  -- v3 renamed the palette; base00-base0F from the Omarchy spec are ignored here.
--  colors = {
--    bg = "#ffffff",          -- base00 Default Background
--    lighter_bg = "#f1f5f9",  -- base01 Lighter Background
--    selection = "#cbd5e1",   -- base02 Selection Background
--    muted = "#94a3b8",       -- base03 Comments, Line Numbers
--    dark_fg = "#64748b",     -- base04 Dark Foreground
--    fg = "#1e293b",          -- base05 Default Foreground
--    light_fg = "#0f172a",    -- base06 Light Foreground
--    bright_fg = "#ffffff",   -- base07 Light Background
--
--    red = "#e11d48",         -- base08 Variables, Errors
--    orange = "#ea580c",      -- base09 Numbers, Constants
--    yellow = "#d97706",      -- base0A Classes, Types
--    green = "#059669",       -- base0B Strings
--    cyan = "#0284c7",        -- base0C Regex, Escapes
--    blue = "#0a64f5",        -- base0D Functions, Methods
--    purple = "#7c3aed",      -- base0E Keywords, Tags
--    brown = "#d97706",       -- base0F Deprecated
--
--    -- v3-only keys with no base16 counterpart
--    background = "#ffffff",
--    foreground = "#1e293b",
--    cursor = "#1e293b",
--    accent = "#0a64f5",
--    selection_background = "#cbd5e1",
--    selection_foreground = "#1e293b",
--    dark_bg = "#f8fafc",
--    darker_bg = "#f1f5f9",
--
--    bright_red = "#f43f5e",
--    bright_yellow = "#f59e0b",
--    bright_green = "#10b981",
--    bright_cyan = "#0ea5e9",
--    bright_blue = "#3b82f6",
--    bright_purple = "#8b5cf6",
--  },
--})
--vim.cmd.colorscheme("aether")

-- Moonfly
--vim.pack.add({gh('bluz71/vim-moonfly-colors')})
--vim.cmd.colorscheme("moonfly")
--Nord
--vim.pack.add({ gh("EdenEast/nightfox.nvim") })
--vim.cmd.colorscheme("nordfox")

-- Solarized Osaka
-- vim.pack.add({gh("craftzdog/solarized-osaka.nvim")})
-- vim.cmd.colorscheme("solarized-osaka")

-- Gruvbox
--vim.pack.add({
--  gh("/ellisonleao/gruvbox.nvim")
--})
--require("gruvbox").setup()
--vim.cmd.colorscheme("gruvbox")

-- Rose pine
--vim.pack.add({gh("/rose-pine/neovim")})
--vim.cmd.colorscheme("rose-pine")

-- Miasma
--vim.pack.add({gh("/OldJobobo/miasma.nvim")})
--require('miasma').setup()
--vim.cmd.colorscheme("miasma")

-- Cattppucin
vim.pack.add({gh('catppuccin/nvim')})
require('catppuccin').setup({
  transparent_background = true
})
vim.cmd.colorscheme("catppuccin")

-- This removes the background to make it look better 
vim.api.nvim_set_hl(0, "LineNr",  {bg = "NONE"})
vim.api.nvim_set_hl(0, "SignColumn",  {bg = "NONE"})
vim.api.nvim_set_hl(0, "CursorLineNr",  {bg = "NONE"})
vim.api.nvim_set_hl(0, "GitSignsAdd",  {bg = "NONE"})
vim.api.nvim_set_hl(0, "GitSignsChange",  {bg = "NONE"})
vim.api.nvim_set_hl(0, "GitSignsDelete",  {bg = "NONE"})
vim.api.nvim_set_hl(0, "SignColumn",  {bg = "NONE"})





vim.pack.add({ gh("/nvim-lualine/lualine.nvim") })
require("lualine").setup({
	options = {
		theme = "catppuccin",
	},
})
vim.pack.add({ gh("nvim-lua/plenary.nvim") })

-- TREESITTER --
vim.pack.add({ gh("nvim-treesitter/nvim-treesitter") })
local treesitter = require("nvim-treesitter")
treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	highlight = { enable = true },
	indent = { enable = true },
})
treesitter.install({
	"lua",
	"python",
	"go",
	"html",
	"json",
	"xml",
	"sql",
	"templ",
	"javascript",
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if vim.list_contains(treesitter.get_available(), lang) then
			if not vim.list_contains(treesitter.get_installed(), lang) then
				treesitter.install(lang):wait()
			end
			vim.treesitter.start(args.buf)
		end
	end,
	desc = "Enable nvim-treesitter and install parser if not installed",
})
---------
vim.pack.add({ gh("brenoprata10/nvim-highlight-colors") })
require("nvim-highlight-colors").setup({
	---Render style
	---@usage 'background'|'foreground'|'virtual'
	render = "virtual",

	---Set virtual symbol (requires render to be set to 'virtual')
	virtual_symbol = "■",

	---Set virtual symbol suffix (defaults to '')
	virtual_symbol_prefix = "",

	---Set virtual symbol suffix (defaults to ' ')
	virtual_symbol_suffix = "",

	---Set virtual symbol position()
	---@usage 'inline'|'eol'|'eow'
	---inline mimics VS Code style
	---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
	---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
	virtual_symbol_position = "eol",

	---Highlight hex colors, e.g. '#FFFFFF'
	enable_hex = true,

	---Highlight short hex colors e.g. '#fff'
	enable_short_hex = true,

	---Highlight rgb colors, e.g. 'rgb(0 0 0)'
	enable_rgb = true,
        ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
	enable_hsl = true,

	-- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
	enable_hsl_without_function = true,

	---Highlight CSS variables, e.g. 'var(--testing-color)'
	enable_var_usage = true,

	---Highlight named colors, e.g. 'green'
	enable_named_colors = true,

	---Highlight tailwind colors, e.g. 'bg-blue-500'
	enable_tailwind = true,

	---Set custom colors
	---Label must be properly escaped with '%' to adhere to `string.gmatch`
	--- :help string.gmatch
	-- custom_colors = {
	-- 	{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
	-- 	{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
	-- },

	-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
	-- exclude_filetypes = {},
	-- exclude_buftypes = {},
	-- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
	-- exclude_buffer = function(bufnr) end,
})

-- LSP --
vim.pack.add({ gh("nvimtools/none-ls.nvim") })
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.pyink,
	},
})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format Text" })

-- Completition --
vim.pack.add({
	gh("hrsh7th/cmp-nvim-lsp"),
	gh("saadparwaiz1/cmp_luasnip"),
	gh("rafamadriz/friendly-snippets"),
	gh("L3MON4D3/LuaSnip"),
	gh("hrsh7th/nvim-cmp"),
})
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
				end
			else
				fallback()
			end
		end),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = require("nvim-highlight-colors").format,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

vim.pack.add({
	gh("williamboman/mason.nvim"),
	gh("williamboman/mason-lspconfig.nvim"),
	gh("neovim/nvim-lspconfig"),
})
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
                "eslint",
                "emmet_language_server",
		"lua_ls",
		-- "pyright",
		-- "pylsp",
		"html",
		-- "gopls",
		"templ",
		"jsonls",
		"cssls",
		"tailwindcss",
		--"ts_ls",
		"clangd",
		--"htmx",
		"denols",
		-- "rust_analyzer",
	},
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--offset-encoding=utf-8",
	},
	root_markers = { ".clangd", "compile_commands.json" },
	filetypes = { "c", "cpp" },
}
vim.lsp.config.gdscript = {
	name = "godot",
	cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
}
vim.lsp.config.tailwindcss = {
	include_languages = { html = "templ" },
	capabilities = capabilities,
}
vim.diagnostic.config({ underline = true})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {desc = "Code Actions"})

vim.pack.add({ gh("mfussenegger/nvim-dap") })
local dap = require("dap")
dap.adapters.godot = {
	type = "server",
	host = "127.0.0.1",
	port = 6006,
}
dap.configurations.gdscript = {
	{
		type = "godot",
		request = "launch",
		name = "Launch scene",
		project = "${workspaceFolder}",
		launch_scene = true,
	},
}

-- C / C++ via codelldb (installed through Mason) --
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}
dap.configurations.c = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}
dap.configurations.cpp = dap.configurations.c

-- DAP UI + virtual text --
vim.pack.add({
	gh("rcarriga/nvim-dap-ui"),
	gh("nvim-neotest/nvim-nio"),
	gh("theHamsta/nvim-dap-virtual-text"),
})
local dapui = require("dapui")
dapui.setup()
require("nvim-dap-virtual-text").setup()

-- auto open/close the UI on session start/end
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- DAP keymaps --
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue / Start" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
vim.keymap.set({ "n", "v" }, "<leader>de", function()
	require("dapui").eval()
end, { desc = "Eval Expression" })

-- TELESCOPE --
-- local install_telescope_fzf = function(ev)
-- 	local name, kind = ev.data.spec.name, ev.data.kind
-- 	if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
-- 		vim.system({ "make" }, { cwd = ev.data.path }):wait()
-- 	end
-- end
-- vim.api.nvim_create_autocmd("PackChanged", { callback = install_telescope_fzf })
-- vim.pack.add({ gh("nvim-lua/plenary.nvim") })
-- vim.pack.add({ gh("nvim-telescope/telescope-fzf-native.nvim") })
-- vim.pack.add({ gh("nvim-telescope/telescope.nvim") })
-- vim.pack.add({ gh("nvim-telescope/telescope-ui-select.nvim") })
-- local telescope = require("telescope")
-- telescope.setup({
-- 	extensions = {
-- 		fzf = {},
-- 		["ui-select"] = {
-- 			require("telescope.themes").get_dropdown({}),
-- 		},
-- 	},
-- 	defaults = {
-- 		file_ignore_patterns = { "node_modules", "venv", "__pycache__" },
-- 	},
-- })
-- telescope.load_extension("fzf")
-- telescope.load_extension("ui-select")
--
-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find FIles" })
-- vim.keymap.set("n", "<C-b>", builtin.buffers, {})
-- vim.keymap.set("n", "<C-h>", builtin.command_history, {desc =  "Command History"})
-- vim.keymap.set("n", "<leader>mp", builtin.man_pages,  {desc = "Man Page"})
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep,  {desc = "Live Grep"})
---------

-- NEO TREE --
vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	-- optional, but recommended
	"https://github.com/nvim-tree/nvim-web-devicons",
})
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {desc = "Neotree Toggle"})

vim.pack.add({ gh("mrcjkb/rustaceanvim") })

-- Which Key --
vim.pack.add({ gh("folke/which-key.nvim") })
local wk = require('which-key')
wk.add({
        {"<leader>a", group = "AI"}, 
        {"<leader>c", group = "Code"},
        {"<leader>d", group = "Debug"},
        {"<leader>f", group = "Files"},
        {"<leader>m", group = "Manual"},
        {"<leader>g", group = "Format"},
        {"<leader>s", group = "Split Terminal"},
        {"<leader>t", group = "Terminal"},
        {"<leader>x", group = "Trouble"}

})

vim.pack.add({
	gh("coder/claudecode.nvim"),
})
local claudecode = require("claudecode")
claudecode.setup()

-- AI/Claude Code keybindings
vim.keymap.set("n", "<leader>ac", ":ClaudeCode<CR>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", ":ClaudeCodeFocus<CR>", { desc = "Focus Claude" })
vim.keymap.set("n", "<leader>ar", ":ClaudeCode --resume<CR>", { desc = "Resume Claude" })
vim.keymap.set("n", "<leader>aC", ":ClaudeCode --continue<CR>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>am", ":ClaudeCodeSelectModel<CR>", { desc = "Select Claude model" })
vim.keymap.set("n", "<leader>ab", ":ClaudeCodeAdd %<CR>", { desc = "Add current buffer" })
vim.keymap.set("v", "<leader>as", ":ClaudeCodeSend<CR>", { desc = "Send to Claude" })
vim.keymap.set("n", "<leader>aa", ":ClaudeCodeDiffAccept<CR>", { desc = "Accept diff" })
vim.keymap.set("n", "<leader>ad", ":ClaudeCodeDiffDeny<CR>", { desc = "Deny diff" })


-- Java/ jdtls --
vim.pack.add({gh ("/mfussenegger/nvim-jdtls")})


-- Mini Pairs
--vim.pack.add({gh("/nvim-mini/mini.pairs")})
--require('mini.pairs').setup()

-- Trouble

vim.pack.add({gh("/folke/trouble.nvim")})
local trouble = require("trouble")
trouble.setup({
	win = {
		type = "float",
		border = "rounded",
		position = { "50%", "50%" },
		size = { width = 0.6, height = 0.5 },
	},
})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })


-- Gitsigns 
vim.pack.add({gh("/lewis6991/gitsigns.nvim")})



-- Vim Diagnostics --
--vim.pack.add({gh("/rachartier/tiny-inline-diagnostic.nvim")})
--local diag = require("tiny-inline-diagnostic") 
--diag.setup({
--  vim.diagnostic.config({virtual_text = false})
--})

--------
