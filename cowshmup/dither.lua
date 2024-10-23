--[[pod_format="raw",created="2024-10-06 20:57:04",modified="2024-10-21 21:56:58",revision=680]]
local threshold_map = {
	0, 8, 2, 10,
	12, 4, 14, 6,
	3, 11, 1, 9,
	15, 7, 13, 5,
}

local function make_mask(value)
	local mask = 0
	for i = 1, 16 do
		mask = mask * 2
		if threshold_map[i] >= value then
			mask += 1
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