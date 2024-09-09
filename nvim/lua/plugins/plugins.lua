return {

{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
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

--" Surrounding plugin (to add quotes/parens/brackets around stuff)
{"tpope/vim-surround"},

--" Nerdcommenter best comment tool ever
{"scrooloose/nerdcommenter"},

--" Syntax checker
{'dense-analysis/ale'},

--" Better swap file handling
{"gioele/vim-autoswap"},

--" Code formatting
{"sbdchd/neoformat"},

-- text case
{
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  end,
  keys = {
    "ga", -- Default invocation prefix
    { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
  },
  cmd = {
    -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
    "Subs",
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
    "TextCaseStartReplacingCommand",
  },
  -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
  -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
  -- available after the first executing of it or after a keymap of text-case.nvim has been used.
  lazy = false,
},

--" Better substitute
{"tpope/vim-abolish"},


--" Dirdiff
{"will133/vim-dirdiff"},

-- vim better whitespace management
{"ntpeters/vim-better-whitespace"},

-- vim-suda
{"lambdalisue/vim-suda"},

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
    "neovim/nvim-lspconfig",
},

-- markdown manager
{ "jannis-baum/vivify.vim" },

}
