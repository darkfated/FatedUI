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
local scrw, scrh = ScrW(), ScrH()

function FatedUI.func.Blur( panel )
	local x, y = panel:LocalToScreen( 0, 0 )

	surface.SetDrawColor( color_white )
	surface.SetMaterial( mat_blur )

	for i = 1, 6 do
		mat_blur:SetFloat( '$blur', i )
		mat_blur:Recompute()

		render.UpdateScreenEffectTexture()

		surface.DrawTexturedRect( -x, -y, scrw, scrh )
	end
end

// Test hud

local convar_hud = CreateClientConVar( 'fated_ui_test_hud', 0, true )

hook.Add( 'HUDPaint', 'FatedUI.test', function()
	if ( !convar_hud:GetBool() ) then
		return
	end

	-- Adaptive color check
	draw.RoundedBox( 6, scrw * 0.5 - 150, 20, 300, 80, FatedUI.col.background() )
	draw.SimpleText( 'It is impossible to live without this text', 'Default', scrw * 0.5, 40, FatedUI.col.text(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	draw.RoundedBoxEx( 6, scrw * 0.5 - 150 + 6, 60, 150 - 6, 40 - 6, FatedUI.col.panel()[ 1 ], false, false, true, false )
	draw.RoundedBoxEx( 6, scrw * 0.5, 60, 150 - 6, 40 - 6, FatedUI.col.panel()[ 2 ], false, false, false, true )
	draw.SimpleText( 'Text on panels', 'Default', scrw * 0.5, 77, FatedUI.col.text(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	-- Adaptive position
	draw.RoundedBox( 6, FatedUI.func.w( 300 ), FatedUI.func.h( 200 ), FatedUI.func.w( 300 ), FatedUI.func.h( 120 ), color_white )
end )

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
	menu:SetTitle( 'Settings' )

	local sp = vgui.Create( 'fu-sp', menu )
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
	menu:SetSize( FatedUI.func.w( 1000 ), FatedUI.func.h( 500 ) )
	menu:Center()
	menu:MakePopup()
	menu:SetTitle( 'Test menu' )

	-- left part

	local main_sp = vgui.Create( 'fu-sp', menu )
	main_sp:SetWide( menu:GetWide() * 0.6 )
	main_sp:Dock( LEFT )

	local btn_test_hud = vgui.Create( 'fu-button', main_sp )
	btn_test_hud:Dock( TOP )
	btn_test_hud:SetTall( FatedUI.func.h( 36 ) )
	btn_test_hud:Rounded( true, true, false, false )
	btn_test_hud:SetText( 'Enable/disable test hud' )
	btn_test_hud.DoClick = function()
		FatedUI.func.Sound()

		if ( convar_hud:GetBool() ) then
			RunConsoleCommand( 'fated_ui_test_hud', 0 )
		else
			RunConsoleCommand( 'fated_ui_test_hud', 1 )
		end
	end

	local split_panel = vgui.Create( 'fu-panel', main_sp )
	split_panel:Dock( TOP )
	split_panel:DockMargin( 0, 6, 0, 6 )
	split_panel:SetTall( 10 )

	local btn_up = vgui.Create( 'fu-button', main_sp )
	btn_up:Dock( TOP )
	btn_up:SetTall( FatedUI.func.h( 40 ) )
	btn_up:Rounded( true, false, true, false )
	btn_up:SetText( "It's over, I have the high ground!" )

	local pan = vgui.Create( 'fu-panel', main_sp )
	pan:Dock( TOP )
	pan:SetTall( FatedUI.func.h( 70 ) )
	pan:DockMargin( 0, 4, 0, 4 )

	local pan_btn = vgui.Create( 'fu-button', pan )
	pan_btn:Dock( RIGHT )
	pan_btn:DockMargin( 6, 6, 6, 6 )
	pan_btn:SetWide( 80 )
	pan_btn:SetText( 'Pan btn' )

	local sp = vgui.Create( 'fu-sp', main_sp )
	sp:Dock( TOP )
	sp:SetTall( FatedUI.func.h( 200 ) )

	for l = 1, 15 do
		local btn_num = vgui.Create( 'fu-button', sp )
		btn_num:Dock( TOP )
		btn_num:SetTall( FatedUI.func.h( 40 ) )
		btn_num:Rounded( true, true, true, true )
		btn_num:SetText( 'button #' .. l )
	end

	for l = 1, 5 do
		local pan_color = vgui.Create( 'fu-panel', sp )
		pan_color:Dock( TOP )
		pan_color:DockMargin( 0, 0, 0, 6 )
		pan_color:SetTall( FatedUI.func.h( 40 ) )

		local pan_inside = vgui.Create( 'fu-panel', pan_color )
		pan_inside:Dock( FILL )
		pan_inside:DockMargin( 8, 8, 8, 8 )
		pan_inside:Color( 2 )
	end

	-- right part
	local right_panel = vgui.Create( 'fu-panel', menu )
	right_panel:Dock( FILL )
	right_panel:DockMargin( 4, 0, 0, 0 )

	local img_panel = vgui.Create( 'fu-panel', right_panel )
	img_panel:SetSize( FatedUI.func.w( 200 ), FatedUI.func.w( 200 ) )
	img_panel:SetPos( FatedUI.func.w( 15 ), FatedUI.func.h( 15 ) )
	
	FatedUI.func.DownloadMat( 'https://i.imgur.com/jsU2HNq.png', 'test_img.png', function( img )
		img_panel.Paint = function( self, w, h )
			surface.SetDrawColor( color_white )
			surface.SetMaterial( img )
			surface.DrawTexturedRect( 0, 0, w, h )
		end
	end )
end )

// Download Material

-- https://github.com/Be1zebub/Small-GLua-Things/blob/master/sh_material_downloader.lua

local file, Material, Fetch, find = file, Material, http.Fetch, string.find
local errorMat = Material( 'error' )
local WebImageCache = {}

function FatedUI.func.DownloadMat( url, path, callback, retry_count )
	if ( WebImageCache[ url ] ) then
		return callback( WebImageCache[ url ])
	end

	local data_path = 'data/' .. path

	if ( file.Exists( path, 'DATA' ) ) then
		WebImageCache[url] = Material( data_path, 'smooth mips' )

		callback( WebImageCache[ url ] )
	else
		Fetch( url, function( img )
			if ( img == nil or find( img, '<!DOCTYPE HTML>', 1, true ) ) then
				return callback( errorMat )
			end
			
			file.Write( path, img )

			WebImageCache[ url ] = Material( data_path, 'smooth mips' )

			callback( WebImageCache[ url ] )
		end, function()
			if ( retry_count and retry_count > 0 ) then
				retry_count = retry_count - 1

				FatedUI.func.DownloadMat( url, path, callback, retry_count )
			else
				callback( errorMat )
			end
		end )
	end
end

// Adaptive interface

FatedUI.save_w = {}
FatedUI.save_h = {}

function FatedUI.func.w( w )
	if ( !FatedUI.save_w[ w ] ) then
		FatedUI.save_w[ w ] = w / 1920 * scrw
	end

	return FatedUI.save_w[ w ]
end

function FatedUI.func.h( h )
	if ( !FatedUI.save_h[ h ] ) then
		FatedUI.save_h[ h ] = h / 1080 * scrh
	end

	return FatedUI.save_h[ h ]
end

// Fonts

for fontSize = 14, 50 do
	surface.CreateFont( 'fu.' .. fontSize, {
		font = 'Roboto Regular',
		size = FatedUI.func.h( fontSize ),
		weight = FatedUI.func.w( 300 ),
		extended = true,
		shadow = false,
		outline = false
	} )
end
