---
--- Created by fox.
--- DateTime: 2018/3/16 21:22
---

---@type Loader
local Loader = require("nodeFrame.core.Net.Loader");

local class = require("nodeFrame.class");

local Utils = require("nodeFrame.core.Utils.Utils")
local Constant = require("nodeFrame.core.Utils.Constant")

---@type Component
local Component = require("nodeFrame.ui.Component")


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
local Sprite = class(Component)

---@param this Sprite
---@param skin string
function Sprite.ctor(this,skin)
    --this.graphics = AutoBitmap.new();
    this:super()
    this.skin = skin;
    this.sizeGrid = "";
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

    if Loader:getImage(this.skin) ~= nil then
        this.graphics:clear();

        ---@type Image
        local img = Loader:getImage(this.skin);

        local width = img:getWidth()
        local height = img:getHeight()

        this.width = this.width == 0 and width or this.width;
        this.height = this.height == 0 and height or this.height;

        if this.anchorX ~= 0 and this.anchorX ~= nil then
            this.pivotX = this.width * this.anchorX;
        end
        if this.anchorY ~= 0 and this.anchorY ~= nil then
            this.pivotY = this.height * this.anchorY;
        end
        if this.parent then
            if this.left ~= nil then
                this.x = this.left + this.pivotX;
            end
            if this.top ~= nil then
                this.y =  this.top + this.pivotY;
            end
            if this.right ~= nil then
                this.width = this.parent.width - (this.x-this.pivotX) - this.right;
            end
            if this.bottom ~= nil then
                this.height = this.parent.height - (this.y-this.pivotY) - this.bottom;
            end
       end


        if this.sizeGrid == nil or this.sizeGrid == "" then
            local sx = this.width / width;
            local sy = this.height / height;
            draw(img,0,0,0,sx,sy,this.pivotX/sx,this.pivotY/sy)
        else
            local grids =  Utils.splteText(this.sizeGrid,",");
            this:__setGrid(unpack(grids));

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