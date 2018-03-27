---
--- Created by fox.
--- DateTime: 2018/3/27 22:08
---
local class = require("nodeFrame.class")

local Drawable = require("nodeFrame.core.Display.Drawable");

---@class stage : Drawable
local stage = class(Drawable);

---@param this stage
function stage.ctor(this)
    this:super()
end


---@param this stage
function stage.draw(this)
    this:_render()
end


function stage:TestPoint(x,y)

end

return stage;