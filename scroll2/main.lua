--[[pod_format="raw",created="2024-09-22 09:21:41",modified="2024-10-16 21:27:21",revision=1125]]
include "moveandshoot.lua"

butdic={ 	-- 0 - stop
	1, 		-- 1  - left
	2, 		-- 2  - right
	0, 		-- 3  - stop l+r
	3, 		-- 4  - up
	5, 		-- 5  - diag u+l
	6, 		-- 6  - diag u+r
	3, 		-- 7  - up u+l+r
	4, 		-- 8  - down
	8, 		-- 9  - diag d+l
	7, 		-- 10 - diag d+r
	4, 		-- 11 - down r+l+d
	0, 		-- 12 - stop u+d
	1, 		-- 13 - left l+u+d
	2, 		-- 14 - right r+u+d
	0  		-- 15 - stop l+r+u+d
}
butdic[0] = 0
dirx = {-1, 1, 0, 0,-0.75, 0.75, 0.75,-0.75}
diry = { 0, 0,-1, 1,-0.75,-0.75, 0.75, 0.75}
shiparr = {8,9,10,11,12}
shipspr = 0
shots = {}
shotwait = 0

wep = 2
muzz = {}

banked = 0

-- INIT
function _init()
	t = 0
	px,py = 240,135
	spd = 1.537
	lastdir = 0
	x_borders = 132
	-- 216px horizontal space mirrors 5:4 tate at 270:216
	-- on a 480px wide display, this would require two padding sections at 132px each
	
	scroll = 11 --270 screen height - (8 tiles x 16 pixels)
	seglib = {}
	
	boss = false
	
	-- BUGFIX: dummy segment needed at start
	mapsegs = {0,32,2,1,8}
	
	-- lazydevs segs 3,3,3,3,3,2,1,0,1,7,6,5,10,4,11,6,11,11,5,9,10,8,1,0,15,14,1,13,12,19,19,18,17,16,18,17,16,17,16,19,22,21,20,27,26,25,23,24,3,3
	--mapsegs = {3,3,3,3,3,2,1,28,1,7,6,5,10,4,11,6,11,11,5,9,10,8,1,28,15,14,1 ,13,12,19,19,18,17,16,18,17,16,17,16,19,22,21,20,27,26,25,23,24,3,3}
	mapsegi = 1
	cursegs = {}
end

-- DRAW
function _draw()
	cls(2)
	for seg in all (cursegs) do
		map(seg.x,seg.y,xscroll+x_borders,scroll-seg.o,21,8)
	end	
	
	for s in all(shots) do
		spr(s.sani[flr(s.si)],s.x+6,s.y)
	end
	
	for m in all(muzz) do
		spr(m.sani[flr(m.si)],px+m.x,py+m.y)
	end
	spr(shiparr[flr(shipspr*2.4+3.5)],px,py)
	
	local flamearr={17,18,17,19,18,20,19,21}
	local fframe = (t % (#flamearr - 1)) + 1
	
	spr(flamearr[fframe],px+6-banked,py+14,true)
	spr(flamearr[fframe],px+2+banked,py+14)
	
	-- draw borders
	rectfill(0, 0, x_borders, 270, 32)
	rectfill(480, 0, 480 - x_borders, 270, 32)

	-- debug
	print(px,2,2,7)
	print(scroll,2,11,7)
	print(xscroll,2,20,7)
	print(boss and "boss" or "no boss",2,29,7)
end

-- UPDATE
function _update()
	t += 1
	
	-- SCROLLING
	scroll += .5
	
	if #cursegs < 1 or scroll - cursegs[#cursegs].o > 0 then
		if boss then
			scroll -= 128
			for seg in all(cursegs) do
				seg.o -= 128
			end
		else
			mapsegi += 1
		end
		
		
		local segnum = mapsegs[mapsegi] or 0
			
		add (cursegs, {
			x = 0,
			y = 248-((segnum-1)*8),
			o = #cursegs < 1 and -128 or cursegs[#cursegs].o+128,
		})
		
		if scroll - cursegs[1].o >= 384 then
			deli(cursegs,1)
		end
	end
	
	-- INPUTS / MOVEMENT
	local dir = butdic[btn()&0b1111]
	
	if lastdir != dir and dir >= 5 then
		px = flr(px) -- or flr(px) + 0.5
		py = flr(py) -- or flr(py) + 0.5
	end
	
	local dshipspr = 0
	banked = 0
	
	if dir > 0 then
		px+=dirx[dir] * spd
		py+=diry[dir] * spd
		
		dshipspr = mysgn(dirx[dir])
		banked = 1
	end
	
	shipspr += mysgn(dshipspr-shipspr)*0.18
	shipspr = mid(-1, shipspr, 1)
	
	lastdir = dir
	
	-- boundary checking
	if (px < x_borders) px = x_borders
	if (px > 480 - x_borders - 15) px = 480 - x_borders - 15 -- 15 is sprite size with an offset
	
	percentage_scrolled = mid(6/32, (px - x_borders - 3) / 201, 26/32)
	xscroll = map_range(percentage_scrolled * -32, -26, -6, -40, 0, true)

	if shotwait > 0 then
		shotwait -= 1
	end
	
	-- shooting
	if btn(4) then
		if wep == 1 then
			shot_raiden()
		elseif wep == 2 then
			shot_ddp()
		end
	end
	
	-- summon boss!
	boss = btn(5)
	
	doshots()
	domuzz()
end