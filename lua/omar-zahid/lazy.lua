local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"github/copilot.vim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-sleuth",
	"nvim-treesitter/nvim-treesitter-context",
	"mbbill/undotree",
	"nvim-lua/plenary.nvim",
	"HiPhish/rainbow-delimiters.nvim",
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	-- {
	-- 	"rosepine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					rainbow_delimiters = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",  opts = {} },
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim",               opts = {} },
	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim",       version = "*", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},
	{
		-- Auto pairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"vhyrro/luarocks.nvim",
		config = function()
			require("luarocks").setup({})
		end,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup()
		end,
	},
	{},
}, {})
