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
      "lua",
      "markdown",
      "python",
      "smithy",
      "sql",
      "tmux",
      "toml",
      "typescript",
      "vim",
      "yaml",
    },
    -- auto install above language parsers
    auto_install = true,
  },
}
