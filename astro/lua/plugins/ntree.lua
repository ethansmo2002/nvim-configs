return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "craftzdog/solarized-osaka.nvim",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings or {}
        -- Update mappings
        maps.n = maps.n or {}
        maps.n["<leader>e"] = { "<cmd>Neotree toggle float<cr>", desc = "Toggle Explorer (float)" }
        maps.n["<leader>o"] = false -- Disable original mapping

        -- Update autocommands
        opts.autocmds = opts.autocmds or {}
        opts.autocmds.neotree_start = {
          {
            event = "BufEnter",
            desc = "Open Neo-Tree on startup with directory",
            callback = function()
              if package.loaded["neo-tree"] then return true end

              local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
              if stats and stats.type == "directory" then
                require("neo-tree").setup()
                vim.cmd "Neotree float"
                return true
              end
            end,
          },
        }

        return opts
      end,
    },
  },
  cmd = "Neotree",
  config = function()
    local colors = require("solarized-osaka.colors").setup()

    -- Calculate window dimensions
    local ui = vim.api.nvim_list_uis()[1]
    local width = math.floor(ui.width * 0.8)
    local height = math.floor(ui.height * 0.8)
    local col = math.floor((ui.width - width) / 2)
    local row = math.floor((ui.height - height) / 2)

    require("neo-tree").setup {
      close_if_last_window = true,
      enable_diagnostics = true,
      enable_git_status = true,
      popup_border_style = "rounded",

      window = {
        position = "float",
        width = width,
        height = height,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },

      floating_window = {
        open_win_config = {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          border = "rounded",
          style = "minimal",
        },
      },

      default_component_configs = {
        indent = {
          with_markers = true,
          with_expanders = true,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = true,
        hijack_netrw_behavior = "open_floating",
      },

      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd [[
              setlocal winhighlight=Normal:NeoTreeNormal,NormalNC:NeoTreeNormalNC
              setlocal fillchars=eob:\ 
            ]]
          end,
        },
      },

      -- Integrate solarized-osaka colors
      highlights = {
        NeoTreeNormal = { fg = colors.base2, bg = colors.base03 },
        NeoTreeNormalNC = { fg = colors.base1, bg = colors.base03 },
        NeoTreeIndentMarker = { fg = colors.base1 },
        NeoTreeRootName = { fg = colors.blue, bold = true },
        NeoTreeFileName = { fg = colors.base2 },
        NeoTreeFileIcon = { fg = colors.blue },
        NeoTreeDirectoryName = { fg = colors.cyan },
        NeoTreeDirectoryIcon = { fg = colors.blue },
        NeoTreeGitUnstaged = { fg = colors.yellow },
        NeoTreeGitModified = { fg = colors.blue },
        NeoTreeGitUntracked = { fg = colors.green },
        NeoTreeGitStaged = { fg = colors.green },
        NeoTreeGitDeleted = { fg = colors.red },
        NeoTreeFloatBorder = { fg = colors.base1, bg = colors.base03 },
        NeoTreeFloatTitle = { fg = colors.blue, bg = colors.base03 },
      },
    }
  end,
}
