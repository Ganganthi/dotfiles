return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    highlight = {
      enable = true,
    },
    -- enable indentation
    indent = { enable = true },
    -- ensure these language parsers are installed
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "diff",
      "dockerfile",
      "gitignore",
      "go",
      "html",
      "json",
      "java",
      "javascript",
      "jinja",
      "kotlin",
      "latex",
      "lua",
      "markdown",
      "norg",
      "python",
      "regex",
      "scss",
      "smithy",
      "sql",
      "svelte",
      "tmux",
      "toml",
      "tsx",
      "typescript",
      "typst",
      "vim",
      "vue",
      "yaml",
    },
    -- auto install above language parsers
    auto_install = true,
  },
}
