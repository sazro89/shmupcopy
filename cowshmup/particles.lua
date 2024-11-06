--[[pod_format="raw",created="2024-10-21 21:26:56",modified="2024-11-06 05:56:15",revision=349]]
function blob(p)
	local flr_r = flr(p.r)
	local _r = {
		0,
		flr_r * 0.05,
		flr_r * 0.15,
		flr_r * 0.30,
	}

	--	local pat = { -- we can also use dither_mask(value) values instead
	--		0b0000000000000000,
	--		0b0001101001011010,
	--		0b0111111111111111,
	--		0b1111111111111111
	--	}

	local pat = {
		dither_mask(1),
		dither_mask(9 / 16),
		dither_mask(1 / 16),
		dither_mask(0),
	}

	if flr_r <= 5 then
		deli(_r, 4)
		deli(_r, 2)
		deli(pat, 2)
		deli(pat, 2)
	--	elseif flr_r <= 6 then
	--		deli(_r,3)
	--		deli(pat,3)
	elseif flr_r <= 8 then
		deli(_r, 4)
		deli(pat, 3)
		pat[2] = 0b1001001001001001
	elseif flr_r >= 12 then
		--		deli(_r,4)
		--		deli(pat,3)
		--		pat[2]=0b1001001001001001
		_r[2] = flr_r * 0.02
		_r[3] = flr_r * 0.08
		_r[4] = flr_r * 0.12
	end
	--	fillp(dither_mask(3/8))
	--	fillp(0b0001101001011010)
	--	circfill(p.x-2,p.y+2, flr_r, 0x1814) -- adds dark outline
	--	circfill(p.x-1,p.y+1, flr_r, 21) -- adds dark outline
	for i = 1, #_r do
		--		poke(0x550b,0x3f) -- set black to transparent
		--		palt()            -- recommended but what is this doing?
		--		fillp(dither_mask(i/#_r))
		fillp(pat[i])
		circfill(p.x, p.y - _r[i], flr_r - _r[i], p.c)
		--		poke(0x550b,0x00) -- set back to black
	end

	fillp()
	if flr_r == 1 then
		pset(p.x, p.y, p.c)
	elseif flr_r == 2 then
		rectfill(p.x - 1, p.y - 1, p.x + 1, p.y + 1, p.c)
	end
end

function explode(ex, ey)
	add(parts, {
		draw = blob,
		x = ex,
		y = ey,
		r = 17,
		maxage = 2,
		ctab = { 0x0707, 0x070a },
	})

	sparkblast(ex, ey, 2)
	sparkblast(ex, ey, 15)

	grape(ex, ey, 2, 13, 1, "return", { 0x070a, 0x070a, 0x070a, 0x0a09 }, 0)
	grape(ex + rnd(5) - 2.5, ey - 5, 10, 20, 1, "return", { 0x070a, 0x0a09, 0x090a }, -0.2)
	grape(ex + rnd(5) - 2.5, ey - 10, 25, 25, 0.2, "fade", { 0x070a, 0x070a, 0x0a09, 0x090a, 0x0d08, 0x0d05 }, -0.3)
end

function dopart(p)
	-- age and wait
	p.age = p.age or 0

	if p.age == 0 then
		p.ox = p.x
		p.oy = p.y
		p.r = p.r or 1
		p.ctabv = p.ctabv or 0
		p.spd = p.spd or 1
	end
	p.age = p.age + 1

	if p.age <= 0 then
		return
	end

	-- particle logic
	p.age = p.age + 1

	-- movement
	if p.to_x then
		p.x = p.x + ((p.to_x - p.x) / (4 / p.spd))
		p.y = p.y + ((p.to_y - p.y) / (4 / p.spd))
	end

	if p.sx then
		p.x = p.x + p.sx
		p.y = p.y + p.sy
		if p.to_x then
			p.to_x = p.to_x + p.sx
			p.to_y = p.to_y + p.sy
		end
		if p.drag then
			p.sx = p.sx * p.drag
			p.sy = p.sy * p.drag
		end
	end

	-- size
	if p.to_r then
		p.r = p.r + ((p.to_r - p.r) / (5 / p.spd))
	end

	if p.sr then
		p.r = p.r + p.sr
	end

	if p.age >= p.maxage or p.r < 0.5 then
		if p.onend == "return" then
			p.to_x = p.ox
			p.to_y = p.oy
			p.to_r = nil
			p.sr = -0.3
		elseif p.onend == "fade" then
			p.to_r = nil
			p.sr = -0.1 - rnd(0.3)
		else
			del(parts, p)
		end
		p.ctab = nil
		p.onend = nil
		p.maxage = 32000
	end
	-- 2 main ways to logic and animate
	-- sx/sy velocity system.  not great control if you want control over the particles final destination
	-- to_x/to_y destination definition
end

function grape(ex, ey, ewait, emaxage, espd, eonend, ectab, edrift)
	local spokes = 6
	local ang = rnd()
	local step = 1 / spokes
	local shakiness = rnd(3) - 1.5

	-- spawn spokes
	for i = 1, spokes do
		local myang = ang + step * i
		local dist = 8 + shakiness
		local dist2 = dist / 2
		local temp_ox = shakiness + ex + sin(myang) * dist2
		local temp_oy = shakiness + ey + cos(myang) * dist2

		add(parts, {
			draw = blob,
			x = temp_ox,
			y = temp_oy,
			ox = temp_ox,
			oy = temp_oy,
			r = 3,
			to_r = rndrange(3, 7),
			to_x = shakiness + ex + sin(myang) * dist,
			to_y = shakiness + ey + cos(myang) * dist,
			sx = 0,
			sy = edrift,
			spd = espd or 1,
			age = -ewait,
			maxage = emaxage,
			onend = eonend,
			ctab = ectab,
			ctabv = rnd(4),
		})
	end
	-- spawn center
	add(parts, {
		draw = blob,
		x = shakiness + ex,
		y = shakiness + ey - 2,
		r = 3,
		to_r = rndrange(6, 9),
		sx = 0,
		sy = edrift,
		spd = espd or 1,
		age = -ewait,
		maxage = emaxage,
		onend = eonend,
		ctab = ectab,
	})
end

function spark(p)
	-- pset(p.x, p.y, 8)
	line(p.x, p.y, p.x - p.sx * 2, p.y - p.sy * 2, 7)
	line(p.x + 1, p.y, p.x + p.sx * 2 + 1, p.y + p.sy * 2, p.c)
end

function sparkblast(ex, ey, ewait)
	local ang = rnd()
	for i = 1, 6 do
		local ang2 = ang + rnd(0.5)
		local spd = rndrange(4, 8)
		add(parts, {
			draw = spark,
			x = ex,
			y = ey,
			sx = sin(ang2) * spd,
			sy = cos(ang2) * spd,
			drag = 0.8,
			age = -ewait,
			maxage = rndrange(8, 20),
			ctab = { 7, 10 },
		})
	end
end

function domuzz()
	for m in all(muzz) do
		m.si = m.si + 1

		if flr(m.si) > #m.sani then
			del(muzz, m)
		end
	end
end

function dosplash()
	for s in all(splash) do
		s.si = s.si + 1

		if flr(s.si) > #s.sani then
			del(splash, s)
		end
	end
end
