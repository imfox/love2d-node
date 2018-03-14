---
--- Created by fox.
--- DateTime: 2018/3/14 20:42
---

---@class EventType
---@field public func func
---@field public args []
---@field public count number

local class = require("class");

---@class Message
---@field protected _events table<string, EventType[]> @子组件数组

local Message = class();

---@param this Message
function Message.ctor(this)

end

---@param this Message
---@param type string
---@param func func
---@param args []
function Message.on(this,type,func,args)
    if not this._events then
        this._events = {};
    end
    if not this._events[type] then
        this._events[type] = {};
    end
    table.insert(this._events[type],{["func"]=func,["args"]=args,["count"]=-1});
end

---@param this Message
---@param type string
---@param func func
---@param args []
function Message.once(this,type,func,args)
    if not this._events then
        this._events = {};
    end
    if not this._events[type] then
        this._events[type] = {};
    end
    table.insert(this._events[type],{["func"]=func,["args"]=args,["count"]=1});
end

---@param this Message
---@param type string
---@param args []
function Message.event(this,type,args)
    if not this._events then return end
    if not this._events[type] then return end
    for _,event in ipairs(this._events[type]) do
        if event.func then
            local params = {};
            if event.args then
                for _, v in ipairs(event.args) do
                    table.insert(params,v)
                end
            end
            if args then
                for _, v in ipairs(args) do
                    table.insert(params,v)
                end
            end

            event.func(unpack(params))
            event.count = event.count - 1;
        end
    end
    for i = #this._events[type],1,-1 do
        if this._events[type][i].count == 0 then
            table.remove(this._events[type],i);
        end
    end
end

---@param this Message
---@param type string
---@param func func
---@param onceOnly boolean
---@return Message
function Message.off(this,type,func,onceOnly)
    if not this._events then return end
    if not this._events[type] then return end
    for i = #this._events[type],1,-1 do
        local event = this._events[type][i];
        if event.func == func and (onceOnly ~= true and true or event.count==1) then
            table.remove(this._events[type],i);
        end
    end
    return this;
end

---@param this Message
---@param type string
---@return Message
function Message.offAll(this,type)
    if not this._events then return end
    if type ~= nil then
        if not this._events[type] then return end
        for i = #this._events[type],1,-1 do
            table.remove(this._events[type],i);
        end
    else
        this._events = nil;
    end
    return this;
end

return Message;