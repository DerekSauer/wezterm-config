local get_os_name = require("config.get_os_name")

local launch_menu = {}

if get_os_name.get_os_name() == "Windows" then
    launch_menu = {
        {
            label = "PowerShell Core",
            args = { "pwsh.exe", "-NoLogo" },
            domain = "DefaultDomain",
        },
        {
            label = "Command Prompt",
            args = { "cmd.exe" },
        },
    }
else
    launch_menu = {
        { label = "bash", args = { "/usr/bin/bash" } },
    }
end

return launch_menu
