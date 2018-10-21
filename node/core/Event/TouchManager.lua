---
--- Created by fox.
--- DateTime: 2018/10/18 21:17
---

local class = require("node.class");
local UIEvent = require("node.core.Event.UIEvent");
local Event = require("node.core.Event.Event");

---@class node2d_core_event_touchmanager : Klass
local c = class()

function c:ctor()

    ---@private
    self.press = {}

    self.event = Event.new();
end

---@param node Drawable
function c:mouseDown(node, id)
    local list = self:getNodes(node);
    self:_addPress(id, node);
    self:sendEvents(list, UIEvent.MOUSE_DOWN);
end

---@param node Drawable
function c:mouseUp(node, id)
    local list = self:getNodes(node);
    self:sendEvents(list, UIEvent.MOUSE_UP);
    ---@type Drawable[]
    local prs = self:_getPress(id);
    for _, n in ipairs(prs) do
        if node == n then
            self:sendEvents(list, UIEvent.CLICK);
        else
            n:event(UIEvent.MOUSE_LEAVE_UP);
            --self:sendEvents(v, UIEvent.MOUSE_LEAVE_UP);
        end
    end
    self.press[id] = nil;
end

---@param node Drawable
function c:mouseMove(node, id)
    local list = self:getNodes(node);
    self:sendEvents(list, UIEvent.MOUSE_MOVE);
end

---@private
---@param id any
---@param node Drawable
function c:_addPress(id, node)
    if not self.press[id] then
        self.press[id] = {};
    end
    table.insert(self.press[id], node);
end


---@private
function c:_getPress(id)
    if self.press[id] then
        return self.press[id];
    end
    return {};
end

---@private
---@param start Node
---@param endl Node
---@return Drawable[]
function c:getNodes(start, endl)
    local arr = {}
    while start ~= endl do
        table.insert(arr, start);
        start = start.parent;
    end
    return arr;
end

---@private
---@param nodes Drawable[]
---@param type string
function c:sendEvents(nodes, type)
    local e = self.event;
    e.stoped = false;
    for _, node in ipairs(nodes) do
        if node.destroyed or e.stoped then
            return;
        end
        node:event(type, { e:set(type, node, nodes[1] ) });
    end
end
---@type node2d_core_event_touchmanager
local instance = c.new()
return instance;