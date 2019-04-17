local Class = require("class");

local _gid = 0;

---@class Node_HashCode : Class
local c = Class();

function c:ctor()
    _gid = _gid + 1;
    self._gid = _gid;
end

return c;