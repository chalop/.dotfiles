-- docs over https://wezfurlong.org/wezterm/config/files.html

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.window_close_confirmation = 'NeverPrompt'

config.font = wezterm.font("MonoLisa Nerd Font", { weight = "Bold" })
config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

local custom_colors = {
    black = "#21222c",
    blue = "#bd93f9",
    cyan = "#8be9fd",
    green = "#50fa7b",
    magenta = "#ff79c6",
    red = "#ff5555",
    yellow = "#f1fa8c",
    white = "#f8f8f2"
}

config.colors = {
    ansi = {
        custom_colors.black, custom_colors.red, custom_colors.green,
        custom_colors.yellow, custom_colors.blue, custom_colors.magenta,
        custom_colors.cyan, custom_colors.white
    }
}
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- and finally, return the configuration to wezterm
return config
