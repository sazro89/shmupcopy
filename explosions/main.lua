--[[pod_format="raw",created="2024-10-06 04:41:06",modified="2024-10-07 07:44:40",revision=548]]
-- [x] flash / contrast flame
-- [ ] fireball
-- [ ] smoke

-- [ ] billowing (fire and smoke)
-- [ ] going up
-- [ ] smoke dissipates
-- [ ] sparks

include("blob.lua")
include("explode.lua")

function _init()
	parts = {}
	slowmo = false
	
	t = 0
end

function _draw()
	cls(12)
	for p in all(parts) do
		if p.wait == nil then
			blob(p)
		end
	end
--	print(myblb.r, 236, 250, 7)
--	print(dither_mask(1.1/16), 2, 2, 7)
	print(t, 2, 2, 7)
end

function _update()
	if btnp(4) then
		slowmo = false
		explode(240,135)
	end
	if btnp(5) then
		slowmo = true
		explode(240,135)
		t = 0
	end
	
	if slowmo == false or btnp(1) then
		t+=1
		for p in all(parts) do
			dopart(p)
		end
	end
end