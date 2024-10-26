--[[pod_format="raw",created="2024-10-21 21:26:35",modified="2024-10-25 19:47:01",revision=279]]
function upd_game()
	profile("_update")

	-- SCROLLING
	scroll = scroll + 0.5

	if #cursegs < 1 or scroll - cursegs[#cursegs].o > 0 then
		if boss then
			scroll = scroll - 128
			for seg in all(cursegs) do
				seg.o = seg.o - 128
			end
		else
			mapsegi = mapsegi + 1
		end

		local segnum = mapsegs[mapsegi] or 0

		add(cursegs, {
			x = 0,
			y = 248 - ((segnum - 1) * 8),
			o = #cursegs < 1 and -128 or cursegs[#cursegs].o + 128,
		})

		if scroll - cursegs[1].o >= 384 then
			deli(cursegs, 1)
		end
	end

	-- INPUTS / MOVEMENT
	if btn(0) then
		sprval = (sprval <= 1) and 1 or (sprval - 1)
	end
	if btn(1) then
		sprval = (sprval >= 5) and 5 or (sprval + 1)
	end
--	local dir = butdic[btn() & 0b1111]
--
--	if lastdir ~= dir and dir >= 5 then
--		px = flr(px) -- or flr(px) + 0.5
--		py = flr(py) -- or flr(py) + 0.5
--	end
--
--	local dshipspr = 0
--	banked = 0
--
--	if dir > 0 then
--		px = px + dirx[dir] * spd
--		py = py + diry[dir] * spd
--
--		dshipspr = mysgn(dirx[dir])
--		banked = 1
--	end
--
--	shipspr = shipspr + mysgn(dshipspr - shipspr) * 0.18
--	shipspr = mid(-1, shipspr, 1)
--
--	lastdir = dir

	-- boundary checking
	if px < x_borders then
		px = x_borders
	end
	if px > 480 - x_borders - 15 then
		px = 480 - x_borders - 15 -- 15 is sprite size with an offset
	end

	percentage_scrolled = mid(6 / 32, (px - x_borders - 3) / 201, 26 / 32)
	xscroll = map_range(percentage_scrolled * -32, -26, -6, -40, 0)

	-- shooting
	if shotwait > 0 then
		shotwait = shotwait - 1
	else
		if btn(4) then
			shoot()
		end
	end

	-- dokaaaaaaaaaan!!!
	if btnp(5) then
		explode(40, 135)
	end

	doshots()
	domuzz()
	for p in all(parts) do
		dopart(p)
	end
	profile("_update")
end

function upd_menu()
	-- SCROLLING
	scroll = scroll + 1

	if #menucursegs < 1 or scroll - menucursegs[#menucursegs].o > 0 then
		mapsegi = mapsegi + 1

		local segnum = menusegs[mapsegi % 2]

		add(menucursegs, {
			x = 0,
			y = 248 - ((segnum - 1) * 8),
			o = #menucursegs < 1 and -128 or menucursegs[#menucursegs].o + 128,
		})

		if scroll - menucursegs[1].o >= 384 then
			deli(menucursegs, 1)
		end
	end

	-- INPUTS
	if btnp(5) then
		startgame()
	end
end
