--[[pod_format="raw",created="2024-10-06 05:10:33",modified="2024-10-21 21:54:39",revision=1006]]
include "dither.lua"

function blob(p)
	local flr_r = flr(p.r)
	local _r = {
		0,
		flr_r * 0.05,
		flr_r * 0.15,
		flr_r * 0.30
	}
	
--	local pat = { -- we can also use dither_mask(value) values instead
--		0b0000000000000000,
--		0b0001101001011010,
--		0b0111111111111111,
--		0b1111111111111111
--	}

	local pat = {
		dither_mask(1),
		dither_mask(9/16),
		dither_mask(1/16),
		dither_mask(0)
	}

	if flr_r <= 5 then
		deli(_r,4)
		deli(_r,2)
		deli(pat,2)
		deli(pat,2)
--	elseif flr_r <= 6 then
--		deli(_r,3)
--		deli(pat,3)
	elseif flr_r <= 8 then
		deli(_r,4)
		deli(pat,3)
		pat[2]=0b1001001001001001	
	elseif flr_r >= 12 then
--		deli(_r,4)
--		deli(pat,3)
--		pat[2]=0b1001001001001001
		_r[2] = flr_r * 0.02
		_r[3] = flr_r * 0.08
		_r[4] = flr_r * 0.12
	end
--	fillp(dither_mask(3/8))
--	fillp(0b0001101001011010)
--	circfill(p.x-2,p.y+2, flr_r, 0x1814) -- adds dark outline
--	circfill(p.x-1,p.y+1, flr_r, 21) -- adds dark outline
	for i = 1, #_r do
--		poke(0x550b,0x3f) -- set black to transparent
--		palt()            -- recommended but what is this doing?
--		fillp(dither_mask(i/#_r))
		fillp(pat[i])
		circfill(p.x, p.y-_r[i], flr_r-_r[i], p.c)
--		poke(0x550b,0x00) -- set back to black
	end
	
	fillp()
	if flr_r == 1 then
		pset(p.x, p.y, p.c)
	elseif flr_r == 2 then
		rectfill(p.x-1, p.y-1, p.x+1, p.y+1, p.c)
	end
end

