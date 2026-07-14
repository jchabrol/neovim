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
    },
    opts = {
      options = {
        theme = "tokyonight",
      },
      tabline = {
        lualine_a = { "tabs" },
        lualine_b = { { "filename", path = 1 } },
        lualine_c = { "windows" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = {},
        lualine_z = { "lsp_status" },
      },
      sections = {
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    },
  },
}
