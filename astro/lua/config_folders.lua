local function list_config_folders()
  -- Define the folder to check
  local config_path = vim.fn.expand "~/.config"

  -- Define the folders you want to list
  local folders = {
    "alacritty",
    "berry",
    "bspwm",
    "dwm",
    "ghostty",
    "kitty",
    "nvim",
    "picom",
    "slstatus",
    "spectrwm",
    "st",
    "wezterm",
    "zathura",
    "zellij",
  }

  -- Filter folders that exist in the directory
  local existing_folders = {}
  for _, folder in ipairs(folders) do
    local folder_path = config_path .. "/" .. folder
    if vim.fn.isdirectory(folder_path) == 1 then table.insert(existing_folders, folder) end
  end

  -- If no folders exist, notify the user
  if #existing_folders == 0 then
    vim.notify("No matching folders found in ~/.config", vim.log.levels.WARN)
    return
  end

  -- Prompt the user to select a folder
  vim.ui.select(existing_folders, { prompt = "Select a folder to open with Neo-tree:" }, function(choice)
    if choice then
      -- Open the chosen folder with Neo-tree
      vim.cmd("Neotree reveal " .. config_path .. "/" .. choice)
    end
  end)
end

-- Create a command to trigger the script
vim.api.nvim_create_user_command("ConfigFolders", list_config_folders, {})
