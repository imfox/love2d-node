local class = require("Node.Core.Class");
local IView = require("Node.Laya.UI.IView");

---@type Component
local Component = require("Node.Laya.UI.Component");

---
local Image = require("Node.Laya.UI.Image");
local Label = require("Node.Laya.UI.Label");
--local List = require("node.ui.List");
local ScaleButton = require("Node.Laya.UI.ScaleButton");
local Dialog = require("Node.Laya.UI.Dialog");
--local Button = require("node.ui.Button");
local Box = require("Node.Laya.UI.Box");

---@class View : Component
local View = class(Component);

---@param this View
function View.ctor(this)
    Component.ctor(this)

end

IView.regComponent("Image", Image)
IView.regComponent("Label", Label)
--IView.regComponent("List", List)
IView.regComponent("ScaleButton", ScaleButton)
IView.regComponent("Dialog", Dialog)
IView.regComponent("Box", Box)
--IView.regComponent("Button", Button);
IView.regComponent("View", View);

View.createComp = IView.createComp;
View.regComponent = IView.regComponent;

return View;

