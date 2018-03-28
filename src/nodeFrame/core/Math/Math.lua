---
--- Created by fox.
--- DateTime: 2018/3/28 21:02
---

local Math = {}
Math.PI = 3.1415926535898;

function Math.rotatePoint(ox,oy,x,y,r)
    r = math.rad(r)
    return (x - ox)*math.cos(r) - (y - oy)*math.sin(r) + ox,(x - ox)*math.sin(r) + (y - oy)*math.cos(r) + oy
end

function Math.rotatePointByZero(x,y,r)
    return Math.rotatePoint(0,0,x,y,r)
end


return Math