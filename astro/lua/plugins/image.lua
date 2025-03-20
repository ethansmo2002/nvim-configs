-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/image-nvim.lua

-- Uncomment these lines if you're using a local Lua installation managed by luaver
-- package.path = package.path
--   .. ";"
--   .. vim.fn.expand("$HOME")
--   .. "/.luaver/luarocks/3.11.0_5.1/share/lua/5.1/magick/?/init.lua"
-- package.path = package.path
--   .. ";"
--   .. vim.fn.expand("$HOME")
--   .. "/.luaver/luarocks/3.11.0_5.1/share/lua/5.1/magick/?.lua"

-- Uncomment these lines if you're using a local LuaRocks installation
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.4/?/init.lua"
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.4/?.lua"

return {
	-- Use luarocks.nvim for managing Lua dependencies
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- Ensure this runs before anything else
		opts = {
			rocks = { "magick" }, -- Install the magick rock via luarocks.nvim
		},
	},

	-- Configuration for image.nvim plugin
	{
		"3rd/image.nvim",
		dependencies = { "vhyrro/luarocks.nvim" }, -- Ensure luarocks.nvim is loaded first
		config = function()
			require("image").setup({
				backend = "kitty", -- Ensure your terminal supports this backend
				kitty_method = "normal",
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = true,
						filetypes = { "markdown", "vimwiki" },
					},
					neorg = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						filetypes = { "norg" },
					},
					html = {
						enabled = true,
					},
					css = {
						enabled = true,
					},
				},
				max_height_window_percentage = 40,
				window_overlap_clear_enabled = false,
				editor_only_render_when_focused = true,
				tmux_show_only_in_active_window = true,
				hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
			})
		end,
	},
}
