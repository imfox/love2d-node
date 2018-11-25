local class = require("Node.Core.Class");

local Drawable = require("Node.Core.Display.Drawable");
local stage = require("Node.Core.Display.Stage").instance;
local tween = require("Node.Laya.Utils.Tween");
local ease = require("Node.Laya.Utils.Ease");
local UIEvent = require("Node.Core.Event.Event");
local Handler = require("Node.Core.Utils.Handler");

---@class Laya_UI_DialogManager__Background : Node_Core_Display_Drawable
local Backgroud = class(Drawable);
function Backgroud:__draw(gr)
    gr.setColor(0, 0, 0, self.alpha);
    gr.rectangle("fill", 0, 0, self.width, self.height);
end
-----------------------------


---@class Laya_UI_DialogManager : Node_Core_Display_Drawable
local c = class(Drawable);

function c:ctor()
    Drawable.ctor(self)

    self.maskLayer = Backgroud.new();
    self.maskLayer.alpha = 0;
    self:addChild(self.maskLayer);

    stage:on(UIEvent.RESIZE, self._adjust, self);

    self.name = "dialogManage"
    self.zOrder = 1000;
    self.visible = false;
    stage:addChild(self);

end

---@private
function c:_adjust()
    local w, h = stage.width, stage.height;
    self.maskLayer:size(w, h);
    self:size(w, h);
end

---@param dialog Laya_UI_Dialog
---@param center boolean
---@param anime boolean
---@return Laya_UI_Dialog
function c:open(dialog, center, anime)
    anime = anime or true;
    center = center or true;

    if center then
        self:_center(dialog)
    end
    self:_adjust();

    if anime then
        dialog:scale(1, 1)
        self.maskLayer.alpha = 0;
        self.maskLayer:removeSelf()
        self:addChild(self.maskLayer)
        tween.To(self.maskLayer, { alpha = 0.4 }, 250, ease.linear);
        tween.From(dialog, { x = stage.width / 2, y = stage.height / 2, scaleX = 0, scaleY = 0 }, 250, ease.outBack);
    end

    self:addChild(dialog)
    self.visible = self:numChild() > 0;
    self:size(stage.width, stage.height)
    return dialog;
end

---@param dialog Laya_UI_Dialog
function c:close(dialog)
    tween.To(self.maskLayer, { alpha = 0 }, 250, ease.inBack);
    tween.To(dialog, { x = stage.width / 2, y = stage.height / 2, scaleX = 0, scaleY = 0 }, 250, ease.inBack, Handler.new(self, self._close, { dialog }, true));
    return dialog;
end

---@param dialog Laya_UI_Dialog
function c:_close(dialog)
    dialog:removeSelf();
    self.visible = self:numChild() > 1;
end

---@param dialog Laya_UI_Dialog
function c:_center(dialog)
    dialog.x = math.floor(((stage.width - dialog.width) / 2) + dialog.pivotX);
    dialog.y = math.floor(((stage.height - dialog.height) / 2) + dialog.pivotY);
    return dialog;
end

c.instance = c.new()
return c;
