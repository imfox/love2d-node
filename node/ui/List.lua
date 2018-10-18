---
--- Created by fox.
--- DateTime: 2018/4/19 22:19
---

local class = require("node.class");
local IView = require("node.ui.IView");
local Timer = require("node.core.Utils.Timer");

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


    self.speaceX = 0;
    self.speaceY = 0;

    ---@private
    self._repeatX2 = 0
    ---@private
    self._repeatY2 = 0;

    self.content = SBox.new()
    self.content:addTo(self);

end

function List:_onResize(...)
    self.content:size(self.width, self.height);
    return Box._onResize(self, ...)
end

function List:_setArray()
    self:changeCells();
    --local s = IView.createComp(self._itemRender, nil, this);
    --s:addTo(self);


end

function List:refresh()
    --Timer:callLater()
    if self.length > 0 then
    end
end

---@return Box
function List:createItem()
    local box = IView.createComp(self._itemRender, nil, nil);
    --if self._itemRender then
    --end
    return box;
end

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


        local nx = self.repeatX;
        local ny = self.repeatY;

        --print(self.repeatX, self.repeatY, self._repeatX2, self._repeatY2)
        self:_createItems(0, nx, ny);

    end
end
function List:_createItems(startY, numX, numY)
    local content = self.content;
    local cell = self:_getOneCell();

    local cellWidth = cell.width + self.speaceX;
    local cellHeight = cell.height + self.speaceX;

    for y = startY, numY - 1 do
        for x = 0, numX - 1 do
            local cell = self:createItem();
            cell:pos(cellWidth * x, cellHeight * y);
            content:addChild(cell);
            self:addCell(cell);
        end
    end

    self:renderItems(1, 0);

end

function List:addCell(box)
    table.insert(self._cells, box);
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
        self:renderItem(self._cells[i], i);
    end
end

---@param index number
---@return Box
function List:getCell(index)

end


function List:addItem(src)

end

function List:removeItem(src)

end

return List;
