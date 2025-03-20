-- Obsidian Keybindings

-- Open Telescope in ~/Documents/second-brain folder
vim.keymap.set("n", "<leader>fs", function()
  -- Expand the full path to avoid any path resolution issues
  local second_brain_path = vim.fn.expand "~/Documents/second-brain"

  -- Use Telescope's find_files function to open the second-brain directory
  require("telescope.builtin").find_files {
    prompt_title = "Second Brain Files",
    cwd = second_brain_path,
  }
end, { desc = "Open Telescope in Second Brain folder" })

-- Open Telescope in ~/Documents/second-brain folder
vim.keymap.set("n", "<leader>fw", function()
  -- Expand the full path to avoid any path resolution issues
  local second_brain_path = vim.fn.expand "~/Documents/second-brain"

  -- Use Telescope's grep files function for word searches in second-brain directory.
  require("telescope.builtin").live_grep {
    prompt_title = "Second Brain Files",
    cwd = second_brain_path,
  }
end, { desc = "Live Grep in Second Brain folder" })

vim.keymap.set(
  "n",
  "<leader>ob",
  function() vim.cmd "Neotree reveal ~/Desktop/build/" end,
  { desc = "Choose Build Files" }
)

vim.keymap.set("n", "<leader>oc", function() vim.cmd "ConfigFolders" end, { desc = "Choose Config Files" })

vim.keymap.set(
  "n",
  "<leader>od",
  function() vim.cmd "e /home/cyborg/Documents/second-brain/Calendar/TODO.md" end,
  { desc = "Open TODO file" }
)

vim.keymap.set("n", "<leader>oe", function() vim.cmd "Neotree reveal ~/bin/" end, { desc = "Choose bash scripts" })

vim.keymap.set("n", "<leader>of", function() vim.cmd "Neotree reveal ~/.config" end, { desc = "Choose Config Files" })

vim.keymap.set(
  "n",
  "<leader>oj",
  function() vim.cmd "e /home/cyborg/Documents/second-brain/Calendar/JOURNAL/Journal.md" end,
  { desc = "Open Journal Entry" }
)

vim.keymap.set(
  "n",
  "<leader>ol",
  function() vim.cmd "Neotree reveal ~/.local/bin/scripts/" end,

  { desc = "Choose Local Scripts" }
)

vim.keymap.set(
  "n",
  "<leader>op",
  function() vim.cmd "e /home/cyborg/Documents/second-brain/Calendar/projects.md" end,
  { desc = "Open Projects file" }
)

vim.keymap.set(
  "n",
  "<leader>oq",
  function() vim.cmd "e /home/cyborg/Documents/second-brain/Calendar/DONE/DONE.md" end,
  { desc = "Things That Are DONE." }
)

--vim.keymap.set("n", "<leader>on", function()
--  -- Ensure the Obsidian plugin is loaded before executing the command
--  vim.cmd "Obsidian"
--  vim.cmd "ObsidianNew"
--end, { desc = "Create a new Obsidian note" })

vim.keymap.set("n", "<leader>ot", function()
  -- Ensure the Obsidian plugin is loaded before executing the command
  vim.cmd "Obsidian"
  vim.cmd "ObsidianTags"
end, { desc = "Fuzzy Find Tags" })

vim.keymap.set("n", "<leader>tt", function() vim.cmd "FloatingTerm" end, { desc = "Floating Terminal" })

--KNAP
