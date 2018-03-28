---
--- Created by fox.
--- DateTime: 2018/3/14 21:47
---
local Utils = {};
function Utils.tablePrint(root)
    if root then
        local print = print
        local tconcat = table.concat
        local tinsert = table.insert
        local srep = string.rep
        local type = type
        local pairs = pairs
        local tostring = tostring
        local next = next
        local cache = {  [root] = "." }
        local function _dump(t,space,name)
            local temp = {}
            for k,v in pairs(t) do
                local key = tostring(k)
                if cache[v] then
                    tinsert(temp,"." .. key .. " {" .. cache[v].."}")
                elseif type(v) == "table" then
                    local new_key = name .. "." .. key
                    cache[v] = new_key
                    tinsert(temp,"." .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
                else
                    tinsert(temp,"." .. key .. " [" .. tostring(v).."]")
                end
            end
            return tconcat(temp,"\n"..space)
        end
        print(_dump(root, "",""))
        print('-------------------------------------')
    end
end

function Utils.tableClone(object)
    local lookup_table = {}
    --新建table用于记录
    local function _copy(object) --_copy(object)函数用于实现复制
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

--分割文本(文本,分割符)
function Utils.splteText(str, mark)
    if str  then
        local result = {}
        str = str..mark
        if mark == "(" or mark == ")" or mark == "." or mark == "%" or mark == "+" or mark == "-" or mark == "*" or mark == "?" or mark == "[" or mark == "^" or mark == "$" then
            mark = "(.-)".."%"..mark
        else
            mark = "(.-)"..mark
        end
        for match in str:gmatch(mark) do
            table.insert(result, match)
        end
        return result
    end
    return {}
end



-- 点与四边形碰撞
function Utils.pointHitQuad(x, y, lt--[[ {x,y} --]], lb--[[ {x,y} --]], rt--[[ {x,y} --]], rb--[[ {x,y} --]])
    local a = (lt.x - lb.x) * (y - lb.y) - (lt.y - lb.y) * (x - lb.x);
    local b = (rt.x - lt.x) * (y - lt.y) - (rt.y - lt.y) * (x - lt.x);
    local c = (rb.x - rt.x) * (y - rt.y) - (rb.y - rt.y) * (x - rt.x);
    local d = (lb.x - rb.x) * (y - rb.y) - (lb.y - rb.y) * (x - rb.x);
    if ((a > 0 and b > 0 and c > 0 and d > 0) or (a < 0 and b < 0 and c < 0 and d < 0)) then
        return true;
    end
    return false;
end

function Utils.pointHitRect(x1,y1,x0,y0,w0,h0)
    return x1 >= x0 and x1 <= x0 + w0 and y1>=y0 and y1 < y0 + h0
end

function Utils.newPoint(x,y)
    return {x=x,y=y};
end


local gid = 0;
-- 得到一个具有唯一性的ID
function Utils.getGID()
    gid = gid + 1;
    return gid;
end


return Utils;