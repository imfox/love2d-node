local class = require("Node.Core.Class");
local Drawable = require("Node.Core.Display.Drawable");
local Constant = require("Node.Laya.Utils.Constant");

local setShader = love.graphics.setShader

---@class Component : Node_Core_Display_Drawable
---@field anchorX number
---@field anchorY number
---@field measureWidth number
---@field measureHeight number
---@field displayWidth number
---@field displayHeight number
---@field dataSource table
local Component = class(Drawable);

function Component:ctor()
    Drawable.ctor(self)
    ----- 使用以下属性将会无视 pivotX,pivotY
    self._anchorX = nil;
    self._anchorY = nil;

    self:setter_getter("anchorX", self.__setAnchorX, self.__getAnchorX);
    self:setter_getter("anchorY", self.__setAnchorY, self.__getAnchorY);
    ---- 使用以下属性将会无视 scaleX、scaleY、x、width、height、anchorX、anchorY、pivotX,pivotY
    self.top = nil;
    self.left = nil;
    self.right = nil;
    self.bottom = nil;

    self:setter_getter("top", self.__setTop, self.__getTop);
    ------
    self:setter("scaleX", self.__setScaleX);
    self:setter("scaleY", self.__setScaleY);

    self._width = nil;
    self._height = nil;
    self:setter_getter("width", self.__setWidth, self.__getWidth);
    self:setter_getter("height", self.__setHeight, self.__getHeight);

    self.tag = nil;
    self.gray = false;
    self.disabled = false;

    ---@protected
    self._dataSource = Component.dataSource;
    self:setter_getter("dataSource", self.__setDataSource, self.__getDataSource);

    -- [[ 自动根据自身或者子组件来制定自身的范围 --]]
    self.autoSize = true;
    self:getter("measureWidth", self.__getMeasureWidth);
    self:getter("measureHeight", self.__getMeasureHeight);
    self:getter("displayWidth", self.__getDisplayWidth);
    self:getter("displayHeight", self.__getDisplayHeight);

    self:setter_getter("mouseEnabled", self.__setMouseEnabled, self.__getMouseEnabled);
    self:setter_getter("mouseThrough", self.__setMouseThrough, self.__getMouseThrough);
end

---@private
function Component:__setMouseEnabled(v)
    self.touchEnabled = not (not v);
end
---@private
function Component:__getMouseEnabled()
    return self.touchEnabled;
end

---@private
function Component:__setMouseThrough(v)
    self.touchThrough = not (not v);
end
---@private
function Component:__getMouseThrough()
    return self.touchThrough;
end

---@protected
function Component:__setWidth(v)
    if v ~= self._width then
        self._width = v;
        self:_onResize()
    end
end
---@protected
function Component:__getWidth()
    if self._width then
        return self._width
    end
    return self.measureWidth
end
---@protected
function Component:__setHeight(v)
    if v ~= self._height then
        self._height = v;
        self:_onResize()
    end
end
---@protected
function Component:__getHeight()
    if self._height then
        return self._height
    end
    return self.measureHeight;
end
---@protected
function Component:__getDisplayWidth()
    return self.width * self.scaleX;
end
---@protected
function Component:__getDisplayHeight()
    return self.height * self.scaleY;
end
---@protected
function Component:__setAnchorX(v)
    if v ~= self._anchorX then
        self._anchorX = v;
        self:_onResize();
    end
end
---@protected
function Component:__getAnchorX()
    return self._anchorX or 0;
end
---@protected
function Component:__setAnchorY(v)
    if v ~= self._anchorY then
        self._anchorY = v;
        self:_onResize();
    end
end
---@protected
function Component:__getAnchorY()
    return self._anchorY or 0;
end
---@protected
function Component:__setTop(v)
    if v ~= self._top then
        self._top = v;
        self:_onResize();
    end
end
---@protected
function Component:__getTop()
    return self._top;
end
---@protected
function Component:__setScaleX(v)
    Drawable.__setScaleX(self, v);
    self:_onResize();
end
---@protected
function Component:__setScaleY(v)
    Drawable.__setScaleY(self, v);
    self:_onResize();
end
---@protected
function Component:__setDataSource(d)
    if d and type(d) == "table" then
        for k, v in pairs(d) do
            if type(self[k]) == "table" then
                self[k].dataSource = v;
            else
                self[k] = v;
            end
        end
    end
    self._dataSource = d;
end
---@protected
function Component:__getDataSource()
    return self._dataSource;
end
---@protected
function Component:__getMeasureWidth()
    local max = 0;
    for i = self:numChild(), 1, -1 do
        ---@type Node_Core_Display_Drawable
        local comp = self:getChildAt(i);
        if comp.visible then
            max = math.max(comp.x + comp.width * comp.scaleX, max);
        end
    end
    return max;
end
---@protected
function Component:__getMeasureHeight()
    local max = 0;
    for i = self:numChild(), 1, -1 do
        ---@type Node_Core_Display_Drawable
        local comp = self:getChildAt(i);
        if comp.visible then
            max = math.max(comp.y + comp.height * comp.scaleY, max);
        end
    end
    return max;
end

---@param this Component
---@param node Component
---@param index number
function Component.addChildAt(this, node, index)
    Drawable.addChildAt(this, node, index)
    if node._repaintChilds then
        node:_repaintChilds()
    end
    return this;
end

---@protected
function Component:_onResize()
    if self._anchorX ~= nil then
        self.pivotX = self.width * (self._anchorX or 0);
    end
    if self._anchorY ~= nil then
        self.pivotY = self.height * (self._anchorY or 0);
    end

    if self.parent then
        if self.left ~= nil then
            self.x = self.left + self.pivotX;
        end
        if self.top ~= nil then
            self.y = self.top + self.pivotY;
        end
        if self.right ~= nil then
            self.width = self.parent.width - (self.x - self.pivotX) - self.right;
        end
        if self.bottom ~= nil then
            self.height = self.parent.height - (self.y - self.pivotY) - self.bottom;
        end
    end

end

---@protected
function Component:__push()
    if self.gray or self.disabled then
        setShader(Constant.grayShader)
    end
    return Drawable.__push(self);
end

---@protected
function Component:__pop(state)
    Drawable.__pop(self, state);
    if self.gray or self.disabled then
        setShader()
    end
    return self;
end

---@private
---@param this Component
function Component._repaintChilds(this)
    this:_onResize()
    for _, dw in ipairs(this._childs) do
        if dw._repaintChilds then
            dw:_repaintChilds()
        end
    end
end

---@param this Component
---@protected
---@return Component
function Component.createChildren(this, ...)
end
---@param this Component
---@protected
---@return Component
function Component.initialize(this, ...)
end

---@param x number
---@param y number
---@return Component
function Component:anchor(x, y)
    self.anchorX = x;
    self.anchorY = y;
    return self;
end

return Component;
