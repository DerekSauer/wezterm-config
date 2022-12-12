local wezterm = require("wezterm")

-- Use bash on linux and powershell on windows
local powershell_path = "/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe"
local default_term = (wezterm.target_triple == "x86_64-pc-windows-msvc")
        and { os.getenv("LOCALAPPDATA") .. powershell_path, "-NoLogo", "-NoProfile" }
    or { "/usr/bin/bash", "-l" }

-- My preferred font has a different name on Windows and Linux
local default_font = (wezterm.target_triple == "x86_64-pc-windows-msvc") and "JetBrainsMono NF"
    or "JetbrainsMono Nerd Font"

-- Colorscheme
local colorscheme_preset = "Catppuccin Mocha"
local colorscheme_table = wezterm.color.get_builtin_schemes()[colorscheme_preset]

-- Strips basename from a file path (E.g.: /cat/dog becomes dog)
local function stripbase(path)
    return string.gsub(path, "(.*[/\\])(.*)", "%2")
end

-- Define a number of useful icons
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)
local ADMIN_ICON = utf8.char(0xf49c)
local CMD_ICON = utf8.char(0xebc4)
local PS_ICON = utf8.char(0xebc7)
local WSL_ICON = utf8.char(0xebc6)
local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON = utf8.char(0xf9df)
local BASH_ICON = utf8.char(0xebca)

-- Superset numerals for labelling tabs
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

-- Subset numerals for labelling tabs
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
wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
    local edge_background = colorscheme_table.background
    local background = colorscheme_table.brights[1]
    local foreground = colorscheme_table.ansi[1]
    local dim_foreground = colorscheme_table.background

    if tab.is_active then
        background = colorscheme_table.ansi[4]
        foreground = colorscheme_table.ansi[1]
    elseif hover then
        background = colorscheme_table.brights[4]
        foreground = colorscheme_table.ansi[1]
    end

    local edge_foreground = background
    local process_name = tab.active_pane.foreground_process_name
    local pane_title = tab.active_pane.title
    local exec_name = stripbase(process_name):gsub("%.exe$", "")
    local title_with_icon

    -- Select an appropriate icon
    if exec_name == "pwsh" then
        title_with_icon = PS_ICON .. " PS"
    elseif exec_name == "cmd" then
        title_with_icon = CMD_ICON .. " CMD"
    elseif exec_name == "wsl" or exec_name == "wslhost" then
        title_with_icon = WSL_ICON .. " WSL"
    elseif exec_name == "nvim" then
        title_with_icon = VIM_ICON .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
    elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
        title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
    elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
        title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
    elseif exec_name == "btm" or exec_name == "ntop" then
        title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
    elseif exec_name == "bash" then
        title_with_icon = BASH_ICON .. " BASH"
    else
        title_with_icon = HOURGLASS_ICON .. " " .. exec_name
    end

    if pane_title:match("^Administrator: ") then
        title_with_icon = title_with_icon .. " " .. ADMIN_ICON
    end

    -- If this is the leftmost tab use a solid bar instead of an arrow
    local left_arrow = SOLID_LEFT_ARROW
    if tab.tab_index == 0 then
        left_arrow = SOLID_LEFT_MOST
    end

    -- Identify tab number with a numeral in the lower left corner
    local id = SUB_IDX[tab.tab_index + 1]

    -- Identify pane number with a numeral in the upper right corner
    local pid = SUP_IDX[tab.active_pane.pane_index + 1]

    -- Trim long titles
    local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

    return {
        { Attribute = { Intensity = "Bold" } },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = left_arrow },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = id },
        { Text = title },
        { Foreground = { Color = dim_foreground } },
        { Text = pid },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
        { Attribute = { Intensity = "Normal" } },
    }
end)

return {
    -- Default shell (bash or pwsh depending on OS)
    default_prog = default_term,

    -- Font config
    font = wezterm.font(default_font, {
        weight = "Medium",
    }),
    font_size = 12,
    line_height = 0.9,
    freetype_load_target = "Normal",

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

    -- Tab bar
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

    -- Visual bell, flare the cursor
    visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = "CursorColor",
    },

    disable_default_key_bindings = true,

    keys = {
        -- Typical CTRL-C/V copy paste commands.
        {
            key = "c",
            mods = "CTRL",
            action = wezterm.action.CopyTo("Clipboard"),
        },
        {
            key = "v",
            mods = "CTRL",
            action = wezterm.action.PasteFrom("Clipboard"),
        },

        -- All other terminal commands use ALT as prefix
        -- since it is not used for anything important in Vim
        {
            key = "\\",
            mods = "ALT",
            action = wezterm.action.ShowLauncher,
        },
        {
            key = "PageUp",
            mods = "ALT",
            action = wezterm.action.ScrollByPage(-1),
        },
        {
            key = "PageDown",
            mods = "ALT",
            action = wezterm.action.ScrollByPage(1),
        },
        {
            key = "Enter",
            mods = "ALT",
            action = wezterm.action.ToggleFullScreen,
        },

        -- Tab management
        {
            key = "t",
            mods = "ALT",
            action = wezterm.action.SpawnTab("CurrentPaneDomain"),
        },
        {
            key = "w",
            mods = "ALT",
            action = wezterm.action.CloseCurrentTab({ confirm = true }),
        },
        {
            key = "1",
            mods = "ALT",
            action = wezterm.action.ActivateTab(0),
        },
        {
            key = "2",
            mods = "ALT",
            action = wezterm.action.ActivateTab(1),
        },
        {
            key = "3",
            mods = "ALT",
            action = wezterm.action.ActivateTab(2),
        },
        {
            key = "4",
            mods = "ALT",
            action = wezterm.action.ActivateTab(3),
        },
        {
            key = "5",
            mods = "ALT",
            action = wezterm.action.ActivateTab(4),
        },
        {
            key = "6",
            mods = "ALT",
            action = wezterm.action.ActivateTab(5),
        },
        {
            key = "7",
            mods = "ALT",
            action = wezterm.action.ActivateTab(6),
        },
        {
            key = "8",
            mods = "ALT",
            action = wezterm.action.ActivateTab(7),
        },
        {
            key = "9",
            mods = "ALT",
            action = wezterm.action.ActivateTab(8),
        },
        {
            key = "0",
            mods = "ALT",
            action = wezterm.action.ActivateTab(9),
        },
        {
            key = "-",
            mods = "ALT",
            action = wezterm.action.ActivateTabRelative(-1),
        },
        {
            key = "=",
            mods = "ALT",
            action = wezterm.action.ActivateTabRelative(1),
        },

        -- Pane management
        {
            key = "b",
            mods = "ALT",
            action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "v",
            mods = "ALT",
            action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        {
            key = "q",
            mods = "ALT",
            action = wezterm.action.CloseCurrentPane({ confirm = true }),
        },
        {
            key = "p",
            mods = "ALT",
            action = wezterm.action.PaneSelect({ alphabet = "1234567890" }),
        },
        {
            key = "f",
            mods = "ALT",
            action = wezterm.action.TogglePaneZoomState,
        },

        -- Pane navigation
        {
            key = "LeftArrow",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
            key = "RightArrow",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Right"),
        },
        {
            key = "UpArrow",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
            key = "DownArrow",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Down"),
        },
        {
            key = "h",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
            key = "l",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Right"),
        },
        {
            key = "k",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
            key = "j",
            mods = "ALT",
            action = wezterm.action.ActivatePaneDirection("Down"),
        },

        -- Pane resizing
        {
            key = "LeftArrow",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Left", 2 }),
        },
        {
            key = "RightArrow",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Right", 2 }),
        },
        {
            key = "UpArrow",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
        },
        {
            key = "DownArrow",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
        },
        {
            key = "j",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Left", 2 }),
        },
        {
            key = "l",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Right", 2 }),
        },
        {
            key = "k",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
        },
        {
            key = "j",
            mods = "SHIFT|ALT",
            action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
        },
    },
}
