
vim.opt.completeopt = { 'menuone','noselect','noinsert','preview' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }

local cmp = require("cmp")

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

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	
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

	mapping = {
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}
})
