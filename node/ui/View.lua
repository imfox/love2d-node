---
--- Created by fox.
--- DateTime: 2018/3/20 21:21
---
local class = require("node.class");

---@type Component
local Component = require("node.ui.Component")

---@class View : Component
local View = class(Component);

---@param this View
function View.ctor(this)
    Component.ctor(this)

end

local Box = require("node.ui.Box");
local Image = require("node.ui.Image");
local Label = require("node.ui.Label");
local ScaleButton = require("node.ui.ScaleButton");
local Dialog = require("node.ui.Dialog");

local uiClass = {}

---@param className string
function getInstance(className)
    if uiClass[className] then
        return uiClass[className].new();
    end
    return Box.new()
end


---@param table table
---@param node Node
---@param root Node
---@return Node
function createComp(table,node,root)
    if type(table) == "string" then
        table = loadstring("return "..table)();
    end

    local props = table.props;
    if not node then
        node = getInstance(table.type);
    end

    local childs = table.child;
    if childs then
        for _, data in ipairs(childs) do
            if (data.props.name == "render" or data.props.renderType == "render") then

            else
                if data.type == "Graphic" then

                else
                    local child = createComp(data,nil,root);
                    node:addChild(child);
                end

            end
        end

    end

    if props then
        for prop, v in pairs(props) do
            if prop == "var" and root then
                root[v] = node;
            else
                node[prop] = v;
            end
        end

    end

    return node;
end

---@param className string
---@param class table
function regComponent(className,class)
    uiClass[className] = class;
end



regComponent("Image",Image)
regComponent("Label",Label)
regComponent("ScaleButton",ScaleButton)
regComponent("Dialog",Dialog)
regComponent("Box",Box)


View.createComp = createComp;
View.regComponent = regComponent;

return View;

