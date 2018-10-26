---
--- Created by fox.
--- DateTime: 2018/3/20 21:09
---
local class = require("node.class");
local Constant = require("node.core.Utils.Constant")

---@type Drawable
local Drawable = require("node.core.Display.Drawable")

local setShader = love.graphics.setShader

---@class Component : Drawable
---@field anchorX number
---@field anchorY number
---@field measureWidth number
---@field measureHeight number
---@field displayWidth number
---@field displayHeight number
---@field dataSource table
local Component = class(Drawable);

---@param this Component
function Component.ctor(this)
    --this:super()
    Drawable.ctor(this)
    --[[
        使用以下属性将会无视 pivotX,pivotY
    --]]
    this._anchorX = nil
    this._anchorY = nil

    this:setter("anchorX",function (v)
        if v ~= this._anchorX then
            this._anchorX = v;
            this:_onResize();
        end
    end)
    this:getter("anchorX",function ()
        return this._anchorX or 0;
    end)

    this:setter("anchorY",function (v)
        if this._anchorY ~= v then
            this._anchorY = v;
            this:_onResize();
        end
    end)
    this:getter("anchorY",function ()
        return this._anchorY or 0;
    end)

    --[[
       使用以下属性将会无视 scalexX、scaleY、x、width、height、anchorX、anchorY、pivotX,pivotY
   --]]
    this.top = nil;
    this.bottom = nil;
    this.left = nil;
    this.right = nil;

    this:setter("top",function (v)
        this._top = v;
        this:_onResize()
    end)
    this:getter("top",function ()
        return this._top;
    end)

    this._width = nil;
    this:setter("width",function (v)
        if v ~= this._width then
            this._width = v;
            this:_onResize()
        end
    end)

    this:getter("width",function ()
        if this._width then return this._width end;
        return this.measureWidth
    end)

    this._height = nil;
    this:setter("height",function (v)
        if v ~= this._height then
            this._height = v;
            this:_onResize()
        end
    end)

    this:getter("height",function ()
        if this._height then return this._height end;
        return this.measureHeight;
    end)


    this._scaleX = 1;
    this:setter("scaleX",function (v)
        this._scaleX = v;
        this:_onResize()
    end)

    this:getter("scaleX",function ()
        return this._scaleX;
    end)

    this._scaleY = 1;
    this:setter("scaleY",function (v)
        this._scaleY = v;
        this:_onResize()
    end)

    this:getter("scaleY",function ()
        return this._scaleY;
    end)


    this.tag = nil;
    this.gray = false;
    this.disabled = false;
    this.dataSource = nil;

    -- [[ 自动根据自身或者子组件来制定自身的范围 --]]
    this.autoSize = true;

    this:getter("measureWidth",function ()
        local max = 0;
        for i=this:numChild(),1,-1 do
            ---@type Sprite
            local comp = this:getChildAt(i);
            if comp.visible then
                max = math.max(comp.x+comp.width*comp.scaleX,max);
            end
        end
        return max;
    end)

    this:getter("measureHeight",function ()
        local max = 0;
        for i=this:numChild(),1,-1 do
            ---@type Sprite
            local comp = this:getChildAt(i);
            if comp.visible then
                max = math.max(comp.y+comp.height*comp.scaleY,max);
            end
        end
        return max;
    end)


    this:getter("displayWidth",function ()
        return this.width * this.scaleX;
    end)
    this:getter("displayHeight",function ()
        return this.height * this.scaleY;
    end)

end

---@param this Component
---@param node Component
---@param index number
function Component.addChildAt(this, node, index)
    Drawable.addChildAt(this,node,index)
    if node._repaintChilds then
        node:_repaintChilds()
    end
    return this;
end


---@param this Component
function Component._onResize(this)
    if this._anchorX ~= nil then
        this.pivotX = this.width * (this._anchorX or 0);
    end
    if this._anchorY ~= nil then
        this.pivotY = this.height * (this._anchorY or 0);
    end

    if this.parent then
        if this.left ~= nil then
            this.x = this.left + this.pivotX;
        end
        if this.top ~= nil then
            this.y =  this.top + this.pivotY;
        end
        if this.right ~= nil then
            this.width = this.parent.width - (this.x-this.pivotX) - this.right;
        end
        if this.bottom ~= nil then
            this.height = this.parent.height - (this.y-this.pivotY) - this.bottom;
        end
    end

end

---@private
function Component:_push(...)
    if self.gray or self.disabled then
        setShader(Constant.grayShader)
    end
    return Drawable._push(self,...);
end

---@private
function Component:_pop(...)
    Drawable._pop(self,...);
    if self.gray or self.disabled then
        setShader()
    end
    return self;
end

---@private
---@param this Component
function Component._repaintChilds(this)
    this:_onResize()
    for _, dw in ipairs(this.components) do
        if dw._repaintChilds then
            dw:_repaintChilds()
        end
    end
end

---@param this Component
---@protected
---@return Component
function Component.createChildren(this,...)
end
---@param this Component
---@protected
---@return Component
function Component.initialize(this,...)
end

---@param x number
---@param y number
---@return Component
function Component:anchor(x,y)
    self.anchorX = x;
    self.anchorY = y;
    return Component;
end
return Component;
