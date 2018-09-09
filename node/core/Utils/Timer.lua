---
--- Created by fox.
--- DateTime: 2018/3/24 22:35
---
local class = require("node.class");
local globalScale = 1

---@class _timer : Klass
local _timer = class()

---@param this _timer
---@param type string
---@param delay number
---@param count number
---@param caller table
---@param func func
---@param params table @这里的params是参数数组 会使用unpack解开
function _timer.ctor(this, type, delay, count, caller, func, params)
    this.m_scale = 1
    this.time = 0
    this.type = type;   -- frame or second

    this.delay = delay
    this.count = count

    this.caller = caller
    this.func = func
    this.params = params

    this.destroyed = false;
end

---@param dt number
---@param this _timer
---@return boolean
function _timer.update(this, dt)
    if (this.count == 0 or this.destroyed) then
        return
    end
    local delay = 1
    delay = ((this.type == "frame") and 1 or dt) * this.m_scale * globalScale;
    this.time = this.time + delay
    if (this.time >= this.delay) then
        this.time = this.time - this.delay
        this.count = this.count - 1
        local params = this.params or {};
        if (type(this.func) == "function") then
            if this.caller then
                this.func(this.caller, unpack(params))
            else
                this.func(unpack(params))
            end
            return this.count == 0
        end
    end
    return false
end

---@param this _timer
---@param n number
---@return _timer
function _timer.scale(this, n)
    this.m_scale = n;
    return this;
end

function _timer:destroy()
    self.destroyed = true;
end

---@type _timer[]
local timers = {}

---@class node_Timer
local Timer = {}

Timer.delta = 0;

---@private
function Timer:_updateAll(dt)
    Timer.delta = dt;
    if #timers > 0 then
        for i = #timers, 1, -1 do
            if (timers[i] == nil or timers[i].destroyed) then
                table.remove(timers, i)
            end
        end
        for _, timer in ipairs(timers) do
            if timer:update(dt) then
                timer:destroy()
            end
        end
    end
end

---@return _timer
local function pushTimer(...)
    local timer = _timer.new(...)
    table.insert(timers, timer)
    return timer;
end
--------------------------------------------------------

---@return _timer
function Timer:once(delay, caller, func, arg)
    return pushTimer("second", delay / 1000, 1, caller, func, arg)
end

---@return _timer
function Timer:loop(delay, caller, func, arg)
    return pushTimer("second", delay / 1000, -1, caller, func, arg)
end

---@return _timer
function Timer:frameOnce(delay, caller, func, arg)
    return pushTimer("frame", delay, 1, caller, func, arg)
end

---@return _timer
function Timer:frameLoop(delay, caller, func, arg)
    return pushTimer("frame", delay, -1, caller, func, arg)
end

---@return _timer
function Timer:count(delay, count, caller, func, arg)
    return pushTimer("second", delay / 1000, count, caller, func, arg)
end

---@return _timer
function Timer:frameCount(delay, count, caller, func, arg)
    return pushTimer("frame", delay, count, caller, func, arg)
end


---@return _timer
---@param caller table
---@param func Function
---@param arg table
function Timer:callLater(caller, func, arg)
    for _, timer in ipairs(timers) do
        if (timer.type == "later" and timer.caller == caller and timer.func == func) then
            timer:destroy();
        end
    end
    return pushTimer("later", 0, 1, caller, func, arg);
end

---@return Timer
function Timer:clear(caller, func)
    for i = 1, #timers do
        if (timers[i].caller == caller and timers[i].func == func) then
            timers[i].destroyed = true
        end
    end
    return Timer;
end

---@return Timer
function Timer:clearAll(caller)
    for i = 1, #timers do
        if (timers[i].caller == caller) then
            timers[i].destroyed = true
        end
    end
    return Timer;
end
-------------------------------------------------------
---@return number
function Timer:getTimerCount()
    local count = 0;
    for i = 1, #timers do
        if timers[i].type ~= "later" then
            count = count + 1
        end
    end
    return count;
end

---@param n number
---@return Timer
function Timer:scale(n)
    globalScale = n
    return Timer;
end

return Timer