---
--- Created by fox.
--- DateTime: 2018/3/29 22:35
---

local class = require("node.class");
local Box = require("node.ui.Box")
local dialogManage = require("node.ui.DialogManage")

---@class Dialog : Box
local Dialog = class(Box);

---@param this View
function Dialog.ctor(this)
    Box.ctor(this)
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
