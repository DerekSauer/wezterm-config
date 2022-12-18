local wezterm = require("wezterm")
local os_name = require("config.get_os_name")
local keybindings = require("config.keybinds")
local launch_menu = require("config.launch_menu")
local colorscheme_preset = require("config.colorscheme").colorscheme_preset
local colorscheme_table = require("config.colorscheme").colorscheme_table

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

    -- Window size and theming
    initial_cols = 120,
    initial_rows = 32,
    audible_bell = "Disabled",
    color_scheme = colorscheme_preset,
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
    colors = {
        tab_bar = {
            background = colorscheme_table.background,
            new_tab = {
                bg_color = colorscheme_table.background,
                fg_color = colorscheme_table.foreground,
                intensity = "Bold",
            },
            new_tab_hover = {
                bg_color = colorscheme_table.background,
                fg_color = colorscheme_table.foreground,
                italic = true,
            },
        },
    },

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
