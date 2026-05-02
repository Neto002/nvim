return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    vim.keymap.set('n', '<leader>gp', function()
      local msg = vim.fn.input("Commit message: ")
      if msg == "" then return end

      vim.cmd('Git add .')
      vim.cmd('Git commit -m "' .. msg .. '"')
      vim.cmd('Git push')
    end, { desc = "Fugitive add/commit/push" })
  end
}
