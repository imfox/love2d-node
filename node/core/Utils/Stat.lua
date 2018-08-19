---
--- Created by fox.
--- DateTime: 2018/8/19 13:01
---

---@type Drawable
local Drawable = require("node.core.Display.Drawable");

---@type stage
local stage = require("node.core.Display.Stage");

---@type node2d_utils_font
local Font = require("node.core.Utils.Font");

---@type node_Timer
local Timer = require("node.core.Utils.Timer");

---@class node2d_utils_stat_ : Drawable
local c = class(Drawable);



function c:ctor()
    Drawable.ctor(self);
    self.zOrder = 9999;
end

function c:_draw(graphics)
    local status = love.graphics.getStats()
    local info = string.format("FPS: %d \nDrawcalls: %d \nImages: %d\nFonts: %d \nMemory: %.2f MB \nTimers: %d", love.timer.getFPS(), status.drawcalls, status.images, status.fonts, status.texturememory / 1024 / 1024, Timer:getTimerCount());
    local font = Font.defaultFont;
    graphics.setFont(font);
    graphics.setColor(0.3, 0.3, 0.3, 0.7);
    graphics.rectangle("fill", 0, 0, font:getWidth(info) + 10, font:getHeight() * 6 + 10);
    graphics.setColor(1, 1, 1, 1)
    graphics.print(info, 5, 5);
end

---@type node2d_utils_stat_
local instance

---@class node2d_utils_stat : Klass
local stat = class()

function stat:show()
    if not instance then
        instance = c.new();
    end
    stage:addChild(instance);
end

function stat:hide()
    if instance then
        instance:removeSelf();
    end
end


---@type node2d_utils_stat
local s = stat.new();
return s;
