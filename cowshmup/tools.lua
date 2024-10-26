--[[pod_format="raw",created="2024-10-21 21:26:41",modified="2024-10-25 19:47:01",revision=239]]
-- alternate to sgn, different in that 0 returns 0 instead of 1
function mysgn(v)
	return v == 0 and 0 or sgn(v)
end

-- for a value x between range in_min and in_max, map the value at the same
-- relational position between out_min and out_max
function map_range(x, in_min, in_max, out_min, out_max)
	return out_min + (x - in_min) * (out_max - out_min) / (in_max - in_min)
end

-- returns a random value inclusively between low and high
function rndrange(low, high)
	return flr(rnd(high + 1 - low) + low)
end

-- dither mask suite
local threshold_map = {
	0,
	8,
	2,
	10,
	12,
	4,
	14,
	6,
	3,
	11,
	1,
	9,
	15,
	7,
	13,
	5,
}

local function make_mask(value)
	local mask = 0
	for i = 1, 16 do
		mask = mask * 2
		if threshold_map[i] >= value then
			mask = mask + 1
		end
	end
	return mask
end

local dither_masks = {}

for i = 0, 16 do
	dither_masks[i] = make_mask(i)
end

-- value 0-1
function dither_mask(value)
	return dither_masks[mid(0, flr(value * 16 + 0.5), 16)]
end
