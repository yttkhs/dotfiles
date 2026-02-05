return {
  -- Disable LazyVim's snacks_explorer extra (prevents keymaps from being created)
  { import = "lazyvim.plugins.extras.editor.snacks_explorer", enabled = false },

  -- Disable neo-tree if present (LazyVim default)
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- Enable nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer (nvim-tree)" },
    },
    opts = {
      view = {
        side = "left",
        width = 40,
        signcolumn = "no",
      },
      renderer = {
        icons = {
          padding = " ",
        },
      },
    },
  },
}
