require("nvchad.configs.lspconfig").defaults()

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
  -- Other
  "lua_ls",
  "biome",
  "marksman",
  "taplo",
  "sqlls",
  "prismals",
}

vim.lsp.enable(servers)
