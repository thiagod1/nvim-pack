----- Options ------
vim.o.guicursor= ""
vim.g.mapleader = " "
vim.o.number = true
vim.o.rnu = true
vim.o.autoindent = true
vim.o.autocomplete = true
vim.o.hlsearch = false
vim.o.expandtab = true
vim.o.incsearch = true

vim.o.sidescrolloff = 32


vim.o.softtabstop = 0
vim.o.shiftwidth = 0
vim.o.smartindent = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 32
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

----- Keymaps ------

-- MOVE LINES UP AND DOWN
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- CTRL-C = ESC
vim.keymap.set("i", "<C-c>", "<Esc>")

-- COPY TO CLIPBOARD
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- OPEN TERMINAL WINDOW
vim.keymap.set("n", "<leader>tr", ":term<CR>i")
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("L")
    vim.api.nvim_win_set_width(0, 100)
end)
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>")

vim.api.nvim_set_keymap('t', '<C-l><C-l>', [[<C-\><C-N>:lua ClearTerm(0)<CR>]], {})
vim.api.nvim_set_keymap('t', '<C-l><C-l><C-l>', [[<C-\><C-N>:lua ClearTerm(1)<CR>]], {})

function ClearTerm(reset)
  vim.opt_local.scrollback = 1

  vim.api.nvim_command("startinsert")
  if reset == 1 then
    vim.api.nvim_feedkeys("reset", 't', false)
  else
    vim.api.nvim_feedkeys("clear", 't', false)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)

  vim.opt_local.scrollback = 10000
end

----- Plugins ------
local function gh(x)
        return "https://github.com/" .. x
end
vim.cmd.colorscheme("retrobox")

vim.pack.add({gh("/nvim-lualine/lualine.nvim")})
require('lualine').setup({
        options = {
                theme = 'codedark'
        }
})
vim.pack.add({gh("nvim-lua/plenary.nvim")})






-- TREESITTER --
vim.pack.add({ gh("nvim-treesitter/nvim-treesitter") })
local treesitter = require("nvim-treesitter")
treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = { enable = true },
    indent = { enable = true },
})
treesitter.install({
    "lua", "python", "go", "html", "json", "xml", "sql", "templ", "javascript",
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
    desc = "Enable nvim-treesitter and install parser if not installed"
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
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

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
   	"lua_ls",
   	-- "pyright",
    -- "pylsp",
   	"html",
        -- "gopls",
   	"templ",
   	"jsonls",
   	"cssls",
   	"tailwindcss",
   	"ts_ls",
   	"clangd",
   	--"htmx",
   	"denols",
   	-- "rust_analyzer",
   },
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}

vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
  },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
}
vim.lsp.config.gdscript = {
    name = "godot",
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
}
vim.lsp.config.tailwindcss = {
    include_languages = { html =  "templ" },
	capabilities = capabilities,
}
vim.diagnostic.config({ underline = false })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

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




-- TELESCOPE --
local install_telescope_fzf = function (ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
        vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = install_telescope_fzf })
vim.pack.add({ gh("nvim-lua/plenary.nvim") })
vim.pack.add({ gh("nvim-telescope/telescope-fzf-native.nvim") })
vim.pack.add({ gh("nvim-telescope/telescope.nvim") })
vim.pack.add({ gh("nvim-telescope/telescope-ui-select.nvim") })
local telescope = require("telescope")
telescope.setup({
    extensions = {
        fzf = {},
        ["ui-select"] =  {
            require("telescope.themes").get_dropdown({}),
        }
    },
    defaults = {
        file_ignore_patterns = { "node_modules", "venv", "__pycache__" },
    },
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-b>", builtin.buffers, {})
vim.keymap.set("n", "<C-h>", builtin.command_history, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>mp", builtin.man_pages, {})
---------

-- NEO TREE --
vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- optional, but recommended
  "https://github.com/nvim-tree/nvim-web-devicons",
})
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")



vim.pack.add({ gh("mrcjkb/rustaceanvim") })
--------
