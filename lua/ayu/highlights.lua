local pallete = require("ayu.pallete")
local config = require("ayu.config")

local M = {}

local highlight = vim.api.nvim_set_hl

local function load_highlights(highlights)
    for group_name, group_settings in pairs(highlights) do
        if type(group_settings) == "function" then
            group_settings = group_settings()
        end

        highlight(0, group_name, group_settings)
    end
end

local function get_highlight_definitions()
    local style = config.options.style
    local transparent = config.options.transparent
    local p = pallete[style]
    local bg = transparent and p.none or p.bg
    local hl = { langs = {}, plugins = {}, extend = {} }

    hl.predef = {
        Comment = { fg = p.comment },
        Constant = { fg = p.constant },
        String = { fg = p.string },
        Function = { fg = p.func },
        Operator = { fg = p.operator },
        Special = { fg = p.special },
        Keyword = { fg = p.keyword },
        Identifier = { fg = p.constant },
        Tag = { fg = p.tag },
        Markup = { fg = p.markup },
        Guide = { fg = p.guide },
        Builtin = { fg = p.builtin },
    }

    hl.common = {
        Normal = { fg = p.fg, bg = bg },
        ColorColumn = { bg = p.line },

        Cursor = { fg = p.fg, bg = p.cursor },
        CursorColumn = { bg = p.line },
        CursorLine = { bg = p.line },
        CursorLineSign = { bg = p.line },
        CursorLineNr = { fg = p.linenr_cursor, bg = p.line },
        LineNr = { fg = p.guide },

        Directory = { fg = p.fg_idle },
        DiffAdd = { fg = p.diff_add, bg = p.panel },
        DiffChange = { fg = p.diff_change, bg = p.panel },
        DiffDelete = { fg = p.diff_delete, bg = p.panel },
        ErrorMsg = { fg = p.error, bg = bg },
        Folded = { fg = p.fg_idle, bg = p.panel },
        FoldColumn = { bg = p.panel },
        SignColumn = { bg = bg },
        VertSplit = { fg = p.border },
        FloatBorder = { fg = p.border },

        MatchParen = { fg = p.fg, bg = bg },
        ModeMsg = { fg = p.string },
        MoreMsg = { fg = p.string },
        NonText = { fg = p.guide },
        Pmenu = { fg = p.fg, bg = bg },
        PmenuSel = { fg = p.tag, bg = p.line, bold = true },
        PmenuSbar = { fg = p.none, bg = p.border },

        Question = { fg = p.string },
        Search = { bg = p.search },
        CurSearch = { bg = p.search },
        SpecialKey = { fg = p.selection },
        SpellCap = { fg = p.tag },
        SpellLocal = { fg = p.keyword },
        SpellBad = { fg = p.error },
        SpellRare = { fg = p.regexp },
        StatusLine = { fg = p.fg, bg = p.panel },
        StatusLineNC = { fg = p.fg_idle, bg = p.panel },
        WildMenu = { fg = bg, bg = p.markup },
        TabLine = { fg = p.fg, bg = p.panel },

        Title = { fg = p.keyword },
        Visual = { bg = p.selection },

        DiagnosticError = { fg = p.error },
        DiagnosticWarn = { fg = p.warn },
        DiagnosticInfo = { fg = p.info },
        DiagnosticHint = { fg = p.hint },
        DiagnosticVirtualTextError = { fg = p.error },
        DiagnosticVirtualTextWarn = { fg = p.warn },
        DiagnosticVirtualTextInfo = { fg = p.info },
        DiagnosticVirtualTextHint = { fg = p.hint },
        DiagnosticLineError = { bg = p.error_bg },
        DiagnosticLineWarn = { bg = p.warn_bg },
        DiagnosticLineInfo = { bg = p.info_bg },
        DiagnosticLineHint = { bg = p.hint_bg },

        WarningMsg = { fg = p.error },
        EndOfBuffer = { fg = bg },
    }

    hl.syntax = {
        Comment = hl.predef.Comment,
        String = hl.predef.String,

        Constant = hl.predef.Constant,
        -- Character
        -- Number
        -- Boolean
        -- Float

        Identifier = hl.predef.Identifier,
        Function = hl.predef.Function,

        Statement = hl.predef.Keyword,
        -- Conditional
        -- Repeat
        -- Label
        -- Keyword
        -- Exception

        Operator = hl.predef.Operator,

        PreProc = hl.predef.Special,
        Include = hl.predef.Keyword,
        -- Include
        -- Define
        -- Macro
        -- PreCondit

        Type = hl.predef.Tag,
        -- StorageClass
        -- Typedef

        Structure = hl.predef.Special,

        Special = hl.predef.Special,
        -- Delimiter
        -- SpecialComment
        -- Debug

        Underlined = { fg = p.tag, underline = true },

        Ignore = { fg = p.none, bg = p.none },

        Error = { fg = p.error, bg = bg },

        Todo = hl.predef.Markup,

        qfLineNr = hl.predef.Keyword,
        -- qfFileName
        -- qfError

        Conceal = hl.predef.Guide,
        CursorLineConceal = hl.predef.Guide,
    }

    hl.plugins.gitgutter = {
        GitGutterAdd = { fg = p.diff_add },
        GitGutterChange = { fg = p.diff_change },
        GitGutterDelete = { fg = p.diff_delete },
    }
    hl.plugins.vgit = {
        GitSignsAdd = { fg = p.diff_add },
        GitSignsChange = { fg = p.diff_change },
        GitSignsDelete = { fg = p.diff_delete },
        GitSignsAddLn = { bg = p.diff_add_bg },
        GitWordAdd = { bg = p.diff_add_bg_accent },
        GitSignsChangeLn = { bg = p.diff_change_bg },
        GitSignsDeleteLn = { fg = p.fg_normal, bg = p.diff_delete_bg },
        GitWordDelete = { fg = p.fg_normal, bg = p.diff_delete_bg_accent },
        GitHeader = { fg = p.none, bg = p.bg_secondary },
        GitFooter = { fg = p.none, bg = p.bg_secondary },
        GitAppBar = { fg = p.none, bg = p.bg_dimmed },
    }

    hl.plugins.barbar = {
        BufferCurrent = hl.common.Normal,
        BufferCurrentTarget = hl.common.Normal,
        BufferCurrentSign = { fg = bg, bg = bg },
        BufferCurrentMod = { fg = p.yellow, bg = bg },
        BufferVisible = { fg = p.gray, bg = bg },
        BufferVisibleSign = { fg = bg, bg = bg },
        BufferVisibleMod = { fg = p.yellow_dimmed, bg = bg },
        BufferInactive = { fg = p.gray, bg = p.bg_dimmed },
        BufferInactiveSign = { fg = p.bg_dimmed, bg = p.bg_dimmed },
        BufferTabPageFill = { fg = p.bg_dimmed, bg = p.bg_dimmed },
        BufferTabpages = { fg = p.bg2, bg = p.tc, bold = true },
        BufferTabpagesSep = { fg = p.bg2, bg = p.tc, bold = true },
        BufferInactiveMod = { fg = p.yellow_dimmed, bg = p.bg_dimmed },

        BufferCurrentERROR = { fg = p.error, bg = bg },
        BufferCurrentWARN = { fg = p.warn, bg = bg },
        BufferCurrentINFO = { fg = p.info, bg = bg },
        BufferCurrentHINT = { fg = p.hint, bg = bg },
        BufferVisibleERROR = { fg = p.error_dimmed, bg = bg },
        BufferVisibleWARN = { fg = p.warn_dimmed, bg = bg },
        BufferVisibleINFO = { fg = p.info_dimmed, bg = bg },
        BufferVisibleHINT = { fg = p.hint_dimmed, bg = bg },
        BufferInactiveERROR = { fg = p.error_dimmed, bg = p.bg_dimmed },
        BufferInactiveWARN = { fg = p.warn_dimmed, bg = p.bg_dimmed },
        BufferInactiveINFO = { fg = p.info_dimmed, bg = p.bg_dimmed },
        BufferInactiveHINT = { fg = p.hint_dimmed, bg = p.bg_dimmed },
    }

    hl.plugins.lspsaga = {
        SagaLightBulb = { fg = p.warn },
        SagaWinbarWord = { fg = p.guide },
        SagaWinbarSep = { fg = p.guide },
        SagaWinbarFolderName = { fg = p.guide },
        SagaWinbarFileName = { fg = p.guide },
        Winbar = { fg = p.guide },
    }

    hl.plugins.vim_swap = {
        SwapItem = function()
            return style == "dark" and { bg = "#1F3113" } or { bg = "#D6FAC9" }
        end,
        SwapCurrentItem = function()
            return style == "dark" and { bg = "#4F6E13" } or { bg = "#A9FA84" }
        end,
    }

    hl.plugins.nvim_tree = {
        NvimTreeFolderName = { fg = p.fg, bg = bg },
        NvimTreeOpenedFolderName = { fg = p.fg, bg = bg },
        NvimTreeOpenedFolderIcon = { fg = p.opened_folder, bg = bg },
    }

    hl.plugins.neo_tree = {
        NeoTreeDirectoryIcon = { fg = p.folder, bg = bg },
        NeoTreeDirectoryName = { fg = p.fg, bg = bg },
        NeoTreeDotfile = { fg = p.ignore, bg = bg },
        NeoTreeGitUnstaged = { fg = p.gray, bg = bg },
        NeoTreeTabSeparatorInactive = { fg = p.bg_dimmed, bg = p.bg_dimmed },
        NeoTreeTabInactive = { fg = p.gray, bg = p.bg_dimmed },
        NeoTreeIndentMarker = { fg = p.guide, bg = bg },
    }

    hl.plugins.nvim_cmp = {
        CmpItemMenu = { fg = p.guide },
        CmpItemAbbrMatch = { fg = p.keyword },
        CmpItemAbbrMatchFuzzy = { fg = p.keyword },
        CmpItemKindVariable = { fg = p.cyan },
        CmpItemKindInterface = { fg = p.cyan },
        CmpItemKindText = hl.predef.String,
        CmpItemKindFunction = hl.predef.Function,
        CmpItemKindMethod = hl.predef.Function,
        CmpItemKindKeyword = hl.predef.Keyword,
        CmpItemKindEnum = hl.predef.Keyword,
        CmpItemKindProperty = hl.predef.Tag,
        CmpItemKindField = hl.predef.Tag,
        CmpItemKindUnit = hl.predef.Special,
    }

    hl.plugins.treesitter = {
        ["@tag"] = hl.predef.Keyword,
        ["@namespace"] = hl.predef.Special,
        ["@field"] = hl.predef.Tag,
        ["@tag.delimiter"] = hl.predef.Special,
        ["@tag.attribute"] = hl.predef.Tag,
        ["@constructor"] = hl.predef.Function,
    }

    hl.plugins.telescope = {
        TelescopeBorder = { fg = p.border, bg = bg },
        TelescopeTitle = { fg = p.keyword, bg = bg, bold = true },
        TelescopeSelection = { fg = p.none, bg = p.line, bold = true },
        TelescopeMatching = { fg = p.keyword, bg = bg },
        TelescopeSelectionCaret = { fg = p.keyword, bg = p.line, bold = true },
    }

    hl.plugins.noice = {
        NoiceCmdlinePopupBorder = { fg = p.border, bg = bg },
        NoiceCmdlinePopupTitle = { fg = p.tag, bg = bg, bold = true },
        NoiceCmdlinePopupIcon = { fg = p.tag, bg = bg, bold = true },
        NoicePopupMenuSelected = { fg = p.none, bg = p.line, bold = true },
        NoicePopupMenuMatch = { fg = p.keyword, bg = bg },
    }

    hl.plugins.highlighturl = {
        HighlightUrl = { fg = "#A37ACC", underline = true },
    }

    hl.plugins.notify = {
        NotifyERRORBorder = { fg = p.error },
        NotifyWARNBorder = { fg = p.warn },
        NotifyINFOBorder = { fg = p.info },
        NotifyDEBUGBorder = { fg = p.hint },
        NotifyTRACEBorder = { fg = p.hint },
        NotifyERRORIcon = { fg = p.error },
        NotifyWARNIcon = { fg = p.warn },
        NotifyINFOIcon = { fg = p.info },
        NotifyDEBUGIcon = { fg = p.hint },
        NotifyTRACEIcon = { fg = p.hint },
        NotifyERRORTitle = { fg = p.error, bold = true },
        NotifyWARNTitle = { fg = p.warn, bold = true },
        NotifyINFOTitle = { fg = p.info, bold = true },
        NotifyDEBUGTitle = { fg = p.hint, bold = true },
        NotifyTRACETitle = { fg = p.hint, bold = true },
        NotifyERRORBody = { fg = p.error },
        NotifyWARNBody = { fg = p.warn },
        NotifyINFOBody = { fg = p.info },
        NotifyDEBUGBody = { fg = p.hint },
        NotifyTRACEBody = { fg = p.hint },
    }

    hl.plugins.symbols_outline = {
        SymbolsOutlineConnector = { fg = p.guide },
    }

    hl.plugins.lspconfig = {
        LspInfoBorder = { fg = p.border, bg = bg },
    }

    hl.plugins.null_ls = {
        NullLsInfoBorder = { fg = p.border, bg = bg },
    }

    hl.plugins.neocomposer = {
        ComposerNormal = { fg = p.fg, bg = p.bg },
    }

    hl.plugins.marks = {
        MarkSignHL = { fg = p.mark_fg, bg = p.mark, bold = true },
        MarkSignNumHL = { fg = p.mark_fg, bg = p.mark },
    }

    return hl
end

local extended_highlights = {}

function M.extend(highlights)
    if highlights ~= nil then
        for group_name, group_settings in pairs(highlights) do
            extended_highlights[group_name] = group_settings
        end
    end
end

function M.setup()
    local hl = get_highlight_definitions()
    load_highlights(hl.common)
    load_highlights(hl.syntax)
    for _, group in pairs(hl.langs) do
        load_highlights(group)
    end
    for _, group in pairs(hl.plugins) do
        load_highlights(group)
    end
    load_highlights(extended_highlights)
end

return M
