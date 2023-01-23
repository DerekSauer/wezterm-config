local wezterm = require("wezterm")

---Enumerate the user's SSH config file to fill in SSH domains in the launch menu,
---instead of hard coding them into our Wezterm config.
---@return table[] #Returns a list of SSH domain tables.
local function insert_ssh_domain_from_ssh_config()
    local ssh_domains = {}

    for host, config in pairs(wezterm.enumerate_ssh_hosts()) do
        table.insert(ssh_domains, {
            name = host,
            remote_address = config.hostname .. ":" .. config.port,
            username = config.user,
            multiplexing = "None",
            assume_shell = "Posix",
        })
    end

    return ssh_domains
end

return insert_ssh_domain_from_ssh_config()
