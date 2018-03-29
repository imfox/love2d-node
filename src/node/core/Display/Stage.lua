---
--- Created by fox.
--- DateTime: 2018/3/27 22:08
---
local class = require("node.class")

local Drawable = require("node.core.Display.Drawable");
local Utils = require("node.core.Utils.Utils");
local Math = require("node.core.Math.Math")

---@param draw Drawable
---@param x number
---@param y number
---@return Drawable
local function HitObject(draw,x,y)
    if not draw.visible or draw.destroyed or not draw.mouseEnabled then
        return false
    end

    local nx,ny = x-draw.x,y-draw.y
    local tx,ty = Math.rotatePointByZero(nx,ny,-draw.rotation)

    local hit = false
    if(Utils.pointHitRect(tx,ty,-draw.pivotX,-draw.pivotY,draw.width,draw.height))then
        hit = draw
        if draw.components then
            for i = draw:numChild(),1,-1 do
                local child = draw:getChildAt(i);
                local h = HitObject(child,tx,ty)
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
        local hit = HitObject(this,x,y)
        if hit and hit.name ~= "Stage" then
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