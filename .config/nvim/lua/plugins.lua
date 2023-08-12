-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- setup package manager
require('lazy').setup({
	-- [[ LSP ]]
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
	},

	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'f3fora/cmp-spell'
		},
	},

	{

		'L3MON4D3/LuaSnip',
		dependencies = { 'rafamadriz/friendly-snippets' },
		config = function()
			require('luasnip.loaders.from_vscode').lazy_load()
		end
	},


	-- [[ FORMATTER ]]

	{ 'mhartington/formatter.nvim' },

	-- [[ AI ]]
	{ 'Exafunction/codeium.vim' },


	-- [[ GIT ]]
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	-- [[ NICETIES ]]
	-- show pending keybinds
	{
		'folke/which-key.nvim',
		opts = {}
	},

	-- 'gc' to comment visual regions/lines
	{
		'numToStr/Comment.nvim',
		opts = {}
	},


	{ 'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {},
	},

	-- [[ AESTHETICS ]]
	{
		'folke/zen-mode.nvim',
		dependencies = {
			'folke/twilight.nvim'
		},
		opts = {
			window = {
				width = 120,
			},
			plugins = {
				wezterm = {
					enabled = true,
					-- can be either an absolute font size or the number of incremental steps
					font = '+0', -- (10% increase per step)
				},
				twilight = {
					enabled = false,
				},
				gitsigns = {
					enabled = true,
				}
			},
			-- callback where you can add custom code when the Zen window opens
			on_open = function(win)
				vim.o.number = false
			end,
			-- callback where you can add custom code when the Zen window closes
			on_close = function()
				vim.o.number = true
			end,
		},
	},

	{
		'andweeb/presence.nvim',
		config = function()
			require('presence').setup()
		end
	},

	{
		-- Theme inspired by Atom
		'navarasu/onedark.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'onedark'
		end,
		lazy = true
	},

	{
		'folke/tokyonight.nvim',
		config = function()
			require('tokyonight').setup({
				style = 'night',
				light_style = 'day',
				transparent = false,
				terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = 'dark',
					floats = 'dark',
				},
				hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = true, -- dims inactive windows
			})
			vim.cmd.colorscheme 'tokyonight'
		end,
		lazy = false
	},


	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		after = 'folke/tokyonight.nvim',
		-- lazy = true,
	},

	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
		},
	},

	--  [[ telescope ]]
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }

	},

	{
		'nvim-telescope/telescope-fzf-native.nvim',
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},

	{ 'nvim-telescope/telescope-symbols.nvim' },

	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		config = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter',
		event = 'CursorHold',
		run = ':TSUpdate',
		config = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	},
	{ 'nvim-treesitter/playground',                  after = 'nvim-treesitter' },
	{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
	{ 'nvim-treesitter/nvim-treesitter-refactor',    after = 'nvim-treesitter' },

},
	{})
