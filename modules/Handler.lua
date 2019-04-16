local Class = require("class");

local _gid = 1;

---@type Node_Handler[]
local _pool = {};

---@class Node_Handler : Node_Class
---@field new fun(caller:any, func:fun, args:any[], once:boolean):Node_Handler
local c = Class();

---@param caller any
---@param func fun
---@param args any[]
---@param once boolean
function c:ctor(caller, func, args, once)
    self:set(caller, func, args, once);
end

---@param caller any
---@param func fun
---@param args any[]
---@param once boolean
---@return Node_Handler
function c:set(caller, func, args, once)
    self.caller = caller;
    self.func = func;
    self.args = args;
    self.once = once;
    self._id = _gid;
    _gid = _gid + 1;
    return self;
end

---@return Node_Handler
function c:clear()
    self.caller = nil;
    self.func = nil;
    self.args = nil;
    return self;
end

function c:run()
    self:runWith();
end

---@param args any[]
function c:runWith(args)
    if self.func then
        local params = {};
        if self.args and #self.args > 0 then
            for _, v in ipairs(self.args) do
                table.insert(params, v)
            end
        end
        if args and #args > 0 then
            for _, v in ipairs(args) do
                table.insert(params, v)
            end
        end
        local id = self._id;
        local ret;
        if self.caller then
            ret = self.func(self.caller, unpack(params))
        else
            ret = self.func(unpack(params))
        end
        if id == self._id and self.once then
            self:recover();
        end
        return ret;
    end
end

---@return void
function c:recover()
    if self._id > 0 then
        self._id = 0;
        table.insert(_pool, self:clear());
    end
end

---@param caller any
---@param func fun
---@param args any[]
---@param once boolean
---@return Node_Handler
function c.Create(caller, func, args, once)
    if #_pool > 0 then
        return table.remove(_pool, 1):set(caller, func, args, once);
    end
    return c.new(caller, func, args, once);
end

return c;