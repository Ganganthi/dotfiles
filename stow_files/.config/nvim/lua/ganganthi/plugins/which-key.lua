return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,

    -- Document existing key chains
    spec = {
      { "<leader>s", group = "[S]earch" },
      { "<leader>f", group = "[F]ind" },
      -- { "<leader>t", group = "[T]oggle" },
      -- { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
    },
  },
}
