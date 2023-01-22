local wezterm = require("wezterm")

-- Jetbrains Mono Nerd Font has a different name on Windows and other systems.
local jetbrains_nf = wezterm.target_triple == "x86_64-pc-windows-msvc" and "JetBrainsMono NF"
    or "JetbrainsMono Nerd Font"

-- Wezterm already has Jetbrains Mono and a Symbols font built-in but the symbols font
-- glyphs are oversized and end up sitting below the text baseline when scaled to appropriate size.
-- We'll use the Jetbrains Mono Nerd Font who's symbols mostly fit well and fallback to
-- the built-ins when the Nerd Font is unavailable
local font_stack = {
    { family = jetbrains_nf, weight = "Regular" },
    { family = "JetBrains Mono", weight = "Regular" },
    { family = "Symbols Nerd Font Mono", weight = "Regular" },
    { family = "Noto Color Emoji", weight = "Regular", assume_emoji_presentation = true }
}

-- Use Wezterm's terminfo if available
local function get_terminfo()
    local term_file = io.open("~/.terminfo/w/wezterm", "r")

    if term_file ~= nil then
        io.close(term_file)
        return "wezterm"
    else
        return "xterm-256color"
    end
end

return {
    font = wezterm.font_with_fallback(font_stack),
    font_size = 12.0,
    line_height = 0.9,

    -- Try out the new WebGPU front end
    front_end = "WebGpu",

    -- Default shell (Powershell on Windows $SHELL on other systems)
    default_prog = wezterm.target_triple == "x86_64-pc-windows-msvc" and { "pwsh.exe", "-NoLogo" },

    -- Launch menu configuration
    launch_menu = require("config.launch_menu"),

    -- SSH
    ssh_domains = require("config.ssh_domains"),

    -- Window size and theming
    term = get_terminfo(),
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
}
