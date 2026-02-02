return {
  -- snacks.nvim: disable features replaced by mini.nvim
  {
    "snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      notifier = { enabled = false }, -- replaced by mini.notify
      indent = { enabled = false }, -- replaced by mini.indentscope
      picker = { enabled = true },
      explorer = { enabled = false },
      git = { enabled = true },
      terminal = { enabled = true },
      bufdelete = { enabled = true },
      scratch = { enabled = true },
      scope = { enabled = false }, -- replaced by mini.indentscope
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
      input = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
    },
  },

  -- Disabled plugins (replaced by mini.nvim alternatives for Kanagawa support)
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false }, -- replaced by mini.notify
  { "lukas-reineke/indent-blankline.nvim", enabled = false }, -- replaced by mini.indentscope
  { "nvim-mini/mini.bufremove", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false }, -- replaced by mini.tabline
  { "folke/todo-comments.nvim", enabled = false }, -- replaced by mini.hipatterns
  { "folke/which-key.nvim", enabled = false }, -- replaced by mini.clue
}
