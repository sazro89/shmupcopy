--[[pod_format="raw",created="2024-10-13 19:34:29",modified="2024-10-21 21:55:32",revision=192]]
function spark(p)
	-- pset(p.x, p.y, 8)
	line(p.x, p.y, p.x - p.sx * 2, p.y - p.sy * 2, 7)
	line(p.x + 1, p.y, p.x - p.sx * 2 + 1, p.y - p.sy * 2, p.c)
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
			wait = ewait,
			maxage = rndrange(8, 20),
			c = 10,
			ctab = { 7, 10 },
		})
	end
end

