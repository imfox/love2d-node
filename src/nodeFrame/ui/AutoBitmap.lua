---
--- Created by fox.
--- DateTime: 2018/3/16 21:23
---
local class = require("nodeFrame.class");

---@type Graphics
local Graphics = require("nodeFrame.core.Display.Graphics")

---@class AutoBitmap : Graphics
local AutoBitmap = class(Graphics);

-----@param this AutoBitmap
-----@return AutoBitmap
--function Graphics._render(this)
--    if this.one then
--        love.graphics[this.one.cmd](unpack(this.one.args));
--    end
--    if this.cmds then
--        for _, drawable in ipairs(this.cmds) do
--            love.graphics[drawable.cmd](unpack(drawable.args));
--        end
--    end
--    return this;
--end


return AutoBitmap;