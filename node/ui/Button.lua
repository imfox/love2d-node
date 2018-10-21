---
--- Created by fox.
--- DateTime: 2018/10/15 17:06
---

local graphics = love.graphics;
local Loader = require("node.core.Net.Loader");
local Utils = require("node.core.Utils.Utils");
local UIEvent = require("node.core.Event.UIEvent");
local s = require("node.ui.Component");

---@class node2d_ui_button : Component
---@field stateNum number
---@field skin string
---@field private _stateNum
local c = class(s);

function c:ctor()
    s.ctor(self);

    ---@private
    self._stateNum = 3;
    ---@private
    self._skin = "";
    ---@private
    ---@type Image
    self._image = nil;


    ---@private
    ---@type Quad
    self._quad = nil --graphics.newQuad(0, 0, 0, 0, 100, 100);

    ---@private
    self._status = 0;

    self:setter("stateNum", function(v)
        self._stateNum = v;
        self:_complete();
    end)
    self:getter("stateNum", function()
        return self._stateNum;
    end)


    self:setter("skin", function(s)
        self._skin = s;
        Loader:load(s, Loader.IMAGE, true, Utils.call(self._complete, self));
    end)

    self:getter("skin", function()
        return self._skin;
    end)

    self:getter("height", function()
        if self._height == nil then
            if self._image then
                return self._image :getHeight() / self.stateNum;
            end
        end
        return self._height;
    end)

    self:setter("height", function(v)
        self._height = v;
    end)


    self:getter("width", function()
        if self._height == nil then
            if self._image then
                return self._image :getWidth();
            end
        end
        return self._width;
    end)


    self:setter("width", function(v)
        self._width = v;
    end)

    self:on(UIEvent.MOUSE_DOWN, Utils.call(self.onMouseDown, self));
    self:on(UIEvent.MOUSE_UP, Utils.call(self.onMouseUp, self));
    self:on(UIEvent.MOUSE_OVER, Utils.call(self.onMouseUp, self));
    self:on(UIEvent.MOUSE_LEAVE_UP, Utils.call(self.onMouseUp, self));

end


function c:onMouseDown()
    if self._image then
        if self.stateNum >= 3 then
            self._status = 2;
        else
            self._status = self.stateNum - 1;
        end
        self:_updateQuad();
    end
end

function c:onMouseUp()
    if self._image then
        self._status = 0;
        self:_updateQuad();
        --self:event(UIEvent.CLICK);
    end
end

---@return Quad
local function getQuad(status, stateNum, width, height )
    local vheight = height / stateNum;
    return graphics.newQuad(0, status * vheight, width, vheight, width, height );
end

function c:_complete()
    if self._skin then
        self._image = Loader:getRes(self._skin)
        self:_updateQuad();
    end
end

---@private
function c:_updateQuad()
    if self._quad then
        self._quad:release();
        self._quad = nil;
    end
    self._quad = getQuad(self._status, self._stateNum, self._image:getWidth(), self._image:getHeight())

end

function c:_draw(graphics)
    if self._image then
        graphics.draw(self._image, self._quad);
    end
end

return c;
