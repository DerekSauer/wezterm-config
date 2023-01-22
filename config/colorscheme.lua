local colors = require("wezterm").get_builtin_color_schemes()["kanagawabones"]

return {
    foreground = colors.foreground,
    background = colors.background,

    cursor_bg = colors.cursor_bg,
    cursor_fg = colors.cursor_fg,
    cursor_border = colors.cursor_border,

    selection_fg = colors.selection_fg,
    selection_bg = colors.selection_bg,

    ansi = colors.ansi,
    brights = colors.brights,

    tab_bar = {
        background = colors.background,
        new_tab = {
            bg_color = colors.background,
            fg_color = colors.foreground,
            intensity = "Bold",
        },
        new_tab_hover = {
            bg_color = colors.background,
            fg_color = colors.foreground,
            italic = true,
        },
    },
}
