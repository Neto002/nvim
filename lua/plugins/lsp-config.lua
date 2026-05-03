return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "omnisharp", "gopls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Diagnostics
			vim.diagnostic.config({
				virtual_text = {
					source = "always", -- Show the diagnostic source (e.g., pyright, tsserver)
					prefix = "●", -- Character preceding the diagnostic text
					spacing = 2, -- Space between code and virtual text
				},
				severity_sort = true, -- Sort diagnostics by severity
				float = {
					source = "always", -- Show source in floating window
				},
			})

			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {})
			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set({ "n", "v" }, "<leader>rr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})

			-- Omnisharp
			vim.lsp.config("omnisharp", {
				cmd = {
					vim.fn.stdpath("data") .. "/mason/bin/omnisharp",
					"--languageserver",
					"--hostPID",
					tostring(vim.fn.getpid()),
				},
			})
			vim.lsp.enable("omnisharp")
		end,
	},
}
