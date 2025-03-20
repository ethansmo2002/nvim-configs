return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<leader>sz", function() require("snacks").zen() end, desc = "Toggle Zen Mode" },
    { "<leader>sZ", function() require("snacks").zen.zoom() end, desc = "Toggle Zoom" },
    { "<leader>sn", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
    { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dashboard = {
      enabled = true,
      row = 5,
      sections = { -- Remove the nested 'sections'
        {
          pane = 1,
          icon = "",
          title = "",
          section = "terminal",
          gap = 0,
          cmd = "/bin/sh ~/.local/bin/ColorScripts/alpha",
        },

        { section = "keys" },
        {
          pane = 2,
          icon = "󰡦 ",
          title = "Recent Files",
          section = "recent_files",
          limit = 3,
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = "󰱾 ",
          title = "Projects",
          section = "projects",
          limit = 3,
          indent = 4,
          padding = 1,
        },
        {
          pane = 2,
          icon = "󰠮 ",
          title = "TODO List",
          section = "terminal",
          gap = 0,
          cmd = "sed -n '7,19p' ~/Documents/second-brain/Calendar/TODO.md",
        },
      },
      preset = {
        keys = {
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua require('snacks').dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = " ",
            key = "d",
            desc = "Open TODO list",
            action = function() vim.cmd "edit ~/Documents/second-brain/Calendar/TODO.md" end,
          },
          {
            icon = "󰜏 ",
            key = "f",
            desc = "Find File",
            action = ":lua require('snacks').dashboard.pick('files')",
          },
          {
            icon = "󰱽 ",
            key = "g",
            desc = "Find Text",
            action = ":lua require('snacks').dashboard.pick('live_grep')",
          },

          {
            icon = "󰵆 ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = "󰱾 ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "󱋑 ", key = "q", desc = "Quit", action = ":qa" },
          {
            icon = "󰡦 ",
            key = "r",
            desc = "Recent Files",
            action = ":lua require('snacks').dashboard.pick('oldfiles')",
          },
          { icon = "⭘ ", key = "s", desc = "Restore Session", section = "session" },
        },
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    vim.defer_fn(function() vim.cmd "redraw" end, 120000)
  end,
}
