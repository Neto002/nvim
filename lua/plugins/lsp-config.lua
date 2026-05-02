return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup ({
        ensure_installed = { "lua_ls", "omnisharp", "gopls" },
        automatic_enable = true
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        virtual_text = {
          source = "always", -- Show the diagnostic source (e.g., pyright, tsserver)
          prefix = "●",      -- Character preceding the diagnostic text
          spacing = 2        -- Space between code and virtual text
        },
        severity_sort = true, -- Sort diagnostics by severity
        float = {
          source = "always"    -- Show source in floating window
        }
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
    end
  }
}
