--[[pod_format="raw",created="2024-09-30 01:26:23",modified="2024-09-30 02:37:59",revision=169]]
function _init()
	t = 0
	particles = {}
end

function _draw()
	cls(0)
	if #particles > 0 then
		for p in all(particles) do
			spr(p.sprite,p.x,p.y)
		end
	end
--	print(t,2,2,7)
--	print(sin(t/13),2,34,7)
--	if #particles > 0 then
--		print(particles[1].x,2,10,7)
--		print(particles[1].y,2,18,7)
--		print(#particles,2,26,7)
--	end
end

function _update()
	t = t + 1
	if btn(5) then
		add(particles,{
			x = rnd(480),
			y = 270,
			vx = rnd(2) * 5,
			vy = mid(2, rnd(10), 10),
			sprite = mid(1, flr(rnd(5)), 4) 
		})
	end

	if #particles > 0 then
		doparticles()
		cleanparticles()
	end
end

function doparticles()
	for p in all(particles) do
		p.x += (p.vx * sin(t/400))
		p.y -= p.vy
	end
end

function cleanparticles()
	local i = #particles
	while i > 0 do
		if particles[i].y < -10 then
			del(particles, particles[i])
		end		
		i -= 1
	end
end