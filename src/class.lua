local _class = {}
--保存父类
local create
create = function(ctor, ct, ...)
    if #ct.super > 0 then --继承属性
        for i, v in ipairs(ct.super) do
            create(ctor, v, ...)
        end
    end
    if ct.ctor then
        ct.ctor(ctor, ...)
    end
end
local function super(self, id, name, ...) --__super
    if type(id) == "number" then
        if _class[self.super[id]] and _class[self.super[id]][name] then
            return _class[self.super[id]][name](self, ...)
        end
    else
        if _class[id] and _class[id][name] then
            return _class[id][name](self, ...)
        end
    end
end
function class(...)
    local class_type = {}
    --new的对象
    class_type.super = {...}
    class_type.ctor = false
    class_type.new = function(...)
        local ctor = {}
        setmetatable(ctor, {__index = _class[class_type]})
        --继承类属性和函数
        create(ctor, class_type, ...)
        --递归所有父类
        return ctor
    end
    _class[class_type] = {CALL = super}
    --类函数实际保存
    local mt = {}
    mt.__newindex = _class[class_type]
    mt.__call = function(t, ...)
        return t.new(...)
    end
    setmetatable(class_type, mt)

    if #class_type.super > 0 then --继承函数
        setmetatable(
            _class[class_type],
            {
                __index = function(t, k)
                    for i, v in ipairs(class_type.super) do
                        local ret = _class[v][k]
                        if ret then
                            return ret
                        end
                    end
                end
            }
        )
    end
    return class_type
end
