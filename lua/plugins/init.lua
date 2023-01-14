-- automatically install Packer.nvim
-- plugins install path
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	vim.notify("installing Pakcer.nvim，Please wait...")
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		-- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
		install_path,
	})

	-- https://github.com/wbthomason/packer.nvim/issues/750
	local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
	if not string.find(vim.o.runtimepath, rtp_addition) then
		vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
	end
	vim.notify("Pakcer.nvim completed install")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("do not installed packer.nvim")
	return
end

packer.startup(function(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim" })
	-- lsp plugin (use mason to manage)
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/nvim-lsp-installer" })
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})
	use({
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup({
				Error = "#db4b4b",
				Warning = "#e0af68",
				Information = "#0db9d7",
				Hint = "#10B981",
			})
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").setup({})
		end,
	})
	-- cmp plugin
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "rafamadriz/friendly-snippets" })
	-- autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	-- Nvimtree for file exploring
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		tag = "nightly",
	})
	-- DAP for debugging
	use({ "mfussenegger/nvim-dap" })
	use({
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup({})
		end,
	})
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
	})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	-- colorscheme dracula.nvim
	use({ "Mofiqul/dracula.nvim" })
	-- nvim-treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	-- format
	use({ "sbdchd/neoformat" })
	-- rainbow pairs
	use({ "p00f/nvim-ts-rainbow" })
	-- keymappings informations
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	-- lspkind
	use({ "onsails/lspkind-nvim" })
	-- run code
	use({
		"michaelb/sniprun",
		run = "bash ./install.sh",
		config = function()
			require("sniprun").setup({})
		end,
	})
	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- give me tabs
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	-- comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- term support float
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	-- indent_blankline
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({ filetype_exclude = { "dashboard" } })
		end,
	})
	-- enhance lua
	use({ "folke/neodev.nvim" })
	-- to find files
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- git support
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	-- dashboard
	use({ "glepnir/dashboard-nvim" })
	-- startuptime
	use({ "dstein64/vim-startuptime" })
	-- todo comments
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
end)

-- TODO: chech todo comments
-- PERF:
-- HACK:
-- WARN:
-- NOTE:
-- TEST:
-- FIX:

require("plugins/file-explorer")
require("plugins/line_lua")
require("plugins/bufferline")
require("plugins/mason-config")
require("plugins/lspsetup")
require("plugins/clangd")
require("plugins/gopls")
require("plugins/pyright")
require("plugins/luaLSP")
require("plugins/code-completion")
require("plugins/debugging")
require("plugins/styling")
require("plugins/syntax-highlight")
require("plugins/autopairs")
require("plugins/dashboard")
require("plugins/indent_blankline")
require("plugins/telescope")
require("plugins/toggleTerm")
require("plugins/neodev")
