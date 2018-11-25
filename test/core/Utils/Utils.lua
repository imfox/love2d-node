local c = {}

-- 用做数组占位符号, 数组中使用nil可能会导致其它的问题
c.NULL = 1 / 0;

function c.tablePrint(root)
    if root then
        local print = print
        local tconcat = table.concat
        local tinsert = table.insert
        local srep = string.rep
        local type = type
        local pairs = pairs
        local tostring = tostring
        local next = next
        local cache = { [root] = "." }
        local function _dump(t, space, name)
            local temp = {}
            for k, v in pairs(t) do
                local key = tostring(k)
                if cache[v] then
                    tinsert(temp, "." .. key .. " {" .. cache[v] .. "}")
                elseif type(v) == "table" then
                    local new_key = name .. "." .. key
                    cache[v] = new_key
                    tinsert(temp, "." .. key .. _dump(v, space .. (next(t, k) and "|" or " ") .. srep(" ", #key), new_key))
                else
                    tinsert(temp, "." .. key .. " [" .. tostring(v) .. "]")
                end
            end
            return tconcat(temp, "\n" .. space)
        end
        print(_dump(root, "", ""))
        print('-------------------------------------')
    end
end

function c.tableClone(object, base)
    local lookup_table = base or {}
    --新建table用于记录
    local function _copy(object)
        --_copy(object)函数用于实现复制
        if type(object) ~= "table" then
            return object ---如果内容不是table 直接返回object(例如如果是数字\字符串直接返回该数字\该字符串)
        elseif lookup_table[object] then
            return lookup_table[object]
            --这里是用于递归滴时候的,如果这个table已经复制过了,就直接返回
        end
        local new_table = {}
        lookup_table[object] = new_table
        --新建new_table记录需要复制的二级子表,并放到lookup_table[object]中.
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
            --遍历object和递归_copy(value)把每一个表中的数据都复制出来
        end
        return setmetatable(new_table, getmetatable(object))
        --每一次完成遍历后,就对指定table设置metatable键值
    end
    return _copy(object)
    --返回clone出来的object表指针/地址
end

---@return fun()
---@param func fun()
---@param caller any
---@param ... any[]
function c.call(func, caller, ...)
    local args = { ... }
    return function(...)
        local params = { ... };
        for i = #args, 1, -1 do
            table.insert(params, 1, args[i]);
        end
        if caller then
            return func(caller, unpack(params))
        end
        return func(unpack(params))
    end
end

function c.rotatePoint(ox, oy, x, y, r)
    r = math.rad(r)
    return (x - ox) * math.cos(r) - (y - oy) * math.sin(r) + ox, (x - ox) * math.sin(r) + (y - oy) * math.cos(r) + oy
end

function c.rotatePointByZero(x, y, r)
    return c.rotatePoint(0, 0, x, y, r)
end

function c.pointHitRect(x1, y1, x0, y0, w0, h0)
    return x1 >= x0 and x1 <= x0 + w0 and y1 >= y0 and y1 < y0 + h0
end

local id = 1;
function c.getGID()
    id = id + 1;
    return id;
end

function c.void()
end

return c;