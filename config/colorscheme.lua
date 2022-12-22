local wezterm = require("wezterm")

local M = {}

-- Colorscheme
M.colorscheme_preset = "kanagawabones"
M.colorscheme_table = wezterm.color.get_builtin_schemes()[M.colorscheme_preset]

return M
