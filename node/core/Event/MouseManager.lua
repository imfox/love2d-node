---
--- Created by fox.
--- DateTime: 2018/10/18 21:03
---

local Utils = require("node.core.Utils.Utils");
local UIEvent = require("node.core.Event.UIEvent");
local Math = require("node.core.Math.Math");
local tcMgr = require("node.core.Event.TouchManager");

---@class node2d_core_event_mousemanager : Klass
local c = class()


function c:ctor()
    self.stoped = false;
    self.mouseEnable = true;
    self.enabled = true;

    ---@type __event[]
    self.eventList = {};

    self.stage = nil;

    self.disableMouseEvent = false;


    self.mouseX = 0;
    self.mouseY = 0;

end



---@param stage stage
function c:set(stage)
    self.stage = stage;

end

---@param type string
---@param x number
---@param y number
function c:onMouseEvent(type, x, y)
    if not self.enabled then
        return;
    end

    --print(type)
    table.insert(self.eventList, { type = type, x = x, y = y });
    self:runEvent()

end

-- 执行事件
---@return void
function c:runEvent()
    for i, e in ipairs(self.eventList) do
        local type = e.type;
        self.mouseX, self.mouseY = e.x, e.y;

        if type == UIEvent.MOUSE_DOWN then
            self:check(self.stage, e.x, e.y, self.onMouseDown)
        elseif type == UIEvent.MOUSE_UP then
            self:check(self.stage, e.x, e.y, self.onMouseUp)
        elseif type == UIEvent.MOUSE_MOVE then
            self:check(self.stage, e.x, e.y, self.onMouseMove)
        end

    end
    self.eventList = {};
end


---@param node Node
---@param x number
---@param y number
local function hitTest(node, x, y)
    return (Utils.pointHitRect(x, y, -node.pivotX * node.scaleX, -node.pivotY * node.scaleY, node.width * node.scaleX, node.height * node.scaleY));
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
        if not hitTest(node, nx, ny) then
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


    local hit = hitTest(node, nx, ny);

    if hit then
        Utils.call(callback, self, node)()
    end

    return hit;
end


---@private
---@param node Drawable
function c:onMouseDown(node)
    tcMgr:mouseDown(node)
end

---@private
---@param node Drawable

function c:onMouseUp(node)
    tcMgr:mouseUp(node)
end

---@private
---@param node Drawable
function c:onMouseMove(node)
    tcMgr:mouseMove(node);
end




---@type node2d_core_event_mousemanager
local instance = c.new();
return instance;


---@class __event
---@field type string
---@field x number
---@field y number
---@field stoped boolean
