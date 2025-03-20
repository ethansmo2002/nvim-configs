return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("solarized-osaka").setup {
      styles = {
        floats = "transparent", -- Keeps floating windows transparent
      },
      on_colors = function(colors)
        -- Modify background colors
        colors.bg = "#0e1f28" -- Custom darker background
        colors.bg_highlight = "#122733" -- Slightly lighter highlight background

        -- Modify text and foreground colors
        colors.fg = "#d3e7f1" -- Lighter foreground text

        -- Customizing specific palette colors
        colors.red500 = "#c84341"
        colors.blue500 = "#1c6790"
        colors.green500 = "#859900"
        colors.yellow500 = "#b58900"
        colors.magenta500 = "#d33682"
        colors.cyan500 = "#2aa198"

        -- Adjusting base tones
        colors.base03 = "#102030"
        colors.base1 = "#a9d5f2"
      end,
    }
    -- Apply the theme
    vim.cmd [[colorscheme solarized-osaka-storm]]
  end,
}
