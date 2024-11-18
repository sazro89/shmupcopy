--[[pod_format="raw",created="2024-11-08 00:54:54",modified="2024-11-14 08:53:40",revision=219]]
function draw_table()
	cls(2)
	-- spr(10, 10, 10)

	refresh_table()

	debug[1]=menu
	for _i = 1, #menu do
		for _j = 1, #menu[_i] do
			local mymenu = menu[_i][_j]
			bgprint(mymenu.text, mymenu.x, mymenu.y, 13)
			-- bgprint("test", 18, 18, 13)
		end
	end

	--[[
	for i = 1, #data do
		for j = 1, #data[i] do
			bgprint(data[i][j],-4+(7*j),-7+(12*i),7)
		end
	end
	]]
end

function refresh_table()
	--[[
	menu = {
		{
			{
				txt = "hello",
				cmd = "say hello",
				x = 2,
				y = 2,
			},
		},
	}
	]]
	menu = {}
	-- for i = 1, #data do
	i = 1
	j = 1
	for _i, _v in pairs(data) do
		local line = {}
		for _index, _value in pairs(_v) do
			add(line, {
				text = _value,
				cmd = "edit",
				x = 2 + 18 * j,
				y = 2 + 8 * i,
			})
			j = j + 1
		end
		add(menu, line)
		i = i + 1
		j = 1
	end
end

