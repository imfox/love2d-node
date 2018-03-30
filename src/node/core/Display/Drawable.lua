---
--- Created by fox.
--- DateTime: 2018/3/15 20:42
---
local class = require("node.class");

local Utils = require("node.core.Utils.Utils");

---@type Node
local Node = require("node.core.Display.Node");

---@type Graphics
local Graphics = require("node.core.Display.Graphics");
local UIEvent = require("node.core.Event.UIEvent");


---@class Drawable : Node
local Drawable = class(Node);

---@param this Drawable
function Drawable.ctor(this)
    this:super()
    this.x = 0;
    this.y = 0;
    this.scaleX = 1;
    this.scaleY = 1;
    this.pivotX = 0;
    this.pivotY = 0;
    this.width = 0;
    this.height = 0;
    this.alpha = 1;
    this.rotation = 0;
    this.visible = true;
    this.graphics = Graphics.new();
    this.id =  Utils.getGID();

    this.mouseEnabled = false;
end

---@param node Drawable
function _mouseEnable(node)
    local parent = node
    while parent do -- 开启全部父节点可以点击
        parent.mouseEnabled = true;
        parent = parent.parent
    end
end

---@param this Drawable
---@param type string
function Drawable.on(this,type,...)
    this:call("on",type,...)
    if UIEvent.isMouseEvent(type) then
        _mouseEnable(this);
    end
    return this
end

---@param this Drawable
---@param node Drawable
---@param index number
---@return Node
function Drawable.addChildAt(this,node,index)
    this:call("addChildAt",node,index)
    if node.mouseEnabled then
        _mouseEnable(this);
    end
end


---@field public x number
---@field public y number
---@field public width number
---@field public height number
---@field public pivotX number
---@field public pivotY number
---@field public scaleX number
---@field public scaleY number
---@field public alpha number
---@field public rotation number
---@field public visible boolean
---@field public graphics Graphics

---@param this Drawable
---@param x number
---@param y number
---@return Drawable
function Drawable.pos(this,x,y)
    this.x,this.y = x,y;
    return this;
end

---@param this Drawable
---@param x number
---@param y number
---@return Drawable
function Drawable.scale(this,x,y)
    this.scaleX,this.scaleY = x,y;
    return this;
end

---@param this Drawable
---@param x number
---@param y number
---@return Drawable
function Drawable.pivot(this,x,y)
    this.pivotX,this.pivotY = x,y;
    return this;
end

---@param this Drawable
---@param w number
---@param h number
---@return Drawable
function Drawable.size(this,w,h)
    this.width,this.height = w,h;
    return this;
end


---@param this Drawable
---@param x number
---@param y number
function Drawable.localToGlobal(this,x,y)
    return x,y;
end

---@param this Drawable
---@param x number
---@param y number
function Drawable.globalToLocal(this,x,y)
    return x,y;
end

---@param this Drawable
---@return Drawable
function Drawable._render(this)
    if not this.visible or this.destroyed or this.alpha == 0 or this.scaleY ==0 or this.scaleX == 0 then    -- 已经不会显示出来了
        return this;
    end
    this.graphics:_begin(this.x,this.y,this.rotation,this.scaleX,this.scaleY):_render();
    for _,drawable in ipairs(this.components) do 
        if drawable._render then 
            drawable:_render()
        end
    end
    this.graphics:_end();
    return this;
end

return Drawable;