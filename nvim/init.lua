local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.do_filetype_lua = 1

--Global shortcut parameters
--plugin shortcut will be managed in plugins configuration
-- LEADER SHORTCUTS
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

-- Quit
vim.api.nvim_set_keymap("n","<LEADER>q",":q<CR>",{noremap = true});

-- Save current buffer
vim.api.nvim_set_keymap("n","<LEADER>w",":w<CR>",{noremap = true});

-- Save and Exit
vim.api.nvim_set_keymap("n","<LEADER>x",":x<CR>",{noremap = true});
-- Select everything
vim.api.nvim_set_keymap("n","<LEADER>v","V`]",{noremap = true});
-- Clear search highlight
vim.api.nvim_set_keymap("n","<LEADER>,",":noh<CR>",{noremap = true});
-- Put nvim in background
vim.api.nvim_set_keymap("n","<LEADER>z","<C-z>",{noremap = true});

-- Refresh vim config from ~/.vimrc
vim.api.nvim_set_keymap("n","<LEADER>sv",":source ~/.config/nvim/init.lua<CR>",{noremap = true});
-- Edit vimrc in a vertical split
vim.api.nvim_set_keymap("n","<leader>ev",":vsplit ~/.config/nvim/init.lua<CR>",{noremap = true});

-- Move around windows
vim.api.nvim_set_keymap("n","<LEADER>h","<C-w>h",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER><Left>","<C-w>h",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>j","<C-w>j",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER><Down>","<C-w>j",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>k","<C-w>k",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER><Up>","<C-w>k",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>l","<C-w>l",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER><Right>","<C-w>l",{noremap = true});

-- Tab movement
vim.api.nvim_set_keymap("n","<F2>",":tabp<CR>",{noremap = true});
vim.api.nvim_set_keymap("n","<F3>",":tabn<CR>",{noremap = true});

-- Activate robotframework sytax highlighting
vim.api.nvim_set_keymap("n","<F12>",":setf robot<CR>",{noremap = true});

-- Force write
vim.keymap.set("c","w!!","SudaWrite");

require("lazy").setup("plugins")
require('lualine').setup()

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 't', api.node.open.tab,        opts('Open: New Tab'))
  vim.keymap.set('n', '?', api.tree.toggle_help,                  opts('Help'))
end

require("nvim-tree").setup{
  on_attach = my_on_attach,
}

local function open_nvim_tree()
-- open the tree
  require("nvim-tree.api").tree.open()
end



vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- remove empty space
vim.api.nvim_set_keymap("n","<LEADER>sw",":StripWhitespace<CR>",{noremap = true});

-- Automatically refresh buffer on external changes
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

require("configurations.coc")
require("configurations.tree-sitter")
require("configurations.options")

vim.g.markdown_fenced_languages = "['html', 'javascript', 'bash=sh']"

vim.api.nvim_create_autocmd({"BufWritePost"},{
  pattern = {"*.py"},
  command = "call flake8#Flake8()",
})

vim.g.vim_markdown_preview_github = 1
