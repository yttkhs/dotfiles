return {
  -- Disable snacks explorer
  {
    "snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },

  -- Enable nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer (nvim-tree)" },
    },
    opts = {
      view = {
        side = "left",
        width = 40,
        signcolumn = "no",
      },
    },
  },
}
