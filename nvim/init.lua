require("configurations.lazy")
vim.cmd[[colorscheme tokyonight]]

-- enable virtual text
vim.diagnostic.config({ virtual_text = true })

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
        path = 1
      }
    },
    lualine_c = {"windows"},
    lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' },
    lualine_y = {},
    lualine_z = {"lsp_status"}
  },
  sections = {
    lualine_x = {
	{
        'copilot',
            -- Default values
            symbols = {
                status = {
                    icons = {
                        enabled = " ",
                        sleep = " ",   -- auto-trigger disabled
                        disabled = " ",
                        warning = " ",
                        unknown = " "
                    },
                    hl = {
                        enabled = "#50FA7B",
                        sleep = "#AEB7D0",
                        disabled = "#6272A4",
                        warning = "#FFB86C",
                        unknown = "#FF5555"
                    }
                },
                spinners = "dots", -- has some premade spinners
                spinner_color = "#6272A4"
            },
            show_colors = false,
            show_loading = true
        },
        'encoding',
        'fileformat',
        'filetype'
    }
    }
}

-- Configuration de nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
  mapping = {

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-g>'] = function()
        if cmp.visible_docs() then
          cmp.close_docs()
        else
          cmp.open_docs()
        end
      end,
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({
            select = true,
          })
        end
      else
        fallback()
      end
    end),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'dotenv' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        path ="[PATH]",
      })
    }),
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require "cmp-under-comparator".under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

-- Configuration de nvim-cmp pour la ligne de commande :
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Configuration de nvim-cmp pour la recherche /
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})

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
  ensure_installed = {"biome","yamlls","dockerls","ruff"}
}

-- tree-sitter highlight parser
require("configurations.tree-sitter")
-- diffview configuration
require("configurations.diffview")
-- global configuration options
require("configurations.options")
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

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable('biome')
vim.lsp.enable('dockerls')

-- === RobotCode (venv auto) ===
-- robotcode n'est pas distribué par mason-lspconfig : on l'attend dans le venv
-- du projet (`pip install robotcode`) ou sur le PATH système.
local function detect_venv()
  local env = os.getenv("VIRTUAL_ENV")
  if env and vim.uv.fs_stat(env) then
    return env
  end
  local local_venv = vim.fn.getcwd() .. "/.venv"
  if vim.uv.fs_stat(local_venv) then
    return local_venv
  end
  return nil
end

local function find_site_packages(venv)
  if not venv then return nil end
  local matches = vim.fn.glob(venv .. "/lib/python*/site-packages", false, true)
  return matches[1]
end

local venv_path = detect_venv()
local robotcode_cmd = (venv_path and vim.fn.executable(venv_path .. "/bin/robotcode") == 1)
    and (venv_path .. "/bin/robotcode")
    or "robotcode"
local python_exec = (venv_path and vim.fn.executable(venv_path .. "/bin/python") == 1)
    and (venv_path .. "/bin/python")
    or "python3"
local site_packages = find_site_packages(venv_path)

vim.lsp.config("robotcode", {
  cmd = { robotcode_cmd, "language-server" },
  settings = {
    robot = {
      pythonpath = site_packages and { site_packages } or {},
      python = { executable = python_exec },
    },
  },
})
if vim.fn.executable(robotcode_cmd) == 1 then
  vim.lsp.enable("robotcode")
else
  vim.schedule(function()
    vim.notify(
      "robotcode LSP introuvable (cherché : " .. robotcode_cmd .. "). Installe-le avec `pip install robotcode`.",
      vim.log.levels.WARN
    )
  end)
end

local dap = require('dap')

-- 1. Configuration de l'adaptateur (le moteur)
dap.adapters.robotcode = function(cb, config)
  if config.request == 'launch' then
    cb({
      type = 'executable',
      command = python_exec,
      args = { robotcode_cmd, "language-server" },
    })
  end
end
-- 2. Configuration du lancement (le comportement)
dap.configurations.robot = {
  {
    type = 'robotcode',
    request = 'launch',
    name = 'Run current robot file',
    cwd = vim.fn.getcwd(),
    target = "${file}",
    pythonPath = python_exec,
    args = {}, -- Vous pouvez ajouter des arguments --variable ici
    console = 'integratedTerminal',
  },
}
-- Crée un groupe d'autocommandes pour le formatage
local format_augroup = vim.api.nvim_create_augroup("RobotFormat", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_augroup,
  pattern = { "*.robot", "*.resource" },
  callback = function()
    -- Demande au LSP de formater le fichier de manière synchrone avant l'écriture
    vim.lsp.buf.format({ async = false })
  end,
})

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
vim.lsp.config('ruff',{
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
})

vim.lsp.enable('ruff')

vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      customTags = { '!reference sequence' },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["../path/relative/to/file.yml"] = "/.github/workflows/*",
        ["/path/from/root/of/project"] = "/.github/workflows/*",
      },
    },
  }
})

vim.lsp.enable('yamlls')


-- Markdown display
vim.api.nvim_set_keymap("n","<LEADER>m","<cmd>MarkdownPreview<CR>",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>ms","<cmd>MarkdownPreviewStop<CR>",{noremap = true});
vim.api.nvim_set_keymap("n","<LEADER>mt","<cmd>MarkdownPreviewToggle<CR>",{noremap = true});

---- nvim dev container launch
require("devcontainer").setup{}

