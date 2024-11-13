--[[pod_format="raw",created="2024-11-08 01:03:28",modified="2024-11-08 22:40:40",revision=116]]
-- warning, export overwrites all of output_file every time it's used!
-- can store everything directly as variables, a lot of interesting uses i can think of

function export()
	store(output_file,data)
	debug[1]="exported"
end