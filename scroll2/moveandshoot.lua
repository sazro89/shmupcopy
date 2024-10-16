--[[pod_format="raw",created="2024-10-13 21:18:38",modified="2024-10-16 21:27:21",revision=405]]
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

function map_range(x, in_min, in_max, out_min, out_max)
	return out_min + (x - in_min)*(out_max - out_min)/(in_max - in_min)
end
