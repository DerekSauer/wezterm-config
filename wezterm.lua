local wezterm = require("wezterm")

-- Jetbrains Mono Nerd Font has a different name on Windows and other systems.
local jetbrains_nf = wezterm.target_triple == "x86_64-pc-windows-msvc" and "JetBrainsMono NF"
    or "JetbrainsMono Nerd Font"

-- Iosevka Nerd Font has a different name on Windows and other systems.
local iosevka_nf = wezterm.target_triple == "x86_64-pc-windows-msvc" and "Iosevka NF"
    or "Iosevka Nerd Font"

local font_stack = {
    { family = iosevka_nf, weight = "Regular" },
    { family = jetbrains_nf, weight = "Regular" },
    { family = "JetBrains Mono", weight = "Regular" },
    { family = "Symbols Nerd Font Mono", weight = "Regular" },
    { family = "Noto Color Emoji", weight = "Regular", assume_emoji_presentation = true },
}

return {
    -- Font settings
    font = wezterm.font_with_fallback(font_stack),
    font_size = 13.0,
    line_height = 0.9,
    freetype_interpreter_version = 40,
    unicode_version = 14,

    -- This looks best on my low DPI 1080 displays
    freetype_load_target = "Light",
    freetype_render_target = "HorizontalLcd",

    -- Try out the new WebGPU front end
    -- Addendum: It works and performs better than the OpenGL front end but
    -- there is something odd going on with font rendering where light text on
    -- a dark background looks thick (very bold), while dark text on a light
    -- background looks thin. Maybe a gamma issue? Revert to OpenGL for now.
    front_end = "OpenGL",

    -- Default shell (Powershell on Windows $SHELL on other systems)
    default_prog = wezterm.target_triple == "x86_64-pc-windows-msvc" and { "pwsh.exe", "-NoLogo" } or
        { "/bin/bash" },

    -- Launch menu configuration
    launch_menu = require("config.launch_menu"),

    -- SSH
    ssh_domains = require("config.ssh_domains"),

    -- Window size and theming
    colors = require("config.colorscheme"),
    initial_cols = 120,
    initial_rows = 32,
    audible_bell = "Disabled",
    scrollback_lines = 1000,
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
    keys = require("config.keybinds"),

    hyperlink_rules = {
        -- Linkify things that look like URLs
        {
            regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
            format = "$0",
        },
        -- match the URL with a PORT
        -- such 'http://localhost:3000/index.html'
        {
            regex = "\\b\\w+://(?:[\\w.-]+):\\d+\\S*\\b",
            format = "$0",
        },
        -- linkify email addresses
        {
            regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
            format = "mailto:$0",
        },
        -- file:// URI
        {
            regex = "\\bfile://\\S*\\b",
            format = "$0",
        },
    },
}
