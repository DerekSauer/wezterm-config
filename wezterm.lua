local wezterm = require("wezterm")

-- Use bash on linux and powershell on windows
local default_term = wezterm.target_triple == "x86_64-pc-windows-msvc" and { "pwsh.exe", "-NoLogo" } or { "bash" }

-- My preferred font has a different name on Windows and Linux
local default_font_name = wezterm.target_triple == "x86_64-pc-windows-msvc" and "JetBrainsMono NF"
    or "JetbrainsMono Nerd Font"

-- Customize font size per device
local default_font_size = 12.0
if wezterm.hostname() == "Monolith" then
    default_font_size = 11.0
elseif wezterm.hostname() == "thinktop" then
    default_font_size = 13
elseif wezterm.hostname() == "CNC-PROG" then
    default_font_size = 11.75
end

-- Customize font weight per device
local default_font_weight = "Regular"
if wezterm.hostname() == "Monolith" then
    default_font_weight = "Regular"
elseif wezterm.hostname() == "thinktop" then
    default_font_weight = "Medium"
elseif wezterm.hostname() == "CNC-PROG" then
    default_font_weight = "Regular"
end

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
    -- Default shell (bash or pwsh depending on OS)
    default_prog = default_term,

    -- Launch menu configuration
    launch_menu = require("config.launch_menu"),

    -- SSH
    ssh_domains = require("config.ssh_domains"),

    -- Font config
    font = wezterm.font(default_font_name, {
        weight = default_font_weight,
    }),
    font_size = default_font_size,
    line_height = 0.9,

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
