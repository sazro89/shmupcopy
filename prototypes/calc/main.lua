--[[pod_format="raw",created="2024-09-22 09:21:41",modified="2024-09-24 07:17:22",revision=25]]
gui = Gui()
set_window(79,73)
buttons = {}
state = 0
a = 0.0
b = 0.0
op = nil
buffer = ""

function _init()
    for i=1,9,3 do
        for j=0,2 do
            add(buttons, gui:attach_button({label=tostr(i+j),x=j*16,y=(abs(i-9)/3)*14+8,bgcol=0x0d01,fgcol=0x070d,tap=function()add_buf(i+j)end}))
        end
    end
    add(buttons, gui:attach_button({label="0",x=0,y=59,bgcol=0x0d01,fgcol=0x070d,tap=function()add_buf(0)end}))
    add(buttons, gui:attach_button({label=".",x=16,y=59,bgcol=0x0d01,fgcol=0x070d,tap=function()add_buf(".")end}))
    add(buttons, gui:attach_button({label="=",x=32,y=59,bgcol=0x0902,fgcol=0x0209,tap=function()eval()end}))
    add(buttons, gui:attach_button({label="+",x=48,y=17,bgcol=0x0b03,fgcol=0x030b,tap=function()set_op("+")end}))
    add(buttons, gui:attach_button({label="-",x=48,y=31,bgcol=0x0b03,fgcol=0x030b,tap=function()set_op("-")end}))
    add(buttons, gui:attach_button({label="*",x=48,y=45,bgcol=0x0b03,fgcol=0x030b,tap=function()set_op("*")end}))
    add(buttons, gui:attach_button({label="/",x=48,y=59,bgcol=0x0b03,fgcol=0x030b,tap=function()set_op("/")end}))
    add(buttons, gui:attach_button({label="c",x=64,y=17,bgcol=0x0902,fgcol=0x0209,tap=function()clear()end}))
    add(buttons, gui:attach_button({label="^",x=64,y=31,bgcol=0x0b03,fgcol=0x030b,tap=function()set_op("^")end}))
    add(buttons, gui:attach_button({label="%",x=64,y=45,bgcol=0x0b03,fgcol=0x030b,tap=function()set_op("%")end}))
    add(buttons, gui:attach_button({label="_",x=64,y=59,bgcol=0x0d01,fgcol=0x070d,tap=function()inv()end}))
end

function _draw()
    gui:update_all()
    cls(n)
    if state==-1 then
        ?"err",1,4,7
    else
        ?buffer,1,4,7
    end
    gui:draw_all()
end

function inv()
	buffer = tostr(buffer)
	if sub(buffer,1,1) != "-" then
		buffer = "-"..buffer
	else
		buffer = sub(buffer, 2)
	end
end

function add_buf(n)
    if(state==-1)state=0
    buffer = buffer..n
    if(#buffer>15)buffer=sub(buffer,1,15)
end

function set_op(n)
    if(state==-1)state=0
    if state == 0 then
        a = buffer
        buffer = ""
        op = n
        state = 1
    else
        state = -1
    end
end

function eval()
    if state == 1 then
        b = buffer
        buffer = ""
        if op == "+" then
            buffer = a + b
        elseif op == "-" then
            buffer = a - b
        elseif op == "*" then
            buffer = a * b
        elseif op == "/" then
            buffer = a / b
        elseif op == "^" then
            buffer = a ^ b
        elseif op == "%" then
            buffer = a % b
        end
        state = 0
    end
end

function clear()
    if buffer == "" then
        op = nil
        a = 0.0
        b = 0.0
        state = 0
    else
        buffer = ""
    end
end