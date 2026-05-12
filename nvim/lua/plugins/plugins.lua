return {

{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
},

{
  "rcarriga/nvim-notify",
  lazy = false,
  priority = 900,
  keys = {
    {
      "<leader>nd",
      function() require("notify").dismiss({ silent = true, pending = true }) end,
      desc = "Dismiss notifications",
    },
  },
  opts = {
    stages = "fade",
    timeout = 3000,
    render = "default",
    top_down = false,
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
},

---- which-key utility to find key used
--{
  --"folke/which-key.nvim",
  --dependencies = { 'echasnovski/mini.icons' },
  --event = "VeryLazy",
  --keys = {
    --{
      --"<leader>?",
      --function()
        --require("which-key").show({ global = false })
      --end,
      --desc = "Buffer Local Keymaps (which-key)",
    --},
  --},
--},

--- show diagnostics, reference.
{
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
},
-- Typescript support
{"leafgarland/typescript-vim"},
{"peitalin/vim-jsx-typescript"},

-- Javascript syntax highlighting
{"pangloss/vim-javascript"},
{"othree/jsdoc-syntax.vim"},

--" Best status bar ever
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    extensions = {'lazy', 'nvim-tree'},
    options = { theme = 'codedark'}
},

--" Git Integration
{"tpope/vim-fugitive"},
{"shumphrey/fugitive-gitlab.vim",
dependencies = {"tpope/vim-fugitive"},
},
{"sindrets/diffview.nvim"},

--" Surrounding plugin (to add quotes/parens/brackets around stuff)
{"tpope/vim-surround"},

--" Nerdcommenter best comment tool ever
{"scrooloose/nerdcommenter"},

--" Better swap file handling
{"gioele/vim-autoswap"},

--" Code formatting
{"sbdchd/neoformat"},

-- vim better whitespace management
{"ntpeters/vim-better-whitespace"},

-- vim-suda
{"lambdalisue/vim-suda"},

-- vim-dap
{ "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },

-- vim telescope
    {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" }
    },

-- nvim tree sitter
{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

-- mason package mananager
-- neovim lsp config
-- Installation for lsp usage

{
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
},

{'neovim/nvim-lspconfig'},

-- Configuration de lazy.nvim
{
  'hrsh7th/nvim-cmp',      -- Framework d'autocomplétion
  'hrsh7th/cmp-nvim-lsp',  -- Source LSP pour nvim-cmp
  'hrsh7th/cmp-buffer',    -- Source de complétion à partir du buffer
  'hrsh7th/cmp-path',      -- Source de complétion à partir du chemin du système de fichiers
  'hrsh7th/cmp-cmdline',   -- Source de complétion pour la ligne de commande
  'hrsh7th/cmp-nvim-lsp-document-symbol',   -- Add symbol in display
  'hrsh7th/cmp-nvim-lsp-signature-help',   -- display function help
  'lukas-reineke/cmp-under-comparator',  -- better sort completion items that start with one or more underlines.
  'SergioRibera/cmp-dotenv',  -- get environement variable
  'saadparwaiz1/cmp_luasnip', -- Source de snippets pour nvim-cmp,
  'onsails/lspkind-nvim',
},

 -- Snippets pour nvim-cmp
{
  'L3MON4D3/LuaSnip',
  dependencies = { "rafamadriz/friendly-snippets" },
  init = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({paths = "~/WAB/e2e-tests/.vscode/robotframework_documentation_template.code-snippets"})
  end,
},

---- markdown manager
{
  "iamcco/markdown-preview.nvim",
  enabled = vim.fn.executable("npm") == 1,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_command_for_global = 1
    vim.g.mkdp_combine_preview = 1

    local function load_then_exec(cmd)
      return function()
        vim.cmd.delcommand(cmd)
        require("lazy").load({ plugins = { "markdown-preview.nvim" } })
        vim.api.nvim_exec_autocmds("BufEnter", {}) -- commands appear only after BufEnter
        vim.cmd(cmd)
      end
    end

    ---Fixes "No command :MarkdownPreview"
    ---https://github.com/iamcco/markdown-preview.nvim/issues/585#issuecomment-1724859362
    for _, cmd in pairs({ "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" }) do
      vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
    end
  end,
},

 --nvim dev container
{
  'https://codeberg.org/esensar/nvim-dev-container'
},

--nvim copilot
{
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",   -- Ctrl + l
          next = "<C-n>",     -- Ctrl + n
          prev = "<C-p>",     -- Ctrl + p
          dismiss = "<C-q>",  -- Ctrl + q
        },
      },
    })
  end,
},
}
