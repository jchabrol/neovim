return {

-- Typescript support
{"leafgarland/typescript-vim"},
{"peitalin/vim-jsx-typescript"},

-- Javascript syntax highlighting
{"pangloss/vim-javascript"},
{"othree/jsdoc-syntax.vim"},

--" Hashicorp Terraform syntax support
{"hashivim/vim-terraform"},

--" Best status bar ever
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},

--" Git Integration
{"tpope/vim-fugitive"},

--" Surrounding plugin (to add quotes/parens/brackets around stuff)
{"tpope/vim-surround"},

--" Nerdcommenter best comment tool ever
{"scrooloose/nerdcommenter"},

--" Ack support
--" Beware ! git.fsck might not like this plugin. Use manual install if needed:
--" git clone --config transfer.fsckobjects=false https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
{"mileszs/ack.vim"},

--" Syntax checker
{'dense-analysis/ale'},

--" Better swap file handling
{"gioele/vim-autoswap"},

--" Code formatting
{"sbdchd/neoformat"},

-- text case
{"johmsalas/text-case.nvim"},

--" Better substitute
{"tpope/vim-abolish"},

--" PEP8 checker
{"nvie/vim-flake8"},

--" Markdown preview
{"iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
  keys = {
    {"<LEADER>m",":MarkdownPreview<CR>", desc = "launch markdown preview"},
    {"<LEADER>ms",":MarkdownPreviewStop<CR>", desc = "stop  markdown preview"},
    {"<LEADER>mt",":MarkdownPreviewToggle<CR>", desc = "stop  markdown preview"},
  },
},

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
}
