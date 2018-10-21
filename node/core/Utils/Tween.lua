---
--- Created by From the internet.(https://github.com/kikito/tween.lua)
---
local tween = {}

-- private stuff
local function copyTables(destination, keysTable, valuesTable)
    valuesTable = valuesTable or keysTable
    local mt = getmetatable(keysTable)
    if mt and getmetatable(destination) == nil then
        setmetatable(destination, mt)
    end
    for k, v in pairs(keysTable) do
        if type(v) == "table" then
            destination[k] = copyTables({}, v, valuesTable[k])
        else
            destination[k] = valuesTable[k]
        end
    end
    return destination
end

local function checkSubjectAndTargetRecursively(subject, target, path)
    path = path or {}
    local targetType, newPath
    for k, targetValue in pairs(target) do
        targetType, newPath = type(targetValue), copyTables({}, path)
        table.insert(newPath, tostring(k))
        if targetType == "number" then
            assert(
            type(subject[k]) == "number",
            "Parameter '" .. table.concat(newPath, "/") .. "' is missing from subject or isn't a number"
            )
        elseif targetType == "table" then
            checkSubjectAndTargetRecursively(subject[k], targetValue, newPath)
        else
            assert(
            targetType == "number",
            "Parameter '" .. table.concat(newPath, "/") .. "' must be a number or table of numbers"
            )
        end
    end
end

local function checkNewParams(duration, subject, target, easing)
    assert(
    type(duration) == "number" and duration > 0,
    "duration must be a positive number. Was " .. tostring(duration)
    )
    local tsubject = type(subject)
    assert(
    tsubject == "table" or tsubject == "userdata",
    "subject must be a table or userdata. Was " .. tostring(subject)
    )
    assert(type(target) == "table", "target must be a table. Was " .. tostring(target))
    assert(type(easing) == "function", "easing must be a function. Was " .. tostring(easing))
    checkSubjectAndTargetRecursively(subject, target)
end

local function performEasingOnSubject(subject, target, initial, clock, duration, easing)
    local t, b, c, d
    for k, v in pairs(target) do
        if type(v) == "table" then
            performEasingOnSubject(subject[k], v, initial[k], clock, duration, easing)
        else
            t, b, c, d = clock, initial[k], v - initial[k], duration
            subject[k] = easing(t, b, c, d)
        end
    end
end

-- Tween methods

local Tween = {}
local Tween_mt = {__index = Tween}

function Tween:set(clock)
    assert(type(clock) == "number", "clock must be a positive number or 0")

    self.initial = self.initial or copyTables({}, self.target, self.subject)
    self.clock = clock
    self._pause = false

    if self.clock <= 0 then
        self.clock = 0
        copyTables(self.subject, self.initial)
    elseif self.clock >= self.duration then -- the tween has expired
        self.clock = self.duration
        copyTables(self.subject, self.target)
    else
        performEasingOnSubject(self.subject, self.target, self.initial, self.clock, self.duration, self.easing)
    end

    return self.clock >= self.duration
end

function Tween:reset()
    return self:set(0)
end

function Tween:pause()
    self._pause = true
end

function Tween:resume()
    self._pause = false
end

---@private
function Tween:onComplete()
    for k, v in pairs(self.target) do
        self.subject[k]=v;
    end
end

function Tween:update(dt)
    assert(type(dt) == "number", "dt must be a number")
    local over = self:set(self.clock + dt)
    if (over) then
        self:onComplete();
    end
    return over
end

-- Public interface
local tweens = {}
---@param subject table
---@param target table
---@param duration number @ms
---@param easing func
---@param complete func
function tween.to(subject, target, duration, easing, complete)
    checkNewParams(duration, subject, target, easing)
    local object =
    setmetatable(
    {
        duration = duration / 1000,
        subject = subject,
        target = target,
        easing = easing,
        clock = 0,
        complete = complete
    },
    Tween_mt
    )
    table.insert(tweens, object)
    return object
end

---@param subject table
---@param from table
---@param duration number @ms
---@param easing func
---@param complete func
function tween.from(subject, from, duration ,easing, complete)
    local target = {};
    for k, v in pairs(from) do
        target[k],subject[k] = subject[k],v;
    end
    return tween.to(subject, target, duration ,easing, complete)
end

function tween._update(dt)
    if (#tweens > 0) then
        local list = {}
        for k, v in ipairs(tweens) do
            if (v:update(dt) == true) then
                if v.complete ~= nil then
                    v.complete()
                end
                table.insert(list, k)
            end
        end
        for k, v in ipairs(list) do
            table.remove(tweens, v)
        end
    end
end

return tween
