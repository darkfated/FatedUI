FatedUI = FatedUI or {}

local FileCl = SERVER and AddCSLuaFile or include

if SERVER then
	resource.AddWorkshop('2878418292')
end

FileCl('fated_ui/config.lua')
FileCl('fated_ui/func.lua')

local files_vgui, _ = file.Find('fated_ui/vgui/*.lua', 'LUA')

for fileID = 1, #files_vgui do
	FileCl('fated_ui/vgui/' .. files_vgui[fileID])
end
