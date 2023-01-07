-- plugins key mappings

local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local pluginKeys = {}
local opt = {
  noremap = true,
  silent = true,
}

-- leader key is space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- press n to open nvim-tree
map('n','<leader>n',[[:NvimTreeToggle<CR>]],{})

-- Nvim-dap keymappings
-- press F5 to debug continue
map('n','<F5>',[[:lua require'dap'.continue()<CR>]],{})
-- press CTRL+d to open dap UI
map('n','<C-d>',[[:NvimTreeToggle<CR> :lua require'dapui'.toggle()<CR>]],{})
-- press CTRL+b to sets a breakpoint
map('n','<C-b>',[[:lua require'dap'.toggle_breakpoint()<CR>]],{})
-- press CTRL+l to sets a logpoint
map('n','<C-l>',[[:lua require'dap'.set_breakpoint(nil,nil,vim.fn.input('Log Point Msg: '))<CR>]],{})
-- press F10 to step over
map('n','<F10>',[[:lua require'dap'.step_over()<CR>]],{})
-- press F11 to step into
map('n','<F11>',[[:lua require'dap'.step_into()<CR>]],{})
-- press F12 to step out
map('n','<F12>',[[:lua require'dap'.step_out()<CR>]],{})
-- press F6 to open repl window
map('n','<F6>',[[:lua require'dap'.repl.open()<CR>]],{})
-- press dl to debug last
map('n','dl',[[:lua require'dap'.run_last()<CR>]],{})

-- bufferline
-- 左右Tab切换
map("n",'<S-Tab>',[[:BufferLineCyclePrev<CR>]],opt)
map("n",'<Tab>',[[:BufferLineCycleNext<CR>]],opt)
-- 关闭左/右侧标签页
map("n",'<leader>bh',[[:BufferLineCloseLeft<CR>]],opt)
map("n",'<leader>bl',[[:BufferLineCloseRight<CR>]],opt)
-- 关闭其他标签页
map("n",'<leader>bo',[[:BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>]],opt)
-- 关闭选中标签页
map("n",'<leader>bp',[[:BufferLinePickClose<CR>]],opt)
map("n",'<leader>bml',[[:BufferLineMoveNext<CR>]],opt)
map("n",'<leader>bmh',[[:BufferLineMovePrev<CR>]],opt)

-- telescope key mappings
local telescope_builtin = require('telescope.builtin')
keymap('n','<leader>ff',telescope_builtin.find_files,{})
keymap('n','<leader>fg',telescope_builtin.live_grep,{})
keymap('n','<leader>fb',telescope_builtin.buffers,{})
keymap('n','<leader>fh',telescope_builtin.help_tags,{})

-- terminal support float
pluginKeys.toggleTerm_map = function(toggleterm)
  keymap({ "n", "t" }, "<leader>tt", toggleterm.toggleTab)
  keymap({ "n", "t" }, "<leader>tf", toggleterm.toggleFloat)
  keymap({ "n", "t" }, "<M-Enter>", toggleterm.toggleFloat)
  keymap({ "n", "t" }, "<leader>tl", toggleterm.toggleRight)
  keymap({ "n", "t" }, "<leader>td", toggleterm.toggleDown)
  keymap({ "n", "t" }, "<leader>tg", toggleterm.toggleGit)
end

-- format all code
keymap({'n','t','i'}, "<M-m>",[[<Esc>:Neoformat<CR>a]], opt)

-- nvim-cmp key mappings
pluginKeys.cmp = function (cmp)
	return {
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}
end

return pluginKeys
