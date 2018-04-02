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


local newQuad_,setShader,translate,scale,draw,pop,push,rotate = love.graphics.newQuad,love.graphics.setShader,love.graphics.translate,love.graphics.scale,love.graphics.draw,love.graphics.pop,love.graphics.push,love.graphics.rotate

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
end

---@param this Sprite
function Sprite._updateSkin(this)
    if this._skin and this._sizeGrid then
        local grids =  Utils.splteText(this._sizeGrid,",");
        this:__setGrid(unpack(grids));
    end
end

---@field public graphics AutoBitmap
---@field public parent Drawable

---@param this Sprite
---@return Sprite
function Sprite._render(this)
    if not this.visible or this.destroyed or this.alpha == 0 or this.scaleY ==0 or this.scaleX == 0 then    -- 已经不会显示出来了
        return this;
    end

    push()
    translate(this.x,this.y)
    scale(this.scaleX,this.scaleY)
    rotate(math.rad(this.rotation))
    if this.gray or this.disabled then
        setShader(Constant.grayShader)
    end

    if this._image ~= nil then
        this.graphics:clear();

        ---@type Image
        local img = this._image;
        local width = img:getWidth()
        local height = img:getHeight()

        if this._sizeGrid == nil then
            local sx = this.width / width;
            local sy = this.height / height;
            draw(img,0,0,0,sx,sy,this.pivotX/sx,this.pivotY/sy)
        else
            local gridCenterWidth = width - this._grid[1] - this._grid[3]
            local gridCenterHeight = height - this._grid[2] - this._grid[4]

            local scaleXGroup = {1, (this.width - this._grid[1] - this._grid[3]) / gridCenterWidth, 1}
            local scaleYGroup = {1, (this.height - this._grid[2] - this._grid[4]) / gridCenterHeight, 1}
            local xGroup = {0, this._grid[1], this.width - this._grid[3]}
            local yGroup = {this.height - this._grid[4], this._grid[2], 0}
            for i = 1, 3 do
                for n = 1, 3 do
                    local j = (i-1) * 3 + n
                    if (this._grid_quad[j]) then
                        draw(
                        img,
                        this._grid_quad[j],
                        (-(this.pivotX * this.scaleX) + (xGroup[n] * this.scaleX)),
                        (-(this.pivotY * this.scaleY) + (yGroup[i] * this.scaleY)),
                        0,
                        this.scaleX * scaleXGroup[n],
                        this.scaleY * scaleYGroup[i])
                    end
                end
            end
        end
    end

    this.graphics:_render();
    translate(-this.pivotX,-this.pivotY)

    for _,drawable in ipairs(this.components) do
        if drawable._render then
            drawable:_render()
        end
    end
    if this.gray or this.disabled then
        setShader()
    end
    pop()
    return this;
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