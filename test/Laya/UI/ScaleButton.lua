local class = require("Node.Core.Class");
local Image = require("Node.Laya.UI.Image")

---@class ScaleButton : Laya_UI_Image
local ScaleButton = class(Image)

local Tween = require("Node.Laya.Utils.Tween");
local Ease = require("Node.Laya.Utils.Ease");
local UIEvent = require("Node.Laya.Core.Event.Event");
local TouchEvent = require("Node.Core.Event.TouchEvent");

---@param skin string
function ScaleButton:ctor(skin)
    Image.ctor(self, skin);

    self.anchorX = 0.5;
    self.anchorY = 0.5;

    self:on(UIEvent.MOUSE_DOWN, Tween.To, self, { { scaleX = 0.8, scaleY = 0.8 }, 100, Ease.linear });
    self:on(UIEvent.MOUSE_UP, Tween.To, self, { { scaleX = 1, scaleY = 1 }, 100, Ease.inBack });
    self:on(TouchEvent.MOUSE_RELEASE_OUTSIDE, Tween.To, self, { { scaleX = 1, scaleY = 1 }, 100, Ease.inBack });

end

function ScaleButton:__setDataSource(d)
    self._dataSource = d;
    if d then
        if type(d) == "string" then
            self.skin = d;
        elseif type(d) == "table" then
            for k, v in pairs(d) do
                if type(self[k]) == "table" then
                    self[k].dataSource = v;
                elseif self[k] ~= nil then
                    self[k] = v;
                else
                    local child = self:getChildByName(k)
                    if child then
                        child.dataSource = v
                    else
                        self[k] = v;
                    end
                end
            end
        end
    end
end

---@see Node_Core_Display_Drawable#hitTest @一些缩放修正 以免按钮松开时 在比较边缘的位置无法触发CLICK
function ScaleButton:hitTest(x, y)
    if self._scaleX ~= nil and self._scaleY ~= nil then
        local w, h = self.scaleX * self.width, self.scaleY * self.height;
        local dw, dh = (self.width - w) / 2, (self.height - h) / 2;
        return x > -dw and y > -dh and x <= self.width + dw and y <= self.height + dh;
    end
    return Image.hitTest(self, x, y);
end

return ScaleButton;