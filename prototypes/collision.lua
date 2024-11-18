--[[pod_format="raw",created="2024-09-22 08:38:44",modified="2024-09-22 09:10:57",revision=1]]
-- per-pixel collision
-- by @freds72
function make_bitmask(sx,sy,sw,sh,tc)
    assert(flr(sw/32)<=1,"32+pixels wide sprites not yet supported")
    tc=tc or 0
    local bitmask={}
    for j=0,sh-1 do
  local bits,mask=0,0x1000.0000
  for i=0,sw-1 do
         local c=sget(sx+i,sy+j)
   if(c!=tc) bits=bor(bits,lshr(mask,i))  
  end
  bitmask[j]=bits
 end
 return bitmask
end

function draw_bitmask(bits,x,y,c)
 color(c)
 local ix=32*flr(x/32)
 for j,b in pairs(bits) do
  -- shift to x
     b=lshr(b,x%32)
     for i=0,31 do
         if(band(lshr(0x1000,i),b)!=0) pset(ix+i,y+j,c)
  end
 end
end

function intersect_bitmasks(a,b,x,ymin,ymax)
    local by=flr(a.y)-flr(b.y)
    for y=ymin,ymax do
     -- out of boud b mask returns nil
     -- nil is evaluated as zero :]
        if(band(a.mask[y],lshr(b.mask[by+y],x))!=0) return true       
    end
end

local plyr={
    mask=make_bitmask(0,0,16,16,5),
    x=64,
    y=64,
    w=16,
    h=16
}

local enmy={
    mask=make_bitmask(16,0,8,8),
    x=64,
    y=64,
    w=8,
    h=8
}
local actors={plyr,enmy}

function collide(a,b)
    -- a is left most
    if(a.x>b.x) a,b=b,a
    -- screen coords
    local ax,ay,bx,by=flr(a.x),flr(a.y),flr(b.x),flr(b.y)
    local xmax,ymax=bx+b.w,by+b.h
    if ax<xmax and 
     ax+a.w>bx and
     ay<ymax and
     ay+a.w>by then
     -- collision coords in a space
     return true,a,b,bx-ax,max(by-ay),min(by+b.h,ay+a.h)-ay
    end
end