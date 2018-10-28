---
--- Created by fox.
--- DateTime: 2018/3/27 21:43
---

local class = require("node.class");

---@type Sprite
local Image = require("node.ui.Image")

local void = require("node.core.Utils.Utils").void;

---@class ScaleButton : Sprite
local ScaleButton = class(Image)

local Tween = require("node.core.Utils.Tween");
local Ease = require("node.core.Utils.Ease");
local UIEvent = require("node.core.Event.UIEvent");
---@param this ScaleButton
---@param skin string
function ScaleButton.ctor(this, skin)
    Image.ctor(this, skin);

    this.anchorX = 0.5;
    this.anchorY = 0.5;

    this:on(UIEvent.MOUSE_DOWN, Tween.to, { this, { scaleX = 0.8, scaleY = 0.8 }, 100, Ease.linear, void });
    this:on(UIEvent.MOUSE_UP, Tween.to, { this, { scaleX = 1, scaleY = 1 }, 100, Ease.inBack, void });
    this:on(UIEvent.MOUSE_LEAVE_UP, Tween.to, { this, { scaleX = 1, scaleY = 1 }, 100, Ease.inBack, void });


    this:setter("dataSource", function(d)
        this._dataSource = d;
        if d then
            if type(d) == "string" then
                this.skin = d;
            elseif type(d) == "table" then
                for k, v in pairs(d) do
                    if type(this[k]) == "table" then
                        this[k].dataSource = v;
                    elseif this[k] ~= nil then
                        this[k] = v;
                    else
                        local child = this:getChildByName(k)
                        if child then
                            child.dataSource = v
                        else
                            this[k] = v;
                        end
                    end
                end
            end
        end
    end)

    this:getter("dataSource", function()
        return this._dataSource;
    end)

end


return ScaleButton;