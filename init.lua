local s = core.get_mod_storage()
local compass = nil

local function compass_enable()
	local mode = s:get_int("mode")
	if not mode or (mode ~= 1 and mode ~= 2) then
		mode = 2
	end
	compass = core.localplayer:hud_add({
		hud_elem_type = "compass",
		text = (mode == 1 and "[combine:384x384:0,0=blank.png:128,0=next_icon.png\\^[colorize\\:#F00\\:255]\\^[transformR90]" .. --North
		":0,128=next_icon.png\\^[colorize\\:#FF0\\:255]\\^[transformR180]" .. -- West
		":256,128=next_icon.png\\^[colorize\\:#0F0\\:255]" .. -- East
		":128,256=next_icon.png\\^[colorize\\:#00A\\:255]\\^[transformR270]" .. -- South
		"]^[opacity:128]" or
		"[png:iVBORw0KGgoAAAANSUhEUgAAAeAAAAAICAYAAAAhtCzOAAABaklEQVRoQ+2a2w6DMAxD4f8/enQCSoA2DRI3G/OySatY7EMSSOl/6eimo0/H/F2feA78WUYYRtfhOcAfscdOXDn425psFUVym8MBbhWrnmulKoGxwUf5Rddhu8EZ/Zy8pWIsrhzMxZGDY0nFlq2eeIlYRxM3uo7IGhopM7sSQ3HlwCyOHBxDDbg+gl5G09h2tMfqSWkewyNqTQrzjVQrebe/I2u3umvcElhotnl7qBsZW357lssWBJtuNy/B8zdrm/K4OYIm0+vXXL4+FBxB8wmvFmnwC9prwF6RHgs6boP6egP2GrIaMOCttGnA7n4vcM6uqJgHhzot7j60GkG3np4AL+lPhrwdU3pjy08aBCzaGz0rf4HBmtDFkYNjRIUacMQlsDVqwGDADoRbK87ey1kHTq+lL3BADfgFEC4KYfcSVn0P+KIIdNpbHGiNnm8JQn9yugNecVbhPt3uR07Y3AN+JCr96VkOWL4DYhYcDIN0SqIAAAAASUVORK5CYIIA^[opacity:128"
		),
		position = {x = 0.5, y = (mode == 1 and 0.5 or 0)},
		size = (mode == 1 and {x = 77, y = 77} or {x = 300, y = 16}),
		scale = { x = 1, y = 1},
		alignment = {x = 0, y = (mode == 1 and 0 or 1)},
		offset = {x = 0, y = (mode == 1 and 0 or 4)},
		direction = mode
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

core.register_chatcommand("compass-mode",{
	description = "Change compass mode",
	func = function(param)
		local mode = tonumber(param)
		if not mode or (mode ~= 1 and mode ~= 2) then
			return false, "Invalid usage, avaiable modes are `1` and `2`"
		end
		s:set_int("mode",mode)
		if compass then
			core.localplayer:hud_remove(compass)
			compass_enable()
		end
		return true, "Compass mode is now set to "..param
end})
