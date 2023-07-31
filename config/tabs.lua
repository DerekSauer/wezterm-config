local wezterm = require("wezterm")
local symbols = require("wezterm").nerdfonts
local colorscheme_table = require("config.colorscheme")

local M = {}

-- Strips basename from a file path (E.g.: /cat/dog becomes dog) and
-- strip the executable extension
local function stripbase(path)
    local new_path = string.gsub(path, "(.*[/\\])(.*)", "%2")
    return new_path:gsub("%.exe$", "")
end

-- Tab separator icons
local SOLID_LEFT_ARROW = symbols.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = symbols.ple_lower_left_triangle

-- Running process icons
local CMD_ICON = symbols.cod_terminal_cmd
local PS_ICON = symbols.cod_terminal_powershell
local BASH_ICON = symbols.cod_terminal_bash
local WSL_ICON = symbols.cod_terminal_linux
local HOURGLASS_ICON = symbols.fa_hourglass_half
local NVIM_ICON = symbols.custom_vim

-- Default colors
local BACKGROUND_COLOR = colorscheme_table.brights[1]
local FOREGROUND_COLOR = colorscheme_table.ansi[1]
local EDGE_COLOR = colorscheme_table.background
local DIM_COLOR = colorscheme_table.background

function M.setup()
    -- Decorate the tab bar with icons based on the running shell/application and its state
    wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
        if tab.is_active then
            BACKGROUND_COLOR = colorscheme_table.ansi[4]
            FOREGROUND_COLOR = colorscheme_table.ansi[1]
        elseif hover then
            BACKGROUND_COLOR = colorscheme_table.brights[4]
            FOREGROUND_COLOR = colorscheme_table.ansi[1]
        else
            BACKGROUND_COLOR = colorscheme_table.split
            FOREGROUND_COLOR = colorscheme_table.foreground
        end

        local edge_foreground = BACKGROUND_COLOR
        local process_name = tab.active_pane.foreground_process_name
        local exec_name = stripbase(process_name)
        local title_with_icon = ""

        -- Select an appropriate icon
        if exec_name == "pwsh" then
            title_with_icon = PS_ICON .. " PS"
        elseif exec_name == "cmd" then
            title_with_icon = CMD_ICON .. " CMD"
        elseif exec_name == "wsl" or exec_name == "wslhost" then
            title_with_icon = WSL_ICON .. " WSL"
        elseif exec_name == "bash" then
            title_with_icon = BASH_ICON .. " BASH"
        elseif exec_name == "nvim" then
            title_with_icon = NVIM_ICON .. " NVIM"
        else
            title_with_icon = HOURGLASS_ICON .. " " .. exec_name
        end

        -- Identify tab number with a numeral
        local id = string.format("%s", tab.tab_index + 1)

        -- Trim long titles
        local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 5) .. " "

        return {
            { Attribute = { Intensity = "Bold" } },
            { Background = { Color = EDGE_COLOR } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            { Background = { Color = BACKGROUND_COLOR } },
            { Foreground = { Color = FOREGROUND_COLOR } },
            { Text = id },
            { Text = title },
            { Foreground = { Color = DIM_COLOR } },
            { Background = { Color = EDGE_COLOR } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
            { Attribute = { Intensity = "Normal" } },
        }
    end)
end

return M
