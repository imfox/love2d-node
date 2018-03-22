---
--- Created by fox.
--- DateTime: 2018/3/15 20:45
---
--local function split(src, sep)
--    assert(type(src) == "string")
--    local sep, fields = sep or ":", {}
--    local pattern = string.format("([^%s]+)", sep)
--    src:gsub(
--    pattern,
--    function(c)
--        fields[#fields + 1] = c
--    end
--    )
--    return fields
--end

local Utils = require("nodeFrame.core.Utils.Utils");

--[[
    正确的使用方式应该是

    a.lua
        local exportA = 1;
        local exportB = 2;
        local localA = 3;
        return {exportA=exportA,exportB=exportB};

    b.lua
        local exportA,exportB = import(".a",{"exprotA","exportB"});
        print(exportA);

    注意 只能用在代码顶部，不可嵌套于函数内执行
--]]
local function import(moduleName, exprotArr)
    local currentModuleName
    local currentModuleNameParts
    local moduleFullName = moduleName
    local offset = 1

    while true do
        if string.byte(moduleName, offset) ~= 46 then -- .
            moduleFullName = string.sub(moduleName, offset)
            if currentModuleNameParts and #currentModuleNameParts > 0 then
                moduleFullName = table.concat(currentModuleNameParts, ".") .. "." .. moduleFullName
            end
            break
        end
        offset = offset + 1

        if not currentModuleNameParts then
            if not currentModuleName then
                local n, v = debug.getlocal(3, 1)
                currentModuleName = v
            end
            currentModuleNameParts = Utils.splteText(currentModuleName, ".")
        end
        table.remove(currentModuleNameParts, #currentModuleNameParts)
    end
    if not exprotArr then
        return require(moduleFullName)
    end
    local module = require(moduleFullName);
    local export = {};
    for _, k in ipairs(exprotArr) do
        table.insert(export,module[k])
    end
    return unpack(export);
end

return import;