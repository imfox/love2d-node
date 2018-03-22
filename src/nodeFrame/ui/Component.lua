---
--- Created by fox.
--- DateTime: 2018/3/20 21:09
---

---@type Loader
local Loader = require("nodeFrame.core.Net.Loader");

local class = require("nodeFrame.class");

---@type AutoBitmap
local AutoBitmap = require("nodeFrame.ui.AutoBitmap")

---@type Drawable
local Drawable = require("nodeFrame.core.Display.Drawable")


---@class Component : Drawable
local Component = class(Drawable);

---@param this Component
function Component.ctor(this)
    --[[
        以下的属性需要优先于 pivotX,pivotY,x,y,width,height ,但是仍需计算出相对的值 以便用户的操作
    --]]
    this.anchorX = 0;
    this.anchorY = 0;
    this.top = 0;
    this.bottom = 0;
    this.left = 0;
    this.right = 0;


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
