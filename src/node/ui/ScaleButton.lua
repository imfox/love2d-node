---
--- Created by fox.
--- DateTime: 2018/3/27 21:43
---

local class = require("node.class");

---@type Sprite
local Image = require("node.ui.Image")

---@class ScaleButton : Sprite
local ScaleButton = class(Image)

local Tween = require("node.core.Utils.Tween");
local Ease = require("node.core.Utils.Ease");

---@param this ScaleButton
---@param skin string
function ScaleButton.ctor(this,skin)
    this:super(skin)

    this.anchorX = 0.5;
    this.anchorY = 0.5;

    this:on("MOUSE_DOWN", function ()
        Tween.to(this,{scaleX=0.8,scaleY=0.8},100,Ease.linear)
    end)
    this:on("MOUSE_UP", function ()
        Tween.to(this,{scaleX=1,scaleY=1},100,Ease.inBack)
        this._press = false;
    end)
end


return ScaleButton;