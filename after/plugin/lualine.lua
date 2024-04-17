local function shorten_git_branch(branch)
	local slash_position = string.find(branch, "/")
	if slash_position then
		local after_slash = string.sub(branch, slash_position + 1)
		local hyphen_position = string.find(after_slash, "-")
		if hyphen_position then
			local second_hyphen_position = string.find(after_slash, "-", hyphen_position + 1)
			if second_hyphen_position then
				local ticket_number = string.sub(after_slash, 1, second_hyphen_position - 1)
				local before_slash = string.sub(branch, 1, slash_position - 1)
				return before_slash .. "/" .. ticket_number
			end
		end
	end
	return branch
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
		theme = "catppuccin",
	},
	sections = {
		lualine_b = {
			{
				"branch",
				icon = "",
				fmt = function(branch)
					return shorten_git_branch(branch)
				end,
			},
			{
				"diff",
			},
			{
				"diagnostics",
			},
		},
	},
})
