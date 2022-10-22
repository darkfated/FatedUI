FatedUI = FatedUI or {}

local FileCl = SERVER and AddCSLuaFile or include

resource.AddWorkshop( '2878418292' )

FileCl( 'fated_ui/config.lua' )
FileCl( 'fated_ui/func.lua' )

local files_vgui, _ = file.Find( 'fated_ui/vgui/*.lua', 'LUA' )

for k, f in ipairs( files_vgui ) do
	FileCl( 'fated_ui/vgui/' .. f )
end
