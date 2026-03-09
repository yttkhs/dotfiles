---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tomorrow_night",
  transparency = true,
  hl_override = {
    IblScopeChar = { fg = "grey_fg", bold = false },
  },
}

M.ui = {
  cmp = {
    style = "atom_colored",
  },
  statusline = {
    theme = "vscode_colored",
  },
  tabufline = {
    modules = {
      treeOffset = function()
        for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
          if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "NvimTree" then
            local w = vim.api.nvim_win_get_width(win)
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            local icon = vim.fn.nr2char(0xf07b)
            local title = " " .. icon .. " " .. dir_name .. " "
            local padding = w - vim.fn.strwidth(title)
            if padding < 0 then padding = 0 end
            return "%#NvimTreeNormal#" .. title .. string.rep(" ", padding) .. "%#NvimTreeWinSeparator#│"
          end
        end
        return ""
      end,
    },
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
