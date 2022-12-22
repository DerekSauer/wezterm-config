local wezterm = require("wezterm")
local os_name = require("config.get_os_name")
local keybindings = require("config.keybinds")
local launch_menu = require("config.launch_menu")

-- Use bash on linux and powershell on windows
local default_term = os_name.get_os_name() == "Windows" and { "pwsh.exe" } or { "bash" }

-- My preferred font has a different name on Windows and Linux
local default_font = os_name.get_os_name() == "Windows" and "JetBrainsMono NF" or "JetbrainsMono Nerd Font"

return {
    -- Default shell (bash or pwsh depending on OS)
    default_prog = default_term,

    -- Launch menu configuration
    launch_menu = launch_menu,

    -- SSH
    ssh_domains = require("config.ssh_domains"),

    -- Font config
    font = wezterm.font(default_font, {
        weight = "Regular",
    }),
    font_size = 12,
    line_height = 0.9,
    freetype_interpreter_version = 40,
    freetype_load_flags = "DEFAULT",
    freetype_load_target = "Normal",
    freetype_render_target = "HorizontalLcd",

    -- Window size and theming
    colors = require("config.colorscheme").colors,
    initial_cols = 120,
    initial_rows = 32,
    audible_bell = "Disabled",
    force_reverse_video_cursor = true,
    enable_scroll_bar = false,
    window_background_opacity = 1.0,
    text_background_opacity = 1.0,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    -- Tab bar look
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_max_width = 60,

    -- Tab bar functionality
    require("config.tabs").setup(),

    -- Visual bell, flare the cursor
    visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = "CursorColor",
    },

    -- Keybindings
    disable_default_key_bindings = true,
    keys = keybindings,
}
