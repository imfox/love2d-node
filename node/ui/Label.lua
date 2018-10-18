---
--- Created by fox.
--- DateTime: 2018/3/20 20:53
---
---
--- Created by fox.
--- DateTime: 2018/3/16 21:22
---
---@type Loader
local Loader = require("node.core.Net.Loader");

local class = require("node.class");

---@type Component
local Component = require("node.ui.Component")

local Utils = require("node.core.Utils.Utils")

---@type node2d_utils_font
local Font = require("node.core.utils.Font")

---@class Label : Component
---@field color string
local Label = class(Component)

local fff = { 1, 1, 1, 1 };
---@param this Label
function Label.ctor(this)
    Component.ctor(this)
    --this.graphics = AutoBitmap.new();
    this.text = "";
    this.align = "left";
    this.valign = "top";
    ---@private
    this._color = fff;
    this._font = love.graphics.getFont()

    this:setter("font", function(v)
        local font = Font:getFont(v);
        if not font then
            return
        end
        this._font = font;
    end)

    this:getter("font", function()
        return this._font;
    end)

    local _hc = "#fff";
    this:setter("color", function(c)
        _hc = c;
        this._color = Utils.htmlColor2RGBA(c);
    end)

    this:getter("color", function()
        return _hc;
    end)


    ---@protected
    this._dataSource = nil;
    this:setter("dataSource", function(d)
        if d then
            if type(d) == "string" then
                this.text = d;
            else
                for k, v in pairs(d) do
                    this[k] = v;
                end
            end
        end
        this._dataSource = d;
    end)

    this:getter("dataSource", function()
        return this._dataSource;
    end)
end

---@return Label
function Label._draw(this, graphics)
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