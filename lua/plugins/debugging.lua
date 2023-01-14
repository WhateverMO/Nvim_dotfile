
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

-- python dap
dap.adapters.python = {
  type = 'executable';
  command = '/usr/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
-- launch configurations
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
		console = "integratedTerminal";
  },
}

-- c/cpp/rust dap
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/absolute/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}
-- launch configurations
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
