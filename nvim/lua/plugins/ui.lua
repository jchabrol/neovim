return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({})
      vim.cmd.colorscheme("tokyonight")

      -- robotcode émet des semantic tokens propres à Robot Framework qui ne sont
      -- pas colorés par défaut. On mappe ces types (suffixe .robot pour ne pas
      -- toucher les autres langages) vers des groupes de surlignage standards.
      local robot_token_links = {
        settingImport = "@keyword.import",
        setting = "@keyword",
        header = "@markup.heading",
        headerSettings = "@markup.heading",
        headerVariable = "@markup.heading",
        headerTestcase = "@markup.heading",
        headerTask = "@markup.heading",
        headerComment = "@markup.heading",
        headerKeyword = "@markup.heading",
        testcaseName = "@function",
        keywordName = "@function",
        controlFlow = "@keyword.repeat",
        argument = "@string",
        variable = "@variable",
        keywordCall = "@function.call",
        keywordCallInner = "@function.call",
        bddPrefix = "@keyword",
        nameCall = "@function.call",
        continuation = "@punctuation.special",
        terminator = "@punctuation.delimiter",
        forSeparator = "@keyword.repeat",
        variableBegin = "@punctuation.bracket",
        variableEnd = "@punctuation.bracket",
        expressionBegin = "@punctuation.bracket",
        expressionEnd = "@punctuation.bracket",
        variableExpression = "@variable",
        escape = "@string.escape",
        namespace = "@module",
        config = "@keyword",
        namedArgument = "@variable.parameter",
        var = "@keyword",
        documentation = "@comment.documentation",
        error = "Error",
      }
      local apply_robot_hl = function()
        for token_type, target in pairs(robot_token_links) do
          vim.api.nvim_set_hl(0, "@lsp.type." .. token_type .. ".robot", { link = target })
        end
      end
      vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_robot_hl })
      apply_robot_hl()
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
