--[[pod_format="raw",created="2024-10-21 21:26:28",modified="2024-10-23 20:36:09",revision=189]]

function drw_game()
	for seg in all(cursegs) do
		map(seg.x, seg.y, xscroll + x_borders, scroll - seg.o, 21, 8)
	end
	
	-- draw borders
	rectfill(0, 0, x_borders, 270, 32)
	rectfill(480, 0, 480 - x_borders, 270, 32)
	
	for p in all(parts) do
		if p.wait == nil then
			p.draw(p)
		end
	end
	
	for s in all(shots) do
		spr(s.sani[flr(s.si)], s.x + 6, s.y)
	end

	for m in all(muzz) do
		spr(m.sani[flr(m.si)], px + m.x, py + m.y)
	end
	
	spr(shiparr[flr(shipspr * 2.4 + 3.5)], px, py)

	local fframe = (t % (#flamearr - 1)) + 1

	spr(flamearr[fframe], px + 6 - banked, py + 14, true)
	spr(flamearr[fframe], px + 2 + banked, py + 14)
end