---
--- Created by fox.
--- DateTime: 2018/3/15 20:42
---
local class = require("node.class");

local Utils = require("node.core.Utils.Utils");

---@type Node
local Node = require("node.core.Display.Node");
local Message = require("node.core.Display.Message")
local Timer = require("node.core.Utils.Timer")

local UIEvent = require("node.core.Event.UIEvent");

local translate,pop,push = love.graphics.translate,love.graphics.pop,love.graphics.push

---@class Drawable : Node
local Drawable = class(Node);

---@param this Drawable
function Drawable.ctor(this)
    Node.ctor(this)
    this.transform = love.math.newTransform();

    this:setter("x",function (v)
        this._x = v;
        this:_calcTransform()
    end)
    this:getter("x",function ()
        return this._x or 0;
    end)

    this:setter("y",function (v)
        this._y = v;
        this:_calcTransform()
    end)

    this:getter("y",function ()
        return this._y or 0;
    end)

    this:setter("scaleX",function (v)
        this._scaleX = v or 1;
        this:_calcTransform()
    end)
    this:getter("scaleX",function ()
        return this._scaleX or 1;
    end)

    this:setter("scaleY",function (v)
        this._scaleY = v or 1;
        this:_calcTransform()
    end)
    this:getter("scaleY",function ()
        return this._scaleY or 1;
    end)

    this:setter("pivotX",function (v)
        this._pivotX = v;
        this:_calcTransform()
    end)
    this:getter("pivotX",function ()
        return this._pivotX or 1;
    end)

    this:setter("pivotY",function (v)
        this._pivotY = v;
        this:_calcTransform()
    end)
    this:getter("pivotY",function ()
        return this._pivotY or 0;
    end)

    this:setter("rotation",function (v)
        this._rotation = v;
        this:_calcTransform()
    end)
    this:getter("rotation",function ()
        return this._rotation or 0;
    end)

    this.zOrder = 0;
    this.x = 0;
    this.y = 0;
    this.scaleX = 1;
    this.scaleY = 1;
    this.pivotX = 0;
    this.pivotY = 0;

    --this.width = 0;
    --this.height = 0;
    this.alpha = 1;
    this.rotation = 0;
    this.visible = true;
    this.id =  Utils.getGID();

    this._width = nil
    this:setter("width", function (v)
        this._width = v;
        this.autoSize = false;
        this:_changeSize()
    end)
    this:getter("width", function ()
        return this._width or 0;
    end)

    this._height = nil
    this:setter("height", function (v)
        this._height = v;
        this.autoSize = false;
        this:_changeSize()
    end)
    this:getter("height", function ()
        return this._height or 0;
    end)


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
function Drawable.on(this,type,func,args)
    Message.on(this,type,func,args)
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
    Node.addChildAt(this,node,index)
    this.sortTabel = this.sortTabel or {}
    this.sortTabel[node] = this:numChild() + 1;
    if node.mouseEnabled then
        _mouseEnable(this);
    end
end
function Drawable.removeChildAt(this,node,index)
    Node.removeChildAt(this,node,index)
    if this.sortTabel then
        this.sortTabel[node] = nil
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
    local parent = this;
    while parent do
        x = x  * parent.scaleX + (parent.x - parent.pivotX)
        y = y + parent.y - parent.pivotY
        parent = parent.parent;
    end
    return x,y;
end

---@param this Drawable
---@param x number
---@param y number
function Drawable.globalToLocal(this,x,y)
    return x,y;
end
---@param a Drawable
---@param b Drawable
local function _sort(a,b)
    local this = a.parent;
    if a.zOrder == b.zOrder then
        return this.sortTabel[a] < this.sortTabel[b];
    end
    return a.zOrder < b.zOrder;
end

---@protected
---@param this Drawable
---@return Drawable
function Drawable._render(this,graphics)
    if not this.visible or this.destroyed or this.alpha == 0 or this.scaleY ==0 or this.scaleX == 0 then    -- 已经不会显示出来了
        return this;
    end
    local r,g,b,a = this:_push()
    if this._draw then
        this._draw(this,graphics);
    end
    table.sort(this.components,_sort)
    this:_renderChildren(graphics);
    return this:_pop(r,g,b,a)
end

---@protected
---@param graphics graphics
function Drawable._renderChildren(this,graphics)
    translate(-this.pivotX,-this.pivotY);
    for _,drawable in ipairs(this.components) do
        if drawable._render then 
            drawable:_render(graphics)
        end
    end
end

---@protected
function Drawable._push(this)
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(r,g,b,this.alpha * a)
    push()
    love.graphics.applyTransform(this.transform);
    return r,g,b,a;
end

---@protected
---@return Drawable
function Drawable._pop(this,r,g,b,a)
    love.graphics.setColor(r,g,b,a)
    pop()
    return this;
end

---@protected
---@param graphics graphics
function Drawable:_draw(graphics)
end

---@protected
---@param this Drawable
function Drawable._calcTransform(this)
    Timer:callLater(this,function (this)
        this.transform:reset();
        this.transform:translate(this.x,this.y);
        this.transform:rotate(math.rad(this.rotation));
        this.transform:scale(this.scaleX,this.scaleY);
        -- this.transform:translate(-this.pivotX,-this.pivotY);
    end,this)
end

---@protected
---@param this Drawable
function Drawable._changeSize(this)
    this:event(UIEvent.RESIZE)
end

return Drawable;