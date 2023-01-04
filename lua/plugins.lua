return require('packer').startup(function(use)
	-- Packer can manage itself
	use { "wbthomason/packer.nvim" }
	-- lsp plugin (use mason to manage)
	use { "williamboman/mason.nvim" }
	use { "williamboman/mason-lspconfig.nvim" }
	use { "neovim/nvim-lspconfig" }
	-- cmp plugin
	use { "hrsh7th/nvim-cmp" }
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lsp-signature-help" }
	use { "hrsh7th/cmp-nvim-lua" }
	use { "hrsh7th/cmp-vsnip" }
	use { "hrsh7th/cmp-path" }
	use { "hrsh7th/cmp-buffer" }
	use { "hrsh7th/vim-vsnip" }
	-- autopairs
	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup{}
		end,
	}
	-- Nvimtree for file exploring
	use {
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons"
		},
		tag = "nightly",
	}
	-- DAP for debugging
	use { "mfussenegger/nvim-dap" }	
	use { 
		"rcarriga/nvim-dap-ui", 
		requires = {"mfussenegger/nvim-dap"} 
	}

	-- colorscheme dracula.nvim
	use { "Mofiqul/dracula.nvim" }

	-- nvim-treesitter
	use { 
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
end)
