vim.api.nvim_create_user_command("NoteTemplate", function()
  -- Prompt for the new note name
  vim.ui.input({ prompt = "New note name: " }, function(input)
    if input then
      -- Construct the file path for the new note
      local new_note_path = vim.fn.expand("~/Documents/second-brain/" .. input .. ".md")
      -- Check if the file already exists
      if vim.fn.filereadable(new_note_path) == 0 then
        -- Read the template content
        local template_path = vim.fn.expand "~/Documents/second-brain/Atlas/note-template.md"
        local template_content = vim.fn.readfile(template_path)
        -- Write the template content to the new file
        vim.fn.writefile(template_content, new_note_path)
        -- Open the new file
        vim.cmd("e " .. new_note_path)
      else
        vim.notify("File already exists: " .. new_note_path, vim.log.levels.ERROR)
      end
    end
  end)
end, { nargs = 0 })

vim.api.nvim_create_user_command("ScriptTemplate", function()
  -- Prompt for the new script name
  vim.ui.input({ prompt = "New script name: " }, function(input)
    if input then
      -- Construct the file path for the new script
      local new_script_path = vim.fn.expand("~/Documents/second-brain/" .. input .. ".md")
      -- Check if the file already exists
      if vim.fn.filereadable(new_script_path) == 0 then
        -- Read the template content
        local template_path = vim.fn.expand "~/Documents/second-brain/Atlas/script-template.md"
        local template_content = vim.fn.readfile(template_path)
        -- Write the template content to the new file
        vim.fn.writefile(template_content, new_script_path)
        -- Open the new file
        vim.cmd("e " .. new_script_path)
      else
        vim.notify("File already exists: " .. new_script_path, vim.log.levels.ERROR)
      end
    end
  end)
end, { nargs = 0 })

vim.api.nvim_set_keymap(
  "n",
  "<leader>on",
  ":NoteTemplate<CR>",
  { noremap = true, silent = true, desc = "Create a new note with template" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>os",
  ":ScriptTemplate<CR>",
  { noremap = true, silent = true, desc = "Create a new script with template" }
)
