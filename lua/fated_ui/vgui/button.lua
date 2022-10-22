local ELEMENT = {}

function ELEMENT:Init()
	self.m_colText = ''
	self.corner1_rounded = false
	self.corner2_rounded = false
	self.corner3_rounded = false
	self.corner4_rounded = false
	self.btn_text = 'Button'
	self.btn_font = 'fu.18'

	self.color = Color( FatedUI.col.button().r, FatedUI.col.button().g, FatedUI.col.button().b )
end

function ELEMENT:Paint( w, h )
	if ( self:IsHovered() ) then
		self.color = Color( Lerp( 7.5 * FrameTime(), self.color.r, FatedUI.col.header().r ), Lerp( 7.5 * FrameTime(), self.color.g, FatedUI.col.header().g ), Lerp( 7.5 * FrameTime(), self.color.b, FatedUI.col.header().b ) )
	else
		self.color = Color( Lerp( 7.5 * FrameTime(), self.color.r, FatedUI.col.button().r ), Lerp( 7.5 * FrameTime(), self.color.g, FatedUI.col.button().g ), Lerp( 7.5 * FrameTime(), self.color.b, FatedUI.col.button().b ) )
	end

	draw.RoundedBoxEx( 8, 0, 0, w, h, FatedUI.col.outline, self.corner1_rounded, self.corner2_rounded, self.corner3_rounded, self.corner4_rounded )
	draw.RoundedBoxEx( 8, 1, 1, w - 2, h - 2, self.color, self.corner1_rounded, self.corner2_rounded, self.corner3_rounded, self.corner4_rounded )
end

function ELEMENT:PaintOver( w, h )
	draw.SimpleText( self.btn_text, self.btn_font, w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

function ELEMENT:Rounded( a1, a2, a3, a4 )
	self.corner1_rounded = a1
	self.corner2_rounded = a2
	self.corner3_rounded = a3
	self.corner4_rounded = a4
end

function ELEMENT:SetText( txt )
	self.btn_text = txt
end

function ELEMENT:SetFont( font )
	self.btn_font = font
end

vgui.Register( 'fu-button', ELEMENT, 'DButton' )
