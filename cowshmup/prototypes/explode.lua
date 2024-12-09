--[[pod_format="raw",created="2024-10-07 01:29:38",modified="2024-10-21 21:56:01",revision=635]]
function explode(ex, ey)
	add(parts, {
		draw = blob,
		x = ex,
		y = ey,
		r = 17,
		maxage = 2,
		c = 0x0707,
		ctab = { 0x0707, 0x070a },
	})

	sparkblast(ex, ey, 2)
	sparkblast(ex, ey, 15)

	grape(ex, ey, 2, 13, 1, "return", { 0x070a, 0x070a, 0x070a, 0x0a09 }, 0)
	grape(rndrange(ex - 2, ex + 2), ey - 5, 10, 20, 1, "return", { 0x070a, 0x0a09, 0x090a }, -0.2)
	grape(
		rndrange(ex - 3, ex + 3),
		ey - 10,
		25,
		25,
		0.2,
		"fade",
		{ 0x070a, 0x070a, 0x0a09, 0x090a, 0x0d08, 0x0d05 },
		-0.3
	)
end

function dopart(p)
	-- [ ] age function
	-- [ ] max age counter

	if p.wait then
		-- wait countdown
		p.wait = p.wait - 1
		if p.wait <= 0 then
			p.wait = nil
			if p.c == nil and p.ctab then
				p.c = p.ctab[1]
			end
		end
	else
		-- particle logic
		p.age = p.age or 0
		if p.age == 0 then
			p.ox = p.x
			p.oy = p.y
			p.r = p.r or 1
			p.ctabv = p.ctabv or 0
		end

		p.age = p.age + 1
		-- animate color
		if p.ctab then
			local life = (p.age + p.ctabv) / p.maxage
			local i = mid(1, flr(1 + life * #p.ctab), #p.ctab)
			p.c = p.ctab[i]
		end

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
			p.r = p.r((p.to_r - p.r) / (5 / p.spd))
		end

		if p.sr then
			p.r = p.r + p.sr
		end

		if p.age >= p.maxage or p.r < 0.5 then
			if p.onend == "return" then
				p.maxage = p.maxage + 32000
				p.to_x = p.ox
				p.to_y = p.oy
				p.to_r = nil
				p.sr = -0.3
			elseif p.onend == "fade" then
				p.maxage = p.maxage + 32000
				p.to_r = nil
				p.sr = -0.1 - rnd(0.3)
			else
				del(parts, p)
			end
			p.ctab = nil
			p.onend = nil
		end
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
			wait = ewait,
			maxage = emaxage,
			onend = eonend,
			c = ectab[1],
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
		wait = ewait,
		maxage = emaxage,
		onend = eonend,
		c = ectab[1],
		ctab = ectab,
	})
end
