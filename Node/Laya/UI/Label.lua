---@type Loader
local class = require("Node.Core.Class");

---@type Component
local Component = require("Node.Laya.UI.Component")

local Utils = require("Node.Laya.Utils.Utils")

---@type node2d_utils_font
local Font = require("Node.Laya.Utils.Font")

---@class Label : Component
---@field color string
local Label = class(Component)

local fff = { 1, 1, 1, 1 };
---@param this Label
function Label.ctor(this)
    Component.ctor(this)
    this.text = "";
    this.align = "left";
    this.valign = "top";
    ---@private
    this._color = fff;
    this._font = love.graphics.getFont()

    this:setter_getter("font", this.__setFont, this.__getFont);

end

function Label:__setColor(c)
    self._color = Utils.htmlColor2RGBA(c);
    self.__color = c;
end

function Label:__getColor()
    return self.__color or "#fff";
end

function Label:__setFont(v)
    local font = Font:getFont(v);
    if not font then
        return
    end
    self._font = font;
end
function Label:__getFont()
    return self._font;
end

function Label:__setDataSource(d)
    if d then
        if type(d) == "string" then
            self.text = d;
        else
            for k, v in pairs(d) do
                self[k] = v;
            end
        end
    end
    self._dataSource = d;
end

---@return Label
function Label.__draw(this, graphics)
    graphics.setFont(this.font);
    if this._color then
        graphics.setColor(this._color)
    end

    local x, y = 0, 0;
    if this.valign == "middle" or this.valign == "bottom" then
        local h = this.height - graphics.getFont():getHeight() * #(Utils.splteText(this.text, "\n"));
        y = h / (this.valign == "middle" and 2 or 1);
        if y < 0 then
            y = 0
        end
    end

    graphics.printf(this.text, x, y, this.width, this.align, 0, 1, 1, this.pivotX, this.pivotY)
    return this;
end

return Label;