return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("configs.conform")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "printf",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "toml",
        "bash",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "gitcommit",
        "diff",
      },
    },
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 40,
        side = "left",
      },
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = { char = "▎", show_start = false },
    },
  },

  -- Better escape (jk without delay)
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      timeout = 200,
      mappings = {
        i = { j = { k = "<Esc>" } },
      },
    },
  },

  -- Cmdline completion
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local cmp = require("cmp")
      -- `/` and `?` search completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      -- `:` command completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
        }),
      })
    end,
  },

  -- Smooth scrolling (terminal only, Neovide handles its own)
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    cond = not vim.g.neovide,
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
      hide_cursor = true,
      respect_scrolloff = true,
    },
  },

  -- Git client (Magit-style, integrates with diffview.nvim)
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },

  -- Diff viewer
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  -- Surround operations (cs"', ysiw], ds])
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto close/rename HTML & JSX/TSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- Accelerated j/k movement
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)", mode = "n" },
      { "k", "<Plug>(accelerated_jk_gk)", mode = "n" },
    },
  },

  -- Flash motion (jump anywhere in 2-3 keystrokes)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Highlight and search TODO/FIXME/HACK comments
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Pretty diagnostics list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Linter integration (complements conform.nvim for formatting)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.lint")
    end,
  },

  -- Session restore
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Stop session saving" },
    },
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        filetypes_denylist = { "dirbuf", "dirvish", "fugitive", "NvimTree", "nvdash" },
      })
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end,
  },

  -- Auto save
  {
    "okuuuu/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {},
  },

  -- Test runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({ dap = { justMyCode = false } }),
          require("neotest-vitest"),
        },
      })
    end,
    cmd = "Neotest",
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle test output" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    },
  },
}
