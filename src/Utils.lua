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

return Utils;


