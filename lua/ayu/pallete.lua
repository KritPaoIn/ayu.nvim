local base = {
    black = "#000000",
    none = "NONE",
}

local semantic = {
    markup = { light = "#F07178", dark = "#F07178" },
    keyword = { light = "#FF7733", dark = "#FF7733" },
    tag = { light = "#36A3D9", dark = "#36A3D9" },
}

local function pick(group, theme)
    local t = {}
    for k, v in pairs(group) do
        t[k] = v[theme]
    end
    return t
end

local function merge(...)
    local out = {}
    for _, tbl in ipairs({ ... }) do
        for k, v in pairs(tbl) do
            out[k] = v
        end
    end
    return out
end

local themes = {
    light = {
        fg = "#5C6773",
        fg_normal = "#6C7680",
        fg_idle = "#828C99",
        bg = "#FAFAFA",
        bg_dimmed = "#EDEDED",
        black = "#000000",
        red = "#F07171",
        green = "#86B300",
        yellow = "#F2AE49",
        yellow_dimmed = "#CC8C49",
        blue = "#399EE6",
        magenta = "#A37ACC",
        cyan = "#4CBF99",
        white = "#D1D1D1",
        gray = "#A6ACB4",
        border = "#BDBDBD",

        tc = "#58C2FF",
        bg1 = "#D3D3D3",
        bg2 = "#F3F3F3",
        fg1 = "#5C6773",
        fg2 = "#828C99",

        error = "#E45454",
        warn = "#FF9330",
        info = "#3A9EE6",
        hint = "#3A9EE6",
        error_dimmed = "#C3797C",
        warn_dimmed = "#C29865",
        hint_dimmed = "#507789",
        info_dimmed = "#507789",
        error_bg = "#EFDDDF",
        warn_bg = "#FCEFE3",
        info_bg = "#C5E4F6",
        hint_bg = "#C5E4F6",

        comment = "#ABB0B6",
        constant = "#A37ACC",
        identifier = "#6C767A",
        number = "#A37ACC",
        boolean = "#A37ACC",
        builtin = "#A37ACC",
        operator = "#E7C547",
        regexp = "#4CBF99",
        string = "#86B300",
        func = "#F29718",
        special = "#E6B673",

        panel = "#FFFFFF",
        line = "#F3F3F3",
        guide = "#A0A6AD",
        linenr_cursor = "#636A75",
        selection = "#F0EEE4",
        search = "#FFF7BB",
        cursor = "#F09D53",
        mark = "#0266D6",
        mark_fg = "#FFFFFF",
        ignore = "#C1C5C8",

        diff_add = "#86B300",
        diff_change = "#399EE6",
        diff_delete = "#F07171",
        diff_add_bg = "#E9EFDC",
        diff_add_bg_accent = "#DBEACA",
        diff_delete_bg = "#FFD2D0",
        diff_delete_bg_accent = "#FFC7C7",

        folder = "#C1C5C8",
        opened_folder = "#FF8F40",
    },

    dark = {
        fg = "#E6E1CF",
        fg_normal = "#B3B1AD",
        fg_idle = "#3E4B59",
        bg = "#0D0F16",
        bg_secondary = "#1B202A",
        bg_dimmed = "#000108",
        black = "#000000",
        red = "#F07178",
        green = "#C2D94C",
        yellow = "#FFB454",
        yellow_dimmed = "#90662F",
        blue = "#59C2FF",
        magenta = "#D2A6FF",
        cyan = "#95E6CB",
        white = "#FFFFFF",
        gray = "Gray",
        border = "#393B41",

        tc = "#37A3D9",
        bg1 = "#14191F",
        bg2 = "#0F141A",
        fg1 = "#E6E1CF",
        fg2 = "#3E4B59",

        error = "#FF6464",
        warn = "#FA973B",
        info = "#58C2FF",
        hint = "#58C2FF",
        error_dimmed = "#702C2F",
        warn_dimmed = "#805422",
        info_dimmed = "#2C5763",
        hint_dimmed = "#2C5763",
        error_bg = "#25171E",
        warn_bg = "#271F1C",
        info_bg = "#051B2B",
        hint_bg = "#051B2B",

        comment = "#5C6773",
        identifier = "#B2B8C3",
        constant = "#FFEE99",
        number = "#D2A6FF",
        boolean = "#D2A6FF",
        builtin = "#D2A6FF",
        operator = "#E7C547",
        regexp = "#95E6CB",
        string = "#B8CC52",
        func = "#FFB454",
        special = "#E6B673",

        panel = "#14191F",
        line = "#131721",
        guide = "#474B56",
        linenr_cursor = "#636A75",
        selection = "#253340",
        search = "#584413",
        cursor = "#F6CD76",
        mark = "#0266D6",
        mark_fg = "#C8C8C8",
        ignore = "#31353D",

        diff_add = "#C2D94C",
        diff_change = "#59C2FF",
        diff_delete = "#F07178",
        diff_add_bg = "#293225",
        diff_add_bg_accent = "#34472C",
        diff_delete_bg = "#3F1418",
        diff_delete_bg_accent = "#551F24",

        folder = "#90A3AE",
        opened_folder = "#FFCC66",
    },
}

local function build(theme_name)
    return merge(base, themes[theme_name], pick(semantic, theme_name))
end

return {
    light = build("light"),
    dark = build("dark"),
}
