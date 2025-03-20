function generate_toc()
  -- Get all lines in the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local toc = {}

  for _, line in ipairs(lines) do
    -- Match Header 2 lines
    if line:match "^## " then
      -- Extract title from header, ignoring metadata
      local title = line:match("^#+%s*([^|]+)"):gsub("^%s*(.-)%s*$", "%1") -- Trim spaces
      -- Add entry to the ToC with a Markdown link
      table.insert(toc, "- [" .. title .. "](#" .. title:gsub(" ", "-"):lower() .. ")")
    end
  end

  -- Insert ToC at the top of the file
  vim.api.nvim_buf_set_lines(0, 0, 0, false, toc)
end

-- Map the function to a keybinding
vim.api.nvim_set_keymap("n", "<leader>oh", ":lua generate_toc()<CR>", { noremap = true, silent = true })
