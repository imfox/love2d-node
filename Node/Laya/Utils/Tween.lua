local Class = require("Node.Core.Class");
local Ease = require("Node.Laya.Utils.Ease");
local tween = require("Node.Lib.tween.tween");

---@class Laya_Utils_Tween : Node_Core_Class
---@field reset fun(self:Laya_Utils_Tween):void
---@field progress fun(self:Laya_Utils_Tween,p:number):void
---@field complete fun(self:Laya_Utils_Tween):void
local c = Class();

---@type Laya_Utils_Tween__Tween[]
c._tweends = {}

---@param target any
---@param props table
---@param duration number
---@param ease fun
---@param complete Node_Core_Utils_Handler
---@param delay number
---@param coverBefore boolean
---@return Laya_Utils_Tween
local function __Create(target, props, duration, ease, complete, delay, coverBefore)
    ease = ease or Ease.linear;

    local tw = tween.new(duration / 1000, target, props, ease);

    function tw:progress(p)
        self:set(self.duration * p)
    end

    function tw:complete()
        self:set(self.duration - 0.0001);
    end

    table.insert(c._tweends, { tween = tw, delay = delay, coverBefore = coverBefore, complete = complete });
    return tw;
end

---@param target any
---@param props table
---@param duration number
---@param ease fun
---@param complete Node_Core_Utils_Handler
---@param delay number
---@param coverBefore boolean
---@return Laya_Utils_Tween
function c.To(target, props, duration, ease, complete, delay, coverBefore)
    return __Create(target, props, duration, ease, complete, delay, coverBefore);
end

---@param target any
---@param props table
---@param duration number
---@param ease fun
---@param complete Node_Core_Utils_Handler
---@param delay number
---@param coverBefore boolean
---@return Laya_Utils_Tween
function c.From(target, props, duration, ease, complete, delay, coverBefore)
    local t = {};
    for k, v in pairs(props) do
        t[k], target[k] = target[k], v;
    end
    return c.To(target, t, duration, ease, complete, delay, coverBefore)
end

---@param target any
function c.ClearAll(target)
    if not target then
        return
    end
    for i = #c._tweends, 1, -1 do
        local tw = c._tweends[i];
        if tw.tween.target >= tw.tween.target then
            tw.complete = nil;
            tw.tween:progress(1);
            --table.remove(c._tweends, tw);
        end
    end
end

function c._Update(dt)
    for _, tw in ipairs(c._tweends) do
        if tw.tween:update(dt) then
            if tw.complete and tw.complete.run then
                tw.complete:run();
            end
            tw.complete = nil;
        end
    end

    for i = #c._tweends, 1, -1 do
        local tw = c._tweends[i];
        if tw.tween.clock >= tw.tween.duration then
            ---@type Laya_Utils_Tween__Tween
            local rm = table.remove(c._tweends, i);
        end
    end

end

return c;

---@class Laya_Utils_Tween__Tween
---@field tween Laya_Utils_Tween
---@field complete Node_Core_Utils_Handler
---@field delay boolean
---@field coverBefore boolean

