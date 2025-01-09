return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "bashls",
        "clangd",
        "gopls",
        "lua_ls",
        "marksman",
        "spectral",
        "pyright",
        "sqlls",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      -- list of tools for mason to install
      ensure_installed = {
        -- FORMATTERS
        -- "black",
        "ruff",
        "gofumpt",
        "golines",
        "goimports",
        "stylua",
        "prettier",
        "shfmt",
        -- LINTERS
        "codespell",
        -- "flake8",
        "golangci-lint",
        "mypy",
        "luacheck",
        "markdownlint",
        -- "pyproject-flake8",
        "shellcheck",
        "staticcheck",
        "yamllint",
        -- DEBUGGERS
        "delve",
      },
    })
  end,
}
