local color_header_el = Color(30,30,30,210)
local mat_header_close = Material('fated_ui/frame_close.png')
local mat_header_settings = Material('fated_ui/frame_settings.png')
local ELEMENT = {}

function ELEMENT:Init()
	self:DockPadding(6, 46, 6, 6)
	self.title = 'Window'
	self.settings = true

	self.Background = vgui.Create('DPanel', self)
	self.Background.Paint = function(slf, w, h)
		FatedUI.func.Blur(slf)

		draw.RoundedBox(0, 0, 0, w, h, FatedUI.col.background())

		surface.SetDrawColor(FatedUI.col.outline)
		surface.DrawOutlinedRect(0, -1, w, h - 5)
	end

	self.Header = vgui.Create('DPanel', self)
	self.Header.Paint = function(_, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, FatedUI.col.header(), true, true)

		FatedUI.func.ShadowGradient(0, 0, w, h, 1)
	end

	self.Header.Close = vgui.Create('DButton', self.Header)
	self.Header.Close:Dock(RIGHT)
	self.Header.Close:DockMargin(0, 4, 4, 4)
	self.Header.Close:SetWide(32)
	self.Header.Close:SetText('')
	self.Header.Close.DoClick = function()
		FatedUI.func.Sound()

		self:Close()
	end
	self.Header.Close.Paint = function(_, w, h)
		surface.SetMaterial(mat_header_close)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.Header.Settings = vgui.Create('DButton', self.Header)
	self.Header.Settings:Dock(RIGHT)
	self.Header.Settings:DockMargin(0, 4, 4, 4)
	self.Header.Settings:SetWide(32)
	self.Header.Settings:SetText('')
	self.Header.Settings.DoClick = function()
		FatedUI.func.Sound()

		FatedUI.OpenSettings()
	end
	self.Header.Settings.Paint = function(_, w, h)
		surface.SetMaterial(mat_header_settings)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.Title = vgui.Create('DPanel', self)
	self.Title.Paint = function(_, w, h)
		draw.SimpleText(self.title, 'fu.26', self:GetWide() * 0.5, h * 0.5, color_header_el, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if !self.settings then
			if self.Header.Settings:IsVisible() then
				self.Header.Settings:SetVisible(false)
			end
		else
			self.Header.Settings:SetVisible(true)
		end
	end
end

function ELEMENT:Paint(w, h)
end

function ELEMENT:PerformLayout(w, h)
	self.Background:SetSize(w, h - 28)
	self.Background:SetPos(0, 34)

	self.Header:SetSize(w, 40)

	self.Title:SetSize(self:GetWide() - 72, 40)
end

function ELEMENT:Close()
	self:Remove()
end

function ELEMENT:SetTitle(text)
	self.title = text
end

function ELEMENT:SetSettings(bool)
	self.settings = bool
end

vgui.Register('fu-frame', ELEMENT, 'EditablePanel')
