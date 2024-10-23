--[[pod_format="raw",created="2024-09-22 09:21:41",modified="2024-10-23 20:36:09",revision=1428]]
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
	profile.enabled(true,true)
	
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
	dirx = { -1, 1,  0, 0, -0.75,  0.75, 0.75, -0.75 }
	diry = {  0, 0, -1, 1, -0.75, -0.75, 0.75,  0.75 }
	
	x_borders = 132
	-- 216px horizontal space mirrors 5:4 tate at 270:216
	-- on a 480px wide display, this would require two padding sections at 132px each
	
	-- BUGFIX: dummy segment needed at start
	
	shiparr = { 8, 9, 10, 11, 12 }
	flamearr = { 17, 18, 17, 19, 18, 20, 19, 21 }
	-- lazydevs segs 3,3,3,3,3,2,1,0,1,7,6,5,10,4,11,6,11,11,5,9,10,8,1,0,15,14,1,13,12,19,19,18,17,16,18,17,16,17,16,19,22,21,20,27,26,25,23,24,3,3
	mapsegs = {0,3,3,3,3,3,2,1,28,1,7,6,5,10,4,11,6,11,11,5,9,10,8,1,28,14,15,1,12,13,19,19,16,17,18,16,17,18,17,18,19,20,21,22,23,24,25,26,27,3,3,3}
	
	startgame()
end

function _draw()
	_drw()	
-- debug
-- print(px, 2, 2, 7)
--	print(scroll, 2, 11, 7)
--	print(xscroll, 2, 20, 7)
--	print(boss and "boss" or "no boss", 2, 29, 7)
end

function _update()
	_upd()
end

function startgame()
	px, py = 240, 135
	spd = 1.537
	lastdir = 0
	shipspr = 0
	
	scroll = 11
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