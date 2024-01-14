-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- cursor
vim.opt.guicursor = ""

-- line number in the left margin
vim.opt.nu = true

-- relative numbers
vim.opt.relativenumber = true

-- tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- adjusts the indentation level based on the code structure
vim.opt.smartindent = true

-- long lines will not visually wrap to the next line
vim.opt.wrap = false

-- undo file support
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- true color support in terminal
vim.opt.termguicolors = true

-- minimum number of lines to keep above and below the cursor when scrolling
vim.opt.scrolloff = 10

-- icons column (to show errors / warnings ...)
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- The length of time Vim waits after you stop typing before it triggers the
-- plugin, default is 4000ms
vim.opt.updatetime = 50

-- color column to know when should break the line
vim.opt.colorcolumn = "80"

-- enable clipboard support
vim.opt.clipboard = "unnamedplus"


-- vertical
vim.g.netrw_altv=1

-- horizontal
vim.g.netrw_alto=1

