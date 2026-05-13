return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "biome", "yamlls", "dockerls", "ruff", "lua_ls" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local venv = require("configurations.venv").info()

      -- nvim-cmp capabilities advertised to LSP servers
      local _ = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.enable("biome")
      vim.lsp.enable("dockerls")
      vim.lsp.enable("lua_ls")

      vim.lsp.config("robotcode", {
        cmd = { venv.robotcode_cmd, "language-server" },
        settings = {
          robot = {
            pythonpath = venv.site_packages and { venv.site_packages } or {},
            python = { executable = venv.python_exec },
          },
        },
      })
      if vim.fn.executable(venv.robotcode_cmd) == 1 then
        vim.lsp.enable("robotcode")
      else
        vim.schedule(function()
          vim.notify(
            "robotcode LSP introuvable (cherché : " .. venv.robotcode_cmd .. "). Installe-le avec `pip install robotcode`.",
            vim.log.levels.WARN
          )
        end)
      end

      vim.lsp.config("ruff", {
        init_options = {
          settings = { args = {} },
        },
      })
      vim.lsp.enable("ruff")

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            customTags = { "!reference sequence" },
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
          },
        },
      })
      vim.lsp.enable("yamlls")

      local format_augroup = vim.api.nvim_create_augroup("RobotFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_augroup,
        pattern = { "*.robot", "*.resource" },
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },
}
