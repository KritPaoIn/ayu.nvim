local highlights = require("ayu.highlights")
local terminal = require("ayu.terminal")
local pallete = require("ayu.pallete")

local M = {}

local function validate_mode(mode)
	local valid_modes = {}
	for key, _ in pairs(pallete) do
		valid_modes[#valid_modes + 1] = key
	end
	for _, v in ipairs(valid_modes) do
		if mode == v then
			return true
		end
	end
	return false
end

local function get_invalid_options(opts)
	local invalid_opts = {}
	for opt, _ in pairs(opts) do
		if M.options[opt] == nil then
			invalid_opts[#invalid_opts + 1] = opt
		end
	end
	return invalid_opts
end

M.options = {
	mode = "dark", -- "dark" | "light"
	extend = {
		-- ExampleHighlight = { fg = "#FFFFFF", bg = "#000000" },
		-- ExampleFunctionHighlight = function() return { fg = "#FFFFFF", bg = "#000000" } end,
	},
}

function M.setup(opts)
	local invalid_opts = get_invalid_options(opts)
	if #invalid_opts <= 0 then
		if opts.mode ~= nil then
			M.options.mode = opts.mode
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
	end
end

function M.colorscheme()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	local mode = M.options.mode
	if not validate_mode(mode) then
		if mode ~= nil then
			print(string.format("Invalid g:ayucolor: %s, defaulting to dark", mode))
		end
		mode = "dark"
	end

	vim.o.background = mode
	vim.o.termguicolors = true
	vim.g.colors_name = "ayu"

	highlights.setup(mode)
	terminal.setup(mode)
end

return M
