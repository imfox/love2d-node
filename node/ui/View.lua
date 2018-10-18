---
--- Created by fox.
--- DateTime: 2018/3/20 21:21
---
local class = require("node.class");
local IView = require("node.ui.IView");

---@type Component
local Component = require("node.ui.Component");

---
local Image = require("node.ui.Image");
local Label = require("node.ui.Label");
local List = require("node.ui.List");
local ScaleButton = require("node.ui.ScaleButton");
local Dialog = require("node.ui.Dialog");
local Button = require("node.ui.Button");
local Box = require("node.ui.Box");

---@class View : Component
local View = class(Component);

---@param this View
function View.ctor(this)
    Component.ctor(this)

end

IView.regComponent("Image", Image)
IView.regComponent("Label", Label)
IView.regComponent("List", List)
IView.regComponent("ScaleButton", ScaleButton)
IView.regComponent("Dialog", Dialog)
IView.regComponent("Box", Box)
IView.regComponent("Button", Button);
IView.regComponent("View", View);

View.createComp = IView.createComp;
View.regComponent = IView.regComponent;

return View;

