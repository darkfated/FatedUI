local ELEMENT = {}

function ELEMENT:Init()
	self.m_colText = ''
	self.corner1_rounded = false
	self.corner2_rounded = false
	self.corner3_rounded = false
	self.corner4_rounded = false
	self.btn_text = 'Button'
	self.btn_font = 'fu.18'
	self.standart_color = FatedUI.col.button()
	self.color = self.standart_color
end

local lerp = Lerp

function ELEMENT:Paint(w, h)
	local fr = FrameTime()

	if self:IsHovered() then
		self.color = Color(lerp(7.5 * fr, self.color.r, FatedUI.col.header().r), lerp(7.5 * fr, self.color.g, FatedUI.col.header().g), lerp(7.5 * fr, self.color.b, FatedUI.col.header().b))
	else
		self.color = Color(lerp(7.5 * fr, self.color.r, self.standart_color.r), lerp(7.5 * fr, self.color.g, self.standart_color.g), lerp(7.5 * fr, self.color.b, self.standart_color.b))
	end

	draw.RoundedBoxEx(8, 0, 0, w, h, FatedUI.col.outline, self.corner1_rounded, self.corner2_rounded, self.corner3_rounded, self.corner4_rounded)
	draw.RoundedBoxEx(8, 1, 1, w - 2, h - 2, self.color, self.corner1_rounded, self.corner2_rounded, self.corner3_rounded, self.corner4_rounded)
end

function ELEMENT:PaintOver(w, h)
	draw.SimpleText(self.btn_text, self.btn_font, w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function ELEMENT:Rounded(a1, a2, a3, a4)
	self.corner1_rounded = a1
	self.corner2_rounded = a2
	self.corner3_rounded = a3
	self.corner4_rounded = a4
end

function ELEMENT:SetText(txt)
	self.btn_text = txt
end

function ELEMENT:SetFont(font)
	self.btn_font = font
end

function ELEMENT:SetColor(col)
	self.standart_color = col
end

vgui.Register('fu-button', ELEMENT, 'DButton')
