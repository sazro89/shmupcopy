--[[pod_format="raw",created="2024-10-21 21:26:28",modified="2024-11-06 05:56:15",revision=404]]

function drw_game()
	cls(0)
	camera(-xscroll, 0)
	for seg in all(cursegs) do
		map(seg.x, seg.y, x_borders, scroll - seg.o, 21, 8)
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

	for e in all(enemies) do
		if e.flash > 0 then
			e.flash = e.flash - 1
			flash_arr = { 8, 8, 8, 8, 8, 14, 7, 14, 15, 7, 7, 8, 8, 14, 7 }
			for i = 1, #flash_arr do
				pal(i, flash_arr[i])
			end
		end
		mspr(e.sani[flr(e.si)], e.x, e.y)
		-- rect(e.x - 7, e.y - 7, e.x + 8, e.y + 8, e.iscol and 8 or 7)
		pal()
	end

	for s in all(shots) do
		mspr(s.sani[flr(s.si)], s.x, s.y)
	end

	for s in all(splash) do
		mspr(s.sani[flr(s.si)], s.x, s.y)
	end

	camera(0, 0)
	for m in all(muzz) do
		mspr(m.sani[flr(m.si)], px + m.x, py + m.y)
	end

	--	spr(shiparr[flr(shipspr * 2.4 + 3.5)], px, py)
	mspr(shiparr[flr(shipspr * 2.4 + 3.5)], px, py)

	-- rect(px - 7, py - 7, px + 8, py + 8, pcol and 8 or 7)

	local fframe = flr((t % (#flamearr - 1)) + 1)

	mspr(flamearr[fframe], px - 2 + banked, py + 6)
	mspr(flamearr[fframe], px + 3 - banked, py + 6, true)

	camera(-xscroll, 0)
	-- enemy bullets last to favor visibility
	for b in all(buls) do
		mspr(b.sani[flr(b.si)], b.x, b.y)
	end

	-- draw borders
	camera(0, 0)
	rectfill(0, 0, x_borders, 270, 32)
	rectfill(480, 0, 480 - x_borders, 270, 32)
	debug[1] = "scroll: " .. scroll
	debug[2] = "fframe: " .. (t % (#flamearr - 1)) + 1
	debug[3] = "enemies: " .. #enemies
end

function mspr(si, sx, sy, flip_x, flip_y)
	local ms = myspr[si]
	sspr(ms.i, 0, 0, ms.w, ms.h, sx - ms.ox, sy - ms.oy, ms.w, ms.h, ms.flip_x or flip_x, ms.flip_y or flip_y)
	if ms.nextspr then
		mspr(ms.nextspr, sx, sy)
	end
end

function drw_menu()
	for seg in all(menucursegs) do
		map(seg.x, seg.y, x_borders - 20 + (sin(t % 300 / 300) * 20), scroll - seg.o, 21, 8)
		--map(seg.x, seg.y, x_borders - 20, scroll - seg.o, 21, 8)
	end
	rectfill(0, 0, x_borders, 270, 32)
	rectfill(480, 0, 480 - x_borders, 270, 32)
end
