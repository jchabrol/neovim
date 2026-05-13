return {
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  { "tpope/vim-surround", event = "VeryLazy" },
  { "scrooloose/nerdcommenter", event = "VeryLazy" },
  { "gioele/vim-autoswap", event = "VeryLazy" },
  { "ntpeters/vim-better-whitespace", event = "VeryLazy" },

  { "sbdchd/neoformat", cmd = "Neoformat" },

  {
    "lambdalisue/vim-suda",
    cmd = { "SudaRead", "SudaWrite" },
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      files = {
        cmd = "rg --files --hidden --follow --glob '!.git' --glob '!.venv'",
      },
      grep = {
        rg_opts = "--hidden --column --line-number --no-heading "
          .. "--color=always --smart-case "
          .. "-g '!.git' -g '!.venv'",
      },
    },
    keys = {
      { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find files" },
      { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help tags" },
      { "<leader>fs", function() require("fzf-lua").grep_cword() end, desc = "Grep word under cursor" },
    },
  },
}
