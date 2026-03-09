require("nvchad.options")

vim.opt.scrolloff = 4
vim.opt.autowriteall = true

-- Session: restore everything (tabs, splits, buffers, cursor position, etc.)
vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.guicursor = {
  "n-v-c:block-blinkon500-blinkoff500-blinkwait500",
  "i-ci-ve:ver25-blinkon500-blinkoff500-blinkwait500",
  "r-cr:hor20-blinkon500-blinkoff500-blinkwait500",
  "o:hor50",
}

