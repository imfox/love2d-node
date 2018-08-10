---
--- Created by fox.
--- DateTime: 2018/3/16 21:22
---

---@type Loader
local Loader = require("node.core.Net.Loader");

local class = require("node.class");

local Utils = require("node.core.Utils.Utils")
local Constant = require("node.core.Utils.Constant")

---@type Component
local Component = require("node.ui.Component")


local newQuad_,translate,scale,draw,pop,push,rotate = love.graphics.newQuad,love.graphics.translate,love.graphics.scale,love.graphics.draw,love.graphics.pop,love.graphics.push,love.graphics.rotate

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



---@class Sprite : Component
---@field public sizeGrid string
---@field public skin string
---@field private _sizeGrid string
local Sprite = class(Component)


---@param this Sprite
---@param skin string
function Sprite.ctor(this,skin)
    Component.ctor(this)
    this:set("skin",function (v)
        this._skin = v;
        this._image = Loader:getImage(this._skin);
        this:_onResize()
        this:_updateSkin()
    end)
    this:get("skin",function ()
        return this._skin;
    end)

    this._sizeGrid = nil

    this:set("sizeGrid", function (v)
        this._sizeGrid = v;
        this:_updateSkin();
    end)
    this:get("sizeGrid",function ()
        return this._sizeGrid;
    end )

    this._width = 0
    this:set("width", function (v)
        if this._width ~= v then
            this._width = v;
            this.autoSize = false;
            this:_onResize()
            this:_changeSize()
        end
    end)
    this:get("width", function ()
        if this._width == nil  then
            if this._image then
                return this._image:getWidth()
            end
            return 0
        end
        return this._width;
    end)

    this._height = 0
    this:set("height", function (v)
        if this._height ~= v then
            this._height = v;
            this.autoSize = false;
            this:_onResize()
            this:_changeSize()
        end
    end)
    this:get("height", function ()
        if this._height == nil  then
            if this._image then
                return this._image:getHeight()
            end
            return 0
        end
        return this._height;
    end)


    this.skin = skin;

    this._drawMode = nil;
    
end

---@param this Sprite
function Sprite._updateSkin(this)
    if this._skin and this._sizeGrid then
        local grids =  Utils.splteText(this._sizeGrid,",");
        this:__setGrid(unpack(grids));
    end
end

---@return Sprite
function Sprite:_draw()
    if self._image ~= nil then
        if self._drawMode == 1 then
            -- todo: 这里应该设置平铺显示
        else
            ---@type Image
            local img = self._image;
            local width = img:getWidth()
            local height = img:getHeight()

            if self._sizeGrid == nil then
                local sx = self.width / width;
                local sy = self.height / height;
                draw(img,0,0,0,sx,sy,self.pivotX/sx,self.pivotY/sy)
            else
                local gridCenterWidth = width - self._grid[1] - self._grid[3]
                local gridCenterHeight = height - self._grid[2] - self._grid[4]

                local scaleXGroup = {1, (self.width - self._grid[1] - self._grid[3]) / gridCenterWidth, 1}
                local scaleYGroup = {1, (self.height - self._grid[2] - self._grid[4]) / gridCenterHeight, 1}
                local xGroup = {0, self._grid[1], self.width - self._grid[3]}
                local yGroup = {self.height - self._grid[4], self._grid[2], 0}
                for i = 1, 3 do
                    for n = 1, 3 do
                        local j = (i-1) * 3 + n
                        if (self._grid_quad[j]) then
                            draw(
                            img,
                            self._grid_quad[j],
                            (-(self.pivotX * self.scaleX) + (xGroup[n] * self.scaleX)),
                            (-(self.pivotY * self.scaleY) + (yGroup[i] * self.scaleY)),
                            0,
                            self.scaleX * scaleXGroup[n],
                            self.scaleY * scaleYGroup[i])
                        end
                    end
                end
            end
        end
    end
    return self;
end

---grid
---@param this Sprite
---@param left number
---@param top number
---@param right number
---@param bottom number
---@return Sprite
---@protected
function Sprite.__setGrid(this , top, right, bottom, left)
    if Loader:getImage(this.skin) == nil then
        return this;
    end

    this._grid = { left, top, right, bottom }
    for k, v in pairs(this._grid) do
        if type(v) ~= "number" then
            this._grid[k] = tonumber(v)
        end
    end

    local left, top, right, bottom = unpack(this._grid);


    local img = Loader:getImage(this.skin);
    local width, height = img:getWidth(), img:getHeight()
    this._grid_quad = this._grid_quad or {}
    this._grid_quad[7] = newQuad(this._grid_quad[7], 0, 0, left, top, width, height) --　左下角
    this._grid_quad[8] = newQuad(this._grid_quad[8], left, 0, width - right - left, top, width, height) --　左下角
    this._grid_quad[9] = newQuad(this._grid_quad[9], width - right, 0, right, top, width, height) --　左下角

    this._grid_quad[4] = newQuad(this._grid_quad[4], 0, top, left, height - top - bottom, width, height) --　左下角
    this._grid_quad[5] = newQuad(this._grid_quad[5], left, top, width - left - right, height - top - bottom, width, height) --　左下角
    this._grid_quad[6] = newQuad(this._grid_quad[6], width - right, top, right, height - top - bottom, width, height) --　左下角

    this._grid_quad[1] = newQuad(this._grid_quad[1], 0, height - bottom, left, bottom, width, height) --　左下角
    this._grid_quad[2] = newQuad(this._grid_quad[2], left, height - bottom, width - left - right, bottom, width, height) --　左下角
    this._grid_quad[3] = newQuad(this._grid_quad[3], width - right, height - bottom, right, bottom, width, height) --　左下角

    return this;
end





return Sprite;