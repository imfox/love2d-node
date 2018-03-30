---
--- Created by fox.
--- DateTime: 2018/3/30 20:30
---

local class = require("node.class");

---@type Drawable
local Drawable = require("node.core.Display.Drawable")

---@class Box : Drawable
local Box = class(Drawable);

---@param this Box
function Box.ctor(this)
    this:super()

    --@type table
    this.dataSource = nil;

end

return Box;
