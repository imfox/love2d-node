---
--- Created by fox.
--- DateTime: 2018/3/20 21:21
---
local class = require("node.class");

---@type Drawable
local Drawable = require("node.core.Display.Drawable")

---@class View : Drawable
local View = class(Drawable);

---@param this View
function View.ctor(this)
    this:super()

end

return View;

