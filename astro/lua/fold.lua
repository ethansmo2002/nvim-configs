-- Function to handle folding for H1 headers
local function custom_markdown_folds(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr, "markdown")
  if not parser then return end

  local tree = parser:parse()[1]
  local root = tree:root()

  local folds = {}
  for node in root:iter_children() do
    if node:type() == "atx_heading" then
      local marker = node:child(0)
      if marker and marker:type() == "atx_h1_marker" then
        local start_row, _, end_row, _ = node:range()
        table.insert(folds, { start_row + 1, end_row })
      end
    end
  end

  -- Apply folds
  for _, fold in ipairs(folds) do
    vim.cmd(string.format("%d,%dfold", fold[1], fold[2]))
  end
end
-- Define toggle_h1_fold as a global function
_G.toggle_h1_fold = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr, "markdown")
  if not parser then
    print "Treesitter parser not found for markdown."
    return
  end

  local tree = parser:parse()[1]
  local root = tree:root()
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1

  for node in root:iter_children() do
    if node:type() == "atx_heading" then
      local marker = node:child(0)
      if marker and marker:type() == "atx_h1_marker" then
        local start_row = node:range()
        if cursor_row == start_row then
          if vim.fn.foldclosed(cursor_row + 1) == -1 then
            vim.cmd(cursor_row + 1 .. "foldclose")
          else
            vim.cmd(cursor_row + 1 .. "foldopen")
          end
          return
        end
      end
    end
  end

  print "No H1 header found under the cursor."
end

-- Keybinding for toggling H1 folds
vim.api.nvim_set_keymap("n", "<leader>zA", ":lua _G.toggle_h1_fold()<CR>", { noremap = true, silent = true })

-- Apply the fold function on Markdown filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.foldmethod = "manual" -- Use manual folding to avoid conflict
    vim.opt_local.foldexpr = "" -- Disable default Treesitter folding

    -- Ensure render-markdown.nvim works seamlessly
    vim.cmd "RenderMarkdown" -- Trigger rendering when opening the file
    custom_markdown_folds() -- Apply custom folding
  end,
})

-- Reapply folds after RenderMarkdownPost
vim.api.nvim_create_autocmd("User", {
  pattern = "RenderMarkdownPost",
  callback = function()
    vim.cmd "silent! normal! zR" -- Reset all folds
    custom_markdown_folds() -- Reapply custom folds
  end,
})

-- Keybinding for toggling H1 folds
-- vim.api.nvim_set_keymap("n", "<leader>zA", ":lua toggle_h1_fold()<CR>", { noremap = true, silent = true })
