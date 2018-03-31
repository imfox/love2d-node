--Create an class.
local function class(super)
    local cls = {}
    cls.__base = {}
    if super then
        for _, base in ipairs(super.__base) do
            table.insert(cls.__base, base)
        end
        table.insert(cls.__base, super)
    end
    cls._index = #cls.__base
    cls.new = function(...)
        local instance
        local sets = {}
        local gets = {}
        instance =
        setmetatable(
        {_index = cls._index, __base = {}},
        {
            __index = function(t, k)
                if (gets[k]) then
                    return gets[k]()
                end
                for i = #t.__base, 1, -1 do
                    if t.__base[i][k] then
                        return t.__base[i][k]
                    end
                end
            end,
            __newindex = function(t, k, v)
                if (sets[k]) then
                    return sets[k](v)
                end
                rawset(t, k, v)
            end
        }
        )

        instance.set = function(this, name, func)
            instance[name] = nil
            sets[name] = func;
            return instance
        end
        instance.get = function(this, name, func)
            gets[name] = func
            return instance
        end
        for _, base in ipairs(cls.__base) do
            table.insert(instance.__base, base)
        end
        table.insert(instance.__base, cls)

        if #instance.__base > 0 then
            instance.super = function(this, ...)
                local o = this.__base[this._index]
                local index = this._index
                this._index = index - 1
                o.ctor(this, ...)
                this._index = index
            end
            instance.call = function(this, f, ...)
                local index = this._index
                for i = index, 1, -1 do
                    local base = this.__base[i]
                    if base[f] then
                        this._index = i - 1
                        base[f](this, ...)
                        this._index = index
                        return
                    end
                end
                error("Property '" .. f .. "' does not exist on 'super'.")
            end
        end

        if cls.ctor then
            cls.ctor(instance, ...)
        end
        return instance
    end
    return cls
end
return class;