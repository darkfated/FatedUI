FatedUI.func = {}

// Shadow gradient

local gradient = {
	surface.GetTextureID( 'gui/gradient_up' ), -- 1
	surface.GetTextureID( 'gui/gradient_down' ), -- 2
}
local shadow_color = Color(30,30,30,210)

function FatedUI.func.ShadowGradient( _x, _y, _w, _h, direction )
	draw.TexturedQuad
	{
		texture = gradient[ direction ],
		color = shadow_color,
		x = _x,
		y = _y,
		w = _w,
		h = _h
	}
end

// Sound

function FatedUI.func.Sound( snd )
	surface.PlaySound( snd or 'UI/buttonclickrelease.wav' )
end

// Blur

local color_white = Color(255,255,255)
local mat_blur = Material( 'pp/blurscreen' )

function FatedUI.func.Blur( panel )
	local x, y = panel:LocalToScreen( 0, 0 )

	surface.SetDrawColor( color_white )
	surface.SetMaterial( mat_blur )

	for i = 1, 6 do
		mat_blur:SetFloat( '$blur', i )
		mat_blur:Recompute()

		render.UpdateScreenEffectTexture()

		surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
	end
end

// Fonts

for fontSize = 14, 30 do
	surface.CreateFont( 'fu.' .. fontSize, {
		font = 'Roboto Regular',
		size = fontSize,
		weight = 300,
		extended = true,
		shadow = false,
		outline = false
	} )
end

// Settings Menu

local ConVarsSettings = {
	{ 'Interface header color', 'fated_ui_color_header', mode = 1 },
	{ 'Interface background color', 'fated_ui_color_background', mode = 1 },
}

function FatedUI.OpenSettings()
	local menu = vgui.Create( 'DFrame' )
	menu:SetSize( 200, 300 )
	menu:Center()
	menu:MakePopup()
	menu:SetTitle( 'FatedUI Settings' )

	local sp = vgui.Create( 'DScrollPanel', menu )
	sp:Dock( FILL )

	local function CreateLabelInfo( txt )
		local InfoPanel = vgui.Create( 'DPanel', sp )
		InfoPanel:Dock( TOP )
		InfoPanel:SetTall( 30 )
		InfoPanel.Paint = function( self, w, h )
			draw.SimpleText( txt, 'fu.16', w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end

	CreateLabelInfo( 'Interface header color' )

	local HeaderComboBox = vgui.Create( 'DComboBox', sp )
	HeaderComboBox:Dock( TOP )
	HeaderComboBox:SetValue( GetConVar( 'fated_ui_color_header' ):GetString() )
	HeaderComboBox.OnSelect = function( self, index, value )
		RunConsoleCommand( 'fated_ui_color_header', value )
	end

	for color_name, col in pairs( FatedUI.col.header_table ) do
		HeaderComboBox:AddChoice( color_name )
	end

	CreateLabelInfo( 'Interface background color' )

	local BackgroundComboBox = vgui.Create( 'DComboBox', sp )
	BackgroundComboBox:Dock( TOP )
	BackgroundComboBox:SetValue( GetConVar( 'fated_ui_color_background' ):GetString() )
	BackgroundComboBox.OnSelect = function( self, index, value )
		RunConsoleCommand( 'fated_ui_color_background', value )
	end

	for color_name, col in pairs( FatedUI.col.background_table ) do
		BackgroundComboBox:AddChoice( color_name )
	end
end

// Test menu

concommand.Add( 'fu_test_menu', function()
	local menu = vgui.Create( 'fu-frame' )
	menu:SetSize( 1000, 500 )
	menu:Center()
	menu:MakePopup()
	menu:SetTitle( 'Test menu' )

	local btn_up = vgui.Create( 'fu-button', menu )
	btn_up:Dock( TOP )
	btn_up:SetTall( 40 )
	btn_up:Rounded( true, false, true, false )
	btn_up:SetText( "It's over, I have the high ground!" )

	local pan = vgui.Create( 'fu-panel', menu )
	pan:Dock( TOP )
	pan:SetTall( 70 )
	pan:DockMargin( 0, 4, 0, 4 )

	local pan_btn = vgui.Create( 'fu-button', pan )
	pan_btn:Dock( RIGHT )
	pan_btn:DockMargin( 6, 6, 6, 6 )
	pan_btn:SetWide( 80 )
	pan_btn:SetText( 'Pan btn' )

	local sp = vgui.Create( 'fu-sp', menu )
	sp:Dock( FILL )

	for l = 1, 15 do
		local btn_num = vgui.Create( 'fu-button', sp )
		btn_num:Dock( TOP )
		btn_num:SetTall( 40 )
		btn_num:Rounded( true, true, true, true )
		btn_num:SetText( 'button #' .. l )
	end

	for l = 1, 5 do
		local pan_color = vgui.Create( 'fu-panel', sp )
		pan_color:Dock( TOP )
		pan_color:DockMargin( 0, 0, 0, 6 )
		pan_color:SetTall( 40 )
		pan_color:Color( 1 )

		local pan_inside = vgui.Create( 'fu-panel', pan_color )
		pan_inside:Dock( FILL )
		pan_inside:DockMargin( 8, 8, 8, 8 )
		pan_inside:Color( 2 )
	end
end )
