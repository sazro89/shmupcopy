--[[pod_format="raw",created="2024-11-08 01:03:28",modified="2024-11-30 13:45:25",revision=1881]]
-- warning, export overwrites all of output_file every time it's used!
-- can store everything directly as variables, a lot of interesting uses i can think of

function export()
	store(output_file,data)
	add(msg,{text="Exported!",t=120})
end

