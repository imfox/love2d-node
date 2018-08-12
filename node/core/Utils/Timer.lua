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

---@param this _timer
---@param dt number
---@return boolean
function _timer.update(this,dt)
    if (this.count == 0 or this.destroyed) then
        return
    end
    local delay = 1
    delay = (this.type == "frame" and 1 or dt) * this.m_scale * globalScale;
    this.time = this.time + delay
    if (this.time > this.delay) then
        this.time = this.time - this.delay
        this.count = this.count - 1
        if (type(this.func) == "function") then
            if this.caller then
                this.func(this.caller,this.params ~= nil and unpack(this.params) or nil)
            else
                this.func(this.params ~= nil and unpack(this.params) or nil)
            end
            return this.count == 0
        end
    end
    return false
end

---@param this _timer
---@param n number
---@return _timer
function _timer.scale(this,n)
    this.m_scale = n;
    return this;
end

---@type _timer[]
local timers = {}

---@class node_Timer
local Timer = {}
---@private
function Timer._updateAll(dt)
    if #timers > 0 then
        for i = #timers, 1, -1 do
            if (timers[i] == nil or timers[i].destroyed) then
                table.remove(timers, i)
            end
        end
        for i = 1, #timers do
            if (timers[i]:update(dt)) then
                timers[i].destroyed = true;
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
function Timer.once(delay, caller, func, arg)
    return pushTimer("second",delay / 1000, 1, caller, func, arg)
end

---@return _timer
function Timer.loop(delay, caller, func, arg)
    return pushTimer("second",delay / 1000, -1, caller, func, arg)
end

---@return _timer
function Timer.frameOnce(delay, caller, func, arg)
    return pushTimer("frame",delay , 1, caller, func, arg)
end

---@return _timer
function Timer.frameLoop(delay, caller, func, arg)
    return pushTimer("frame",delay , -1, caller, func, arg)
end

---@return _timer
function Timer.count(delay, count, caller, func, arg)
    return pushTimer("second",delay / 1000, count, caller, func, arg)
end

---@return _timer
function Timer.frameCount(delay, count, caller, func, arg)
    return pushTimer("frame",delay , count, caller, func, arg)
end


---@return _timer
---@param caller table
---@param func Function
---@param arg table
function Timer.callLater(caller,func,arg)
    ---@type _timer
    local timer;
    for i = #timers,1,-1 do   -- 会在render之前调用 并且只会调用一次
        if (timers[i].type == "later" and not timers[i].destroyed and timers[i].caller == caller and timers[i].func == func) then
            timer = timers[i];
            timer.func = func
            timer.arg = arg;
        end
    end
    if not timer then
        timer = pushTimer("later",0,1,caller,func,arg)
    end
    return
end

---@return Timer
function Timer.clear(caller, func)
    for i = 1, #timers do
        if (timers[i].caller == caller and timers[i].func == func) then
            timers[i].destroyed = true
        end
    end
    return Timer;
end

---@return Timer
function Timer.clearAll(caller)
    for i = 1, #timers do
        if (timers[i].caller == caller) then
            timers[i].destroyed = true
        end
    end
    return Timer;
end
-------------------------------------------------------
---@return number
function Timer.getTimerCount()
    return #timers
end

---@param n number
---@return Timer
function Timer.scale(n)
    globalScale = n
    return Timer;
end

return Timer