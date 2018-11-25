local Class = require("Node.Core.Class");
---@class Node_Core_Event_Event
local c = Class();

c.RESIZE = "RESIZE"

c.ADDED = "ADDED"
c.REMOVED = "REMOVED"
c.BEFORE_REMOVE = "BEFORE_REMOVE"

c.KEY_DOWN = "KEY_DOWN"
c.KEY_UP = "KEY_UP"
c.KEY_PRESS = "KEY_PRESS"

c.MOUSE_LEAVE_UP = "MOUSE_LEAVE_UP"
c.TOUCH_RELEASE_OUTSIDE = "TOUCH_RELEASE_OUTSIDE";
c.CHANGE = "CHANGE"
c.FOCUS = "FOCUS"
c.BLUR = "BLUR";

return c;
