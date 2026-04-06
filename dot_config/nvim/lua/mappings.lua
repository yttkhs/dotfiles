require("nvchad.mappings")

local map = vim.keymap.set
local del = vim.keymap.del

-- Remove NvChad insert mode cursor movement
del("i", "<C-h>")
del("i", "<C-l>")
del("i", "<C-j>")
del("i", "<C-k>")

-- Remove NvChad terminal mapping (conflicts with gitsigns <leader>h* keys)
del("n", "<leader>h")

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

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

