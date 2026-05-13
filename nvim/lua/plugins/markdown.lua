return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = vim.fn.executable("npm") == 1,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
    },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_combine_preview = 1

      local function load_then_exec(cmd)
        return function()
          vim.cmd.delcommand(cmd)
          require("lazy").load({ plugins = { "markdown-preview.nvim" } })
          vim.api.nvim_exec_autocmds("BufEnter", {})
          vim.cmd(cmd)
        end
      end

      for _, cmd in pairs({ "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" }) do
        vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
      end
    end,
  },
}