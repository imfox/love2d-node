---
--- Created by fox.
--- DateTime: 2018/10/18 21:03
---

local class = require("node.class");
local Utils = require("node.core.Utils.Utils");
local UIEvent = require("node.core.Event.UIEvent");
local Math = require("node.core.Math.Math");
local tcMgr = require("node.core.Event.TouchManager");

---@class node2d_core_event_mousemanager : Klass
local c = class()


function c:ctor()
    self.enabled = true;

    ---@type __event[]
    self.eventList = {};

    self.stage = nil;

    self.disableMouseEvent = false;

    self.mouseX = 0;
    self.mouseY = 0;

    self.touchId = nil;

end



---@param stage stage
function c:set(stage)
    self.stage = stage;

end

---@param type string
---@param id any
---@param x number
---@param y number
function c:onMouseEvent(type, id, x, y)
    if not self.enabled then
        return;
    end
    table.insert(self.eventList, { type = type, x = x, y = y, touchId = id });
end

-- 执行事件
---@return void
function c:runEvent()
    local len = #self.eventList;
    for i = 1, len do
        local e = self.eventList[1];
        local type = e.type;
        self.mouseX, self.mouseY = e.x, e.y;
        self.touchId = e.touchId;
        if type == UIEvent.MOUSE_DOWN then
            self:check(self.stage, e.x, e.y, self.onMouseDown)
        elseif type == UIEvent.MOUSE_UP then
            self:check(self.stage, e.x, e.y, self.onMouseUp)
        elseif type == UIEvent.MOUSE_MOVE then
            self:check(self.stage, e.x, e.y, self.onMouseMove)
        end

        table.remove(self.eventList, 1);
    end
end

---@param node Node
---@param x number
---@param y number
local function hitTest(node, x, y)
    if node.width > 0 and node.height > 0 or node.mouseThrough then
        if node.mouseThrough then
            return false;
        else
            return Utils.pointHitRect(x, y, -node.pivotX * node.scaleX, -node.pivotY * node.scaleY, node.width * node.scaleX, node.height * node.scaleY);
        end
    end
    return false;
end

---@private
---@param node Drawable
---@param x number
---@param y number
---@param callback fun
function c:check(node, x, y, callback)
    local nx, ny = x - node.x, y - node.y

    if node.rotation ~= 0 and node.rotation % 360 ~= 0 then
        nx, ny = Math.rotatePointByZero(nx, ny, -node.rotation)
    end

    if not self.disableMouseEvent then
        node.mouseX, node.mouseY = nx, ny;
        if not node.mouseThrough and not hitTest(node, nx, ny) then
            return false;
        end

        for i = node:numChild(), 1, -1 do
            ---@type Drawable
            local child = node:getChildAt(i);
            if child.visible and not child.destroyed and child.mouseEnabled then
                if self:check(child, (nx + node.pivotX * node.scaleX) * (1 / node.scaleX), (ny + node.pivotY * node.scaleY) * (1 / node.scaleY), callback) then
                    return true;
                end

            end
        end

    end

    local hit = false;

    if not node.mouseThrough and not disableMouseEvent then
        hit = true;    
    else
        hit = hitTest(node, nx, ny);
    end


    if hit then
        Utils.call(callback, self, node)()
    end

    return hit;
end


---@private
---@param node Drawable
function c:onMouseDown(node)
    tcMgr:mouseDown(node, self.touchId)
end

---@private
---@param node Drawable

function c:onMouseUp(node)
    tcMgr:mouseUp(node, self.touchId)
end

---@private
---@param node Drawable
function c:onMouseMove(node)
    tcMgr:mouseMove(node, self.touchId);
end

---@type node2d_core_event_mousemanager
local instance = c.new();
return instance;


---@class __event
---@field type string
---@field x number
---@field y number
---@field touchId any
