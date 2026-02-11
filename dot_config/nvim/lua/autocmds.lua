require("nvchad.autocmds")

-- Auto-restore session when opening nvim without arguments
vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    if vim.fn.argc() == 0 then
      require("persistence").load()
    end
  end,
})
