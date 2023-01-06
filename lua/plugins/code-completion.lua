
-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

vim.opt.completeopt = { 'menuone','noselect','noinsert','preview' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	-- Configurations
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 3 },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua', keywordlength = 2 },
		{ name = 'buffer', keywordlength = 2 },
		{ name = 'vsnip', keywordlength = 2 },
	},

	snippet = {
		expand = function(args)
			-- For `vsnip` users.
			vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` users.
			-- require('luasnip').lsp_expand(args.body)

			-- For `ultisnips` users.
			-- vim.fn["UltiSnips#Anon"](args.body)

			-- For `snippy` users.
			-- require'snippy'.expand_snippet(args.body)
		end,
	},

	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	
	--[[
	formatting = {
		fields = { 'menu','abbr','kind' },
		format = function(entry,item)
			local menu_icon = {
				nvim_lsp = '力',
				vsnip = '',
				buffer = '﬘',
				path = '',
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	--]]
	formatting = {
		format = lspkind.cmp_format({
			with_text = true, -- do not show text alongside icons
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			before = function (entry, vim_item)
				vim_item.menu = "["..string.upper(entry.source.name).."]"
				return vim_item
			end
		})
	},

	mapping = require('pluginsKMappings').cmp(cmp)
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
