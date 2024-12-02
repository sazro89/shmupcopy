--[[pod_format="raw",created="2024-10-21 21:26:48",modified="2024-11-30 13:12:15",revision=456]]
function spawnenemy()
	-- add(enemies, {
	-- 	-- play range for these enemies is 143-379 with current coordinate system
	-- 	x = map_range(rnd(), 0, 1, 143, 379),
	-- 	-- x = 379,
	-- 	-- x = 143,
	-- 	y = -16,
	-- 	sani = { 18, 19, 20 },
	-- 	si = 1,
	-- 	sx = 0,
	-- 	sy = 0,
	-- 	brain = 1,
	-- 	age = 0,
	-- })
	add(enemies, {
		x = 240,
		y = 120,
		sani = { 18, 19, 20 },
		si = 1,
		sx = 0,
		sy = 0,
		brain = 2,
		age = 0,
		flash = 0,
		hp = 15,
	})
end

function doenemies()
	for e in all(enemies) do
		if e.brain == 1 then
			if e.age < 12 then
				-- fly down
				e.sy = 1.5
			elseif e.age < 120 then
				if e.age == 60 then
					add(buls, {
						x = e.x,
						y = e.y,
						sx = 0,
						sy = 2,
						sani = { 21, 22 },
						si = 1,
					})
				end
				-- stay
				e.sy = max(0, e.sy - 0.03)
			else
				-- fly up
				e.sy = e.sy - 0.04
				if e.y < -16 then
					del(enemies, e)
				end
			end
		end
		e.age = e.age + 1
		e.x = e.x + e.sx
		e.y = e.y + e.sy
		e.si = e.si + 0.15
		if flr(e.si) > #e.sani then
			e.si = 1
		end
	end
end

function doshots(arr)
	for s in all(arr) do
		s.x = s.x + s.sx
		s.y = s.y + s.sy
		s.si = s.si + 0.5

		if flr(s.si) > #s.sani then
			s.si = 1
		end
		if s.y < -16 or s.y > 280 then
			del(arr, s)
		end
	end
end

function shoot()
	local shotspd = -12
	shotwait = 3
	add(shots, {
		x = px - 5 + banked - xscroll,
		y = py - 4,
		sx = 0,
		sy = shotspd,
		sani = { 6, 7, 8, 7 },
		si = t % 4 + 1,
	})
	add(shots, {
		x = px + 5 - banked - xscroll,
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
