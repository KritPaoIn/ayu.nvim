local pallete = require("ayu.pallete")
local config = require("ayu.config")

local function get_style()
    local style = config.options.style or vim.g.ayucolor or vim.o.background
    if pallete[style] ~= nil then
        return style
    end
    return "dark"
end

local p = pallete[get_style()]

local function hl(fg, bg, bold)
    return {
        fg = fg,
        bg = bg,
        gui = bold and "bold" or nil,
    }
end

local M = {
    inactive = {
        a = hl(p.gray, p.bg2, true),
        b = hl(p.gray, p.bg2),
        c = hl(p.gray, p.bg2),
        x = hl(p.gray, p.bg2),
        y = hl(p.gray, p.bg2),
        z = hl(p.gray, p.bg2),
    },

    normal = {
        a = hl(p.bg, p.blue, true),
        b = hl(p.fg, p.bg1),
        c = hl(p.fg, p.bg2),
        x = hl(p.fg, p.bg2),
        y = hl(p.fg, p.bg1),
        z = hl(p.bg, p.blue),
    },

    insert = {
        a = hl(p.bg, p.green, true),
        b = hl(p.fg, p.bg1),
        c = hl(p.fg, p.bg2),
        x = hl(p.fg, p.bg2),
        y = hl(p.fg, p.bg1),
        z = hl(p.bg, p.green),
    },

    visual = {
        a = hl(p.bg, p.number, true),
        b = hl(p.fg, p.bg1),
        c = hl(p.fg, p.bg2),
        x = hl(p.fg, p.bg2),
        y = hl(p.fg, p.bg1),
        z = hl(p.bg, p.number),
    },

    replace = {
        a = hl(p.bg, p.red, true),
        b = hl(p.fg, p.bg1),
        c = hl(p.fg, p.bg2),
        x = hl(p.fg, p.bg2),
        y = hl(p.fg, p.bg1),
        z = hl(p.bg, p.red),
    },

    command = {
        a = hl(p.bg, p.warn, true),
        b = hl(p.fg, p.bg1),
        c = hl(p.fg, p.bg2),
        x = hl(p.fg, p.bg2),
        y = hl(p.fg, p.bg1),
        z = hl(p.bg, p.warn),
    },
}

return M
