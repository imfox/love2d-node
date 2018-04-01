---
--- Created by fox.
--- DateTime: 2018/3/29 22:35
---

local class = require("node.class");
local View = require("node.ui.View")
local dialogManage = require("node.ui.DialogManage")

---@class Dialog : View
local Dialog = class(View);

---@param this View
function Dialog.ctor(this)
    View.ctor(this)
    this.dragArea = nil;
end

---@param this Dialog
function Dialog.popup(this)
    dialogManage:open(this,true,true)
end

---@param this Dialog
function Dialog.close(this)
    dialogManage:close(this,true,true)
end

return Dialog;
