local wezterm = require("wezterm")

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    return {
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
    return {}
end
