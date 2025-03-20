return {
  "shastenm76/obsidian.nvim",
  version = "*",
  cmd = { "Obsidian" }, -- Load plugin when :Obsidian is called.
  ft = { "markdown" }, -- Lazy-load for Markdown files.
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- config = function()
  --   require("obsidian").setup {
  --     ui = { enable = false },
  --   }
  -- end,
  opts = {
    dir = "~/Documents/second-brain", -- Vault directory.
    templates = {
      folder = "~/Documents/second-brain/Atlas", -- Templates folder
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
  },
}
