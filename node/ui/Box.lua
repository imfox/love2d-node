---
--- Created by fox.
--- DateTime: 2018/3/30 20:30
---

local class = require("node.class");

---@type Component
local Component = require("node.ui.Component")

---@class Box : Component
local Box = class(Component);

---@param this Box
function Box.ctor(this)
    Component.ctor(this)
    --@type table
    this.dataSource = nil;
end

return Box;
