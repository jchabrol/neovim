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
-- Put neovim in background
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
vim.api.nvim_set_keymap("n","<LEADER>é",":tabp<CR>",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>\"",":tabn<CR>",{noremap = true});

-- Force write
vim.keymap.set("c","w!!","SudaWrite");

-- remove empty space
vim.api.nvim_set_keymap("n","<LEADER>sw",":StripWhitespace<CR>",{noremap = true});

-- Activate lualine tool bar management
require('lualine').setup {
  options = {
    -- ... your lualine config
    theme = 'tokyonight',
    -- ... your lualine config
  },
  tabline = {
    lualine_a = {"tabs"},
    lualine_b = {
      {
        "filename",
        path = 2
      }
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
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
  require("nvim-tree.api").tree.open()
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
  ensure_installed = {"biome","yamlls","dockerls","ruff","robotframework_ls"}
}

--require('lint').linters_by_ft = {
  --markdown = {'vale'},
  --robot = {'robocop'},
--}


--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  --callback = function()

    ---- try_lint without arguments runs the linters defined in `linters_by_ft`
    ---- for the current filetype
    --require("lint").try_lint()
  --end,
--})

require("configurations.coc")
require("configurations.tree-sitter")
require("configurations.options")
require("configurations.diffview")

-- telescope configurations
local telescope = require 'telescope'
local telescope_builtin = require('telescope.builtin')
telescope.setup{
  pickers = {
    live_grep = {
      file_ignore_patterns = {'.git','.venv'},
      additional_args = function(_)
        return { "--hidden" }
      end
    }
  }
}
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', telescope_builtin.grep_string, {})


-- LSP configurations
local venv_path = vim.fn.trim(vim.fn.system("poetry env info --path"))
if string.len(venv_path) < 50 then
   vim.g.python3_host_prog = venv_path .."/bin/python"
end

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local lspconfig = require'lspconfig'

lspconfig.biome.setup{}
lspconfig.dockerls.setup{}

vim.g.robot_pythonpath = {'.'}

lspconfig.robotframework_ls.setup{
  cmd = { venv_path .."/bin/robotframework_ls" },
  filetypes = {
    'robot','resource'
  },
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname)
  end,
  docs = {
    description = [[
    https://github.com/robocorp/robotframework-lsp

    Language Server Protocol implementation for Robot Framework.
    ]],
  },
  settings = {
    robot = {
      python = { venv_path .. "/bin/python" },
      pythonpath = vim.g.robot_pythonpath
    }
  }
}

lspconfig.yamlls.setup{
  settings = {
    yaml = {
      customTags = { '!reference sequence' },
    },
  }
}

--lspconfig.robotcode.setup{
  --cmd = { venv_path .."/bin/robocode", 'language-server' },
  --filetypes = {
    --'robot','resource'
  --},
  --root_dir = function(fname)
    --return lspconfig.util.find_git_ancestor(fname)
  --end,
  --settings = {
    --robot = {
      --python = { venv_path .. "/bin/python" },
      --pythonpath = vim.g.robot_pythonpath
    --}
  --}
--}


-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
lspconfig.ruff .setup {
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}

-- Markdown display
vim.api.nvim_set_keymap("n","<LEADER>m","<cmd>MarkdownPreview<CR>",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>ms","<cmd>MarkdownPreviewStop<CR>",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>mt","<cmd>MarkdownPreviewToggle<CR>",{noremap = true});

---- nvim dev container launch
--require("devcontainer").setup{}
