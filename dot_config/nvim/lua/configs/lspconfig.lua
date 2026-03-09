require("nvchad.configs.lspconfig").defaults()

-- Hide diagnostic sign column icons (keep gitsigns only) & use undercurl
vim.diagnostic.config({ signs = false })

for _, type in ipairs({ "Error", "Warn", "Info", "Hint" }) do
  local hl = "DiagnosticUnderline" .. type
  local existing = vim.api.nvim_get_hl(0, { name = hl })
  existing.underline = false
  existing.undercurl = true
  vim.api.nvim_set_hl(0, hl, existing)
end

local servers = {
  -- Web frontend
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "emmet_language_server",
  "jsonls",
  "eslint",
  "cssmodules_ls",
  "somesass_ls",
  -- Python
  "basedpyright",
  "ruff",
  -- Infra
  "yamlls",
  "bashls",
  "dockerls",
  "docker_compose_language_service",
  -- Shader
  "glsl_analyzer",
  -- Other
  "lua_ls",
  "biome",
  "marksman",
  "taplo",
  "sqlls",
  "prismals",
}

local inlayHints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

vim.lsp.config("ts_ls", {
  settings = {
    typescript = { inlayHints = inlayHints },
    javascript = { inlayHints = inlayHints },
  },
})

vim.lsp.config("lua_ls", {
  settings = { Lua = { hint = { enable = true } } },
})

vim.lsp.enable(servers)
vim.lsp.inlay_hint.enable(true)
