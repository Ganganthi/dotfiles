return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        python = { "ruff_format" },
        lua = { "stylua" },
        sh = { "shfmt" },
        yaml = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
	lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      },
    })

  end,
}
