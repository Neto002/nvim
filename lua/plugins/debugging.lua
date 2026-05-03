return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
			"Cliffback/netcoredbg-macOS-arm64.nvim",
			"mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			require("dapui").setup()
			require("dap-go").setup()
			require("netcoredbg-macOS-arm64").setup(require("dap"))
      require("dap-python").setup("python3")

			-- Keymaps
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})

			-- Step controls
			vim.keymap.set("n", "<leader>dn", dap.step_over, {}) -- next (step over)
			vim.keymap.set("n", "<leader>di", dap.step_into, {}) -- step into
			vim.keymap.set("n", "<leader>do", dap.step_out, {}) -- step out

			-- Controle geral
			vim.keymap.set("n", "<leader>dr", dap.restart, {}) -- restart
			vim.keymap.set("n", "<leader>dq", dap.terminate, {}) -- stop

			-- Breakpoints avançados
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, {})

			-- Ver valores
			vim.keymap.set("n", "<leader>dh", function()
				require("dap.ui.widgets").hover()
			end, {})

			-- Dap events
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- .NET Configuration
			dap.adapters.coreclr = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
		end,
	},
}
