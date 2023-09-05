local colors = {
    foreground = "#dcd7ba",
    background = "#1F1F28",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#363646",

    scrollbar_thumb = "#363646",
    split = "#16161d",

    ansi = {
        "#090618",
        "#c34043",
        "#76946a",
        "#c0a36e",
        "#7e9cd8",
        "#957fb8",
        "#6a9589",
        "#c8c093",
    },
    brights = {
        "#727169",
        "#e82424",
        "#98bb6c",
        "#e6c384",
        "#7fb4ca",
        "#938aa9",
        "#7aa89f",
        "#dcd7ba",
    },
    indexed = {
        [16] = "#ffa066",
        [17] = "#ff5d62",
    },
}

return {
    foreground = colors.foreground,
    background = colors.background,

    cursor_bg = colors.cursor_bg,
    cursor_fg = colors.cursor_fg,
    cursor_border = colors.cursor_border,

    selection_fg = colors.selection_fg,
    selection_bg = colors.selection_bg,

    scrollbar_thumb = colors.scrollbar_thumb,
    split = colors.split,

    ansi = colors.ansi,
    brights = colors.brights,
    indexed = colors.indexed,

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
            intensity = "Bold",
        },
    },
}
