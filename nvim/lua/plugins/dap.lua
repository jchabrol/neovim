return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "DAP Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP Step Out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI" },
    },
    ft = { "robot", "python" },
    config = function()
      local dap = require("dap")
      local venv = require("configurations.venv").info()

      dap.adapters.robotcode = {
        type = "executable",
        command = venv.robotcode_cmd,
        args = { "debug-launch", "--stdio" },
      }

      dap.configurations.robot = {
        {
          type = "robotcode",
          request = "launch",
          name = "Run current robot file",
          cwd = vim.fn.getcwd(),
          target = "${file}",
          args = {},
          console = "integratedTerminal",
        },
      }
    end,
  },
}
