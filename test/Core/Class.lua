local clone = require("Node.Core.Utils.Utils").tableClone;

---@class Node_Core_Class
---@field new fun:Node_Core_Class
---@field protected setter fun(self:Node_Core_Class,key:string,func:fun)
---@field protected getter fun(self:Node_Core_Class,key:string,func:fun)
---@field protected setter_getter fun(self:Node_Core_Class,key:string,set:fun,get:fun)
---@field protected ctor fun(self:Node_Core_Class)

---@return Node_Core_Class
local function Class(...)
    -- super list
    local cls
    local superList = { ... }

    if (#superList > 0) then
        cls = clone(superList[1])

        for n = 2, #superList do
            cls = clone(superList[n], cls)
        end
    else
        cls = {
            ctor = function()
            end
        }
    end

    function cls.new(...)
        local sets = {}
        local gets = {}
        local instance = setmetatable({}, {
            __index = function(t, k)
                if gets[k] then
                    return gets[k](t)
                end
                return cls[k]
            end,
            __newindex = function(t, k, v)
                if sets[k] then
                    return sets[k](t, v)
                elseif gets[k] then
                    return
                end
                rawset(t, k, v)
            end
        });
        if instance.setter or instance.getter then
            error("error : Prohibition of override 'setter' and 'getter' Function;");
        end
        function instance:setter(name, func)
            instance[name] = nil
            sets[name] = func
            return instance
        end
        function instance:getter(name, func)
            instance[name] = nil
            gets[name] = func
            return instance
        end
        function instance:setter_getter(name, set, get)
            instance[name] = nil
            sets[name] = set;
            gets[name] = get;
        end

        instance.class = cls
        instance:ctor(...)
        return instance
    end

    return cls
end

return Class
