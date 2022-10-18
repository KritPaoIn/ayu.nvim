local pallete = require("ayu.pallete")

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

local function get_highlight_definitions(mode)
	local p = pallete[mode]
	local hl = { langs = {}, plugins = {}, extend = {} }

	hl.predef = {
		Comment = { fg = p.comment },
		Constant = { fg = p.constant },
		String = { fg = p.string },
		Function = { fg = p.func },
		Operator = { fg = p.operator },
		Special = { fg = p.special },
		Keyword = { fg = p.keyword },
		Tag = { fg = p.tag },
		Markup = { fg = p.markup },
		Guide = { fg = p.guide },
	}

	hl.common = {
		Normal = { fg = p.fg, bg = p.bg },
		ColorColumn = { bg = p.line },

		CursorColumn = { bg = p.line },
		CursorLine = { bg = p.line },
		CursorLineNr = { fg = p.accent, bg = p.line },
		LineNr = { fg = p.guide },

		Directory = { fg = p.fg_idle },
		DiffAdd = { fg = p.diff_add, bg = p.panel },
		DiffChange = { fg = p.diff_change, bg = p.panel },
		DiffDelete = { fg = p.diff_delete, bg = p.panel },
		ErrorMsg = { fg = p.fg, bg = p.error },
		Folded = { fg = p.fg_idle, bg = p.panel },
		FoldColumn = { bg = p.panel },
		SignColumn = { bg = p.panel },
		VertSplit = { fg = p.border },
        FloatBorder = { fg = p.border },

		MatchParen = { fg = p.fg, bg = p.bg },
		ModeMsg = { fg = p.string },
		MoreMsg = { fg = p.string },
		NonText = { fg = p.guide },
		Pmenu = { fg = p.fg, bg = p.bg },
		PmenuSel = { fg = p.fg, bg = p.bg },

		Question = { fg = p.string },
		Search = { fg = p.bg, bg = p.constant },
		SpecialKey = { fg = p.selection },
		SpellCap = { fg = p.tag },
		SpellLocal = { fg = p.keyword },
		SpellBad = { fg = p.error },
		SpellRare = { fg = p.regexp },
		StatusLine = { fg = p.fg, bg = p.panel },
		StatusLineNC = { fg = p.fg_idle, bg = p.panel },
		WildMenu = { fg = p.bg, bg = p.markup },
		TabLine = { fg = p.fg, bg = p.panel },

		Title = { fg = p.keyword },
		Visual = { bg = p.selection },

		WarningMsg = { fg = p.error },
		EndOfBuffer = { fg = p.bg },
	}

	hl.syntax = {
		Comment = hl.predef.Comment,
		String = hl.predef.String,

		Constant = hl.predef.Constant,
		-- Character
		-- Number
		-- Boolean
		-- Float

		Identifier = hl.predef.Tag,
		Function = hl.predef.Function,

		Statement = hl.predef.Keyword,
		-- Conditional
		-- Repeat
		-- Label
		-- Keyword
		-- Exception

		Operator = hl.predef.Operator,

		PreProc = hl.predef.Special,
		-- Include
		-- Define
		-- Macro
		-- PreCondit

		Type = hl.predef.Tag,
		-- StorageClass
		-- Typedef

		Structure = hl.predef.special,

		Special = hl.predef.special,
		-- SpecialChar
		-- Tag
		-- Delimiter
		-- SpecialComment
		-- Debug

		Underlined = { fg = p.tag, underline = true },

		Ignore = { fg = p.none, bg = p.none },

		Error = { fg = p.fg, bg = p.error },

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

	hl.plugins.barbar = {
		BufferCurrent = hl.common.Normal,
		BufferCurrentTarget = hl.common.Normal,
		BufferCurrentSign = hl.common.Normal,
		BufferCurrentMod = { fg = p.yellow, bg = p.bg },
		BufferVisible = { fg = p.gray, bg = p.bg },
		BufferInactive = { fg = p.gray, bg = p.bg_dimmed },
		BufferInactiveSign = { fg = p.bg_dimmed, bg = p.bg_dimmed },
		BufferTabPageFill = { fg = p.bg_dimmed, bg = p.bg_dimmed },
		BufferVisibleSign = { fg = p.bg, bg = p.bg },
		BufferVisibleMod = { fg = p.yellow_dimmed, bg = p.bg },
		BufferInactiveMod = { fg = p.yellow_dimmed, bg = p.bg_dimmed },
	}

	hl.plugins.lspsaga = {
		LspSagaDiagnosticBorder = hl.common.Normal,
		LspSagaCodeActionBorder = hl.common.Normal,
		LspSagaFloatWinBorder = hl.common.Normal,
		LspSagaRenameBorder = hl.common.Normal,
		LspSagaSignatureHelpBorder = hl.common.Normal,
		LspSagaDiagBorder = hl.common.Normal,
		LspSagaDefPreviewBorder = hl.common.Normal,
		LspSagaDiagnosticTruncateLine = hl.common.Normal,
		LspSagaCodeActionTruncateLine = hl.common.Normal,
		LspSagaFloatWinTruncateLine = hl.common.Normal,
		LspSagaRenameTruncateLine = hl.common.Normal,
		LspSagaSignatureHelpTruncateLine = hl.common.Normal,
		LspSagaDiagTruncateLine = hl.common.Normal,
		LspSagaDefPreviewTruncateLine = hl.common.Normal,
	}

	hl.plugins.vim_swap = {
		SwapItem = hl.common.Visual,
		SwapCurrentItem = hl.common.Search,
	}

	hl.plugins.nvim_tree = {
		NvimTreeFolderName = hl.common.Normal,
		NvimTreeOpenedFolderName = hl.common.Normal,
	}

	hl.plugins.treesitter = {}

	return hl
end

function M.extend(highlights)
    load_highlights(highlights)
end

function M.setup(mode)
	local hl = get_highlight_definitions(mode)
    load_highlights(hl.predef)
    load_highlights(hl.common)
    load_highlights(hl.syntax)
    for _, group in pairs(hl.langs) do
        load_highlights(group)
    end
    for _, group in pairs(hl.plugins) do
        load_highlights(group)
    end
end

return M
