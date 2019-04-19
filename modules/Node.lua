---@type Class
local Class = require("class");
local Event = require("node.modules.Event");
local EventDispatcher = require("node.modules.EventDispatcher");

---@class Node_Node : Node_EventDispatcher
local c = Class(EventDispatcher);
---@field public new Node_Node
---@field protected _childs Node_Node[] @子组件数组
---@field public name string @名称
---@field public parent Node_Node @父对象
---@field public destroyed boolean @是否已经被销毁

function c:ctor()
    EventDispatcher.ctor(self)
    self.name = "";
    ---@type Node_Node[]
    self._childs = {};
    self.parent = nil;
    self.destroyed = false;
end

---@param node Node_Node
---@return Node_Node
function c:addChild(node)
    self:addChildAt(node, #self._childs + 1);
    return self;
end

---@param node Node_Node
---@param index number
---@return Node_Node
function c:addChildAt(node, index)
    if self.destroyed or node == nil or node.destroyed or node == self then
        return self;
    end
    -- 有可能是自己的祖节点
    local p = self;
    while p do
        p = p.parent;
        if p == node then
            self:removeSelf();
            break
        end
    end
    if node.parent then
        node.parent:removeChild(node);
    end
    index = math.min(index, #self._childs + 1);
    table.insert(self._childs, index, node);
    node:event(Event.ADDED);
    node.parent = self;
    return self;
end

---@param ... Node_Node[]
---@return Node_Node
function c:addChildren(...)
    local ns = { ... };
    for _, n in ipairs(ns) do
        self:addChild(n);
    end
    return self;
end

---@param parent Node_Node
---@return Node_Node
function c:addTo(parent)
    parent:addChild(self);
    return self;
end

---@param node Node_Node
---@return Node_Node
function c:removeChild(node)
    return self:removeChildAt(self:getChildIndex(node))
end

---@param index number
---@return Node_Node
function c:removeChildAt(index)
    ---@type Node_Node
    local node = table.remove(self._childs, index);
    if node then
        node.parent = nil;
        node:event(Event.REMOVED);
    end
    return node;
end

---@param name string
---@return Node_Node
function c:removeChildByName(name)
    return self:removeChild(self:getChildByName(name));
end

---@return Node_Node
---@param begin number
---@param endl number
function c:removeChildren(begin, endl)
    begin = begin or 1;
    endl = endl or self:numChild();
    for i = endl, begin, -1 do
        self:removeChildAt(i);
    end
    return self;
end

---@return Node_Node
function c:removeSelf()
    if self.parent ~= nil then
        self.parent:removeChild(self);
    end
    return self;
end

---@param name string
---@return Node_Node
function c:getChildByName(name)
    for index = #self._childs, 1, -1 do
        if (name == self._childs[index].name) then
            return self._childs[index];
        end
    end
end

---@param index number
---@return Node_Node
function c:getChildAt(index)
    return self._childs[index];
end

---@param node Node_Node
---@return number
function c:getChildIndex(node)
    for index = #self._childs, 1, -1 do
        if (node == self._childs[index]) then
            return index;
        end
    end
    return -1;
end

---@param newNode Node_Node
---@param node Node_Node
---@return Node_Node
function c:replaceChild(node, newNode)
    local index = self:getChildIndex(node);
    if index > 0 and newNode then
        if newNode.parent then
            local nIndex = newNode.parent:getChildIndex(newNode);
            newNode.parent:addChildAt(node, nIndex);
        else
            node:removeSelf();
        end
        self:addChildAt(newNode, index);
    end
    return self;
end

---@param node Node_Node
---@return boolean
function c:contains(node)
    while node do
        if node == self then
            return true;
        end
        node = node.parent;
    end
    return false;
end

---@return number
function c:numChild()
    return #self._childs;
end

---@param destroyChild boolean
---@return void
function c:destroy(destroyChild)
    if self.destroyed then
        return
    end
    self.destroyed = true;
    self:removeSelf();
    if destroyChild ~= false then
        self:destroyChildren();
    end
    self.name = nil;
    self._childs = nil
    self.parent = nil;
    self:offAll();
end

---@return Node_Node
function c:destroyChildren()
    for i = #self._childs, 1, -1 do
        self._childs[i]:destroy(true);
    end
end

return c;
