---
--- Created by fox.
--- DateTime: 2018/3/29 22:35
---
local class = require("node.class");

local Drawable = require("node.core.Display.Drawable")
local stage = require("node.core.Display.Stage")
local tween = require("node.core.Utils.Tween")
local ease = require("node.core.Utils.Ease")
local UIEvent = require("node.core.Event.UIEvent")

---@type DialogManage
local dialogManage


---@class DialogManage : Drawable
local DialogManage = class(Drawable);

---@param this DialogManage
function DialogManage.ctor(this)
    Drawable.ctor(this)
    this.maskLayer = Drawable.new();
    this.visible = false;

    stage:on(UIEvent.RESIZE,function ()
        local w,h = stage.width,stage.height
        this:size(w,h)
        this.maskLayer:size(w,h)
        this.maskLayer.graphics:clear()
        this.maskLayer.alpha = 0.4;
this.maskLayer.graphics:setColor(0x1,0x1,0x1,this.maskLayer.alpha * 255)
this.maskLayer.graphics:rectangle("fill",0,0,w,h)
this.maskLayer.graphics:setColor(255,255,255)
end)

this:addChild(this.maskLayer);
this.zOrder = 1000;
this.name = "dialogManage"
stage:addChild(this);
end

---@param this DialogManage
---@param dialog Dialog
---@param center boolean
---@param anime boolean
---@return Dialog
function DialogManage.open(this,dialog,center,anime)
    if anime == nil then anime = true end
    if center == nil then center = true end

    if center then
        this:_center(dialog)
    end

    if anime then
        dialog:scale(1,1)
        this.maskLayer.alpha = 0;
        this.maskLayer:removeSelf()
        this:addChild(this.maskLayer)
        tween.to(this.maskLayer,{alpha=1},250,ease.linear);
        tween.from(dialog,{x = stage.width/2,y =stage.height/2,scaleX= 0, scaleY=0},250,ease.outBack);
    end

    this:addChild(dialog)
    this.visible = this:numChild() > 0;
    this:size(stage.width,stage.height)
    return dialog;
end

---@param this DialogManage
---@param dialog Dialog
function DialogManage.close(this,dialog)
    tween.to(this.maskLayer,{alpha=0},250,ease.inBack);
    tween.to(dialog,{x = stage.width/2,y =stage.height/2,scaleX= 0, scaleY=0},250,ease.inBack, function ()
        dialog:removeSelf();
        this.visible = this:numChild() > 1;
    end);
    return dialog;
end

---@param this DialogManage
---@param dialog Dialog
function DialogManage._center(this,dialog)
    dialog.x = math.floor(((stage.width - dialog.width)/2) + dialog.pivotX);
    dialog.y = math.floor(((stage.height - dialog.height)/2) + dialog.pivotY);
    return dialog;
end


dialogManage = DialogManage.new()
return dialogManage;
