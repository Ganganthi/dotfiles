return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-tree/nvim-web-devicons",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      -- cond = function()
      --   return vim.fn.executable 'make' == 1
      -- end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          }
        }
      }
    })

    -- telescope.load_extension("fzf")

    -- keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {desc = "[F]ind [F]iles"})
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", {desc = "[F]ind [G]it Files"})
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {desc = "[F]ind [R]ecent Files"})
    keymap.set('n', "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind existing [B]uffers"})
    keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", {desc = "[S]earch [G]rep"})
    keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", {desc = "[S]earch [W]ord Under Cursor"})

  end
}
