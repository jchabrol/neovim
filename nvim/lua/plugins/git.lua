return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "Gstatus", "Glog" },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
    config = function()
      require("configurations.diffview")
    end,
  },
}
