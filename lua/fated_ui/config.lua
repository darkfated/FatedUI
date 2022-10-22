// Colors

local convar_header = CreateConVar( 'fated_ui_color_header', 'Blue', 1, 'Interface header color' )
local convar_background = CreateConVar( 'fated_ui_color_background', 'Light', 1, 'Interface background color' )

FatedUI.col = {}

-- Header
FatedUI.col.header_table = {
	[ 'Blue' ] = Color(56,129,193),
	[ 'Red' ] = Color(205,57,57),
	[ 'Green-Blue' ] = Color(65,176,163),
	[ 'Purple' ] = Color(127,73,214),
	[ 'Orange' ] = Color(220,123,67),
	[ 'Pink' ] = Color(199,75,141),
	[ 'Gray' ] = Color(155,158,164),
	[ 'Green' ] = Color(72,174,72),
}
FatedUI.col.header = function()
	return FatedUI.col.header_table[ convar_header:GetString() ]
end

-- Background
FatedUI.col.background_table = {
	[ 'Dark' ] = Color(0,0,0,120),
	[ 'Light' ] = Color(255,255,255,50),
}
FatedUI.col.background = function()
	return FatedUI.col.background_table[ convar_background:GetString() ]
end

-- Outline
FatedUI.col.outline = Color(0,0,0,140)

-- Panel
FatedUI.col.panel_table = {
	[ 'Dark' ] = {
		Color(255,255,255,25),
		Color(0,0,0,120),
	},
	[ 'Light' ] = {
		Color(0,0,0,115),
		Color(255,255,255,30),
	},
}
FatedUI.col.panel = function()
	return FatedUI.col.panel_table[ convar_background:GetString() ]
end

-- Button
FatedUI.col.button_table = {
	[ 'Dark' ] = Color(116,116,116),
	[ 'Light' ] = Color(60,60,60),
}
FatedUI.col.button = function()
	return FatedUI.col.button_table[ convar_background:GetString() ]
end
