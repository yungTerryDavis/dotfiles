local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Identation
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Wrapping
opt.wrap = false
-- opt.linebreak = true
-- opt.breakindent = true

-- UI / movement
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true
opt.signcolumn = "yes"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Files / system
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.undofile = true
opt.updatetime = 250
opt.termguicolors = true
opt.showcmd = true
opt.showmode = false

-- Command line / completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmenu = true
opt.wildmode = "longest:full,full"

