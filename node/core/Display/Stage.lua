---
--- Created by fox.
--- DateTime: 2018/3/27 22:08
---
local class = require("node.class")

local Drawable = require("node.core.Display.Drawable");
local Utils = require("node.core.Utils.Utils");
local Math = require("node.core.Math.Math");
local UIEvent = require("node.core.Event.UIEvent");


---@param this Drawable
--local function drawRect(this,x,y,r,w,h,mouseX,mouseY) --这个方法是用来渲染出组件的包围盒的
--    local px,py,pr,pw,ph = (this.x-this.pivotX*this.scaleX)*w,(this.y-this.pivotY*this.scaleY)*h,r,((this.width)*this.scaleX)*w,((this.height)*this.scaleY)*h
--    love.graphics.rectangle("line",x+px,y+py,pw,ph)
--    if this:numChild() > 0 then
--        for i=1,this:numChild() do
--            ---@type Drawable
--            local node = this:getChildAt(i);
--            drawRect(node,x+px,y+py,this.rotation,this.scaleX*w,this.scaleY*h);
--        end
--    end
--
--end

---@param draw Drawable
---@param x number
---@param y number
---@return Drawable
local function HitObject(draw,x,y)
    if not draw.visible or draw.destroyed then
        return false
    end

    local nx,ny = x-draw.x,y-draw.y
    local tx,ty = Math.rotatePointByZero(nx,ny,-draw.rotation)

    local hit = false
    if(Utils.pointHitRect(tx,ty,-draw.pivotX*draw.scaleX,-draw.pivotY*draw.scaleY,draw.width*draw.scaleX,draw.height*draw.scaleY))then
        hit = draw
        for i = draw:numChild(),1,-1 do
            ---@type Drawable
            local child = draw:getChildAt(i);
            if child.visible and not child.destroyed and child.mouseEnabled then
                local h = HitObject(child,(tx+draw.pivotX*draw.scaleX)*(1/draw.scaleX),(ty+draw.pivotY*draw.scaleY)*(1/draw.scaleY))
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

    this.mouseX = 0;
    this.mouseY = 0;
end

---@param this stage
---@param type string
---@param x number
---@param y number
function stage.mouseEvent(this,type,x,y)
    this.mouseX,this.mouseY = x,y;
    local hit = HitObject(this,x,y)
    if hit and hit ~= Stage and hit.mouseEnabled then
        if type == UIEvent.MOUSE_DOWN then
            this.pressNode = hit;
        elseif type == UIEvent.MOUSE_UP then
            if this.pressNode == hit then
                hit:event(UIEvent.CLICK)
                this.pressNode = nil
            end
        elseif type == UIEvent.MOUSE_MOVE then
        end
        hit:event(type)
    end
    if this.pressNode and type == UIEvent.MOUSE_UP then
        this.pressNode:event(UIEvent.MOUSE_LEAVE_UP)
        this.pressNode = nil
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
    this:_render(love.graphics)
    local status = love.graphics.getStats()
    love.window.setTitle(string.format("fps:%d  images:%d  drawcalls:%d",love.timer.getFPS(),status.images,status.drawcalls))
    --drawRect(this,0,0,0,1,1,0,0);
end

Stage = stage.new();
return Stage;