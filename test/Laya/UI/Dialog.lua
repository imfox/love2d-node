local class = require("Node.Core.Class");
local Box = require("Node.Laya.UI.Box");
local dialogManage = require("Node.Laya.UI.DialogManager");

---@class Laya_UI_Dialog : Box
local Dialog = class(Box);

---@param this View
function Dialog.ctor(this)
    Box.ctor(this)
    this.dragArea = nil;
end

---@param this Laya_UI_Dialog
function Dialog.popup(this)
    dialogManage.instance:open(this, true, true)
end

---@param this Laya_UI_Dialog
function Dialog.close(this)
    dialogManage.instance:close(this, true, true)
end

return Dialog;
