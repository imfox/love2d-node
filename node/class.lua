--[[
	* When using New() would not automatically use Ctor() of the base class, you should manually use it. (Base.Ctor(self, ...))
	* When accessing attribute of the base class, you should use self.xxx, if the current class has homonymous attribute that will cover the base class.
	* When accessing method of the base class, you should use Base.func(self, ...).
	* When using self:func(), if the current class has not it, that will access the method of the base class and upper untill access it.
]] --

local Utils = require("node.core.Utils.Utils")
local clone = Utils.tableClone

---@return Klass
local function class(...) -- super list
    local cls
    local superList = {...}

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
        local instance =
        setmetatable(
        {},
        {
            __index = function(t, k)
                if gets[k] then
                    return gets[k]()
                end
                return cls[k]
            end,
            __newindex = function(t, k, v)
                if sets[k] then
                    return sets[k](v)
                end
                rawset(t, k, v)
            end
        }
        )
        instance.set = function(this, name, func)
            instance[name] = nil
            sets[name] = func
            return instance
        end
        instance.get = function(this, name, func)
            gets[name] = func
            return instance
        end

        instance.class = cls
        instance:ctor(...)
        return instance
    end

    return cls
end

return class
