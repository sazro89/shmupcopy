--[[pod_format="raw",created="2024-10-21 21:26:41",modified="2024-12-16 05:47:04",revision=703]]
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

function col(x1, y1, w1, h1, x2, y2, w2, h2)
	local a_left = x1
	local a_top = y1
	local a_right = x1 + w1 - 1
	local a_bottom = y1 + h1 - 1

	local b_left = x2
	local b_top = y2
	local b_right = x2 + w2 - 1
	local b_bottom = y2 + h2 - 1

	if a_top > b_bottom then
		return false
	end
	if b_top > a_bottom then
		return false
	end
	if a_left > b_right then
		return false
	end
	if b_left > a_right then
		return false
	end

	return true
end

function cyc(age, arr, anis)
	anis = anis or 1
	return arr[(age\anis) % #arr + 1]
end

function drawobj(obj)
	mspr(cyc(obj.age, obj.ani, obj.anis), obj.x, obj.y)
end