local ELEMENT = {}

function ELEMENT:Init()
	local vbar = self:GetVBar()
	vbar:SetWide( 16 )
	vbar:SetHideButtons( true )
	vbar.Paint = nil
	vbar.btnGrip.Paint = function( s, w, h )
		draw.RoundedBox( 6, 4, 4, w - 8, h - 8, FatedUI.col.header() )
	end
end

function ELEMENT:RemoveBar()
	self:GetVBar():SetWide( 0 )
end

vgui.Register( 'fu-sp', ELEMENT, 'DScrollPanel' )
