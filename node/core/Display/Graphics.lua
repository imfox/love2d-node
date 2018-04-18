---
--- Created by fox.
--- DateTime: 2018/3/15 20:44
---
local class = require("node.class");

local recharge = love.graphics.rectangle

local setLineWidth,getLineWidth,setColor,lprint,printf = love.graphics.setLineWidth,love.graphics.getLineWidth,love.graphics.setColor,love.graphics.print,love.graphics.printf

---@param x number
---@param y number
---@param width number
---@param height number
---@param fillColor number
---@param lineColor number
---@param lineWidth number
local function rect(x, y, width, height,fillColor,lineColor,lineWidth)
    lineWidth = lineWidth or 1
    lineColor = lineColor or "#fff"
    setLineWidth(lineWidth);
    if fillColor then
        setColor(fillColor)
        recharge("fill",x,y,width, height);
    end
    setColor(lineColor)
    recharge("line",x,y,width, height);
end

local function fillText(text,x,y,align,width,color)
    setColor(color)
    printf(text,x,y,width,align,0,1,1,0,0,0,0);
end


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
function Graphics.rectangle(this,mode,x,y,w,h)
    this:pushCmd("rectangle",{mode,x,y,w,h})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.setColor(this,r,g,b)
    this:pushCmd("setColor",{r/255,g/255,b/255})
    return this;
end

---@param this Graphics
---@return Graphics
function Graphics.stencil(this,...)
    this:pushCmd("stencil",{...})
    return this;
end

---@param this Graphics
function Graphics.setShader(this,...)
    this:pushCmd("setShader",{...})
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
---@return Graphics
function Graphics._render(this)
    if this.one then
        love.graphics[this.one.cmd](unpack(this.one.args));
    end

    if this.cmds and #this.cmds > 0 then
        for _, drawable in ipairs(this.cmds) do
            if(drawable.cmd == "setColor") then
                local _,_,_,alpha = love.graphics.getColor()
                local r,g,b = unpack(drawable.args);
                love.graphics[drawable.cmd](r,g,b,alpha);
            else
                love.graphics[drawable.cmd](unpack(drawable.args));
            end
        end
    end
    return this;
end

---@param this Graphics
---@return Graphics
---@param x number
---@param y number
function Graphics.translate(this,x,y)
    love.graphics.translate(x,y)
    return this;
end
---@param this Graphics
---@return Graphics
---@param r number
function Graphics.rotate(this,r)
    love.graphics.rotate(r)
    return this;
end

---@param this Graphics
---@return Graphics
---@param x number
---@param y number
function Graphics.scale(this,x,y)
    love.graphics.sclae(x,y)
    return this;
end

return Graphics;
