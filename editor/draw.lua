--[[pod_format="raw",created="2024-11-08 00:54:54",modified="2024-11-08 22:40:40",revision=143]]
function draw_table()
	cls(2)
	-- spr(10, 10, 10)

	refresh_table()

	for i = 1, #menu do
		for j = 1, #menu[i] do
			local mymenu = menu[i][j]
			bgprint(mymenu.text, mymenu.x, mymenu.y, 13)
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
	for i, i_arr in ipairs(data) do
		local line = {}
		for j, j_arr in ipairs(i_arr) do
			add(line, {
				text = j_arr,
				cmd = "edit",
				x = 2 + 18 * j,
				y = 2 + 8 * i,
			})
		end
		add(menu, line)
	end
end

