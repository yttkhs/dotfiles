-- mini.nvim alternatives for better Kanagawa theme support
-- Replaces snacks.nvim features with mini.nvim equivalents
return {
  -- mini.notify: notification system (replaces snacks notifier)
  {
    "nvim-mini/mini.notify",
    version = false,
    event = "VeryLazy",
    opts = {
      lsp_progress = {
        enable = true,
      },
    },
    config = function(_, opts)
      local notify = require("mini.notify")
      notify.setup(opts)
      vim.notify = notify.make_notify()
    end,
  },

  -- mini.indentscope: animated indent scope (replaces snacks indent)
  {
    "nvim-mini/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        animation = function() return 0 end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "nvim-tree",
          "Trouble",
          "trouble",
          "snacks_dashboard",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- mini.tabline: buffer/tab line (replaces bufferline)
  {
    "nvim-mini/mini.tabline",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      show_icons = true,
      tabpage_section = "right",
    },
  },

  -- mini.hipatterns: highlight patterns like TODO/FIXME (replaces todo-comments)
  {
    "nvim-mini/mini.hipatterns",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local hi = require("mini.hipatterns")
      return {
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          -- Highlight hex colors
          hex_color = hi.gen_highlighter.hex_color(),
        },
      }
    end,
  },

  -- mini.clue: key binding helper (replaces which-key)
  {
    "nvim-mini/mini.clue",
    version = false,
    event = "VeryLazy",
    opts = function()
      local miniclue = require("mini.clue")
      return {
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },

          -- Brackets
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },

        window = {
          delay = 300,
          config = {
            width = "auto",
          },
        },
      }
    end,
  },
}
