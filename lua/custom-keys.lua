
local map = vim.api.nvim_set_keymap

-- press n to open nvim-tree
map('n','n',[[:NvimTreeToggle<CR>]],{})
-- press CTRL+s to save file
map('n','<C-s>',[[:w<CR>]],{})
-- press ALT+CRTL+q to quit
map('n','<ac-Q>',[[:q<CR>]],{})

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
