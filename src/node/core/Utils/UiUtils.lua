---
--- Created by fox.
--- DateTime: 2018/3/21 0:08
---

local Drawable = require("node.core.Display.Drawable");
local Image = require("node.ui.Image");
local Label = require("node.ui.Label");
local ScaleButton = require("node.ui.ScaleButton");
local Utils = {};


---@param className string
function Utils.getInstance(className)
    if className == "Image" then
        return Image.new();
    elseif className == "Label" then
        return Label.new();
    elseif className == "ScaleButton" then
        return ScaleButton.new();
    else
        return Drawable.new()
    end
end


---@param table table
---@param node Node
---@param root Node
---@return Node
function Utils.createByTable(table,node,root)
    if type(table) == "string" then
        table = loadstring("return "..table)();
    end

    local props = table.props;
    if not node then
        --print(table.type)
        node = Utils.getInstance(table.type);
    end

    local childs = table.child;
    if childs then
        for _, data in ipairs(childs) do
            if (data.props.name == "render" or data.props.renderType == "render") then

            else
                if data.type == "Graphic" then

                else
                    local child = Utils.createByTable(data,nil,root);
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

return Utils;