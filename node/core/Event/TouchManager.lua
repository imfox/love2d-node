---
--- Created by fox.
--- DateTime: 2018/10/18 21:17
---

local UIEvent = require("node.core.Event.UIEvent");
local Event = require("node.core.Event.Event");
local Utils = require("node.core.Utils.Utils");

---@class node2d_core_event_touchmanager : Klass
local c = class()

function c:ctor()

    ---@private
    self.press = {}

    self.event = Event.new();
end

---@param node Drawable
function c:mouseDown(node)
    local list = self:getNodes(node);
    table.insert(self.press, node)
    self:sendEvents(list, UIEvent.MOUSE_DOWN);
end

---@param node Drawable
function c:mouseUp(node)
    local list = self:getNodes(node);
    self:sendEvents(list, UIEvent.MOUSE_UP);
    if Utils.tableIndexOf(self.press, node) > 0 then
        self:sendEvents(list, UIEvent.CLICK);
    end
end

---@param node Drawable
function c:mouseMove(node)
    local list = self:getNodes(node);
    self:sendEvents(list, UIEvent.MOUSE_MOVE);
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