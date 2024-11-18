--[[pod_format="raw",created="2024-09-22 02:52:49",modified="2024-09-22 09:11:01",revision=268]]
include("profiler.lua")

-- can handle about 2000 8x8 bullets and hold 60fps with map calls and no moving
-- can handle about 3000 4x4 bullets and hold 60fps with map calls and no moving
-- updating position of 1500 objects is about 50% cpu hit
function _init()
	profile.enabled(true,true)
	player={
		x=240,
		y=200
	}
	buls={}
	for i=1,1250 do
		local mybul={
			x=rnd(480),
			y=rnd(286)-8
		}
		add(buls,mybul)
	end
end

function _draw()
	profile("_draw")
	map()
	
	for bul in all(buls) do
		spr(1,bul.x,bul.y)	
	end
	spr(3,player.x,player.y)
	spr(4,player.x+6,player.y+4)
	profile.draw()
	print("fps: " .. stat(7),1,29,7)
	profile("_draw")
end

function _update()
	profile("_update")
	for bul in all(buls) do
		if (bul.y < 269) bul.y+=0.5
	end
	if (btn(0)) player.x-=1
	if (btn(1)) player.x+=1
	if (btn(2)) player.y-=1
	if (btn(3)) player.y+=1
	
	profile("_update")
end