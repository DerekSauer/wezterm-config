local wezterm = require("wezterm")
local utf8 = require("utf8")

local M = {}

-- Strips basename from a file path (E.g.: /cat/dog becomes dog) and
-- strip the executable extension
local function stripbase(path)
    local new_path = string.gsub(path, "(.*[/\\])(.*)", "%2")
    return new_path:gsub("%.exe$", "")
end

-- Tab separator icons
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

-- Running process icons
local ADMIN_ICON = utf8.char(0xf49c)
local CMD_ICON = utf8.char(0xebc4)
local PS_ICON = utf8.char(0xebc7)
local WSL_ICON = utf8.char(0xebc6)
local HOURGLASS_ICON = utf8.char(0xf252)
local BASH_ICON = utf8.char(0xebca)

function M.setup()
    -- Decorate the tab bar with icons based on the running shell/application and its state
    wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
        local colorscheme_table = require("config.colorscheme").colors

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

        -- Identify tab number with a numeral
        local id = string.format("%s", tab.tab_index + 1)

        -- Trim long titles
        local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 5) .. " "

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
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
            { Attribute = { Intensity = "Normal" } },
        }
    end)
end

return M
