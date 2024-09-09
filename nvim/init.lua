require("configurations.lazy")
vim.cmd[[colorscheme tokyonight]]

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

-- remove empty space
vim.api.nvim_set_keymap("n","<LEADER>sw",":StripWhitespace<CR>",{noremap = true});

-- Activate lualine tool bar management
require('lualine').setup {
  options = {
    -- ... your lualine config
    theme = 'tokyonight'
    -- ... your lualine config
  }
}
-- nvim tree configuration
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
  require("nvim-tree.api").tree.open({current_window = true })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


-- Automatically refresh buffer on external changes
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup {
  ensure_installed = {"markdown_oxide","robotframework_ls","biome","yamlls","dockerls","ruff_lsp"}
}

require("configurations.coc")
require("configurations.tree-sitter")
require("configurations.options")

-- telescope configurations
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})

config = function()
  require('textcase').setup {}
  require('telescope').load_extension('textcase')
  vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
  vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
end

-- LSP configurations
require('lspconfig').robotframework_ls.setup{}
require('lspconfig').markdown_oxide.setup{}
require('lspconfig').biome.setup{}
require('lspconfig').yamlls.setup{}
require('lspconfig').dockerls.setup{}

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
require('lspconfig').ruff_lsp.setup {
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}

-- Markdown display with Vivify

vim.api.nvim_set_keymap("n","<LEADER>m","<cmd>Vivify<CR>",{noremap = true});
