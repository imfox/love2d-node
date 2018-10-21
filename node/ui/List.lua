---
--- Created by fox.
--- DateTime: 2018/4/19 22:19
---

local class = require("node.class");
local IView = require("node.ui.IView");
local UIEvent = require("node.core.Event.UIEvent");
local Utils = require("node.core.Utils.Utils");
local SliderBoard = require("node.ui.SliderBoard");
local Tween = require("node.core.Utils.Tween");
local Ease = require("node.core.Utils.Ease");

---@type Box
local Box = require("node.ui.Box")

local function round(n)
    if n - math.floor(n) >= 0.5 then
        return math.ceil(n);
    end
    return math.floor(n);
end

local setCanvas, newCanvas = love.graphics.setCanvas, love.graphics.newCanvas

---@class _sbox : Box
local SBox = class(Box)

function SBox:ctor()
    Box.ctor(self);
    self._canvas = nil;
    self:_addToRenderLine()
end

function SBox:_onResize(...)
    if self._canvas ~= nil then
        self._canvas:release();
        self._canvas = nil;
    end
    if self.height > 0 and self.width > 0 then
        self._canvas = newCanvas(self.width, self.height);
    end
    return Box._onResize(self, ...)
end

---@class List : Box
---@field public itemRender Box
---@field length number
---@field content Box
---@field array table
---@field itemRender table
---@field repeatX number
---@field repeatY number
---@field speaceX number
---@field speaceY number
local List = class(Box);
List.ItemRender = {};

---@param self Box
function List:ctor()
    Box.ctor(self)

    ---@type Drawable[]
    self._cells = {};

    ---@private
    self._itemRender = List.ItemRender;

    ---@private
    self._array = nil;

    ---@private
    self._isVertical = true;


    self:setter("itemRender", function(v)
        self._itemRender = v;
    end)
    self:getter("itemRender", function()
        return self._itemRender;
    end)


    self:setter("array", function(arr)
        self._array = arr;
        self:_setArray()
    end)
    self:getter("array", function()
        return self._array;
    end)


    self:getter("length", function()
        return self._array and #self._array or 0;
    end)


    self:setter("repeatX", function(v)
        self._repeatX = v;
    end)
    self:getter("repeatX", function()
        if self._repeatX ~= nil and self._repeatX > 0 then
            return self._repeatX;
        elseif self._repeatX2 ~= nil and self._repeatX2 > 0 then
            return self._repeatX2;
        end
        return 1;
    end)


    self:setter("repeatY", function(v)
        self._repeatY = v;
    end)
    self:getter("repeatY", function()
        if self._repeatY ~= nil and self._repeatY > 0 then
            return self._repeatY;
        elseif self._repeatY2 ~= nil and self._repeatY2 > 0 then
            return self._repeatY2;
        end
        return 1;
    end)


    self:setter("startIndex", function(v)

    end)

    self:getter("startIndex", function()
        return nil;
    end)


    self.speaceX = 0;
    self.speaceY = 0;

    ---@private
    self._repeatX2 = 0
    ---@private
    self._repeatY2 = 0;

    self.content = SBox.new()
    self.content:addTo(self);

    ---@type fun
    self.mouseHandler = Utils.void;

    ---@private
    self._startIndex = 0;

    ---@private
    self._cellSize = 0;

    ---@private
    ---@type node2d_ui_sliderboard
    self._slider = SliderBoard.new();
    self._slider.direction = 1;
    self._slider.target = self;
    self._slider:on(UIEvent.CHANGE, Utils.call(self._onChangeScrollValue, self));


end

---@private
function List:_onResize(...)
    self.content:size(self.width, self.height);
    return Box._onResize(self, ...)
end

---@private
function List:_setArray()
    self:changeCells();
    self._slider:set(0, self._cellSize * #self.array - self.height);
end

function List:refresh()
    if self.length > 0 then
        self.array = self.array;
    end
end

---@private
---@return Box
function List:createItem()
    local box;
    if type(self._itemRender) == "function" then
        box = self._itemRender();
    else
        box = IView.createComp(self._itemRender, nil, nil);
    end
    return box;
end

---@private
function List:changeCells()
    if self._itemRender ~= List.ItemRender then
        local cell = self:_getOneCell();

        local cellWidth = cell.width + self.speaceX;
        local cellHeight = cell.height + self.speaceX;

        if self._width ~= nil and self._width > 0 then
            local calc = self._isVertical == true and round or math.ceil;
            self._repeatX2 = calc(self._width / cellWidth)
        end


        if self._height ~= nil and self._height > 0 then
            local calc = self._isVertical == true and math.ceil or round;
            self._repeatY2 = calc(self._height / cellHeight)
            --print(self._height, cellHeight, " - - !")
        end

        if self._isVertical then
            self._cellSize = cellHeight;
        else
            self._cellSize = cellWidth;
        end


        local nx = self.repeatX;
        local ny = self.repeatY;

        self:_createItems(0, nx, ny + 1);

    end
end

---@private
function List:_createItems(startY, numX, numY)
    local content = self.content;
    local cell = self:_getOneCell();

    local cellWidth = cell.width + self.speaceX;
    local cellHeight = cell.height + self.speaceX;

    local arr = {};
    for _, v in ipairs(self._cells) do
        table.insert(arr, v);
    end
    self._cells = {};

    for y = startY, numY - 1 do
        for x = 0, numX - 1 do
            ---@type Box
            local cell
            if #arr > 0 then
                cell = arr[1];
                table.remove(arr, 1);
            else
                cell = self:createItem();
            end
            cell:pos(cellWidth * x, cellHeight * y);
            content:addChild(cell);
            self:addCell(cell);
        end
    end
    self:renderItems(1, 0);
end

---@param box Box
function List:addCell(box)
    local fun = Utils.call(self._onMouseEvent, self);
    box:offAll();
    box:on(UIEvent.MOUSE_DOWN, fun);
    box:on(UIEvent.MOUSE_UP, fun);
    box:on(UIEvent.CLICK, fun);
    box:on(UIEvent.MOUSE_MOVE, fun);
    table.insert(self._cells, box);
end

---@param e node2d_core_event_event
function List:_onMouseEvent(e)
    local p = Utils.tableIndexOf(self._cells, e.currentTarget);
    self.mouseHandler(e, self._startIndex + p);
end

---@private
---@return Box
function List:_getOneCell()
    if #self._cells <= 0 then
        local cell = self:createItem();
        return cell;
    end
    return self._cells[1];
end

---@private
---@param cell Box
---@param index number
---@return void
function List:renderItem(cell, index)
    if self._array and index > 0 and index <= #self._array then
        local data = self._array[index];
        cell.visible = true;
        cell.dataSource = data;
    else
        cell.visible = false;
        cell.dataSource = nil;
    end
end

---@private
function List:renderItems(from, length)
    if not length or length == 0 then
        length = #self._cells;
    end
    for i = from, length do
        self:renderItem(self._cells[i], self._startIndex + i);
    end
end

---@private
---@param x number
---@param y number
function List:cellOffset(x, y)
    for _, item in ipairs(self._cells) do
        item:pivot(x, y);
    end
end

---@private
function List:_onChangeScrollValue()
    local scvalue = self._slider.x;
    if self._isVertical then
        scvalue = self._slider.y;
    end
    local dv = scvalue / self._cellSize;
    self._startIndex = math.floor(dv);
    local d = dv - self._startIndex;
    local offset = d * self._cellSize;

    self:changeCells();
    if self._isVertical then
        self:cellOffset(0, offset)
    else
        self:cellOffset(offset, 0);
    end
end


---@param index number
function List:scrollTo(index)
    if index > self.length then
        index = self.length;
    end
    if index < 1 then
        index = 1;
    end
    if self._isVertical then
        self._slider.y = self._cellSize * index;
        self:_onChangeScrollValue()
    else
        self._slider.x = self._cellSize * index;
        self:_onChangeScrollValue()
    end
end

---@param index number
---@param time number
function List:tweenTo(index, time)
    if index > self.length then
        index = self.length;
    end
    if index < 1 then
        index = 1;
    end
    local function onchange(...)
        self:_onChangeScrollValue();
        return Ease.linear(...)
    end
    local target = {}
    if self._isVertical then
        target.y = index * self._cellSize;
    else
        target.x = index * self._cellSize;
    end
    Tween.to(self._slider, target, time, onchange, Utils.call(self._onChangeScrollValue, self));
end


---@private
---@param index number
---@return Box
function List:getCell(index)
end

--function List:addItem(src)
--
--end
--
--function List:removeItem(src)
--
--end

return List;
