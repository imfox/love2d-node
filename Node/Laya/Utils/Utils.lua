---@class Laya_Utils_Utils
local Utils = {};

--分割文本(文本,分割符)
function Utils.splteText(str, mark)
    if str then
        local result = {}
        str = str .. mark
        if mark == "(" or mark == ")" or mark == "." or mark == "%" or mark == "+" or mark == "-" or mark == "*" or mark == "?" or mark == "[" or mark == "^" or mark == "$" then
            mark = "(.-)" .. "%" .. mark
        else
            mark = "(.-)" .. mark
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

function Utils.pointHitRect(x1, y1, x0, y0, w0, h0)
    return x1 >= x0 and x1 <= x0 + w0 and y1 >= y0 and y1 < y0 + h0
end

function Utils.newPoint(x, y)
    return { x = x, y = y };
end

--获取路径
function Utils.stripFilename(filename)
    return string.match(filename, "(.+)/[^/]*%.%w+$") --*nix system
    --return string.match(filename, “(.+)\\[^\\]*%.%w+$”) — windows
end

--获取文件名
function Utils.stripPath(filename)
    return string.match(filename, ".+/([^/]*%.%w+)$") -- *nix system
    --return string.match(filename, “.+\\([^\\]*%.%w+)$”) — *nix system
end

--去除扩展名
function Utils.stripExtension(filename)
    local idx = filename:match(".+()%.%w+$")
    if (idx) then
        return filename:sub(1, idx - 1)
    else
        return filename
    end
end

--获取扩展名
function Utils.getExtension(filename)
    return filename:match(".+%.(%w+)$")
end

---@param color string
---@return number,number,number,number
function Utils.htmlColor2RGBA(color)
    local str
    local len = 2
    if string.len(color) == 7 then
        str = string.sub(color, 2, 8)
    elseif string.len(color) == 4 then
        len = 1;
        str = string.sub(color, 2, 5)
    else
        str = "ffffff";
    end

    local rgba = {}
    for i = 1, #str, len do
        local x = tonumber(string.sub(str, i, i + len - 1), 16);
        if len == 1 then
            x = x / 0xf;
        else
            x = x / 0xff;
        end
        table.insert(rgba, x)
    end

    if #rgba <= 3 then
        table.insert(rgba, 1)
    end

    return rgba;
end

---@param any[]
---@param any
---@return number
function Utils.tableIndexOf(arr, value)
    for i, v in ipairs(arr) do
        if v == value then
            return i;
        end
    end
    return 0;
end

function Utils.void()
end

return Utils;