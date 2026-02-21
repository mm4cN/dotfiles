local wezterm = require('wezterm')

local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window{} -- tab, pane, window
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.default_cursor_style = "BlinkingBlock"
config.color_scheme = 'Tokyo Night'
config.window_decorations = "RESIZE" -- "NONE"
config.window_close_confirmation = 'AlwaysPrompt'

return config
