return {
  "j-morano/buffer_manager.nvim",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>bl",
      "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<CR>",
      { desc = "Buffers List" }
    )
  end,
}
