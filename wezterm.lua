local wezterm = require("wezterm")

-- Use bash on linux and powershell on windows
local powershell_path = "/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe"
local default_term = (wezterm.target_triple == "x86_64-pc-windows-msvc")
		and { os.getenv("LOCALAPPDATA") .. powershell_path, "-NoLogo", "-NoProfile" }
	or { "/usr/bin/bash", "-l" }

-- My preferred font has a different name on Windows and Linux
local default_font = (wezterm.target_triple == "x86_64-pc-windows-msvc") and "JetBrainsMono NF"
	or "Jetbrains Mono Nerd Font"

-- Strips basename from a file path (E.g.: /cat/dog becomes dog)
local function stripbase(path)
	return string.gsub(path, "(.*[/\\])(.*)", "%2")
end

-- Define a number of useful icons
-- Borrowed from: https://github.com/wez/wezterm/discussions/628
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)

local CMD_ICON = utf8.char(0xe62a)
local PS_ICON = utf8.char(0xe70f)
local WSL_ICON = utf8.char(0xf83c)

local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON = utf8.char(0xf9df)

local PYTHON_ICON = utf8.char(0xf820)
local NODE_ICON = utf8.char(0xe74e)
local DENO_ICON = utf8.char(0xe628)

local SUP_IDX = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
	"¹⁰",
	"¹¹",
	"¹²",
	"¹³",
	"¹⁴",
	"¹⁵",
	"¹⁶",
	"¹⁷",
	"¹⁸",
	"¹⁹",
	"²⁰",
}
local SUB_IDX = {
	"₁",
	"₂",
	"₃",
	"₄",
	"₅",
	"₆",
	"₇",
	"₈",
	"₉",
	"₁₀",
	"₁₁",
	"₁₂",
	"₁₃",
	"₁₄",
	"₁₅",
	"₁₆",
	"₁₇",
	"₁₈",
	"₁₉",
	"₂₀",
}

-- Decorate the tab bar with icons based on the running shell/application and its state
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width) end)

return {
	-- Default shell (bash or pwsh depending on OS)
	default_prog = default_term,

	-- Font config
	font = wezterm.font(default_font, {
		weight = "Regular",
	}),
	font_size = 12,
	line_height = 0.9,
	freetype_interpreter_version = 40,
	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",

	-- Window size and theming
	initial_cols = 120,
	initial_rows = 32,
	audible_bell = "Disabled",
	color_scheme = "kanagawabones",
	enable_scroll_bar = false,
	window_background_opacity = 1.0,
	text_background_opacity = 1.0,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Tab bar
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,
	window_frame = {
		font = wezterm.font({
			family = default_font,
			weight = "Regular",
		}),
		font_size = 10,
		active_titlebar_bg = "#1F1F28",
		inactive_titlebar_bg = "#1F1F28",
	},

	-- Visual bell, flare the cursor
	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},

	-- SSH domains
	ssh_domains = {
		-- My 3D printer
		{
			name = "The Prusa - Klipper",
			remote_address = "prusa.local",
			username = "pi",
		},
	},
}
