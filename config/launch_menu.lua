local wezterm = require("wezterm")

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    launch_menu = {
        {
            label = "PowerShell Core",
            args = { "pwsh.exe", "-NoLogo" },
            domain = "DefaultDomain",
        },
        {
            label = "Command Prompt",
            args = { "cmd.exe" },
            domain = "DefaultDomain",
        },
    }
else
    launch_menu = {
        { label = "Bash Shell", args = { "/usr/bin/bash" } },
    }
end

return launch_menu
