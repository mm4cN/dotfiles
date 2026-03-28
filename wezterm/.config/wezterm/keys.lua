local wezterm = require("wezterm")
local act = wezterm.action

return function(config)
  config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

  config.keys = {
    { key = "c",          mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

    { key = '"',          mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "%",          mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

    { key = "h",          mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "j",          mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "k",          mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "l",          mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },

    { key = "LeftArrow",  mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "UpArrow",    mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow",  mods = "LEADER", action = act.ActivatePaneDirection("Down") },

    { key = "v",          mods = "LEADER", action = act.ActivateCopyMode },
    { key = "y",          mods = "LEADER", action = act.CopyTo("Clipboard") },

    { key = "1",          mods = "LEADER", action = act.ActivateTab(0) },
    { key = "2",          mods = "LEADER", action = act.ActivateTab(1) },
    { key = "3",          mods = "LEADER", action = act.ActivateTab(2) },
    { key = "4",          mods = "LEADER", action = act.ActivateTab(3) },
    { key = "5",          mods = "LEADER", action = act.ActivateTab(4) },
    { key = "6",          mods = "LEADER", action = act.ActivateTab(5) },
    { key = "7",          mods = "LEADER", action = act.ActivateTab(6) },
    { key = "8",          mods = "LEADER", action = act.ActivateTab(7) },
    { key = "9",          mods = "LEADER", action = act.ActivateTab(8) },
  }
end
