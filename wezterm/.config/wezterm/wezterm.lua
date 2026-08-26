local wezterm = require('wezterm')

local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window{} -- tab, pane, window
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()
config.front_end = "OpenGL"
config.max_fps = 120
config.term = "xterm-256color"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.default_cursor_style = "BlinkingBlock"
config.color_scheme = 'Tokyo Night'
config.window_decorations = "RESIZE"
config.window_close_confirmation = 'AlwaysPrompt'

return config
