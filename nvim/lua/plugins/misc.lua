vim.pack.add({
	{ src = 'https://github.com/christoomey/vim-tmux-navigator' },
	{ src = 'https://github.com/tpope/vim-sleuth' },
	{ src = 'https://github.com/tpope/vim-fugitive' },
	{ src = 'https://github.com/tpope/vim-rhubarb' },
	{ src = 'https://github.com/windwp/nvim-autopairs' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/folke/todo-comments.nvim' },
	{ src = 'https://github.com/norcalli/nvim-colorizer.lua' },
	{ src = 'https://github.com/numToStr/Comment.nvim' },
})

require('nvim-autopairs').setup({})

require('todo-comments').setup({ signs = false })

require('colorizer').setup()

require('Comment').setup()
