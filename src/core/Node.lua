
---@type Message
local Message = require("core.Message")

---@class Node : Message
---@field public new Node
---@field protected components Node[] @子组件数组
---@field public name string @sss
---@field public parent Node @rr
local Node =  class(Message);

function Node:ctor()
    self.name = "";
    self.components = {};
    self.parent = nil;
end

---@param node Node
---@return Node
---@param this Node
function Node.addChild(this,node)
    table.insert(self.components,node);
    this.addChildAt(this,node,nil);
    return this;
end

---@param this Node
---@param node Node
---@param index number
---@return Node
function Node.addChildAt(this,node,index)
    table.insert(this.components,node,index);
    return this;
end

---@param node Node
---@return Node
function Node:removeChild(node)
    return self:removeChildAt(self:getChildIndex(node))
end

---@param name string
---@return Node
function Node:removeChildByName(name)
    return self:removeChildAt(self:getChildByName(name));
end

---@param index number
---@return Node
function Node:removeChildAt(index)
    return table.remove(self.components,index);
end

---@param name string
---@return Node
function Node:getChildByName(name)
    for index = #self.components, 1 ,-1 do
        if(name == self.components[index].name) then
            return components[index];
        end
    end
end

---@param node Node
---@return number
function Node:getChildIndex(node)
    for index = #self.components, 1,-1 do
        if(node == self.components[index]) then
            return index;
        end
    end
    return -1;
end

---@return Node
function Node:removeSelf()
    if self.parent ~= nil then
        self.parent:removeChild(self);
    end
end

