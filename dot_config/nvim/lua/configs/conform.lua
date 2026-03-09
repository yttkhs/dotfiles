local conform = require("conform")

local web_fmts = { "biome-check", "prettierd", "prettier", stop_after_first = true }
local prettier_fmts = { "prettierd", "prettier", stop_after_first = true }

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = web_fmts,
    typescript = web_fmts,
    javascriptreact = web_fmts,
    typescriptreact = web_fmts,
    json = web_fmts,
    jsonc = web_fmts,
    css = prettier_fmts,
    html = prettier_fmts,
    yaml = prettier_fmts,
    markdown = prettier_fmts,
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
