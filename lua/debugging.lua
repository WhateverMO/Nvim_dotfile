
local dap = require("dap")
local dapui = require("dapui")
-- setup dap UI
dapui.setup()

-- Dap Fires events Before and After, Triggle dap UI when we see them
dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()
  end
dap.listeners.before.event_terminated['dapui_config'] = function()
	dapui.close()
  end
dap.listeners.before.event_exited['dapui_config'] = function()
	dapui.close()
  end

-- go dap
dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = 'dlv',
		args = {'dap','-l','127.0.0.1:${port}'},
	}
}

-- launch configurations
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},{
		type = "delve",
		name = "Debug Tests",
		request = "launch",
		mode = "test",
		program = "${file}",
	}
}
