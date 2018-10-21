---
--- Created by fox.
--- DateTime: 2018/10/20 23:10
---

local class = require("node.class");
local UIEvent = require("node.core.Event.UIEvent");
local Utils = require("node.core.Utils.Utils");
local Message = require("node.core.Display.Message");
local Stage = require("node.core.Display.Stage");
local Timer = require("node.core.Utils.Timer");

---@class node2d_ui_sliderboard : Message
---@field target Drawable
---@field x number
---@field y number
local c = class(Message)

function c:ctor()
    Message.ctor(self);

    ---@private
    ---@type Drawable
    self._target = nil;

    self:setter("target", function(d)
        self._target = d;
        if self._target then

            self._target:on(UIEvent.MOUSE_DOWN, Utils.call(self._onMouseDown, self));
        end
    end)
    self:getter("target", function()
        return self._target;
    end)

    ---@private
    self._pos = { x = 0, y = 0 };

    ---@private
    ---@type _timer
    self._timer = nil;
    ---@private
    ---@type _timer
    self._tweenTimer = nil;

    self.width = 0;
    self.height = 0;

    ---@type number @0、1、2 (1=up or down 、2=left or right、0=free)
    self.direction = 0;

    ---@private
    ---@type table[]
    self._offsets = {};

    ---@private
    self._offsetY = 0;
    ---@private
    self._offsetX = 0;


    ---@private
    self._x = 0;
    ---@private
    self._y = 0;

    self:setter("x", function(v)
        self._x = v;
        if self._x > self.width then
            self._x = self.width;
        end
        if self._x < 0 then
            self._x = 0;
        end
    end)
    self:getter("x", function()
        return self._x;
    end)


    self:setter("y", function(v)
        self._y = v;
        if self._y > self.height then
            self._y = self.height;
        end
        if self._y < 0 then
            self._y = 0;
        end
    end)
    self:getter("y", function()
        return self._y;
    end)

end

---@param width number
---@param height number
---@param direction number @ 0 or 1 or 2
function c:set(width, height)
    self.width = width;
    self.height = height;
    if self.x > self.width then
        self.x = self.width;
    end
    if self.y > self.height then
        self.y = self.height;
    end
end

---@private
function c:_loop()
    local mx, my = Stage.mouseX, Stage.mouseY;
    local px, py = mx - self._pos.x, my - self._pos.y;
    table.insert(self._offsets, { px, py });
    if px == 0 and py == 0 then
        return
    end
    self:_change(-px, -py);
    self._pos.x, self._pos.y = mx, my;
end

---@private
function c:_onMouseDown()
    Timer:clearAll(self);
    self._offsets = {};
    self._offsetX, self._offsetY = 0, 0;
    self._pos.x, self._pos.y = Stage.mouseX, Stage.mouseY;
    Stage:once(UIEvent.MOUSE_UP, Utils.call(self._onMouseUp, self));
    self._timer = Timer:frameLoop(1, self, self._loop);
end

---@private
function c:_onMouseUp()
    self:stop();

    if self._offsets then
        local offsetX, offsetY = 0, 0;
        local len = #self._offsets;
        local m = math.min(len, 3);
        for i = len, len - m + 1, -1 do
            offsetX = offsetX + self._offsets[i][1];
            offsetY = offsetY + self._offsets[i][2];
        end

        if math.abs(offsetX) > 2 and (self.direction == 0 or self.direction == 2) then
            self._offsetX = offsetX / m;
        end
        if math.abs(offsetY) > 2 and (self.direction == 0 or self.direction == 1) then
            self._offsetY = offsetY / m;
        end

        self._tweenTimer = Timer:frameLoop(1, self, self._tweenMove)
    end
end

---@private
function c:_change(x, y)
    local f = false;
    if self.direction == 0 or self.direction == 2 then
        local o = self.x;
        self.x = self.x + x;
        f = self.x ~= o;
    end

    if self.direction == 0 or self.direction == 1 then
        local o = self.y;
        self.y = self.y + y;
        f = f or (self.y ~= o);
    end
    if f then
        self:event(UIEvent.CHANGE)
    end
end

---@private
function c:_tweenMove()
    if self._offsetX ~= 0 then
        self._offsetX = self._offsetX + -(self._offsetX) * Timer.delta * 10;
    end
    if self._offsetY ~= 0 then
        self._offsetY = self._offsetY + -(self._offsetY) * Timer.delta * 10;
    end
    if math.abs(self._offsetY) <= 1 and math.abs(self._offsetX) <= 1 then
        self._tweenTimer:destroy()
        self._offsetX = 0;
        self._offsetY = 0;
    else
        self:_change(-self._offsetX, -self._offsetY)
    end
end

function c:stop()
    if self._timer then
        self._timer:destroy()
        self._timer = nil;
    end
end


function c:destroy()

end

return c;