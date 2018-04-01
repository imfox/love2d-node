---
--- Created by fox.
--- DateTime: 2018/3/20 21:21
---
local class = require("node.class");

---@type Component
local Component = require("node.ui.Component")

---@class View : Component
local View = class(Component);

---@param this View
function View.ctor(this)
    Component.ctor(this)

end

return View;

