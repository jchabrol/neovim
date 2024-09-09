return {
   {
     "harrisoncramer/gitlab.nvim",
     dependencies = {
       "MunifTanjim/nui.nvim",
       "nvim-lua/plenary.nvim",
       "sindrets/diffview.nvim",
       "folke/tokyonight.nvim",
       "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
       "nvim-tree/nvim-web-devicons" -- Recommended but not required. Icons in discussion tree.
     },
     enabled = true,
     build = function ()
       require("gitlab.server").build(true)
     end, -- Builds the Go binary
     config = function()
       require("tokyonight").setup({})
       vim.cmd[[colorscheme tokyonight]]

       local gitlab = require("gitlab")
       gitlab.setup()
       vim.keymap.set("n", "<leader>glb", gitlab.choose_merge_request, { desc = "Choose merge request" })
       vim.keymap.set("n", "<leader>glr", gitlab.review, { desc = "Review" })
       vim.keymap.set("n", "<leader>gls", gitlab.summary, { desc = "Summary" })
       vim.keymap.set("n", "<leader>glA", gitlab.approve, { desc = "Approve" })
       vim.keymap.set("n", "<leader>glR", gitlab.revoke, { desc = "Revoke" })
       vim.keymap.set("n", "<leader>glc", gitlab.create_comment, { desc = "Create comment" })
       vim.keymap.set("v", "<leader>glc", gitlab.create_multiline_comment, { desc = "Create multiline comment" })
       vim.keymap.set("v", "<leader>glC", gitlab.create_comment_suggestion, { desc = "Create comment suggestion" })
       vim.keymap.set("n", "<leader>glO", gitlab.create_mr, { desc = "Create merge request" })
       vim.keymap.set("n", "<leader>glm", gitlab.move_to_discussion_tree_from_diagnostic, { desc = "Move to discussion tree" })
       vim.keymap.set("n", "<leader>gln", gitlab.create_note, { desc = "Create note" })
       vim.keymap.set("n", "<leader>gld", gitlab.toggle_discussions, { desc = "Toggle discussions" })
       vim.keymap.set("n", "<leader>glaa", gitlab.add_assignee, { desc = "Add assignee" })
       vim.keymap.set("n", "<leader>glad", gitlab.delete_assignee, { desc = "Delete assignee" })
       vim.keymap.set("n", "<leader>glla", gitlab.add_label, { desc = "Add label" })
       vim.keymap.set("n", "<leader>glld", gitlab.delete_label, { desc = "Delete label" })
       vim.keymap.set("n", "<leader>glra", gitlab.add_reviewer, { desc = "Add reviewer" })
       vim.keymap.set("n", "<leader>glrd", gitlab.delete_reviewer, { desc = "Delete reviewer" })
       vim.keymap.set("n", "<leader>glp", gitlab.pipeline, { desc = "Pipeline" })
       vim.keymap.set("n", "<leader>glo", gitlab.open_in_browser, { desc = "Open in browser" })
       vim.keymap.set("n", "<leader>glM", gitlab.merge, { desc = "Merge" })
       vim.keymap.set("n", "<leader>glu", gitlab.copy_mr_url, { desc = "Copy MR URL" })
       vim.keymap.set("n", "<leader>glP", gitlab.publish_all_drafts, { desc = "Publish all drafts" })
       vim.keymap.set("n", "<leader>glD", gitlab.toggle_draft_mode, { desc = "Toggle draft mode" })
     end,
   },
}
