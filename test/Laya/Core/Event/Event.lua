local TouchEvent = require("Node.Core.Event.TouchEvent");
---@class Laya_Core_Event_Event
local e = {}
e.LOADED = "LOADED";
e.CLICK = TouchEvent.CLICK;
e.MOUSE_MOVE = TouchEvent.MOUSE_MOVE;
e.MOUSE_DOWN = TouchEvent.MOUSE_DOWN;
e.MOUSE_UP = TouchEvent.MOUSE_UP;
return e;