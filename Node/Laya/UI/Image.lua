local Class = require("Node.Core.Class");
local Utils = require("Node.Core.Utils.Utils");
local LUtils = require("Node.Laya.Utils.Utils");
local Component = require("Node.Laya.UI.Component");
local Loader = require("Node.Laya.Core.Net.Loader").instance;
local Event = require("Node.Laya.Core.Event.Event");
local newQuad_ = love.graphics.newQuad

---newQuad
---@param quad Quad
---@param x number
---@param y number
---@param w number
---@param h number
---@param width number
---@param height number
---@return Quad
local function newQuad(quad, x, y, w, h, width, height)
    if (w == 0 or h == 0) then
        return nil
    end
    if quad == nil then
        quad = newQuad_(x, y, w, h, width, height)
    else
        quad:setViewport(x, y, w, h)
    end
    return quad
end

local function _fill(draw, img, quad, x, y, width, height)
    local bx = x;
    local by = y;
    local qx, qy, qw, qh = quad:getViewport();
    local bh = height
    while bh > 0 do
        local bw = width
        if bh < qh then
            quad:setViewport(qx, qy, bw, bh)
        end
        while bw > 0 do
            if bw < qw then
                quad:setViewport(qx, qy, bw, qh)
            end
            draw(img, quad, bx + width - bw, by + height - bh, 0, 1, 1);
            bw = bw - qw;
        end
        bh = bh - qh;
        quad:setViewport(qx, qy, qw, qh)
    end
end

---@class Laya_UI_Image : Component
---@field public sizeGrid string
---@field public skin string
local c = Class(Component)

---@param skin string
function c:ctor(skin)
    Component.ctor(self)

    ---@private
    self._skin = nil;
    self:setter_getter("skin", self.__setSkin, self.__getSkin);

    ---@private
    self._sizeGrid = nil
    self:setter_getter("sizeGrid", self.__setSizeGrid, self.__getSizeGrid);

    self._drawMode = nil;

    if skin then
        self.skin = skin;
    end
end

---@protected
function c:__setDataSource(d)
    if d then
        if type(d) == "string" then
            self.skin = d;
        elseif type(d) == "table" then
            for k, v in pairs(d) do
                if type(self[k]) == "table" and self[k].dataSource then
                    self[k].dataSource = v;
                else
                    self[k] = v;
                end
            end
        end
    end
    self._dataSource = d;
end
---@private
function c:__setSizeGrid(v)
    self._sizeGrid = v;
    self:_updateSkin();
end
---@private
function c:__getSizeGrid()
    return self._sizeGrid;
end
---@private
function c:__getWidth()
    if not self._width and self._image then
        return self._image:getWidth()
    end
    return self._width or 0;
end

---@private
function c:__getHeight()
    if not self._height and self._image then
        return self._image:getHeight()
    end
    return self._height or 0;
end

---@private
function c:__setSkin(v)
    self._skin = v;
    Loader:load(self._skin, Loader.IMAGE, true, Utils.call(self._onLoad, self));
end

---@private
function c:__getSkin()
    return self._skin;
end

---@protected
function c:_onLoad()
    if self._skin then
        self._image = Loader.getRes(self._skin);
        self:_onResize();
        self:event(Event.LOADED);
    end
end

---@protected
function c:_onResize()
    Component._onResize(self);
    self:_updateSkin()
end

---@private
function c:_updateSkin()
    if self._skin and self._sizeGrid then
        local grids = LUtils.splteText(self._sizeGrid, ",");
        if #grids >= 5 and grids[5] == "1" then
            self._drawMode = 1;
        end
        self:__setGrid(unpack(grids));
    end
end

---@protected
---@return Laya_UI_Image
function c:__draw(gr)
    if self._image ~= nil then
        ---@type Image
        local img = self._image;
        local width = img:getWidth()
        local height = img:getHeight()

        if self._sizeGrid == nil then
            local sx = self.width / width;
            local sy = self.height / height;
            gr.draw(img, 0, 0, 0, sx, sy, self.pivotX / sx, self.pivotY / sy)
        else
            local gridCenterWidth = width - self._grid[1] - self._grid[3]
            local gridCenterHeight = height - self._grid[2] - self._grid[4]

            local scaleXGroup = { 1, (self.width - self._grid[1] - self._grid[3]) / gridCenterWidth, 1 }
            local scaleYGroup = { 1, (self.height - self._grid[2] - self._grid[4]) / gridCenterHeight, 1 }
            local xGroup = { 0, self._grid[1], self.width - self._grid[3] }
            local yGroup = { self.height - self._grid[4], self._grid[2], 0 }

            local dw, dh;
            if self._drawMode == 1 then
                dw = { self._grid[1], gridCenterWidth, self._grid[3] };
                dh = { self._grid[4], gridCenterHeight, self._grid[2] };
            end

            local j, quad;
            for i = 1, 3 do
                for n = 1, 3 do
                    j = (i - 1) * 3 + n
                    quad = self._grid_quad[j];
                    if (quad) then
                        local bx = (-(self.pivotX * self.scaleX) + (xGroup[n] * self.scaleX));
                        local by = (-(self.pivotY * self.scaleY) + (yGroup[i] * self.scaleY));
                        if self._drawMode == 1 then
                            _fill(gr.draw, img, quad, bx, by, self.scaleX * scaleXGroup[n] * dw[n], self.scaleY * scaleYGroup[i] * dh[i])
                        else
                            gr.draw(img, quad, bx, by, 0, self.scaleX * scaleXGroup[n], self.scaleY * scaleYGroup[i])
                        end
                    end
                end
            end
        end
    end
    return self;
end

---@protected
---@param left number
---@param top number
---@param right number
---@param bottom number
---@return Laya_UI_Image
function c:__setGrid(top, right, bottom, left)
    if self._image == nil then
        return self;
    end

    self._grid = { left, top, right, bottom }
    for k, v in pairs(self._grid) do
        if type(v) ~= "number" then
            self._grid[k] = tonumber(v)
        end
    end

    local left, top, right, bottom = unpack(self._grid);

    local img = self._image;
    local width, height = img:getWidth(), img:getHeight()
    self._grid_quad = self._grid_quad or {}
    self._grid_quad[7] = newQuad(self._grid_quad[7], 0, 0, left, top, width, height) --　左下角
    self._grid_quad[8] = newQuad(self._grid_quad[8], left, 0, width - right - left, top, width, height) --　左下角
    self._grid_quad[9] = newQuad(self._grid_quad[9], width - right, 0, right, top, width, height) --　左下角

    self._grid_quad[4] = newQuad(self._grid_quad[4], 0, top, left, height - top - bottom, width, height) --　左下角
    self._grid_quad[5] = newQuad(self._grid_quad[5], left, top, width - left - right, height - top - bottom, width, height) --　左下角
    self._grid_quad[6] = newQuad(self._grid_quad[6], width - right, top, right, height - top - bottom, width, height) --　左下角

    self._grid_quad[1] = newQuad(self._grid_quad[1], 0, height - bottom, left, bottom, width, height) --　左下角
    self._grid_quad[2] = newQuad(self._grid_quad[2], left, height - bottom, width - left - right, bottom, width, height) --　左下角
    self._grid_quad[3] = newQuad(self._grid_quad[3], width - right, height - bottom, right, bottom, width, height) --　左下角

    return self;
end

return c;
