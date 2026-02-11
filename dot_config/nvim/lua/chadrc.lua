---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa-dragon",
  transparency = true,
}

M.ui = {
  cmp = {
    style = "atom_colored",
  },
  statusline = {
    theme = "vscode_colored",
  },
  telescope = {
    style = "bordered",
  },
}

M.nvdash = {
  load_on_startup = true,
}

M.mason = {
  pkgs = {
    -- LSP (Web frontend)
    "lua-language-server",
    "typescript-language-server",
    "biome",
    "tailwindcss-language-server",
    "emmet-language-server",
    "json-lsp",
    "eslint-lsp",
    "cssmodules-language-server",
    "some-sass-language-server",
    -- LSP (Python)
    "basedpyright",
    "ruff",
    -- LSP (Infra)
    "yaml-language-server",
    "bash-language-server",
    "dockerfile-language-server",
    "docker-compose-language-service",
    -- LSP (Other)
    "marksman",
    "taplo",
    "sqlls",
    "prisma-language-server",
    -- Formatters
    "stylua",
    "prettier",
    "shfmt",
    -- Linters
    "shellcheck",
  },
}

return M
