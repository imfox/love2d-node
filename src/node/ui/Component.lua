---
--- Created by fox.
--- DateTime: 2018/3/20 21:09
---

---@type Loader
local Loader = require("node.core.Net.Loader");

local class = require("node.class");

---@type AutoBitmap
local AutoBitmap = require("node.ui.AutoBitmap")

---@type Drawable
local Drawable = require("node.core.Display.Drawable")


---@class Component : Drawable
local Component = class(Drawable);

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
    this.dataSource = nil;

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


return Component;
