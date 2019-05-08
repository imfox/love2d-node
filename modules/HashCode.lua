local Class = require("class");

local _gid = 0;

---@class Node_HashCode : Class
---@field public gid number @readonly
local c = Class();

function c:ctor()
    _gid = _gid + 1;

    ---@private
    self._gid = _gid;

    self:getter("gid", self.__getGid);
end

---@private
function c:__getGid()
    return self._gid;
end

return c;