--[[pod_format="raw",created="2024-09-22 09:21:41",modified="2024-10-27 03:59:36",revision=1536]]
---@diagnostic disable-next-line: undefined-global
include("tools.lua")
include("draw.lua")
include("update.lua")
include("gameplay.lua")
include("particles.lua")
include("profiler.lua")

function _init()
	profile("_init")
	t = 0
	debug = {}
	profile.enabled(true, true)

	-- in the tutorial he stores a bunch of values needed for sspr in pico-8
	-- we don't need that in picotron, but then he also bakes in offset values
	-- so this array is for holding those kinds of values
	myspr = {
		-- ship sprites 1-5
		{ i = 8, w = 15, h = 18, ox = 5, oy = 8 },
		{ i = 9, w = 16, h = 18, ox = 7, oy = 8 },
		{ i = 10, w = 18, h = 18, ox = 8, oy = 8 },
		{ i = 11, w = 16, h = 18, ox = 7, oy = 8 },
		{ i = 12, w = 15, h = 18, ox = 8, oy = 8 },
		-- shot sprites 6-8
		{ i = 24, w = 8, h = 16, ox = 3, oy = 0 },
		{ i = 25, w = 6, h = 16, ox = 2, oy = 0 },
		{ i = 26, w = 4, h = 16, ox = 1, oy = 0 },
		-- muzz sprites 9-12
		{ i = 27, w = 10, h = 10, ox = 5, oy = 9 },
		{ i = 28, w = 12, h = 14, ox = 6, oy = 13 },
		{ i = 29, w = 14, h = 13, ox = 7, oy = 12 },
		{ i = 30, w = 16, h = 14, ox = 8, oy = 13 },
		-- flame sprites 13-17
		{ i = 17, w = 1, h = 1, ox = 0, oy = 0 },
		{ i = 18, w = 3, h = 3, ox = 1, oy = 0 },
		{ i = 19, w = 3, h = 6, ox = 1, oy = 0 },
		{ i = 20, w = 3, h = 8, ox = 1, oy = 0 },
		{ i = 21, w = 3, h = 8, ox = 1, oy = 0 },
	}

	sprval = 3

	butdic = { -- 0 - stop
		1, -- 1  - left
		2, -- 2  - right
		0, -- 3  - stop l+r
		3, -- 4  - up
		5, -- 5  - diag u+l
		6, -- 6  - diag u+r
		3, -- 7  - up u+l+r
		4, -- 8  - down
		8, -- 9  - diag d+l
		7, -- 10 - diag d+r
		4, -- 11 - down r+l+d
		0, -- 12 - stop u+d
		1, -- 13 - left l+u+d
		2, -- 14 - right r+u+d
		0, -- 15 - stop l+r+u+d
	}
	butdic[0] = 0
	dirx = { -1, 1, 0, 0, -0.75, 0.75, 0.75, -0.75 }
	diry = { 0, 0, -1, 1, -0.75, -0.75, 0.75, 0.75 }

	x_borders = 132
	-- 216px horizontal space mirrors 5:4 tate at 270:216
	-- on a 480px wide display, this would require two padding sections at 132px each

	-- BUGFIX: dummy segment needed at start

	shiparr = { 1, 2, 3, 4, 5 }
	flamearr = { 13, 14, 13, 15, 14, 16, 15, 17 }
	-- lazydevs segs 3,3,3,3,3,2,1,0,1,7,6,5,10,4,11,6,11,11,5,9,10,8,1,0,15,14,1,13,12,19,19,18,17,16,18,17,16,17,16,19,22,21,20,27,26,25,23,24,3,3
	menusegs = { 5 }
	menusegs[0] = 4
	menucursegs = {}
	scroll = 0
	mapsegi = 0
	xscroll = 0

	mapsegs = {
		0,
		3,
		3,
		3,
		3,
		3,
		2,
		1,
		28,
		1,
		7,
		6,
		5,
		10,
		4,
		11,
		6,
		11,
		11,
		5,
		9,
		10,
		8,
		1,
		28,
		14,
		15,
		1,
		12,
		13,
		19,
		19,
		16,
		17,
		18,
		16,
		17,
		18,
		17,
		18,
		19,
		20,
		21,
		22,
		23,
		24,
		25,
		26,
		27,
		3,
		3,
		3,
	}

	_upd = upd_menu
	_drw = drw_menu
end

function _draw()
	_drw()
	-- debug
	cursor(4, 4)
	color(7)
	for txt in all(debug) do
		print(txt)
	end
end

function _update()
	t = t + 1
	_upd()
end

function startgame()
	px, py = 240, 230
	spd = 1.537
	lastdir = 0
	shipspr = 0

	scroll = 700 -- def 11
	xscroll = 0
	mapsegi = 1
	seglib = {}
	cursegs = {}

	boss = false

	parts = {}
	shots = {}
	shotwait = 0
	muzz = {}
	banked = 0

	_upd = upd_game
	_drw = drw_game
end
