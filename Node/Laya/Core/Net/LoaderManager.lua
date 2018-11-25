local class = require("Node.Core.Class");
local EventDispatcher = require("Node.Core.Event.EventDispatcher");
local Loader = require("Node.Laya.Core.Net.Loader");

---@class Laya_Core_Net_LoaderManager : Node_Core_Event_EventDispatcher
---@field protected instance
local c = class(EventDispatcher);
c.instance = nil;

function c:ctor(a)
    EventDispatcher.ctor(self);

end

---@param url string
---@param complete Node_Core_Utils_Handler
---@param progress Node_Core_Utils_Handler
---@param type string
---@param cache boolean
---@param group string
---@return Laya_Core_Net_LoaderManager
function c:load(url, complete, progress, type, cache, group)
    if Loader.getRes() then

    end
    return self
end

function c:_createLoader(a1)
end

c.instance = c.new();
return c;





