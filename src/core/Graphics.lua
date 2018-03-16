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
function Graphics.ctor(this)
end

---@field public cmds CMD[]
---@field public one CMD

---@param this Graphics
---@return Graphics
function Graphics.draw(this,...)
    --love.graphics.draw(...);
    this:pushCmd("draw",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.circle(this,...)
    --love.graphics.circle(...);
    this:pushCmd("circle",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.arc(this,...)
    this:pushCmd("arc",{...})
    return this;
end


---@param this Graphics
---@return Graphics
function Graphics.ellipse(this,...)
    this:pushCmd("ellipse",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.line(this,...)
    this:pushCmd("line",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.points(this,...)
    this:pushCmd("points",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.polygon(this,...)
    this:pushCmd("polygon",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.printf(this,...)
    this:pushCmd("printf",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.print(this,...)
    this:pushCmd("print",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.quad(this,...)
    this:pushCmd("quad",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.rectangle(this,...)
    this:pushCmd("rectangle",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.stencil(this,...)
    this:pushCmd("stencil",{...})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.triangle(this,...)
    this:pushCmd("triangle",{...})
    return this;
end


---@param this Graphics
---@return Graphics
function Graphics.clear(this,...)
    this.cmds = {};
    return this;
end

---@param this Graphics
---@param funcName string
function Graphics.pushCmd(this, funcName,args)
    if not this.cmds then
        this.cmds = {};
    end
    table.insert(this.cmds,{cmd = funcName,args = args})
    return this;
end

---@param this Graphics
---@param x number
---@param y number
---@param r number
---@param w number
---@param h number
function Graphics._begin(this,x,y,r,w,h)
    love.graphics.push()
    love.graphics.translate(x,y);
    love.graphics.rotate(r);
    love.graphics.scale(w,h);
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics._render(this)
    if this.one then
        love.graphics[this.one.cmd](unpack(this.one.args));
    end
    if this.cmds then
        for _, drawable in ipairs(this.cmds) do
            love.graphics[drawable.cmd](unpack(drawable.args));
        end
    end
    return this;
end

---@param this Graphics
function Graphics._end(this)
    love.graphics.pop();
    return this;
end



return Graphics;
