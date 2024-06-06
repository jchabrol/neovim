return {
  {"nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
    keys = {
      {"<leader>n","<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim tree"},
      {"<leader>f","<cmd>NvimTreeFindFile<cr>", desc = "Find file nvim tree"},
    }
  },
  {"nvim-tree/nvim-web-devicons"},
}
