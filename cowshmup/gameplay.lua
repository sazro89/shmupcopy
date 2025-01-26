--[[pod_format="raw",created="2024-10-21 21:26:48",modified="2024-12-16 05:47:04",revision=763]]
function spawnenemy()
	-- play range for these enemies is 143-379 with current coordinate system
	add(enemies, {
		x = 240,
		y = 120,
		ani = anilib[5],
		anis = 6,
--		si = 1,
		sx = 0,
		sy = 0,
		brain = 2,
		age = 0,
		flash = 0,
		hp = 15000,
	})
	
	add(buls, {
		x = 280,
		y = 64,
		sx = 0,
		sy = 0,
		ani = anilib[6],
		anis = 4,
		age = 1,
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
						ani = anilib[6],
						anis = 4,
						age = 1,
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
	end
end

function doshots(arr)
	for s in all(arr) do
		s.age = s.age + 1
		s.x = s.x + s.sx
		s.y = s.y + s.sy

		if s.y < -16 or s.y > 280 then
			del(arr, s)
		end
	end
end

function shoot()
--	slowmo = true
	local shotspd = -12
	shotwait = 2
	add(shots, {
		x = px - 5 + banked - xscroll,
		y = py - 4,
		sx = 0,
		sy = shotspd,
		ani = anilib[3],
		anis = 2,
		age = t % 4 + 1,
	})
	add(shots, {
		x = px + 5 - banked - xscroll,
		y = py - 4,
		sx = 0,
		sy = shotspd,
		ani = anilib[3],
		anis = 2,
		age = t % 4 + 1,
	})
	add(parts,{
		draw = sprite,
		maxage = 4,
		x = -4 + banked,
		y = -1,
		ani = anilib[2],
		age = -1,
		plock = true,
	})
	add(parts,{
		draw = sprite,
		maxage = 4,
		x = 6 - banked,
		y = -1,
		ani = anilib[2],
		age = -1,
		plock = true,
	})
end
