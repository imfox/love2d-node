---
--- Created by fox.
--- DateTime: 2018/3/20 20:53
---
---
--- Created by fox.
--- DateTime: 2018/3/16 21:22
---
---@type Loader
local Loader = require("nodeFrame.core.Net.Loader");

local class = require("nodeFrame.class");

---@type AutoBitmap
local AutoBitmap = require("nodeFrame.ui.AutoBitmap")

---@type Component
local Component = require("nodeFrame.ui.Component")

local Utils = require("nodeFrame.core.Utils.Utils")
---@class Label : Component
local Label = class(Component)

---@param this Label
function Label.ctor(this)
    this:super()
    --this.graphics = AutoBitmap.new();
    this.text = "";
    this.align = "left";
    this.valign = "top";
    this.color = "#fff";
end

---@field public graphics AutoBitmap

---@param this Label
---@return Label
function Label._render(this)
    if not this.visible or this.destroyed or this.alpha == 0 or this.scaleY ==0 or this.scaleX == 0 then    -- 已经不会显示出来了
        return this;
    end

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

    local x,y = 0,0;
    if this.valign == "middle" or this.valign  == "bottom" then
        local h = this.height - love.graphics.getFont():getHeight() * #(Utils.splteText(this.text,"\n"));
        y =  h / (this.valign=="middle"and 2 or 1);
        if y < 0 then
            y = 0
        end
    end
    this.graphics.one = {cmd="printf",args={this.text,x,y,this.width,this.align,0,1,1,this.pivotX,this.pivotY}};
    this.graphics:_begin(this.x,this.y,this.rotation,this.scaleX,this.scaleY):_render();
    this.graphics:translate(-this.pivotX,-this.pivotY)
    for _,drawable in ipairs(this.components) do
        if drawable._render then
            drawable:_render()
        end
    end
    this.graphics:_end();
    return this;
end


return Label;