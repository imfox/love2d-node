---
--- Created by fox.
--- DateTime: 2018/3/20 21:09
---
local class = require("node.class");

local Box = require("node.ui.Box")

---@class Component : Box
local Component = class(Box);

---@param this Component
function Component.ctor(this)
    this:super()
    --[[
        使用以下属性将会无视 pivotX,pivotY
    --]]
    this.anchorX = 0;
    this.anchorY = 0;

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
