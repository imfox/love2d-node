local c = {}

c.NULL = 1 / 0;

function c.tableClone(object, base)
    local lookup_table = base or {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

local id = 1;
function c.getGID()
    id = id + 1;
    return id;
end

function c.void()
end

return c;