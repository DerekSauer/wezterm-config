local wezterm = require("wezterm")

return {
    -- Typical CTRL-C/V copy paste commands.
    -- Can press CTRL-SHIFT-C to send SIGTERM
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
}
