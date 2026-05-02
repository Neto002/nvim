return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()

    require('nvim-treesitter').setup {

      -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
      install_dir = vim.fn.stdpath('data') .. '/site'
    }

    require('nvim-treesitter').install { 'lua', 'rust', 'go', 'gomod', 'c_sharp', 'java', 'typescript', 'tsx', 'javascript' }
  end
}
