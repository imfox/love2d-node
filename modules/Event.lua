local modules = (...):gsub('%.[^%.]+$', '') .. ".";
local Class = require(modules .. "Class");
---@class Node_Event
local c = Class();

c.ADDED = "ADDED"
c.REMOVED = "REMOVED"
c.BEFORE_REMOVE = "BEFORE_REMOVE"

return c;
