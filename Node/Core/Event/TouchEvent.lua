local class = require("Node.Core.Class");

---@class Node_Core_Event_TouchEvent
local c = class();
c.MOUSE_DOWN = "MOUSE_DOWN";
c.MOUSE_UP = "MOUSE_UP";
c.MOUSE_RELEASE_OUTSIDE = "MOUSE_RELEASE_OUTSIDE";
c.CLICK = "CLICK";

c.RMOUSE_DOWN = "RMOUSE_DOWN";
c.RMOUSE_UP = "RMOUSE_UP";
c.RMOUSE_RELEASE_OUTSIDE = "RMOUSE_RELEASE_OUTSIDE";
c.RCLICK = "RCLICK";

c.MOUSE_MOVE = "MOUSE_MOVE";
c.MOUSE_ENTER = "MOUSE_ENTER";
c.MOUSE_OUT = "MOUSE_OUT";

c.TOUCH_MOVE = c.MOUSE_MOVE;
c.TOUCH_BEGIN = c.MOUSE_DOWN;
c.TOUCH_END = c.MOUSE_UP;
c.TOUCH_RELEASE_OUTSIDE = c.MOUSE_RELEASE_OUTSIDE;
c.TAP = c.CLICK;

function c:ctor()
    self.stoped = false;
    self.mouseX = 0;
    self.mouseY = 0;
    self.type = nil;
    self.keyCode = nil;
    self.target = nil;
    self.currentTarget = nil;
    self.touchId = nil;
end

---@param type string
---@param currentTarget Node_Core_Display_Drawable
---@param target Node_Core_Display_Drawable
---@return Node_Core_Event_Event
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

---@param type string
function c.IsTouchEvent(type)
    return type == c.CLICK or type == c.MOUSE_DOWN or type == c.MOUSE_UP or type == c.MOUSE_RELEASE_OUTSIDE or type == c.MOUSE_MOVE or type == c.MOUSE_ENTER or type == c.MOUSE_OUT;
end

return c;