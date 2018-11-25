local Class = require("Node.Core.Class");
local Drawable = require("Node.Core.Display.Drawable");
local Event = require("Node.Core.Event.Event");
local TouchManager = require("Node.Core.Event.TouchManager").instance;
local gr = love.graphics;

---@class Node_Core_Display_Stage : Node_Core_Display_Drawable
local c = Class(Drawable);
function c:ctor()
    Drawable.ctor(self);

    self._gid = 1;
    self.offsetX = 0;
    self.offsetY = 0;
    self.screenScaleX = 1;
    self.screenScaleY = 1;
    self._bgColor = nil;
    self.bgColor = 0xffffff;

    self._scaleMode = "SHOWALL";
end

function c:update(dt)
    TouchManager:runEvent();
end

function c:draw()
    gr.push()
    gr.translate(self.offsetX, self.offsetY)
    gr.scale(self.screenScaleX, self.screenScaleY)
    self:__render(gr);
    gr.pop()

    if self.offsetX ~= 0 or self.offsetY ~= 0 then
        --隐藏其它...比较搓
        local w, h = gr.getWidth(), gr.getHeight()
        gr.setColor(0.1, 0.1, 0.1, 1)
        gr.rectangle("fill", 0, 0, self.offsetX, h)
        gr.rectangle("fill", 0, 0, w, self.offsetY)
        gr.rectangle("fill", w - self.offsetX, 0, self.offsetX, h)
        gr.rectangle("fill", 0, h - self.offsetY, w, self.offsetY)
        gr.setColor(1, 1, 1, 1)
    end

end

---@param w number
---@param h number
function c:setSceenSize(w, h)
    self:event(Event.RESIZE);
    
    local sw = gr.getWidth();
    local sh = gr.getHeight();

    self.width = w;
    self.height = h;

    local minScale = math.min(sw / self.width, sh / self.height)
    self.screenScaleX, self.screenScaleY = minScale, minScale
    self.offsetX, self.offsetY = (sw - (self.width * minScale)) / 2, (sh - (self.height * minScale)) / 2;
end

function c:keyboardEvent()
    --TouchManager:onTouch(Event.MOUSE_DOWN, 1, 115, 877)
end

---@private
function c:touchPoint(x, y)
    x = x - self.offsetX
    x = x / (self.screenScaleX * self.width) * self.width
    if (x < 0 or x > self.width) then
        x = -1
    end

    y = y - self.offsetY
    y = y / (self.screenScaleY * self.height) * self.height
    if (y < 0 or y > self.height) then
        y = -1;
    end
    return x, y
end

---@param type string
---@param id any
---@param x number
---@param y number
function c:onMouseEvent(type, id, x, y)
    local nx, ny = self:touchPoint(x, y);
    if nx > 0 and ny > 0 then
        TouchManager:onTouch(type, id, nx, ny);
    end
end

function c:_changeWindowSize()
    self:setSceenSize(self.width, self.height);
end

c.instance = c.new();
TouchManager:setStage(c.instance);
return c;
