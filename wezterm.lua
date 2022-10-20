local wezterm = require('wezterm')

-- Use bash on linux and powershell on windows
local default_term = {'/usr/bin/bash'}
local default_args = {'-l'}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_term = {'C:/Program Files/WindowsApps/Microsoft.PowerShell_7.2.6.0_x64__8wekyb3d8bbwe/pwsh.exe'}
    default_args = {'-NoLogo', '-NoProfile'}
end

-- My prefered font has a different name on Windows and Linux
local default_font = 'Jetbrains Mono Nerd Font'
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_font = 'JetBrainsMono NF'
end

-- Compact launch args
local launch_args = default_term
for _, value in pairs(default_args) do
    table.insert(launch_args, value)
end

return {
    -- Default shell (bash or pwsh depending on OS)
    default_prog = launch_args,

    -- Font config
    font = wezterm.font(default_font, {
        weight = 'Regular'
    }),
    font_size = 12,
    line_height = 0.9,
    freetype_interpreter_version = 40,
    freetype_load_target = 'Light',
    freetype_render_target = 'HorizontalLcd',

    -- Window size and theming
    initial_cols = 120,
    initial_rows = 32,
    audible_bell = "Disabled",
    color_scheme = 'kanagawabones',
    enable_scroll_bar = false,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    -- Tab bar
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    window_frame = {
        font = wezterm.font {
            family = default_font,
            weight = 'Light'
        },
        font_size = 10,
        active_titlebar_bg = '#1F1F28',
        inactive_titlebar_bg = '#1F1F28'
    }
}
