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

local translate, pop, push, newTransform = love.graphics.translate, love.graphics.pop, love.graphics.push, love.math.newTransform
local gr = love.graphics

---@param a Drawable
---@param b Drawable
local function _sort(a, b)
    local this = a.parent;
    if a.zOrder == b.zOrder then
        return this.sortTabel[a] < this.sortTabel[b];
    end
    return a.zOrder < b.zOrder;
end


---@type Drawable[]
local renderLine = {}

---@class Drawable : Node
---@field displayedInStage boolean @readonly
---@field protected _draw:fun()
---@field zOrder number
---@field parent Drawable
local Drawable = class(Node);

---@param this Drawable
function Drawable.ctor(this)
    Node.ctor(this)
    this.transform = newTransform();

    this:setter("x", function(v)
        this._x = v;
        this:_calcTransform()
    end)
    this:getter("x", function()
        return this._x or 0;
    end)

    this:setter("y", function(v)
        this._y = v;
        this:_calcTransform()
    end)

    this:getter("y", function()
        return this._y or 0;
    end)

    this:setter("scaleX", function(v)
        this._scaleX = v or 1;
        this:_calcTransform()
    end)
    this:getter("scaleX", function()
        return this._scaleX or 1;
    end)

    this:setter("scaleY", function(v)
        this._scaleY = v or 1;
        this:_calcTransform()
    end)
    this:getter("scaleY", function()
        return this._scaleY or 1;
    end)

    this:setter("pivotX", function(v)
        this._pivotX = v;
        this:_calcTransform()
    end)
    this:getter("pivotX", function()
        return this._pivotX or 1;
    end)

    this:setter("pivotY", function(v)
        this._pivotY = v;
        this:_calcTransform()
    end)
    this:getter("pivotY", function()
        return this._pivotY or 0;
    end)

    this:setter("rotation", function(v)
        this._rotation = v;
        this:_calcTransform()
    end)
    this:getter("rotation", function()
        return this._rotation or 0;

    end)

    this.x = 0;
    this.y = 0;
    this.scaleX = 1;
    this.scaleY = 1;
    this.pivotX = 0;
    this.pivotY = 0;
    this.blendMode = "";

    --this.width = 0;
    --this.height = 0;
    this.alpha = 1;
    this.rotation = 0;
    this.visible = true;
    this._gid = Utils.getGID();

    ---@protected
    this._canvas = nil;
    ---@protected
    this.renderArea = nil;

    this._zOrder = 0;
    this:setter("zOrder", function(v)
        if this._zOrder ~= v then
            this._zOrder = v;
            if this.parent then
                Timer:callLater(this.parent, this.parent.zOrderSort)
            end
        end
    end)
    this:getter("zOrder", function()
        return this._zOrder or 0;
    end)


    this._width = nil
    this:setter("width", function(v)
        this._width = v;
        this.autoSize = false;
        this:_changeSize()
    end)
    this:getter("width", function()
        return this._width or 0;
    end)

    this._height = nil
    this:setter("height", function(v)
        this._height = v;
        this.autoSize = false;
        this:_changeSize()
    end)
    this:getter("height", function()
        return this._height or 0;
    end)


    this:getter("displayedInStage", function()
        local node = this;
        while node do
            if not node.visible or not node.parent then
                break
            end
            node = node.parent;
        end
        return node._gid == 1 and node.visible;
    end)
    this.mouseEnabled = false;
    this.mouseThrough = false;

end

---@param node Drawable
local function _mouseEnable(node)
    local parent = node
    while parent do
        -- 开启全部父节点可以点击
        parent.mouseEnabled = true;
        parent = parent.parent
    end
end

---@param this Drawable
---@param type string
function Drawable.on(this, type, func, args)
    Message.on(this, type, func, args)
    if UIEvent.isMouseEvent(type) then
        _mouseEnable(this);
    end
    return this
end

---@param this Drawable
---@param node Drawable
---@param index number
---@return Node
function Drawable.addChildAt(this, node, index)
    Node.addChildAt(this, node, index)
    this.sortTabel = this.sortTabel or {}
    this.sortTabel[node] = Utils.getGID();    --this:numChild() + 1
    if node.mouseEnabled then
        _mouseEnable(this);
    end
    this:zOrderSort()
end
function Drawable.removeChildAt(this, node, index)
    Node.removeChildAt(this, node, index)
    if this.sortTabel then
        this.sortTabel[node] = nil
    end
end

---@public
function Drawable:zOrderSort()
    table.sort(self.components, _sort);
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
function Drawable.pos(this, x, y)
    this.x, this.y = x, y;
    return this;
end

---@param this Drawable
---@param x number
---@param y number
---@return Drawable
function Drawable.scale(this, x, y)
    this.scaleX, this.scaleY = x, y;
    return this;
end

---@param this Drawable
---@param x number
---@param y number
---@return Drawable
function Drawable.pivot(this, x, y)
    this.pivotX, this.pivotY = x, y;
    return this;
end

---@param this Drawable
---@param w number
---@param h number
---@return Drawable
function Drawable.size(this, w, h)
    this.width, this.height = w, h;
    return this;
end

---@protected
function Drawable:_addToRenderLine()
    self.renderArea = true;
    for _, dw in ipairs(renderLine) do
        if dw == self then
            break;
        end
    end
    table.insert(renderLine, self);
end

---@protected
function Drawable:_removeForRenderLide()
    self.renderArea = false;
    for i = #renderLine, 1, -1 do
        if renderLine[i] == self then
            table.remove(renderLine, i);
        end
    end
end

---@protected
---@param graphics graphics
function Drawable:_renderRenderLine(graphics)
    for _, dw in ipairs(renderLine) do
        if dw.destroyed or not dw.visible or not dw.displayedInStage then
        else
            graphics.setCanvas(dw._canvas)
            graphics.clear()
            dw:_render(graphics)
        end
    end
    graphics.setCanvas()
end

---@protected
---@param graphics graphics
function Drawable:_render2(graphics)
    if self._canvas then
        graphics.draw(self._canvas, 0, 0);
    end
end

---@param this Drawable
---@param x number
---@param y number
function Drawable.localToGlobal(this, x, y)
    local parent = this;
    while parent do
        x = x * parent.scaleX + (parent.x - parent.pivotX)
        y = y + parent.y - parent.pivotY
        parent = parent.parent;
    end
    return x, y;
end

---@param this Drawable
---@param x number
---@param y number
function Drawable.globalToLocal(this, x, y)
    return x, y;
end

---@protected
---@param this Drawable
---@param graphics graphics
---@return Drawable
function Drawable._render(this, graphics)
    if not this.visible or this.destroyed or this.alpha == 0 or this._scaleY == 0 or this._scaleX == 0 then
        -- 已经不会显示出来了
        return this;
    end
    local r, g, b, a, blendMode = this:_push()

    if this._draw then
        this._draw(this, graphics);
    end
    this:_renderChildren(graphics);
    return this:_pop(r, g, b, a, blendMode)
end

---@protected
---@param graphics graphics
function Drawable._renderChildren(this, graphics)
    translate(-this.pivotX, -this.pivotY);
    for _, drawable in ipairs(this.components) do
        if drawable.renderArea then
            drawable:_render2(graphics)
        elseif drawable._render then
            drawable:_render(graphics)
        end
    end
end

---@protected
---@return number,number,number,number
function Drawable._push(this)
    local r, g, b, a = gr.getColor()
    gr.setColor(r, g, b, this.alpha * a)
    local blendMode
    if this.blendMode == "lighter" then
        blendMode = gr.getBlendMode();
        gr.setBlendMode("add")
    end
    push()
    gr.applyTransform(this.transform);
    return r, g, b, a, blendMode;
end

---@protected
---@return Drawable
function Drawable._pop(this, r, g, b, a, blendMode)
    gr.setColor(r, g, b, a)
    if blendMode then
        gr.setBlendMode(blendMode)
    end
    pop()
    return this;
end

-----@protected
-----@param graphics graphics
--function Drawable:_draw(graphics)
--end

---@protected
---@param dw Drawable
function Drawable._transform(this)
    this.transform:reset();
    this.transform:translate(this.x, this.y);
    this.transform:rotate(math.rad(this.rotation));
    this.transform:scale(this.scaleX, this.scaleY);
    -- this.transform:translate(-this.pivotX,-this.pivotY);
end

---@protected
---@param this Drawable
function Drawable._calcTransform(this)
    Timer:callLater(this, this._transform, this)
end

---@protected
---@param this Drawable
function Drawable._changeSize(this)
    this:event(UIEvent.RESIZE)
end

return Drawable;