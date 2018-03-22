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

---@type Drawable
local Drawable = require("nodeFrame.core.Display.Drawable")

---@class Label : Drawable
local Label = class(Drawable)

---@param this Label
function Label.ctor(this)
    this.graphics = AutoBitmap.new();
    this.text = "";
end

---@field public graphics AutoBitmap

---@param this Label
---@return Label
function Label._render(this)
    if not this.visible or this.destroyed or this.alpha == 0 or this.scaleY ==0 or this.scaleX == 0 then    -- 已经不会显示出来了
        return this;
    end
    this.graphics.one = {cmd="print",args={this.text,0,0,0,1,1,this.pivotX,this.pivotY}};
    this.graphics:_begin(this.x,this.y,this.rotation,this.scaleX,this.scaleY):_render();
    for _,drawable in ipairs(this.components) do
        if drawable._render then
            drawable:_render()
        end
    end
    this.graphics:_end();
    return this;
end


return Label;