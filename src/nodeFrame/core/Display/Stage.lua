---
--- Created by fox.
--- DateTime: 2018/3/27 22:08
---
local class = require("nodeFrame.class")

local Drawable = require("nodeFrame.core.Display.Drawable");

function PointHitRect(x1,y1,x0,y0,w0,h0)
    return x1 >= x0 and x1 <= x0 + w0 and y1>=y0 and y1 < y0 + h0
end


---@param draw Drawable
---@param x number
---@param y number
---@return Drawable
local function testPoint(draw,x,y)
    if not draw.visible or draw.destroyed or not draw.mouseEnabled then
        return false
    end

    local _x,_y ,_w,_h= 0,0,0,0
    _x = draw.x - draw.pivotX
    _y = draw.y - draw.pivotY
    _w = draw.width * draw.scaleX
    _h = draw.height * draw.scaleY

    local hit = false
    if(PointHitRect(x,y,_x,_y ,_w,_h))then
        hit = draw
        if draw.components then
            for i = draw:numChild(),1,-1 do
                local child = draw:getChildAt(i);
                local h = testPoint(child,x - _x,y - _y)
                if h then
                    hit = h
                    break
                end
            end
        end
    end
    return hit
end

---@class stage : Drawable
local stage = class(Drawable);

---@param this stage
function stage.ctor(this)
    this:super()
    this.name = "Stage"

    ---@type Node
    local pressNode

    local function mouseEvent(type,x,y)
        local hit = testPoint(this,x,y)

        if hit then
            if type == "MOUSE_DOWN" then
                pressNode = hit
            end
            hit:event(type)
            if type == "MOUSE_UP" then
                if pressNode == hit then
                    hit:event("CLICK")
                end
            end
        end
    end

    --this:on("MOUSE_MOVE",mouseEvent)
    this:on("MOUSE_DOWN",mouseEvent)
    this:on("MOUSE_UP",mouseEvent)

end


---@param this stage
function stage.draw(this)
    this:_render()
end


function stage:TestPoint(x,y)

end

return stage;