local wezterm = require("wezterm")

local M = {}

-- Colorscheme
M.colorscheme_preset = "ayu"
-- M.colorscheme_preset = "Catppuccin Mocha"
M.colorscheme_table = wezterm.color.get_builtin_schemes()[M.colorscheme_preset]

return M
