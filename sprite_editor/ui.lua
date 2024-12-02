--[[pod_format="raw",created="2024-11-23 10:46:36",modified="2024-11-30 13:45:25",revision=491]]
function refresh_edit()
	menu = {}
	
	add(menu,{{
		text = "< sprite "..selected_sprite.. " >",
		w = width_to_string(9+#tostr(selected_sprite)),
		cmd = "sprhead",
		x = 2,
		y = 2,
	}})
	local label = {"id:", "x:", "y:", "ox:", "oy:", "fx:", "fy:"}
	for i = 1, 7 do
		local s = tostr(data[selected_sprite][i])
		if s == nil then
			s = "[nil]"
		end
		
		add(menu,{
			{
				text = label[i],
				w = "    ",
				x = 2,
				y = 2+i*13,
			},
			{
				text = s,
				w = width_to_string(#s),
				cmd = "editval",
				cmdy = selected_sprite,
				cmdx = i,
				x = 17,
				y = 2+i*13,
			},
		})
	end
	add(menu,{{
		text = "DELETE",
		w = width_to_string(6),
		cmd = "delspr",
		x = 2,
		y = 108,
	}})
end

function refresh_list()
	menu = {}
	for i = 1, #data do
		local row = {}
		add(row, {
				text = "spr " .. i,
				cmd = "editspr",
				cmdy = i,
				x = 2,
				y = -11 + 13 * i,
				w = width_to_string(4+#tostr(i)),
		})
		add(menu, row)
	end
	add(menu,{{
		text = " + ",
		key = "_add",
		x = 2,
		y = -11 + 13 * (#data + 1),
		w = "   ",
		cmd = "newline",
		cmdx = j,
		cmdy = i,
	}})
end

function refresh_table()
	menu = {}
	for i = 1, #data do
		local row = {}
		add(row, {
				text = i,
				cmd = "",
				x = 2,
				y = -11 + 13 * i,
				w = "   ",
				c = 18,
			})
		for j = 1, #data[i] do
			add(row, {
				text = data[i][j],
				cmd = "edit",
				cmdx = j,
				cmdy = i,
				x = -43 + 32 * (j + 1),
				y = -11 + 13 * i,
				w = "      ",
			})
		end
		if cury == i then
			add(row, {
				text = " + ",
				cmd = "newcell",
				cmdy = i,
				x = -43 + 32 * (#data[i] + 2),
				y = -11 + 13 * i,
				w = "   ",
			})
		end
		add(menu, row)
	end
	add(menu,{{
		text = " + ",
		key = "_add",
		x = 2,
		y = -11 + 13 * (#data + 1),
		w = "   ",
		cmd = "newline",
		cmdx = j,
		cmdy = i,
	}})
end