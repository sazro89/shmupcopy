--[[pod_format="raw",created="2024-09-22 09:21:41",modified="2024-10-06 04:05:51",revision=1011]]
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


function _init()
	px,py = 240,135
	spd = 1.537
	lastdir = 0
	t = 0 -- timer variable
	cls(0)
end

function _draw()
	cls(12)
--	map()

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
	
--	local btnval = btn()&0b1111
--	print(shipspr*2.4+3.5,5,5,7)
--	print(butdic[btnval],5,14,7)
	print("shots: "..#shots,2,2,7)
end

function _update()
	t += 1
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
	
	doshots()
	domuzz()
end

function doshots()
	for s in all(shots) do
		s.x += s.sx
		s.y += s.sy
		s.si += 0.5
		
		if flr(s.si) > #s.sani then
			s.si = 1
		end
		if s.y < -16 then
			del(shots,s)
		end
	end
end

function domuzz()
	for m in all(muzz) do
		m.si += 1
		
		if flr(m.si) > #m.sani then
			del(muzz,m)
		end
	end
end

function mysgn(v)
	return v == 0 and 0 or sgn(v)
end

function shot_raiden()
	if shotwait <= 0 and #shots < 6 then
		local shotspd = -3.5
		shotwait = 4
		add(shots,{
			x = px-3,
			y = py+9,
			sx = 0,
			sy = shotspd,
			sani = {16},
			si = 1
		})
		add(shots,{
			x = px+3,
			y = py+9,
			sx = 0,
			sy = shotspd,
			sani = {16},
			si = 1
		})
	end
end

function shot_ddp()
	if shotwait <= 0 and #shots < 14 then
		local shotspd = -12
		shotwait = 3
		add(shots,{
			x = px-6,
			y = py,
			sx = 0,
			sy = shotspd,
			sani = {24,25,26,25},
			si = t%4+1
		})
		add(shots,{
			x = px+2,
			y = py,
			sx = 0,
			sy = shotspd,
			sani={24,25,26,25},
			si = t%4+1
		})
		add(muzz, {
			x = -4,
			y = -8,
			sani = {27,28,29,30},
			si = 0
		})
		add(muzz, {
			x = 4,
			y = -8,
			sani = {27,28,29,30},
			si = 0
		})
	end
end