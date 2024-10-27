--[[pod_format="raw",created="2024-10-21 21:26:48",modified="2024-10-27 03:59:36",revision=268]]
function doshots()
	for s in all(shots) do
		s.x = s.x + s.sx
		s.y = s.y + s.sy
		s.si = s.si + 0.5

		if flr(s.si) > #s.sani then
			s.si = 1
		end
		if s.y < -16 then
			del(shots, s)
		end
	end
end

function shoot()
	local shotspd = -12
	shotwait = 3
	add(shots, {
		x = px - 5 + banked,
		y = py - 4,
		sx = 0,
		sy = shotspd,
		sani = { 6, 7, 8, 7 },
		si = t % 4 + 1,
	})
	add(shots, {
		x = px + 5 - banked,
		y = py - 4,
		sx = 0,
		sy = shotspd,
		sani = { 6, 7, 8, 7 },
		si = t % 4 + 1,
	})
	add(muzz, {
		x = -4 + banked,
		y = -1,
		sani = { 9, 10, 11, 12 },
		si = 0,
	})
	add(muzz, {
		x = 6 - banked,
		y = -1,
		sani = { 9, 10, 11, 12 },
		si = 0,
	})
end
