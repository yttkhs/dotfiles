require("nvchad.mappings")

local map = vim.keymap.set
local del = vim.keymap.del

-- Remove NvChad insert mode cursor movement
del("i", "<C-h>")
del("i", "<C-l>")
del("i", "<C-j>")
del("i", "<C-k>")

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Neogit
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Neogit" })

-- Git branches
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })

-- Diffview
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })

-- Todo Comments
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle<CR>", { desc = "LSP references (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix (Trouble)" })

-- Neovide-specific mappings
if vim.g.neovide then
  -- Cmd+S to save
  map({ "n", "i", "v" }, "<D-s>", "<cmd>w<CR>", { desc = "Save file" })

  -- Cmd+V to paste from system clipboard
  map({ "n", "v" }, "<D-v>", '"+p', { desc = "Paste from clipboard" })
  map("i", "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })
  map("c", "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })

  -- Cmd+=/- for zoom
  vim.g.neovide_scale_factor = 1.0

  map("n", "<D-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, { desc = "Zoom in" })

  map("n", "<D-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
  end, { desc = "Zoom out" })

  map("n", "<D-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Reset zoom" })
end
