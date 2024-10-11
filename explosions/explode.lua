--[[pod_format="raw",created="2024-10-07 01:29:38",modified="2024-10-07 07:44:40",revision=173]]
function explode(ex, ey)
	add(parts, {
		x = ex,
		y = ey,
		r = 17,
		maxage = 2,
	})
	grape(ex, ey)
end

function dopart(p)
	-- [ ] age function
	-- [ ] max age counter

	if p.wait then
		-- wait countdown
		p.wait -= 1
		if p.wait >= 0 then
			p.wait = nil
		end
	else
		-- particle logic
		p.age = p.age or 0
    if p.age == 0 then
      p.ox = p.x
      p.oy = p.y
    end

		p.age += 1

		--movement
		if p.to_x then
			p.x += (p.to_x - p.x) / 4
			p.y += (p.to_y - p.y) / 4
		end
		if p.age >= p.maxage then
      if p.onend == "return" then
        p.onend = nil
        p.maxage += 10
        p.to_x = p.ox
        p.to_y = p.oy
      else
        del(parts, p)
      end
		end
	end
	-- 2 main ways to logic and animate
	-- sx/sy velocity system.  not great control if you want control over the particles final destination
	-- to_x/to_y destination definition
end

function grape(ex, ey)
	local spokes = 6
	local ang = rnd()
	local step = 1 / spokes
	local shakiness = rnd(4) - 2

	for i = 1, spokes do
		-- spawn blobs
		local myang = ang + step * i
		local dist = 8
		local dist2 = dist / 2

		add(parts, {
			x = shakiness + ex + sin(myang) * dist2,
			y = shakiness + ey + cos(myang) * dist2,
			r = shakiness + 6,
			to_x = shakiness + ex + sin(myang) * dist,
			to_y = shakiness + ey + cos(myang) * dist,
			maxage = 120,
      onend = "return"
		})
	end
	add(parts, {
		x = shakiness + ex,
		y = shakiness + ey - 4,
		r = shakiness + 10,
		maxage = 120,
	})
end
