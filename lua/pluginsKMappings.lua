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
map("n", "<leader>n", [[:NvimTreeToggle<CR>]], {})

-- Nvim-dap keymappings
-- press F5 to debug continue
map("n", "<F5>", [[:lua require'dap'.continue()<CR>]], {})
-- press CTRL+d to open dap UI
map("n", "<C-d>", [[:NvimTreeToggle<CR> :lua require'dapui'.toggle()<CR>]], {})
-- press CTRL+b to sets a breakpoint
map("n", "<C-b>", [[:lua require'dap'.toggle_breakpoint()<CR>]], {})
-- press CTRL+l to sets a logpoint
map("n", "<C-l>", [[:lua require'dap'.set_breakpoint(nil,nil,vim.fn.input('Log Point Msg: '))<CR>]], {})
-- press F10 to step over
map("n", "<F10>", [[:lua require'dap'.step_over()<CR>]], {})
-- press F11 to step into
map("n", "<F11>", [[:lua require'dap'.step_into()<CR>]], {})
-- press F12 to step out
map("n", "<F12>", [[:lua require'dap'.step_out()<CR>]], {})
-- press F6 to open repl window
map("n", "<F6>", [[:lua require'dap'.repl.open()<CR>]], {})
-- press dl to debug last
map("n", "dl", [[:lua require'dap'.run_last()<CR>]], {})

-- bufferline
-- 左右Tab切换
map("n", "<S-Tab>", [[:BufferLineCyclePrev<CR>]], opt)
map("n", "<Tab>", [[:BufferLineCycleNext<CR>]], opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", [[:BufferLineCloseLeft<CR>]], opt)
map("n", "<leader>bl", [[:BufferLineCloseRight<CR>]], opt)
-- 关闭其他标签页
map("n", "<leader>bo", [[:BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>]], opt)
-- 关闭选中标签页
map("n", "<leader>bp", [[:BufferLinePickClose<CR>]], opt)
map("n", "<leader>bml", [[:BufferLineMoveNext<CR>]], opt)
map("n", "<leader>bmh", [[:BufferLineMovePrev<CR>]], opt)

-- telescope key mappings
local telescope_builtin = require("telescope.builtin")
keymap("n", "<leader>ff", telescope_builtin.find_files, {})
keymap("n", "<leader>fg", telescope_builtin.live_grep, {})
keymap("n", "<leader>fb", telescope_builtin.buffers, {})
keymap("n", "<leader>fh", telescope_builtin.help_tags, {})

-- which_key
map("n", "<leader>key", [[:WhichKey<CR>]], opt)

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
keymap({ "n", "t" }, "<M-m>", [[:Neoformat<CR>]], opt)
keymap({ "i" }, "<M-m>", [[<Esc>:Neoformat<CR>a]], opt)

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- Show cursor diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
-- Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
-- Outline
keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })
-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- Float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want to pass some cli command into a terminal you can do it like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

-- nvim-cmp key mappings
pluginKeys.cmp = function(cmp)
	return {
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}
end

return pluginKeys
