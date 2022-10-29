local highlights = require("ayu.highlights")
local terminal = require("ayu.terminal")
local pallete = require("ayu.pallete")
local config = require("ayu.config")

local M = {}

local function validate_style(style)
	local valid_styles = {}
	for key, _ in pairs(pallete) do
		valid_styles[#valid_styles + 1] = key
	end
	for _, v in ipairs(valid_styles) do
		if style == v then
			return true
		end
	end
	return false
end

local function get_invalid_options(opts)
	local invalid_opts = {}
	for opt, _ in pairs(opts) do
		if config.options[opt] == nil then
			invalid_opts[#invalid_opts + 1] = opt
		end
	end
	return invalid_opts
end

function M.setup(opts)
	local invalid_opts = get_invalid_options(opts)
	if #invalid_opts <= 0 then
		if opts.style ~= nil then
			config.options.style = opts.style
		end
		if opts.extend ~= nil then
			highlights.extend(opts.extend)
		end
	else
		local st = "Invalid option(s) for ayu.nvim setup: "
		local n = #invalid_opts
		for i, invalid_opt in ipairs(invalid_opts) do
			st = st .. invalid_opt .. i == n and "." or ", "
		end
        error(st)
	end
end

function M.colorscheme()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	local style = config.options.style
	if not validate_style(style) then
		if style ~= nil then
			print(string.format("Invalid g:ayucolor: %s, defaulting to dark", style))
		end
		style = "dark"
	end

	vim.o.background = style
	vim.o.termguicolors = true
	vim.g.colors_name = "ayu"
	vim.g.ayucolor = style

	highlights.setup()
	terminal.setup()
end

return M
