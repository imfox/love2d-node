---
--- Created by fox.
--- DateTime: 2018/3/20 20:53
---
---
--- Created by fox.
--- DateTime: 2018/3/16 21:22
---
---@type Loader
local Loader = require("node.core.Net.Loader");

local class = require("node.class");

---@type Component
local Component = require("node.ui.Component")

local Utils = require("node.core.Utils.Utils")

local setShader,translate,scale,printf,pop,push,rotate = love.graphics.setShader,love.graphics.translate,love.graphics.scale,love.graphics.printf,love.graphics.pop,love.graphics.push,love.graphics.rotate


---@class Label : Component
local Label = class(Component)

---@param this Label
function Label.ctor(this)
    Component.ctor(this)
    --this.graphics = AutoBitmap.new();
    this.text = "";
    this.align = "left";
    this.valign = "top";
    this.color = "#fff";
    this._font = love.graphics.getFont()

    this:set("font", function (v)
        local font = Loader:getFont(v);
        if not font then return end
        this._font = font;
    end)

    this:get("font", function ()
        return this._font;
    end)
end

---@return Label
function Label._draw(this)
    love.graphics.setFont(this.font);

    local x,y = 0,0;
    if this.valign == "middle" or this.valign  == "bottom" then
        local h = this.height - love.graphics.getFont():getHeight() * #(Utils.splteText(this.text,"\n"));
        y =  h / (this.valign=="middle"and 2 or 1);
        if y < 0 then
            y = 0
        end
    end

    printf(this.text,x,y,this.width,this.align,0,1,1,this.pivotX,this.pivotY)
    return this;
end



return Label;