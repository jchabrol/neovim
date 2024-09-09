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
{"sindrets/diffview.nvim"},

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
},
{'neovim/nvim-lspconfig'},

{'mfussenegger/nvim-lint'},

---- markdown manager
--{ "jannis-baum/vivify.vim" },

{'preservim/vim-markdown', ft = 'markdown'},

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
}

-- nvim dev container
--{
  --'https://codeberg.org/esensar/nvim-dev-container',
  --dependencies = 'nvim-treesitter/nvim-treesitter'
--},

}
