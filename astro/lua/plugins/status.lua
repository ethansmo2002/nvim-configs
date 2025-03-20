return {
  "nvim-lualine/lualine.nvim",
  requires = { "nvim-tree/nvim-web-devicons", opt = true },

  config = function()
    -- Define the solarized_osaka theme
    local solarized_osaka = {
      normal = {
        a = { fg = "#0e1f28", bg = "#1c6790", gui = "bold" },
        b = { fg = "#a9d5f2", bg = "#1f2335" },
        c = { fg = "#1c6790", bg = "#0e1f28" },
      },
      insert = { a = { fg = "#0e1f28", bg = "#b58900", gui = "bold" } },
      visual = { a = { fg = "#0e1f28", bg = "#c84341", gui = "bold" } },
      replace = { a = { fg = "#0e1f28", bg = "#2aa198", gui = "bold" } },
      command = { a = { fg = "#0e1f28", bg = "#1c6790", gui = "bold" } },
      inactive = {
        a = { fg = "#1c6790", bg = "#1f2335" },
        b = { fg = "#a9d5f2", bg = "#1f2335" },
        c = { fg = "#839496", bg = "#0e1f28" },
      },
    }

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = solarized_osaka, -- Use the custom theme
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { "mode" }, -- Custom icon for mode
        lualine_b = {
          { "branch", icon = "" }, -- Custom icon for branch
          { "diff", icons = { added = " ", modified = "󰬔 ", removed = "" } }, -- Custom diff icons
          { "diagnostics", icons = { error = " ", warn = " ", info = " ", hint = " " } }, -- Diagnostics icons
        },
        lualine_c = { { "filename", icon = " " } }, -- Custom icon for filename
        lualine_x = { { "encoding", icon = "󰱉 " }, { "fileformat", icon = "" }, { "filetype", icon = "" } },
        lualine_y = { { "progress", icon = "" } }, -- Custom icon for progress
        lualine_z = { { "location", icon = "" } }, -- Custom icon for location
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", icon = "" } }, -- Custom icon for inactive filename
        lualine_x = { { "location", icon = "" } }, -- Custom icon for inactive location
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
