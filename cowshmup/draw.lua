--[[pod_format="raw",created="2024-10-21 21:26:28",modified="2024-12-16 05:47:04",revision=802]]

function drw_game()
	cls(0)
	camera(-xscroll, 0)
	for seg in all(cursegs) do
		map(seg.x, seg.y, x_borders, scroll - seg.o, 21, 8)
	end

	for e in all(enemies) do
		if e.flash > 0 then
			e.flash = e.flash - 1
			flash_arr = { 8, 8, 8, 8, 8, 14, 7, 14, 15, 7, 7, 8, 8, 14, 7 }
			for i = 1, #flash_arr do
				pal(i, flash_arr[i])
			end
		end
--		mspr(cyc(e.age,e.ani,e.anis), e.x, e.y)
		drawobj(e)
		pal()
	end
	
	for s in all(shots) do
--		mspr(cyc(s.age, s.ani, s.anis), s.x, s.y)
		drawobj(s)
		if s.delme then
			del(shots,s)
		end
	end

	for p in all(parts) do
		if p.age >= 0 then
			-- animate color
			if p.ctab then
				p.ctabv = p.ctabv or 0
				local life = (p.age + p.ctabv) / p.maxage
				local i = mid(1, flr(1 + life * #p.ctab), #p.ctab)
				p.c = p.ctab[i]
			end
			p.draw(p)
		end
	end
	
	camera(0, 0)
	
	mspr(flr(shipspr * 2.4 + 3.5), px, py)

	local fframe = flr((t % (#anilib[1] - 1)) + 1)

	mspr(anilib[1][fframe], px - 2 + banked, py + 6)
	mspr(anilib[1][fframe], px + 3 - banked, py + 6, true)

	camera(-xscroll, 0)
	
	-- enemy bullets last to favor visibility
	for b in all(buls) do
--		mspr(cyc(b.age, b.ani, b.anis), b.x, b.y)
		drawobj(b)
	end

	-- draw borders
	camera(0, 0)
	rectfill(0, 0, x_borders, 270, 32)
	rectfill(480, 0, 480 - x_borders, 270, 32)

--	debug[1] = "scroll: " .. scroll
--	debug[2] = "fframe: " .. (t % (#anilib[1] - 1)) + 1
--	debug[3] = "enemies: " .. #enemies

	mspr(27,40,135)
end

function mspr(si, sx, sy, flip_x, flip_y)
	local ms = myspr[si]
	-- 1:i, 2:w, 3:h, 4:ox, 5:oy, 6:flip_x 7:flip_y
	sspr(ms[1], 0, 0, ms[2], ms[3], sx - ms[4], sy - ms[5], ms[2], ms[3], ms.flip_x or flip_x, ms.flip_y or flip_y)
	if ms.nextspr then
		mspr(ms.nextspr, sx, sy)
	end
end

function drw_menu()
	for seg in all(menucursegs) do
		map(seg.x, seg.y, x_borders - 20 + (sin(t % 300 / 300) * 20), scroll - seg.o, 21, 8)
	end
	rectfill(0, 0, x_borders, 270, 32)
	rectfill(480, 0, 480 - x_borders, 270, 32)
end
