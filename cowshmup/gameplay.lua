--[[pod_format="raw",created="2024-10-21 21:26:48",modified="2024-10-23 20:36:09",revision=177]]
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
		x = px - 6,
		y = py,
		sx = 0,
		sy = shotspd,
		sani = { 24, 25, 26, 25 },
		si = t % 4 + 1,
	})
	add(shots, {
		x = px + 2,
		y = py,
		sx = 0,
		sy = shotspd,
		sani = { 24, 25, 26, 25 },
		si = t % 4 + 1,
	})
	add(muzz, {
		x = -4,
		y = -8,
		sani = { 27, 28, 29, 30 },
		si = 0,
	})
	add(muzz, {
		x = 4,
		y = -8,
		sani = { 27, 28, 29, 30 },
		si = 0,
	})
end