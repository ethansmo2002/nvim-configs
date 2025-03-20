if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "markdown",
      "markdown_inline",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    textobjects = {
      enable = true,
    },
  },
}
