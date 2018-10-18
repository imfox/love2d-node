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

---@type stage
local Stage

---@class stage : Drawable
local stage = class(Drawable);

---@param this stage
function stage.ctor(this)
    Drawable.ctor(this)
    this.name = "Stage"

    this.mouseEnabled = true;

end

---@param this stage
---@param type string
function stage.keyboardEvent(this, type, key)
    this:event(type, { key })
    return this
end

---@param this stage
function stage.draw(this, graphics)
    this:_render(graphics)
end

Stage = stage.new();
return Stage;