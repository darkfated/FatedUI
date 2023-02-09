local ELEMENT = {}
local color_white = Color(255,255,255)
local color_black = Color(0,0,0)

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
	self.active_hover_color = true
	self.hover_color = FatedUI.col.header()
end

local lerp = Lerp

function ELEMENT:Paint(w, h)
	if self.active_hover_color then
		local fr = FrameTime()

		if self:IsHovered() then
			self.color = Color(lerp(7.5 * fr, self.color.r, self.hover_color.r), lerp(7.5 * fr, self.color.g, self.hover_color.g), lerp(7.5 * fr, self.color.b, self.hover_color.b))
		else
			self.color = Color(lerp(7.5 * fr, self.color.r, self.standart_color.r), lerp(7.5 * fr, self.color.g, self.standart_color.g), lerp(7.5 * fr, self.color.b, self.standart_color.b))
		end
	else
		self.color = self.standart_color
	end

	draw.RoundedBoxEx(8, 0, 0, w, h, FatedUI.col.outline, self.corner1_rounded, self.corner2_rounded, self.corner3_rounded, self.corner4_rounded)
	draw.RoundedBoxEx(8, 1, 1, w - 2, h - 2, self.color, self.corner1_rounded, self.corner2_rounded, self.corner3_rounded, self.corner4_rounded)
end

function ELEMENT:PaintOver(w, h)
	draw.SimpleText(self.btn_text, self.btn_font, w * 0.5, h * 0.5 - 1, self:IsHovered() and color_black or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

function ELEMENT:HoverColor(bool)
	self.active_hover_color = bool
end

function ELEMENT:SetHoverColor(col)
	self.hover_color = col
end

vgui.Register('fu-button', ELEMENT, 'DButton')
