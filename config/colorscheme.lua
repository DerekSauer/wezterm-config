local tundra_colors = {
    foreground = "#D1D5DB",
    background = "#111827",

    cursor_fg = "#111827",
    cursor_bg = "#D1D5DB",
    cursor_border = "#111827",

    selection_fg = "#DDD6FE",
    selection_bg = "#374151",

    scrollbar_thumb = "#6B7280",
    split = "#6B7280",

    ansi = {
        "#6B7280",
        "#FCA5A5",
        "#B1E3AD",
        "#FBC19D",
        "#BAE6FD",
        "#957FB8",
        "#DDD6FE",
        "#A5F3FC",
    },
    brights = {
        "#6B7280",
        "#FCA5A5",
        "#B1E3AD",
        "#FBC19D",
        "#BAE6FD",
        "#938AA9",
        "#DDD6FE",
        "#A5F3FC",
    },
}

local colors = tundra_colors

return {
    foreground = colors.foreground,
    background = colors.background,

    cursor_bg = colors.cursor_bg,
    cursor_fg = colors.cursor_fg,
    cursor_border = colors.cursor_border,

    selection_fg = colors.selection_fg,
    selection_bg = colors.selection_bg,

    scrollbar_thumb = colors.ansi.scrollbar_thumb,
    split = colors.ansi.split,

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
