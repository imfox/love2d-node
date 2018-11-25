local Class = require("Node.Core.Class");
local Node = require("Node.Core.Display.Node");
local Util = require("Node.Core.Utils.Utils");
local TouchEvent = require("Node.Core.Event.TouchEvent");

local gr = love.graphics
local translate, pop, push, applyTransform, newTransform = gr.translate, gr.pop, gr.push, gr.applyTransform, love.math.newTransform
local getColor, setColor = gr.getColor, gr.setColor
local setBlendMode, getBlendMode = gr.setBlendMode, gr.getBlendMode

---@param a Node_Core_Display_Drawable
---@param b Node_Core_Display_Drawable
local function _sort(a, b)
    local this = a.parent;
    if a.zOrder == b.zOrder then
        return this.sortTabel[a] < this.sortTabel[b];
    end
    return a.zOrder < b.zOrder;
end

---@class Node_Core_Display_Drawable : Node_Core_Display_Node
---@field parent Node_Core_Display_Drawable
---@field _childs Node_Core_Display_Drawable[]
---@field x number
---@field y number
---@field zOrder number
---@field pivotX number
---@field pivotY number
---@field width number
---@field height number
---@field rotation number
---@field scaleX number
---@field scaleY number
---@field blendMode string
---@field alpha number
---@field touchEnabled boolean
---@field touchThrough boolean
local c = Class(Node);

function c:ctor()
    Node.ctor(self);

    self._gid = Util.getGID();

    self.width = 0;
    self.height = 0;
    self.alpha = 1;
    self.blendMode = nil;
    self.transform = newTransform();

    self.pivotX = 0;
    self.pivotY = 0;

    self.visible = true;

    self:setter_getter("x", self.__setX, self.__getX);
    self:setter_getter("y", self.__setY, self.__getY);
    self:setter_getter("scaleX", self.__setScaleX, self.__getScaleX);
    self:setter_getter("scaleY", self.__setScaleY, self.__getScaleY);
    self:setter_getter("rotation", self.__setRotation, self.__getRotation);
    self:setter_getter("zOrder", self.__setZOrder, self.__getZOrder);

end

---@protected
function c:__setX(v)
    if self._x ~= v then
        self._x = v
        self:__calcTransfrom();
    end
end

---@protected
function c:__getX()
    return self._x or 0;
end

---@protected
function c:__setY(v)
    if self._y ~= v then
        self._y = v
        self:__calcTransfrom();
    end
end

---@protected
function c:__getY()
    return self._y or 0;
end

---@protected
function c:__setScaleX(v)
    if self._scaleX ~= v then
        self._scaleX = v
        self:__calcTransfrom();
    end
end

---@protected
function c:__getScaleX()
    return self._scaleX or 1;
end

---@protected
function c:__setScaleY(v)
    if self._scaleY ~= v then
        self._scaleY = v;
        self:__calcTransfrom();
    end
end

---@protected
function c:__getScaleY()
    return self._scaleY or 1;
end

---@protected
function c:__setRotation(v)
    if self._rotation ~= v then
        self._rotation = v;
        self:__calcTransfrom();
    end
end

---@protected
function c:__getRotation()
    return self._rotation or 0;
end

---@protected
function c:__setZOrder(v)
    if v ~= self._zOrder then
        self._zOrder = v;
        self:zOrderSort()
    end
end

---@protected
function c:__getZOrder()
    return self._zOrder or 0;
end

---@public
function c:zOrderSort()
    table.sort(self._childs, _sort);
end

---@protected
function c:__calcTransfrom()
    if self.transform then
        self.transform:reset();
        self.transform:translate(self._x or 0, self._y or 0);
        self.transform:rotate(math.rad(self.rotation or 0));
        self.transform:scale(self._scaleX or 1, self._scaleY or 1);
    end
end

---@protected
---@param bool boolean
function c:_mouseEnable(bool)
    local parent = self
    while parent do
        -- 开启全部父节点可以点击
        parent.touchEnabled = bool;
        parent = parent.parent
    end
end

---@overload
function c:on(type, func, caller, args)
    if TouchEvent.IsTouchEvent(type) then
        self:_mouseEnable(true);
    end
    return Node.on(self, type, func, caller, args);
end

---@overload
---@param node Node_Core_Display_Drawable
---@param index number
---@return Node_Core_Display_Drawable
function c:addChildAt(node, index)
    if node.__render then
        Node.addChildAt(self, node, index);
        self.sortTabel = self.sortTabel or {}
        self.sortTabel[node] = Util.getGID();    --this:numChild() + 1
        if node.touchEnabled then
            self:_mouseEnable(true);
        end
        self:zOrderSort();
    else
        print("error: 0x0010");
    end
    return self;
end

function c:removeChildAt(index)
    local node = Node.removeChildAt(self, index)
    if self.sortTabel then
        self.sortTabel[node] = nil;
    end
    return node;
end

---@protected
---@return Node_Core_Display_Drawable__RenderState
function c:__push()
    ---@type Node_Core_Display_Drawable__RenderState
    local state = {};
    state.r, state.g, state.b, state.alpha = getColor()
    state.blendMode = getBlendMode();
    if self.alpha < 1 then
        setColor(state.r, state.g, state.b, state.alpha * self.alpha);
    end
    if self.blendMode then
        setBlendMode(self.blendMode);
    end
    push()
    --if self.rotation % 360 ~= 0 and self._childs[1] then
    --end
    applyTransform(self.transform);
    return state;
end

---@protected
---@param state Node_Core_Display_Drawable__RenderState
---@return Node_Core_Display_Drawable
function c:__pop(state)
    if self.alpha < 1 then
        setColor(state.r, state.g, state.b, state.alpha);
    end
    if self.blendMode then
        setBlendMode(state.blendMode);
    end
    pop()
    return self;
end

---@protected
---@param gr graphics
---@return Node_Core_Display_Drawable
function c:__render(gr)
    if self.destroyed or not self.visible --[[ or self.alpha == 0 or self._scaleY == 0 or self._scaleX == 0 --]] then
        return self;
    end
    local state = self:__push()
    self:__draw(gr);
    self:__renderChildren(gr);
    return self:__pop(state)
end

---@protected
---@param gr graphics
function c:__draw(gr)
end

---@protected
---@param gr graphics
function c:__renderChildren(gr)
    --- 理论上比 self:numChild() > 0  快
    if self._childs[1] then
        translate(-self.pivotX, -self.pivotY);
        for _, d in ipairs(self._childs) do
            d:__render(gr)
        end
    end
end

---@param x1 number
---@param y1 number
---@return boolean @只需要检测原始宽高即可 缩放系数已经在 x,y 中处理
function c:hitTest(x1, y1)
    return x1 > 0 and y1 > 0 and x1 <= self.width and y1 <= self.height;
end

function c:destroy(destroyChild)
    Node.destroy(self, destroyChild);
end

---@param x number
---@param y number
---@return Node_Core_Display_Drawable
function c:pos(x, y)
    self.x, self.y = x, y;
    return self;
end

---@param x number
---@param y number
---@return Node_Core_Display_Drawable
function c:scale(x, y)
    self.scaleX, self.scaleY = x, y;
    return self;
end

---@param x number
---@param y number
---@return Node_Core_Display_Drawable
function c:pivot(x, y)
    self.pivotX, self.pivotY = x, y;
    return self;
end

---@param w number
---@param h number
---@return Node_Core_Display_Drawable
function c:size(w, h)
    self.width, self.height = w, h;
    return self;
end

---@param x number
---@param y number
function c:localToGlobal(x, y)
    x, y = self:localToParent(x, y)
    local p = self.parent
    if p then
        x, y = p:localToGlobal(x, y)
    end
    return x, y
end

---@param x number
---@param y number
function c:globalToLocal(x, y)
    local p = self.parent
    if p then
        x, y = p:globalToLocal(x, y)
    end
    return self:parentToLocal(x, y)
end

function c:parentToLocal(x, y)
    -- translate
    x = x - self.x
    y = y - self.y
    -- rotate
    local r = -math.rad(self.rotation)
    local c = math.cos(r)
    local s = math.sin(r)
    local rx = c * x - s * y
    local ry = s * x + c * y
    x, y = rx, ry
    -- scale
    x = x * self.scaleX
    y = y * self.scaleY
    return x, y
end

function c:localToParent(x, y)
    -- scale
    x = x / self.scaleX
    y = y / self.scaleY
    -- rotate
    local r = math.rad(self.rotation)
    local c = math.cos(r)
    local s = math.sin(r)
    local rx = c * x - s * y
    local ry = s * x + c * y
    x, y = rx, ry
    -- translate
    x = x + self.x
    y = y + self.y
    return x, y
end

return c;

---@class Node_Core_Display_Drawable__RenderState
---@field alpha number @0-1
---@field r number
---@field g number
---@field b number
---@field blendMode string
