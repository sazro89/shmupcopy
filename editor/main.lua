--[[pod_format="raw",created="2024-11-08 00:51:35",modified="2024-11-08 22:40:40",revision=149]]
include("draw.lua")
include("update.lua")
include("tools.lua")
include("io.lua")

function _init()
	input_file = "myspr.pod"
	output_file = "out.pod"
	-- is this array_name needed?
	array_name = "myspr"
	data = fetch(input_file)

	debug = {}
	_drw = draw_table
	_upd = update_table
	menuitem(1, "export", export)
end

function _draw()
	_drw()

	-- debug --
	cursor(4, 4)
	color(8)
	for txt in all(debug) do
		print(txt)
	end
end

function _update()
	_upd()
end
