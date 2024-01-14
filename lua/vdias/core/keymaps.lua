-- Set the mapleader to a space character for key mappings that use <leader>.
vim.g.mapleader = " "

-- Define a key mapping in normal mode (<leader>pv) to execute an Ex command.
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Create key mappings for moving selected text down and up in visual mode.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join the current line with the line below in normal mode (J).
vim.keymap.set("n", "J", "mzJ`z")

-- Search and replace the word under the cursor with itself in normal mode.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Edit the Packer.nvim configuration file in normal mode.
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/plugins/example.lua<CR>")

-- Keymap tips:
-- N => "x": remove one char
-- N => "ddp": change line lines above to below
-- N => "di": deletes inside " or ', ( ...
-- N => "yi": yank inside " or ', ( ...
-- N => "dG": delete intire document up to down
-- N => "dgg": delete intire document down to up
-- I => "Ctrl + w": delete previous word
-- I => "Ctrl + u": delete everything until the beginning of the line
-- I => "Ctrl + o": switch back to normal mode just to execute one command
-- N => "S": right indent
-- N => "gg=G": indent the hole document
