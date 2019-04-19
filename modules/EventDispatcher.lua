local Class = require("class");
---@type Node_HashCode
local HashCode = require("node.modules.HashCode");
---@type Node_Handler
local Handler = require("node.modules.Handler");
---@class Node_EventDispatcher : Node_HashCode
---@field protected _events table<string,Node_Handler[]>
local c = Class(HashCode);

function c:ctor()
    HashCode.ctor(self);
end

---@private
---@param type string
---@param func fun
---@param caller any
---@param args any[]
---@param offBefore boolean
---@return Node_EventDispatcher
function c:__createListener(type, func, caller, args, once, offBefore)
    if type then
        offBefore = offBefore or true;
        if offBefore and self:hasListener(type) then
            self:off(type, func, caller)
        end
        local handler = Handler.Create(caller, func, args, once);
        self._events = self._events or {};
        self._events[type] = self._events[type] or {};
        table.insert(self._events[type], handler);
    else
        print("error: 0x0011");
    end
    return self;
end

---@param type string
---@param func fun
---@param caller any
---@param args any[]
---@return Node_EventDispatcher
function c:on(type, func, caller, args)
    self:__createListener(type, func, caller, args, false);
    return self;
end

---@param type string
---@param func fun
---@param caller any
---@param args any[]
---@return Node_EventDispatcher
function c:once(type, func, caller, args)
    self:__createListener(type, func, caller, args, true);
    return self;
end

---@param type string
---@return boolean
function c:hasListener(type)
    local e = self._events and self._events[type];
    return not (not e);
end

---@param type string
---@param args any[]
---@return void
function c:event(type, args)
    if not self._events or not self._events[type] then
        return self
    end
    local i = 1;
    while i <= #self._events[type] do
        local e = self._events[type][i];
        if e then
            e:runWith(args)
        end
        if not e or e.once then
            table.remove(self._events[type], i);
        else
            i = i + 1
        end
    end
end

---@param type string
---@param func fun
---@param caller any
---@param args any[]
---@return Node_EventDispatcher
function c:off(type, func, caller, onceOnly)
    if not self._events or not self._events[type] then
        return self
    end
    for i = #self._events[type], 1, -1 do
        local event = self._events[type][i];
        if event.func == func and caller == event.caller and (not onceOnly or event.once) then
            ---@type Node_Handler
            local e = table.remove(self._events[type], i);
            if e then
                e:recover();
            end
        end
    end
    return self;
end

---@param type string
function c:offAll(type)
    if not self._events then
        return self
    end
    if type ~= nil then
        self:offType(type);
    else
        for k, _ in pairs(self._events) do
            self:offType(k);
        end
    end
    return self;
end

---@private
---@param type string
function c:offType(type)
    if not self._events or not self._events[type] then
        return self
    end
    if type ~= nil then
        if not self._events[type] then
            return self
        end
        for i = #self._events[type], 1, -1 do
            ---@type Node_Handler
            local e = table.remove(self._events[type], i);
            self:off(type, e.func, e.caller)
        end
        self._events[type] = {};
    end
    return self;
end

return c;