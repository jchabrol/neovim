local ensure_installed = { "robot", "typescript", "javascript", "lua" }

require("nvim-treesitter").install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  pattern = ensure_installed,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
