// Colors

local convar_header = CreateConVar( 'fated_ui_color_header', 'blue', 1, 1 )
local convar_background = CreateConVar( 'fated_ui_color_background', 'light', 1, 1 )

FatedUI.col = {}

-- Header
FatedUI.col.header_table = {
	[ 'blue' ] = Color(56,129,193),
	[ 'ted' ] = Color(205,57,57),
	[ 'green-blue' ] = Color(65,176,163),
	[ 'purple' ] = Color(127,73,214),
	[ 'orange' ] = Color(220,123,67),
	[ 'pink' ] = Color(199,75,141),
	[ 'gray' ] = Color(155,158,164),
	[ 'green' ] = Color(72,174,72),
}
FatedUI.col.header = function()
	return FatedUI.col.header_table[ convar_header:GetString() ]
end

-- Background
FatedUI.col.background_table = {
	[ 'dark' ] = Color(0,0,0,120),
	[ 'light' ] = Color(255,255,255,50),
}
FatedUI.col.background = function()
	return FatedUI.col.background_table[ convar_background:GetString() ]
end

-- Outline
FatedUI.col.outline = Color(0,0,0,140)

-- Panel
FatedUI.col.panel_table = {
	[ 'dark' ] = {
		Color(255,255,255,25),
		Color(0,0,0,120),
	},
	[ 'light' ] = {
		Color(0,0,0,115),
		Color(255,255,255,30),
	},
}
FatedUI.col.panel = function()
	return FatedUI.col.panel_table[ convar_background:GetString() ]
end

-- Button
FatedUI.col.button_table = {
	[ 'dark' ] = Color(116,116,116),
	[ 'light' ] = Color(60,60,60),
}
FatedUI.col.button = function()
	return FatedUI.col.button_table[ convar_background:GetString() ]
end
