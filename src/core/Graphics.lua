---
--- Created by fox.
--- DateTime: 2018/3/15 20:44
---
local import = require("Import");
local class = import("..class");

--[[
    实际上这里应该放出接口 好让开发者有更多的扩展
--]]
---@class Graphics
local Graphics = class();

---@param this Graphics
---@field public cmds string[]
function Graphics.ctor(this)
    this.cmds = {};
end

---@param this Graphics
function Graphics.draw(this,...)
    love.graphics.draw(...);
end

---@param this Graphics
---@param text string
function Graphics.print(this,text,...)
    --love.graphics.print(text,...)
end

---@param this Graphics
---@param x number
---@param y number
---@param r number
---@param w number
---@param h number
function Graphics._render(this,x,y,r,w,h)
    love.graphics.push()
    love.graphics.translate(x,y);
    love.graphics.rotate(r);
    love.graphics.scale(w,h);

    -- .

    love.graphics.pop();
end

return Graphics;
