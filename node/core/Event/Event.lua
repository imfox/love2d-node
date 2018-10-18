---
--- Created by fox.
--- DateTime: 2018/10/18 22:36
---

local UIEvent = require("node.core.Event.UIEvent");

---@class node2d_core_event_event : node2d_core_event_uievent
local c = class(UIEvent)

function c:ctor()
    self.stoped = false;
    self.mouseX = 0;
    self.mouseY = 0;
    self.type = nil;
    self.keyCode = nil;
    self.target = nil;
    self.currentTarget = nil;
end


---@param type string
---@param currentTarget Drawable
---@param target Drawable
---@return node2d_core_event_event
function c:set(type, currentTarget, target)
    self.type = type;
    self.currentTarget = currentTarget;
    self.target = target;
    return self;
end

---@return void
function c:stopPropagation()
    self.stoped = true;
end

return c;