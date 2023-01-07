---@diagnostic disable: missing-parameter
local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("not found toggleterm")
  return
end

toggleterm.setup({
	
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
	shell = "/bin/fish"
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    -- q / <leader>tg 关闭 terminal
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>tg", "<cmd>close<CR>", { noremap = true, silent = true })
    -- ESC 键取消，留给lazygit
    if vim.fn.mapcheck("<Esc>", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<Esc>")
    end
  end,
  on_close = function(_)
    -- 添加回来
    vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
      noremap = true,
      silent = true,
    })
  end,
})

local tTab = Terminal:new({
	direction = "tab",
	close_on_exit = true,
})

local tFloat = Terminal:new({
  direction = "float",
  close_on_exit = true,
})

local tRight = Terminal:new({
  direction = "vertical",
  close_on_exit = true,
})

local tDown = Terminal:new({
  direction = "horizontal",
  close_on_exit = true,
})

local M = {}

M.toggleTab = function ()
	tTab:toggle()
end

M.toggleFloat = function()
  if tFloat:is_open() then
    tFloat:close()
    return
  end
  tRight:close()
  tDown:close()
  tFloat:open()
end

M.toggleRight = function()
  if tRight:is_open() then
    tRight:close()
    return
  end
  tFloat:close()
  tDown:close()
  tRight:open()
end

M.toggleDown = function()
  if tDown:is_open() then
    tDown:close()
    return
  end
  tFloat:close()
  tRight:close()
  tDown:open()
end

M.toggleGit = function()
  lazygit:toggle()
end

require("pluginsKMappings").toggleTerm_map(M)
