---
--- Created by fox.
--- DateTime: 2018/3/16 21:22
---
local import = require("Import");
local class = import("..class");

---@type AutoBitmap
local AutoBitmap = import(".AutoBitmap")

---@type Drawable
local Drawable = import("..core.Drawable")

---@class Sprite : Drawable
local Sprite = class(Drawable)

---@param this Sprite
function Sprite.ctor(this)
    this.graphics = AutoBitmap.new();
    this.skin = "";
end

---@field public graphics AutoBitmap

---@param this Sprite
---@return Sprite
function Sprite._render(this)
    if not this.visible or this.destroyed or this.alpha == 0 or this.scaleY ==0 or this.scaleX == 0 then    -- 已经不会显示出来了
        return this;
    end
    this.graphics.one = {cmd="print",args={"test string",0,0}};
    this.graphics:_begin(this.x,this.y,this.rotation,this.scaleX,this.scaleY):_render();
    for _,drawable in ipairs(this.components) do
        if drawable._render then
            drawable:_render()
        end
    end
    this.graphics:_end();
    return this;
end



return Sprite;