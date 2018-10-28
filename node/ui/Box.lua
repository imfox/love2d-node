---
--- Created by fox.
--- DateTime: 2018/3/30 20:30
---

local class = require("node.class");

---@type Component
local Component = require("node.ui.Component")

---@class Box : Component
local Box = class(Component);

---@param this Box
function Box.ctor(this)
    Component.ctor(this)

    -----@type table
    this._dataSource = nil;

    this:setter("dataSource", function(d)
        if d and type(d) == "table" then
            for k, v in pairs(d) do
                ---@type Component
                local child = this:getChildByName(k);
                if child then
                    child.dataSource = v;
                else
                    this[k] = v;
                end
            end
        end
        this._dataSource = d;
    end)

    this:getter("dataSource", function(v)
        return this._dataSource;
    end)
end

return Box;
