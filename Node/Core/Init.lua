--[[
    使用这个框架将会注册以下几个全局变量，请注意不要冲突
        class
--]]

class = require("Node.Core.Class");
local Namespace = require("Node.Core.Namespace");
local Event = require("Node.Core.Event.Event");
local TouchEvent = require("Node.Core.Event.TouchEvent");
local Stage = require("Node.Core.Display.Stage");

---@type Node_Core_Display_Stage
local stageInstance = Stage.instance;

local function resize(w, h)
    stageInstance:_changeWindowSize(w, h);
end
local function update(dt)
    stageInstance:update(dt);
end
local function draw()
    stageInstance:draw();
end
local function focus(b)
    stageInstance:event(b and Event.FOCUS or Event.BLUR);
end
local function mouseEvent(type, id, x, y)
    stageInstance:onMouseEvent(type, id, x, y);
end
local function keyboardEvent(type, key)
    stageInstance:keyboardEvent(type, key)
end

local function wheelmoved(x, y)
end
local function touchmoved(id, x, y, dx, dy, pressure)
    mouseEvent(TouchEvent.TOUCH_MOVE, id, x, y)
end
local function touchpressed(id, x, y, dx, dy, pressure)
    mouseEvent(TouchEvent.TOUCH_BEGIN, id, x, y)
end
local function touchreleased(id, x, y, dx, dy, pressure)
    mouseEvent(TouchEvent.TOUCH_END, id, x, y)
end
local function mousereleased(x, y, button, istouch)
    local type = TouchEvent.MOUSE_UP;
    if button == 2 then
        type = TouchEvent.RMOUSE_UP
    end
    mouseEvent(type, button, x, y)
end
local function mousepressed(x, y, button, istouch)
    local type = TouchEvent.MOUSE_DOWN;
    if button == 2 then
        type = TouchEvent.RMOUSE_DOWN
    end
    mouseEvent(type, button, x, y)
end
local function mousemoved(x, y, dx, dy, istouch)
    mouseEvent(TouchEvent.MOUSE_MOVE, 1, x, y)
end

local function keypressed(key, scancode, isrepeat)
    keyboardEvent(TouchEvent.KEY_DOWN, key)
end
local function keyreleased(key, scancode)
    keyboardEvent(Event.KEY_UP, key)
end
local registerFuncions = {
    update = update,
    draw = draw,
    focus = focus,
    resize = resize,
    keypressed = keypressed,
    keyreleased = keyreleased,
    mousemoved = mousemoved,
    mousepressed = mousepressed,
    mousereleased = mousereleased,
    touchmoved = touchmoved,
    touchpressed = touchpressed,
    touchreleased = touchreleased,
    wheelmoved = wheelmoved,
}

---@class Node_Core : Node_Core_Namespace
local node = { version = 0.2, versionName = "Bacon" };

local function init(width, height)
    stageInstance:setSceenSize(width, height);
    node.stage = stageInstance;
    return node;
end

local function register()
    if stageInstance then
        local funcs = { "update", "draw", "focus", "resize", "keypressed", "keyreleased", "wheelmoved" };

        local touchFuncs = { "mousemoved", "mousepressed", "mousereleased" }
        local system = love.system.getOS();
        if system == "Android" or system == "iOS" then
            touchFuncs = { "touchmoved", "touchreleased", "touchpressed" };
        end

        for _, name in pairs(touchFuncs) do
            love[name] = registerFuncions[name];
        end
        for _, name in pairs(funcs) do
            love[name] = registerFuncions[name];
        end
    else
        print("error: don't initial.");
    end
    return node;
end

node.init = init;
node.register = register;
node.registerFuncions = registerFuncions;

setmetatable(node, { __index = Namespace });

return node;