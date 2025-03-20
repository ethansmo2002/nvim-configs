--- Lua function to expand the tilde (~) to the user's home directory
local function expand_home_directory(path)
  local home = os.getenv "HOME"
  if home then
    return path:gsub("~", home)
  else
    return path
  end
end

-- Define the file paths with the expanded home directory
local todo_file = expand_home_directory "~/Documents/second-brain/Calendar/TODO.md"
local done_file = expand_home_directory "~/Documents/second-brain/Calendar/DONE/DONE.md"

-- Function to check if a line contains a "done" task
local function is_done_task(line)
  return line:match "%[x%]" ~= nil -- Checks for "[x]" which indicates a completed task
end

-- Function to process the TODO file
local function move_done_tasks()
  -- Open the TODO file
  local todo = io.open(todo_file, "r")
  if not todo then
    print("Error: Could not open " .. todo_file)
    return
  end

  -- Open the DONE file in append mode
  local done = io.open(done_file, "a")
  if not done then
    print("Error: Could not open " .. done_file)
    return
  end

  -- Read each line from the TODO file
  local remaining_lines = {}
  for line in todo:lines() do
    if is_done_task(line) then
      -- If the task is completed, move it to the DONE file
      done:write(line .. "\n")
    else
      -- Otherwise, keep the line in the remaining lines list
      table.insert(remaining_lines, line)
    end
  end

  -- Close the TODO and DONE files
  todo:close()
  done:close()

  -- Rewrite the TODO file without completed tasks
  local todo_rewrite = io.open(todo_file, "w")
  if not todo_rewrite then
    print("Error: Could not open " .. todo_file .. " for writing")
    return
  end

  for _, line in ipairs(remaining_lines) do
    todo_rewrite:write(line .. "\n")
  end

  todo_rewrite:close()
  print "Finished moving completed tasks to DONE.md."
end

-- Keybinding for <leader>oz
vim.keymap.set("n", "<leader>oz", move_done_tasks, { desc = "Move completed tasks to DONE.md" })
