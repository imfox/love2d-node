---
--- Created by fox.
--- DateTime: 2018/3/29 20:54
---


---@class node2d_core_event_uievent : Klass
local UIEvent = {}

UIEvent.MOUSE_DOWN = "MOUSE_DOWN"
UIEvent.MOUSE_UP = "MOUSE_UP"
UIEvent.RMOUSE_DOWN = "RMOUSE_DOWN"
UIEvent.RMOUSE_UP = "RMOUSE_UP"

UIEvent.MOUSE_MOVE = "MOUSE_MOVE"
UIEvent.MOUSE_ENTER = "MOUSE_ENTER"
UIEvent.MOUSE_OVER = "MOUSE_OVER"
UIEvent.CLICK = "CLICK"

UIEvent.RESIZE = "RESIZE"

UIEvent.ADDED = "ADDED"
UIEvent.REMOVE = "REMOVE"
UIEvent.BEFORE_REMOVE = "BEFORE_REMOVE"

UIEvent.KEY_DOWN = "KEY_DOWN"
UIEvent.KEY_UP = "KEY_UP"
UIEvent.KEY_PRESS = "KEY_PRESS"

UIEvent.MOUSE_LEAVE_UP = "MOUSE_LEAVE_UP"

UIEvent.CHANGE = "CHANGE"

---@param type string
function UIEvent.isMouseEvent(type)
    return type == UIEvent.CLICK or type == UIEvent.MOUSE_DOWN or type == UIEvent.MOUSE_UP or type == UIEvent.MOUSE_LEAVE_UP or type == UIEvent.MOUSE_MOVE or type == UIEvent.MOUSE_ENTER or type == UIEvent.MOUSE_OVER;
end

return UIEvent;