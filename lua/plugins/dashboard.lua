local status, db = pcall(require, "dashboard")
if not status then
  vim.notify("not found dashboard")
  return
end

db.custom_footer = {
  "",
  "",
  "https://github.com/WhateverMO/Nvim_dotfile",
}

db.custom_center = {
  {
    icon = "  ",
    desc = "Projects                            ",
    action = "Telescope projects",
  },
  {
    icon = "  ",
    desc = "Recently files                      ",
    action = "Telescope oldfiles",
  },
  {
    icon = "  ",
    desc = "Edit keybindings                    ",
    action = "edit ~/.config/nvim/lua/custom-keys.lua",
  },
  {
    icon = "  ",
    desc = "Edit plugins_keybindings            ",
    action = "edit ~/.config/nvim/lua/pluginsKMappings.lua",
  },
  -- {
  --   icon = "  ",
  --   desc = "Edit Projects                       ",
  --   action = "edit ~/.local/share/nvim/project_nvim/project_history",
  -- },
  {
    icon = "  ",
    desc = "Edit .bashrc                        ",
    action = "edit ~/.bashrc",
  },
  {
    icon = "  ",
    desc = "Change colorscheme                  ",
    action = "ChangeColorScheme",
  },
  {
    icon = "  ",
    desc = "Edit init.lua                       ",
    action = "edit ~/.config/nvim/init.lua",
  },
  {
    icon = "  ",
    desc = "Find file                           ",
    action = "Telescope find_files",
  },
  {
    icon = "  ",
    desc = "Find text                           ",
    action = "Telescopecope live_grep",
  },
}
db.custom_header = {
  [[]],
  [[          ▀████▀▄▄              ▄█ ]],
  [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
  [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
  [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
  [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
  [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
  [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
  [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
  [[   █   █  █      ▄▄           ▄▀   ]],
}
