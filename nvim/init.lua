require("configurations.lazy")
require("configurations.options")

-- enable virtual text
vim.diagnostic.config({ virtual_text = true })

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Quit
vim.api.nvim_set_keymap("n", "<LEADER>q", ":q<CR>", { noremap = true })
-- Save current buffer
vim.api.nvim_set_keymap("n", "<LEADER>w", ":w<CR>", { noremap = true })
-- Save and Exit
vim.api.nvim_set_keymap("n", "<LEADER>x", ":x<CR>", { noremap = true })
-- Select everything
vim.api.nvim_set_keymap("n", "<LEADER>v", "V`]", { noremap = true })
-- Clear search highlight
vim.api.nvim_set_keymap("n", "<LEADER>,", ":noh<CR>", { noremap = true })
-- Put neovim in background
vim.api.nvim_set_keymap("n", "<LEADER>z", "<C-z>", { noremap = true })

-- Move around windows
vim.api.nvim_set_keymap("n", "<LEADER>h", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER><Left>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER>j", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER><Down>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER>k", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER><Up>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER>l", "<C-w>l", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER><Right>", "<C-w>l", { noremap = true })

-- Tab movement
vim.api.nvim_set_keymap("n", "<LEADER>é", ":tabp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<LEADER>\"", ":tabn<CR>", { noremap = true })

-- Force write (sudo)
vim.keymap.set("c", "w!!", "SudaWrite")

-- Strip trailing whitespace
vim.api.nvim_set_keymap("n", "<LEADER>sw", ":StripWhitespace<CR>", { noremap = true })