local s = core.get_mod_storage()
local compass = nil
local function compass_enable()
	compass = core.localplayer:hud_add({
		hud_elem_type = "compass",
		size = {x = 77, y = 77},
		text = "[combine:384x384:0,0=blank.png:128,0=next_icon.png\\^[colorize\\:#F00\\:255]\\^[transformR90]" .. --North
		":0,128=next_icon.png\\^[colorize\\:#FF0\\:255]\\^[transformR180]" .. -- West
		":256,128=next_icon.png\\^[colorize\\:#0F0\\:255]" .. -- East
		":128,256=next_icon.png\\^[colorize\\:#00A\\:255]\\^[transformR270]" .. -- South
		"]^[opacity:128]",
		position = {x = 0.5, y = 0.5},
		alignment = {x = 0, y = 0},
		offset = {x = 0, y = 0},
		direction = 1
	})
	return compass
end

local need_init = true
core.register_globalstep(function(dtime)
	if need_init and not compass and core.localplayer and s:get("compass") then
		compass_enable()
		need_init = nil
	end
end)

core.register_chatcommand("compass",{
	description = "Enable/disable compass",
	func = function(param)
		if compass then
			s:set_string("compass","")
			core.localplayer:hud_remove(compass)
			compass = nil
			return true, "Compass disabled"
		else
			local success = compass_enable()
			if success then
				s:set_string("compass","1")
				return true, "Compass enabled"
			else
				return false, "Error enabling compass"
			end
		end
end})
