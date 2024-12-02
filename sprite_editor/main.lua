--[[pod_format="raw",created="2024-11-08 00:51:35",icon=userdata("u8",16,16,"01010101010101010101010101010101010606070707070707070707070606010106060707070707070707070706060101060607070707070707070707060601010606070707070707070707070606010106060707070707070707070706060101060607070707070707070707060601010606070707070707070707070606010106060606060606060606060606060101060606060606060606060606060601010606060606060606060606060606010106060601010101010101010106060101060606010707070701010101060601010606060107070707010101010606010001060601070707070101010106060100000101010101010101010101010101"),modified="2024-11-30 13:45:25",revision=2036]]
include("draw.lua")
include("update.lua")
include("tools.lua")
include("io.lua")
include("ui.lua")

function _init()
	printh("new run")
	modify_text_display = create_gui()
	
	window{width = 200, height = 200}
	
	input_file = "gfx/myspr.pod"
	output_file = "gfx/myspr.pod"
	data = fetch(input_file)
	myspr = data

	debug = {}
	msg = {}
	_drw = draw_list
	_upd = update_list
	menuitem(1, "export", export)
	
	curx = 1
	cury = 1
	scrolly = 0
	scrollx = 0
	scrollspeed = 4
	magnification = 1
end

function _draw()
	_drw()
	
	if current_page == "edit" then
		modify_text_display:draw_all()
	elseif current_page == "newline" then
		modify_text_display:draw_all()
	end
	
	if #msg > 0 then
		bgprint(msg[1].text,100-(#msg[1].text*2.5),97,14)
		msg[1].t = msg[1].t - 1
		if msg[1].t <= 0 then
			deli(msg,1)
		end
	end
	
	-- debug --
	cursor(4, 4)
	color(8)
	for txt in all(debug) do
		print(txt)
	end
end

function _update()
	_upd()
	modify_text_display:update_all()
end
