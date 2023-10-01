// Colors

local convar_header = CreateClientConVar('fated_ui_color_header', 'blue', true)
local convar_background = CreateClientConVar('fated_ui_color_background', 'dark', true)

FatedUI.col = {}

-- Header
FatedUI.col.header_table = {
	['blue'] = Color(56,129,193),
	['red'] = Color(205,57,57),
	['green-blue'] = Color(65,176,163),
	['purple'] = Color(127,73,214),
	['orange'] = Color(220,123,67),
	['pink'] = Color(199,75,141),
	['gray'] = Color(155,158,164),
	['green'] = Color(72,174,72),
}
FatedUI.col.header = function()
	local header_color = FatedUI.col.header_table[convar_header:GetString()]

	return header_color and header_color or FatedUI.col.header_table['blue']
end

-- Background
FatedUI.col.background_table = {
	['dark'] = Color(0,0,0,120),
	['light'] = Color(255,255,255,50),
}

FatedUI.col.ValidTheme = {
	'dark',
	'light',
}

FatedUI.col.background = function()
	local con = convar_background:GetString()

	return FatedUI.col.background_table[table.HasValue(FatedUI.col.ValidTheme, con) and con or 'dark']
end

-- Outline
FatedUI.col.outline = Color(0,0,0,140)

-- Panel
FatedUI.col.panel_table = {
	['dark'] = {
		Color(255,255,255,25),
		Color(0,0,0,120),
	},
	['light'] = {
		Color(0,0,0,115),
		Color(255,255,255,30),
	},
}
FatedUI.col.panel = function()
	local con = convar_background:GetString()

	return FatedUI.col.panel_table[table.HasValue(FatedUI.col.ValidTheme, con) and con or 'dark']
end

-- Button
FatedUI.col.button_table = {
	['dark'] = Color(116,116,116),
	['light'] = Color(60,60,60),
}
FatedUI.col.button = function()
	local con = convar_background:GetString()

	return FatedUI.col.button_table[table.HasValue(FatedUI.col.ValidTheme, con) and con or 'dark']
end

-- Text
FatedUI.col.text_table = {
	['dark'] = Color(245,245,245),
	['light'] = Color(23,23,23),
}

FatedUI.col.text = function()
	local con = convar_background:GetString()

	return FatedUI.col.text_table[table.HasValue(FatedUI.col.ValidTheme, con) and con or 'dark']
end
