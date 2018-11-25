local class = require("Node.Core.Class");
local TouchEvent = require("Node.Core.Event.TouchEvent");
local Utils = require("Node.Core.Utils.Utils");

---@param node Node_Core_Display_Drawable
---@param x number
---@param y number
local function hitTest(node, x, y)
    if node.width > 0 and node.height > 0 or node.touchThrough then
        if node.touchThrough then
            return false;
        else
            local tx = (x + node.pivotX * node.scaleX) * (1 / node.scaleX);
            local ty = (y + node.pivotY * node.scaleX) * (1 / node.scaleY);
            --return Utils.pointHitRect(x, y, -node.pivotX * node.scaleX, -node.pivotY * node.scaleY, node.width * node.scaleX, node.height * node.scaleY);
            return node:hitTest(tx, ty);
        end
    end
    return false;
end

---@class Node_Core_Event_Touch : Node_Core_Class
local c = class();

function c:ctor()
    self.disableMouseEvent = false;
    ---@type Node_Core_Event_Touch__Event[]
    self._events = {};

    self._press = {};

    self.event = TouchEvent.new();

end

---@private
---@param node Node_Core_Display_Drawable
---@param x number
---@param y number
---@param id any
---@param callback fun
function c:check(node, x, y, id, callback)
    local nx, ny = x - node.x, y - node.y
    if node.rotation % 360 ~= 0 then
        nx, ny = Utils.rotatePointByZero(nx, ny, -node.rotation)
    end

    if not self.disableMouseEvent then
        node.mouseX, node.mouseY = nx, ny;
        if not node.touchThrough and not hitTest(node, nx, ny) then
            return false;
        end

        for i = node:numChild(), 1, -1 do
            ---@type Node_Core_Display_Drawable
            local child = node:getChildAt(i);
            if child.visible and not child.destroyed and child.touchEnabled then
                if self:check(child, (nx + node.pivotX * node.scaleX) * (1 / node.scaleX), (ny + node.pivotY * node.scaleY) * (1 / node.scaleY), id, callback) then
                    return true;
                end

            end
        end

    end

    local hit = false;

    if not node.touchThrough and not self.disableMouseEvent then
        hit = true;
    else
        hit = hitTest(node, nx, ny);
    end

    if hit then
        callback(self, node, id);
    end

    return hit;
end

---@private
---@param type string
---@param id any
---@param x number
---@param y number
function c:_addTouchEvent(type, id, x, y)
    table.insert(self._events, { type = type, id = id, x = x, y = y });
end

---@param type string
---@param id any
---@param x number
---@param y number
function c:onTouch(type, id, x, y)
    self:_addTouchEvent(type, id, x, y);
end

function c:runEvent()
    local len = #self._events;
    for _ = 1, len do
        local event = self._events[1];
        if event.type == TouchEvent.TOUCH_BEGIN then
            self:check(self.stage, event.x, event.y, event.id, self.onTouchBegin);
        elseif event.type == TouchEvent.TOUCH_END then
            self:check(self.stage, event.x, event.y, event.id, self.onTouchEnd);
        elseif event.type == TouchEvent.TOUCH_MOVE then
            --self:check(self.stage, event.x, event.y, self.onTouchUp);
        end
        table.remove(self._events, 1);
    end
end

---@private
---@param start Node_Core_Display_Drawable
---@param endl Node_Core_Display_Drawable
---@return Node_Core_Display_Drawable[]
function c:getNodes(start, endl)
    local arr = {}
    while start ~= endl do
        table.insert(arr, start);
        start = start.parent;
    end
    return arr;
end

---@private
---@param nodes Node_Core_Display_Drawable[]
---@param type string
---@param id any
function c:_sendEvents(nodes, type, id)
    local e = self.event;
    e.stoped = false;
    e.touchId = id;
    for _, node in ipairs(nodes) do
        if node.destroyed or e.stoped then
            return
        end
        node:event(type, { e:set(type, node, nodes[1]) });
    end
end

---@protected
---@param node Node_Core_Display_Drawable
---@param id any
function c:onTouchBegin(node, id)
    if node then
        local list = self:getNodes(node);
        self._press[id] = node;
        self:_sendEvents(list, TouchEvent.TOUCH_BEGIN, id);
    end
end

---@protected
---@param node Node_Core_Display_Drawable
---@param id any
function c:onTouchEnd(node, id)
    if node then
        local list = self:getNodes(node);
        self:_sendEvents(list, TouchEvent.TOUCH_END, id);
        if self._press[id] == node then
            self:_sendEvents(list, TouchEvent.TAP, id);
        end
    end
    if self._press[id] ~= node and self._press[id] ~= nil then
        self:_sendEvents(self:getNodes(self._press[id]), TouchEvent.MOUSE_RELEASE_OUTSIDE, id);
    end
    self._press[id] = nil;
end

---@protected
---@param node Node_Core_Display_Drawable
function c:onTouchMove(node)

end

---@param stage Node_Core_Display_Stage
function c:setStage(stage)
    self.stage = stage;
end

c.instance = c.new();

return c;

---@class Node_Core_Event_Touch__Event
---@field type string
---@field id any
---@field x number
---@field y number
