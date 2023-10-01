local ELEMENT = {}

function ELEMENT:Init()
	self.color_id = 1
	self.rad = 6
end

function ELEMENT:Paint(w, h)
	local con = GetConVar( 'fated_ui_color_background'):GetString()
	
	draw.RoundedBox(self.rad, 0, 0, w, h, FatedUI.col.panel_table[table.HasValue(FatedUI.col.ValidTheme, con) and con or 'dark'][self.color_id])
end

function ELEMENT:Color(id)
	self.color_id = id
end

function ELEMENT:Radius(rad)
	self.rad = rad
end

vgui.Register('fu-panel', ELEMENT, 'DPanel')
