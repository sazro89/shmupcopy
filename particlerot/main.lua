--[[pod_format="raw",created="2024-09-20 09:43:18",modified="2024-09-21 07:02:15",revision=186]]
include "rspr.lua"
include "profiler.lua"

function _init()
-- frame counter
frames = 0
-- bullet array
	buls={}
-- larger value = sprites drawn
-- hit around 2000 objects at 95% cpu with this naive approach
	for i=1,800 do
		local mybul={
			x=rnd(480),
			y=rnd(270),
			col=flr(rnd(2))+1,
			vx=(rnd()-.5)*rnd(5)+1,
			vy=(rnd()-.5)*rnd(5)+1,
			r=rnd(),
			vr=rnd()
		}
		add(buls,mybul)
	end
-- enable profiling
	profile.enabled(true,true)
end

function _draw()
	profile("_draw")
--clear the screen
	cls(2)

--draw our bullets
	for bul in all(buls) do
		spr(bul.col,bul.x,bul.y)
-- 		rspr(bul.col,bul.x,bul.y,1,1,bul.r)
--		for j=0,15 do
--			local x0,y0 = rotate(0,j)
--			local x1,y1 = rotate(15,j)
--			tline3d(bul.col,x0+bul.x,y0+bul.y,x1+bul.x,y1+bul.y,0,j,16,j)
--		end
	end
	profile.draw()
	profile("_draw")
end

function _update()
	profile("_update")
--collision and movement
	for bul in all(buls) do
		bul.x+=bul.vx
		if (bul.x < 16) bul.x=16 bul.vx*=-1
		if (bul.x > 464) bul.x=464 bul.vx*=-1
		bul.y+=bul.vy
		if (bul.y < 16) bul.y=16 bul.vy*=-1
		if (bul.y > 254) bul.y=254 bul.vy*=-1
		bul.r+=bul.vr
	end
	frames += 1
	profile("_update")
end

function rotate(x,y)
	local a = angle
	return cos(a)*x - sin(a)*y, cos(a)*y + sin(a)*x
end