-- Spell checking configuration
vim.opt.spell = true
vim.opt.spelllang = { "en", "es" }

-- Utility function to load dictionary
local function load_dictionary(lang)
  local words = {}
  local spellfile = vim.fn.stdpath "config" .. "/spell/" .. lang .. ".utf-8.add"
  local file = io.open(spellfile, "r")
  if file then
    for word in file:lines() do
      table.insert(words, word)
    end
    file:close()
  end
  return words
end

-- Initialize dictionaries
local dictionaries = {
  ["en-US"] = load_dictionary "en",
  ["es-ES"] = load_dictionary "es",
}

-- Track LTeX state
local ltex_enabled = true

-- Function to toggle LTeX server
local function toggle_ltex()
  if ltex_enabled then
    -- Stop the server
    vim.cmd "LspStop ltex"
    ltex_enabled = false
  else
    -- Restart the server
    vim.cmd "LspStart ltex"
    -- Wait a brief moment for the server to start
    vim.defer_fn(function()
      -- Reload the configuration to ensure proper initialization
      vim.cmd "LspRestart ltex"
    end, 100)
    ltex_enabled = true
  end
end

-- Key mappings for spell checking
vim.keymap.set("n", "<leader>zs", function()
  vim.opt.spell = not vim.opt.spell:get()
  toggle_ltex() -- Toggle LTeX server along with spell checking
  vim.defer_fn(function() print("Spellcheck and LTeX " .. (vim.opt.spell:get() and "enabled" or "disabled")) end, 150) -- Delay the message slightly to ensure it appears after server status changes
end, { desc = "Toggle spellcheck" })

vim.keymap.set("n", "<leader>ze", function()
  vim.opt.spelllang = { "en" }
  print "Switched to English spellcheck"
end, { desc = "Switch to English spellcheck" })

vim.keymap.set("n", "<leader>za", function()
  vim.opt.spelllang = { "es" }
  print "Switched to Spanish spellcheck"
end, { desc = "Switch to Spanish spellcheck" })

vim.keymap.set("n", "<leader>zb", function()
  vim.opt.spelllang = { "en", "es" }
  print "Switched to English and Spanish spellcheck"
end, { desc = "Switch to both English and Spanish spellcheck" })

-- Add key mapping for opening spelling suggestions
vim.keymap.set("n", "zj", function() vim.cmd "normal! z=" end, { desc = "Show spelling suggestions" })

-- Mason and LSP configuration
---@type LazySpec
----- Previous spell checking configuration remains the same...

-- Mason and LSP configuration
---@type LazySpec
return {
  -- mason-lspconfig setup
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
      },
    },
  },

  -- LTeX configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"

      -- Configure LTeX
      lspconfig.ltex.setup {
        -- Explicitly specify filetypes to avoid conflicts
        filetypes = { "markdown", "tex", "latex" },
        settings = {
          ltex = {
            enabled = true,
            language = "en-US",
            dictionary = dictionaries,
            additionalRules = {
              enablePickyRules = true,
              motherTongue = "en-US",
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Use vim.bo instead of the deprecated api call
          vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"

          -- Add key mapping for showing diagnostics
          vim.keymap.set("n", "<leader>zR", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics" })
        end,
      }

      -- Configure HTMX LSP
      lspconfig.htmx.setup {
        -- Explicitly specify filetypes for HTMX
        filetypes = { "html", "htm" },
        root_dir = function(fname) return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir() end,
      }

      -- Command to reload spellfiles
      vim.api.nvim_create_user_command("ReloadSpellfiles", function()
        dictionaries["en-US"] = load_dictionary "en"
        dictionaries["es-ES"] = load_dictionary "es"
        vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", {
          settings = {
            ltex = {
              dictionary = dictionaries,
            },
          },
        })
      end, {})
    end,
  },

  -- mason-null-ls setup
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "ltex-ls",
      },
    },
  },

  -- mason-nvim-dap setup
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {
        "python",
      },
    },
  },
}
