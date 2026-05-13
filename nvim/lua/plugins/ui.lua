return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({})
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 900,
    keys = {
      {
        "<leader>dn",
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

  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      options = {
        theme = "tokyonight",
      },
      tabline = {
        lualine_a = { "tabs" },
        lualine_b = { { "filename", path = 1 } },
        lualine_c = { "windows" },
        lualine_x = { "copilot", "encoding", "fileformat", "filetype" },
        lualine_y = {},
        lualine_z = { "lsp_status" },
      },
      sections = {
        lualine_x = {
          {
            "copilot",
            symbols = {
              status = {
                icons = {
                  enabled = " ",
                  sleep = " ",
                  disabled = " ",
                  warning = " ",
                  unknown = " ",
                },
                hl = {
                  enabled = "#50FA7B",
                  sleep = "#AEB7D0",
                  disabled = "#6272A4",
                  warning = "#FFB86C",
                  unknown = "#FF5555",
                },
              },
              spinners = "dots",
              spinner_color = "#6272A4",
            },
            show_colors = false,
            show_loading = true,
          },
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    },
  },

  { "AndreM222/copilot-lualine", lazy = true },
}
