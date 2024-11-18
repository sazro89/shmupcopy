--[[pod_format="raw",created="2024-09-22 09:21:41",modified="2024-09-28 06:31:05",revision=586]]
function _init()
	scroll = 142 --270 screen height - (8 tiles x 16 pixels)
	seglib = {}
	
	-- order of these adds is important!
	for i=1,32 do
		col=0
		row=248-((i-1)*8)
		add(seglib,{
			mx=col,
			my=row
		})
	end
	
	mapsegs = {32,2,1,8}
end

function _draw()
	cls(2)
	for i=1,#mapsegs do
		local myseg=seglib[mapsegs[i]]
		local segy=scroll-(i-1)*128
		map(myseg.mx,myseg.my,0,segy,30,8)
--		print("\16\16\16\16\16\16\16\16",2,2,1)
--		print(segy,2,2,7)
	end	
end

function _update()
	scroll += .5
end