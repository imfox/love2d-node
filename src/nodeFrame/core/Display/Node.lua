--local import = require("Import");
local class = require("nodeFrame.class");

---@type Message
local Message = require("nodeFrame.core.Display.Message")

---@class Node : Message
local Node =  class(Message);
---@field public new Node
---@field protected components Node[] @子组件数组
---@field public name string @名称
---@field public parent Node @父对象
---@field public destroyed boolean @是否已经被销毁

function Node:ctor()
    self.name = "";
    self.components = {};
    self.parent = nil;
    self.destroyed = false;
end

---@param node Node
---@return Node
---@param this Node
function Node.addChild(this,node)
    this.addChildAt(this,node,nil);
    return this;
end

---@param this Node
---@param node Node
---@param index number
---@return Node
function Node.addChildAt(this,node,index)
    if this.destroyed or node == nil or node.destroyed or node == this then
        return this;
    end
    if node.parent then
        node.parent.removeChild(node.parent,node);
    end
    table.insert(this.components,index==nil and #this.components+1 or index,node);
    node.parent = this;
    return this;
end

---@param node Node
---@return Node
---@param this Node
function Node.removeChild(this,node)
    return this:removeChildAt(this:getChildIndex(node))
end

---@param name string
---@return Node
---@param this Node
function Node.removeChildByName(this,name)
    return this:removeChild(this:getChildByName(name));
end

---@param index number
---@return Node
---@param this Node
function Node.removeChildAt(this,index)
    ---@type Node
    local node = table.remove(this.components,index);
    node.parent = nil;
    return this;
end

---@param name string
---@return Node
---@param this Node
function Node.getChildByName(this,name)
    for index = #this.components, 1 ,-1 do
        if(name == this.components[index].name) then
            return this.components[index];
        end
    end
end

---@param index number
---@return Node
---@param this Node
function Node.getChildAt(this,index)
    return this.components[index];
end

---@param node Node
---@return number
---@param this Node
function Node.getChildIndex(this,node)
    for index = #this.components, 1, -1 do
        if(node == this.components[index]) then
            return index;
        end
    end
    return -1;
end

---@return Node
---@param this Node
function Node.removeSelf(this)
    if this.parent ~= nil then
        this.parent:removeChild(this);
    end
    return this;
end

---@param this Node
---@param parent Node
---@return Node
function Node.addTo(this,parent)
    parent:addChild(this);
    return this;
end

---@param this Node
---@param newNode Node
---@param node Node
---@return Node
function Node.replaceChild(this,node ,newNode)
    local index = this:getChildIndex(node);
    if index > 0 and newNode then
        if newNode.parent then
            local nIndex = newNode.parent:getChildIndex(newNode);
            newNode.parent:addChildAt(node,nIndex);
        else
            node:removeSelf();
        end
        this:addChildAt(newNode,index);
    end
    return this;
end

---@param this Node
---@param node Node
---@return boolean
function Node.contains(this,node)
    return this:getChildIndex(node) > 0;
end

---@param this Node
---@param destroyChild boolean
---@return void
function Node.destroy(this,destroyChild)
    this.destroyed = true;
    this:removeSelf();
    if destroyChild ~= false then
        this:destroyChildren();
    end
    this.name = nil;
    this.components = nil
    this.parent = nil;
    this:offAll();
end

---@param this Node
---@return number
function Node.numChild(this)
    return #this.components;
end

---@param this Node
---@return Node
function Node.destroyChildren(this)
    for i = #this.components,1,-1 do
        this.components[i]:destroy(true);
    end
end
return Node;
