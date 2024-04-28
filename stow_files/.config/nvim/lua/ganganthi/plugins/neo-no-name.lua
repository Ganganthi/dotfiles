return {
  "nyngwang/NeoNoName.lua",
  config = function()
    require("neo-no-name").setup({
      before_hooks = {
        function(u)
          if vim.bo.filetype == "fzf" then
            vim.api.nvim_input("a<Esc>")
            u.abort()
          end
        end,
      },
      should_skip = function()
        -- never go next to a terminal buffer.
        return vim.bo.buftype == "terminal"
      end,
      go_next_on_delete = false, -- layout-preserving buffer deletion.
    })
    -- replace the current buffer with the `[No Name]`.
    vim.keymap.set("n", "<M-w>", function()
      vim.cmd("NeoNoName")
    end)
    -- the plain old buffer delete.
    vim.keymap.set("n", "<Leader>bd", function()
      vim.cmd("NeoNoName")
      vim.cmd("bn")
    end)
  end,
}
