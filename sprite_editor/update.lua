--[[pod_format="raw",created="2024-11-08 00:55:08",modified="2024-11-30 13:45:25",revision=2330]]
function update_edit()
	refresh_edit()
	
	curx = (cury == 1 or cury == 9) and 1 or 2
	wheel_y = ({mouse()})[5]
	
	--up
	if keyp("up") then
		cury = cury - 1
	end
	--down
	if keyp("down") then
		cury = cury + 1
	end
	cury = (cury-1) % (#menu) + 1
	cury = cury - wheel_y
	cury = mid(1, cury, #menu)
	
	if keyp("left") then
		selected_sprite -= 1
	end
	if keyp("right") then
		selected_sprite += 1
	end
	selected_sprite = mid(1, selected_sprite, #data)
	
	if keyp("x") then
		_drw = draw_list
		_upd = update_list
		curx = 1
		cury = selected_sprite
		refresh_list()
		return
	end
	
	if keyp("z") then
		mymenu = menu[cury][curx]
		if mymenu.cmd == "editval" then
			current_page = "edit"
			prev_upd = "update_edit"
			text_bar = spawntextbox()
			_upd = upd_type	
			text_bar:set_keyboard_focus(true)
			text_bar:set_text(tostr(data[mymenu.cmdy][mymenu.cmdx]))
			mymenu.data = tonum(mymenu.data)
		elseif mymenu.cmd == "delspr" then
			deli(data,selected_sprite)
			_drw = draw_list
			_upd = update_list
			curx = 1
			cury = 1
			refresh_list()	
		end
	end

	printh("cury: " .. cury .. ", curx: " .. curx)
	local curmenu = menu[cury][curx]
	
	if curmenu then
		if curmenu.y + scrolly > (200 - 30) then
			scrolly = scrolly - scrollspeed
		end
		if curmenu.y + scrolly < 22 then
			scrolly = scrolly + scrollspeed
		end
		scrolly = min(0, scrolly)
		
		camera(0,-scrolly)
	end
end

function update_list()
	refresh_list()
	
	wheel_y = ({mouse()})[5]
	
	--up
	if keyp("up") then
		cury = cury - 1
	end
	--down
	if keyp("down") then
		cury = cury + 1
	end
	cury = (cury-1) % (#menu) + 1
	cury = cury - wheel_y
	cury = mid(1, cury, #menu)
	
	local curmenu = menu[cury][curx]
	
	if curmenu then
		if curmenu.y + scrolly > (200 - 30) then
			scrolly = scrolly - scrollspeed
		end
		if curmenu.y + scrolly < 22 then
			scrolly = scrolly + scrollspeed
		end
		scrolly = min(0, scrolly)
		
		camera(0,-scrolly)
	end
	
	--left and right control zoom between 1-5x
	if keyp("left") then
		magnification -= 1
	end
	if keyp("right") then
		magnification += 1
	end
	magnification = mid(1,magnification,5)
	
	if keyp("z") then
		local mymenu = menu[cury][curx]
		if mymenu.cmd == "newline" then
			add(data,{0, 0, 0, 0, 0})
		elseif mymenu.cmd == "editspr" then
			selected_sprite = mymenu.cmdy
			_upd = update_edit
			_drw = draw_edit
			cury = 1
		end
	end
end

function update_table()
	refresh_table()
	
	wheel_y = ({mouse()})[5]
	
	--up
	if keyp("up") then
		cury = cury - 1
	end
	--down
	if keyp("down") then
		cury = cury + 1
	end
	cury = (cury-1) % (#menu) + 1
	cury = cury - wheel_y
	cury = mid(1, cury, #menu)
	
	--left
	if keyp("left") then
		curx = curx - 1
	end
	--right
	if keyp("right") then
		curx = curx + 1
	end
	if cury < #menu then
		curx = (curx-2) % (#menu[cury]-1) + 2
	else
		curx = 1
	end
	
	local curmenu = menu[cury][curx]
	
	if curmenu then
		if curmenu.y + scrolly > (200 - 30) then
			scrolly = scrolly - scrollspeed
		end
		if curmenu.y + scrolly < 22 then
			scrolly = scrolly + scrollspeed
		end
		scrolly = min(0, scrolly)
		
		if curmenu.x + scrollx > (400 - 80) then
			scrollx = scrollx - scrollspeed
		end
		if curmenu.x + scrollx < 22 then
			scrollx = scrollx + scrollspeed
		end
		scrollx = min(0, scrollx)
		
		camera(-scrollx,-scrolly)
	end
	
	-- selecting a cell
	if keyp("z") then
		mymenu = menu[cury][curx]
		-- editable cell selected
		if mymenu.cmd == "edit" then
			current_page = "edit"
			text_bar = spawntextbox()
			_upd = upd_type	
			text_bar:set_keyboard_focus(true)
			text_bar:set_text(tostring(mymenu.text))
			mymenu.data = tonum(mymenu.data)
		-- newline cell selected
		elseif mymenu.cmd == "newline" then
			add(data, { 0 })
		elseif mymenu.cmd == "newcell" then
			add(data[mymenu.cmdy],0)
		end
	end
end

function upd_type()
	-- no need to check for input if we're typing
end

function spawntextbox(_i)
	local enter_mode = _i
	local editval
	local text_bar = modify_text_display:attach_text_editor{
		x = mymenu.x+14+scrollx, y = mymenu.y-1+scrolly,
		width = 16,
		height = 12,
		margin_top = 2,
		key_callback = {
			enter = function(enter_mode)
				editval = text_bar:get_text()[1]
				if (editval == "") then
					editval = 0
-- this is all for edit_table, we might want to split these up
--					-- if current x is on the last cell
--					if mymenu.cmdx == #data[mymenu.cmdy] then
--						if mymenu.cmdx == 1 then
--							deli(data, mymenu.cmdy)
--						else
--							deli(data[mymenu.cmdy],mymenu.cmdx)
--						end
--					else
--						editval = tonum(editval)
--						data[cury][curx-1] = (editval) and editval or 0
--					end
--				else
--					if enter_mode == "newline" then
--						local _el = {
--							text = 0,
--							key = editval,
--							cmd = "edit",
--							cmdx = j,
--							cmdy = i,
--							x = -30 + 32 * j,
--							y = -11 + 13 * i,
--							w = "      "
--						}
--						add(data,{_el})
--					else
--						editval = tonum(editval)
--						data[cury][curx-1] = (editval) and editval or 0
--					end
				end
				removeAllChildren(modify_text_display)
				current_page = nil
				if prev_upd == "update_edit" then
					data[mymenu.cmdy][mymenu.cmdx] = (editval) and editval or 0			
					_upd = update_edit
				end
			end
		}
	}
	return text_bar
end