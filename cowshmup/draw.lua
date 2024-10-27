--[[pod_format="raw",created="2024-10-21 21:26:28",modified="2024-10-27 03:59:36",revision=317]]

function drw_game()
	for seg in all(cursegs) do
		map(seg.x, seg.y, xscroll + x_borders, scroll - seg.o, 21, 8)
	end

	-- draw borders
	rectfill(0, 0, x_borders, 270, 32)
	rectfill(480, 0, 480 - x_borders, 270, 32)

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

	for s in all(shots) do
		mspr(s.sani[flr(s.si)], s.x, s.y)
	end

	for m in all(muzz) do
		mspr(m.sani[flr(m.si)], px + m.x, py + m.y)
	end

	--	spr(shiparr[flr(shipspr * 2.4 + 3.5)], px, py)
	mspr(shiparr[flr(shipspr * 2.4 + 3.5)], px, py)
	-- rect(px, py, px + 1, py + 1, 8) -- ship hitbox
	-- pset(px - 4, py + 0, 11) -- muzz alignment
	-- pset(px + 5, py + 0, 11) -- muzz alignment

	local fframe = flr((t % (#flamearr - 1)) + 1)

	mspr(flamearr[fframe], px - 2 + banked, py + 6)
	mspr(flamearr[fframe], px + 3 - banked, py + 6, true)

	debug[1] = "scroll: " .. scroll
	debug[2] = "fframe: " .. (t % (#flamearr - 1)) + 1
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
