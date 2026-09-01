return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'python',
        'lua',

        'bash',
        'sql',

        'json',
        'yaml',
        'toml',

        'dockerfile',

        'markdown',
        'markdown_inline',
      })
    end,
  }
}
