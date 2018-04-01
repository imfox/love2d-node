---
--- Created by fox.
--- DateTime: 2018/3/27 22:08
---
local class = require("node.class")

local Drawable = require("node.core.Display.Drawable");
local Utils = require("node.core.Utils.Utils");
local Math = require("node.core.Math.Math");
local UIEvent = require("node.core.Event.UIEvent");

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


---@type stage
local Stage

---@class stage : Drawable
local stage = class(Drawable);

---@param this stage
function stage.ctor(this)
    Drawable.ctor(this)
    this.name = "Stage"

    ---@type Node
    this.pressNode = nil
    this.mouseEnabled = true;
end

---@param this stage
---@param type string
---@param x number
---@param y number
function stage.mouseEvent(this,type,x,y)
    local hit = HitObject(this,x,y)
    if hit and hit ~= Stage then
        if type == UIEvent.MOUSE_DOWN then
            this.pressNode = hit
        end
        hit:event(type)
        if type == UIEvent.MOUSE_UP then
            if this.pressNode == hit then
                hit:event(UIEvent.CLICK)
            else
                this.pressNode:event(UIEvent.MOUSE_LEAVE_UP)
            end
        end
    end
    return this
end

---@param this stage
---@param type string
function stage.keyboardEvent(this,type,key)
    this:event(type,{key})
    return this
end

---@param this stage
function stage.draw(this)
    this:_render()
    local status = love.graphics.getStats()
    love.window.setTitle(string.format("fps:%d  images:%d  drawcalls:%d",love.timer.getFPS(),status.images,status.drawcalls))
end

Stage = stage.new();
return Stage;