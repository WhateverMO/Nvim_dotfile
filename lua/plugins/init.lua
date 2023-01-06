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
	use { "wbthomason/packer.nvim" }
	-- lsp plugin (use mason to manage)
	use { "williamboman/mason.nvim" }
	use { "williamboman/mason-lspconfig.nvim" }
	use { "neovim/nvim-lspconfig" }
	use { "williamboman/nvim-lsp-installer" }
	-- cmp plugin
	use { "hrsh7th/nvim-cmp" }
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lsp-signature-help" }
	use { "hrsh7th/cmp-nvim-lua" }
	use { "hrsh7th/cmp-vsnip" }
	use { "hrsh7th/cmp-path" }
	use { "hrsh7th/cmp-buffer" }
	use { "hrsh7th/vim-vsnip" }
	use {'rafamadriz/friendly-snippets'}
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
	-- lspkind
	use {'onsails/lspkind-nvim'}
	-- lualine
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- give me tags
	use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
end)

require("plugins/file-explorer")
require("plugins/line_lua")
require("plugins/tags")
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
