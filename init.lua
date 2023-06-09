local compass = nil
core.register_globalstep(function(dtime)
	if not compass and core.localplayer then
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
	end
end)
