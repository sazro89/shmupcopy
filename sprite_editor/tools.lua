--[[pod_format="raw",created="2024-11-08 00:58:52",modified="2024-11-30 13:45:25",revision=1886]]
function bgprint(txt,x,y,c)
	print("\#0"..txt,x,y,c)
end

function fillBG(self, col)
	rectfill(1,1,self.width-2,self.height-2,col)
end

function fillSELECTED(self, col)
	rectfill(-1,-1,self.width+1,self.height+1,col)
end

function removeAllChildren(el)
	for child in all(el.child) do
		el:detach(child)
	end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function print_table(node)
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)

    print(output_str)
end

function width_to_string(_num)
	local _out = ""
	for i = 0,_num+1 do
		_out ..= " "
	end
	return _out
end

function mspr(si, sx, sy, mag, flip_x, flip_y)
	local ms = myspr[si]
	mag = (mag) and mag or 1
	-- 1:i, 2:w, 3:h, 4:ox, 5:oy, 6:flip_x 7:flip_y
	sspr(ms[1], 0, 0, ms[2], ms[3], sx - ms[4]*mag, sy - ms[5]*mag, ms[2]*mag, ms[3]*mag, ms.flip_x or flip_x, ms.flip_y or flip_y)
	if ms.nextspr then
		mspr(ms.nextspr, sx, sy)
	end
end