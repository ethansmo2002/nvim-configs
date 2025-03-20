-- Enable word wrap and adjust settings for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Enable word wrap
    vim.opt_local.wrap = true
    -- Use break indentation
    vim.opt_local.breakindent = true
    -- Set the character for wrapping long lines
    vim.opt_local.showbreak = ""
    -- Disable text wrapping in the middle of words
    vim.opt_local.linebreak = true
  end,
})
