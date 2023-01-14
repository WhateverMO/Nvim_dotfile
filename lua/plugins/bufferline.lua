vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		mod = "buffers",
		numbers = "ordinal",
		show_buffer_close_icons = true,
		show_buffer_icons = true,
		show_tab_indicators = true,
		always_show_bufferline = true,
		separator_style = "thin",
		-- 关闭 Tab 的命令
		close_command = "Bdelete! %d",
		right_mouse_command = "Bdelete! %d",
		-- 侧边栏配置
		-- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "center",
				padding = 1,
			},
			{
				filetype = "lspsagaoutline",
				text = "Lspsaga Outline",
				text_align = "center",
				padding = 1,
			},
		},
		-- 使用 nvim 内置 LSP  后续课程会配置
		diagnostics = "nvim_lsp",
		-- 可选，显示 LSP 报错图标
		---@diagnostic disable-next-line: unused-local
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
	},
})
