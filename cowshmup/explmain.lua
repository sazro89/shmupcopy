--[[pod_format="raw",created="2024-10-06 04:41:06",modified="2024-11-06 05:56:15",revision=1258]]
-- [x] flash / contrast flame
-- [ ] fireball
-- [ ] smoke

-- colors for fireball progression
-- white/white 		0x0707		119
-- white/yellow 		0x070a		167
-- yellow/orange 	0x0a09		154
-- orange/yellow 	0x090a		169
-- pgrey/red 		0x0d08		141
-- pgrey/dark grey 0x0d05		93

-- [ ] billowing (fire and smoke)
-- [ ] going up
-- [ ] smoke dissipates
-- [ ] sparks

include("blob.lua")
include("explode.lua")
include("spark.lua")

function _init()
	parts = {}
	slowmo = false

	t = 0
end

function _draw()
	cls(12)
	for p in all(parts) do
		if p.wait == nil then
			p.draw(p)
		end
	end
	--	print(myblb.r, 236, 250, 7)
	--	print(dither_mask(1.1/16), 2, 2, 7)
	print(t, 2, 2, 7)
end

function _update()
	if btnp(4) then
		slowmo = false
		explode(240 + rnd(20) - 10, 135 + rnd(20) - 10)
	end
	if btnp(5) then
		slowmo = true
		explode(240, 135)
		t = 0
	end

	if slowmo == false or btnp(1) then
		t += 1
		for p in all(parts) do
			dopart(p)
		end
	end
end

function rndrange(low, high)
	return flr(rnd(high + 1 - low) + low)
end

