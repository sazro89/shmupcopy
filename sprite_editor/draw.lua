--[[pod_format="raw",created="2024-11-08 00:54:54",modified="2024-11-30 13:45:25",revision=2325]]
function draw_edit()
	camera(0,0)
	cls(2)
	fillp(0b11001100001100111100110000110011)
	rectfill(0,0,199,199,0x1502)
	fillp(0b1010010110100101)		-- sets checkerboard
	line(100,0,100,200,0x0d01)	-- crosshair
	line(0,100,200,100,0x0d01)	-- crosshair

	fillp() -- resets fill pattern
	draw_menu()
	
	if selected_sprite then
		mspr(selected_sprite,100,100)
	end
	
	if (time()*2)%1<0.5 then
		pset(100,100,rnd{8,13,7,15})
	end
end


function draw_list()
	cls(2)
	fillp(0b11001100001100111100110000110011)
	rectfill(0,0,199,#menu*13+20,0x1502)
	fillp(0b1010010110100101)
	line(100,0-scrolly,100,200-scrolly,0x0d01)	
	line(0,100-scrolly,200,100-scrolly,0x0d01)	

	fillp()
	printh(menu == nil)
	
	draw_menu()

	local mymenu = menu[cury][curx]
	
	if mymenu.cmdy then
		mspr(mymenu.cmdy,100,100-scrolly,magnification)
	end
	
	if (time()*2)%1<0.5 then
		rectfill(100,100-scrolly,100+magnification-1, 100-scrolly+magnification-1, rnd{8,13,7,15})
	end
end

function draw_table()
	cls(1)
	draw_menu()
end

function draw_menu()
	if menu then
		for _i = 1, #menu do
			for _j = 1, #menu[_i] do
				-- change color if cell is currently selected
				local _c = menu[_i][_j].c or 18
				if _i == cury and _j == curx then
					_c = 7
				end
				
				-- make copy of local cell we're working with
				local mymenu = menu[_i][_j]
				
				-- print cell
				bgprint(mymenu.w, mymenu.x, mymenu.y, _c) --*****
				bgprint(mymenu.text, mymenu.x, mymenu.y, _c)
				if _i == cury and _j == curx then
					rect(mymenu.x-2, mymenu.y-2, mymenu.x+(#mymenu.w * 5), mymenu.y+11, _c)
				end
			end
		end
	end
end