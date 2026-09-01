vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "python",
    "lua",

    "sh",
    "bash",
    "sql",

    "json",
    "yaml",
    "toml",

    "dockerfile",

    "markdown",
  },
  callback = function()
    vim.treesitter.start()
  end,
})
