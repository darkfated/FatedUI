local ELEMENT = {}

function ELEMENT:Init()
	self.color_id = 1
end

function ELEMENT:Paint( w, h )
	draw.RoundedBox( 6, 0, 0, w, h, FatedUI.col.panel_table[ GetConVar( 'fated_ui_color_background' ):GetString() ][ self.color_id ] )
end

function ELEMENT:Color( id )
	self.color_id = id
end

vgui.Register( 'fu-panel', ELEMENT, 'DPanel' )
