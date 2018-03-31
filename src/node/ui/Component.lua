---
--- Created by fox.
--- DateTime: 2018/3/20 21:09
---
local class = require("node.class");

local Box = require("node.ui.Box")

---@class Component : Box
---@field anchorX number
---@field anchorY number
local Component = class(Box);

---@param this Component
function Component.ctor(this)
    this:super()
    --[[
        使用以下属性将会无视 pivotX,pivotY
    --]]
    this._anchorX = nil
    this._anchorY = nil

    this:set("anchorX",function (v)
        this._anchorX = v;
        this:_repaint();
    end)
    this:get("anchorX",function (v)
        return this._anchorX;
    end)
    this:set("anchorY",function (v)
        this._anchorY = v;
        this:_repaint();
    end)
    this:get("anchorY",function (v)
        return this._anchorY;
    end)

    --[[
       使用以下属性将会无视 scalexX、scaleY、x、width、height、anchorX、anchorY、pivotX,pivotY
   --]]
    this.top = nil;
    this.bottom = nil;
    this.left = nil;
    this.right = nil;


    this.tag = nil;
    this.gray = false;
    this.disabled = false;

    -- [[ 自动根据自身或者子组件来制定自身的范围 --]]
    this.autoSize = true;

end

---@param this Component
function Component._repaint(this)
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

-- 应该由子组件完成
---@param this Component
function Component.displayHeight(this)
    return this.height;
end

---@param this Component
function Component.displayWidth(this)
    return this.width;
end

return Component;
