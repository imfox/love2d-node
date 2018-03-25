local Utils = require("nodeFrame.core.Utils.Utils");
--Create an class.
local function class(super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
        super = nil
    end

    -- inherited from Lua Object
    if super then
        cls = Utils.tableClone(super)
        if super.ctor then
            cls.__super = cls.__super or {}
            table.insert(cls.__super, cls.ctor)
        end
        cls.ctor = nil
    else
        cls = {}
    end
    cls.__index = cls

    function cls.new(...)
        local instance = setmetatable({}, cls)
        instance.super = cls.__super == nil and nil or function(...)
            -- local info = debug.getinfo(2, "n")
            -- if (info.name ~= nil and info.name ~= "super" and info.name ~= "ctor") then
            --     error(
            --         "Super calls are not permitted outside constructors or in nested functions inside constructors.."
            --     )
            -- end
            instance._super_init_count_ = (instance._super_init_count_ or #cls.__super+1)-1
            cls.__super[instance._super_init_count_](...)
        end
        if instance.ctor then
            instance:ctor(...)
        end
        if cls.__super and instance._super_init_count_ ~= 1 then
            error("Constructors for derived classes must contain a 'super' call.")
        end
        return instance
    end

    return cls
end
return class;