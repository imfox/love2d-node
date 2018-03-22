---
--- Created by fox.
--- DateTime: 2018/3/14 21:43
---

require("nodeFrame.engine");
local drawable = require("nodeFrame.core.Display.Drawable");
local sprite = require("nodeFrame.ui.Sprite")
local label = require("nodeFrame.ui.Label")
local utils = require("nodeFrame.core.Utils.Utils");
local uiUtils = require("nodeFrame.core.Utils.UiUtils");
local Node = require("nodeFrame.core.Display.Node");

local n1 = Node.new();
n1.name = "n1";
local n2 = Node.new();
n2.name = "n2";
local n3 = Node.new();
n3.name = "n3";
local n4 = Node.new();
n4.name = "n4";
local n5 = Node.new();
n5.name = "n5";
local n6 = Node.new();
n6.name = "n6";
local n7 = Node.new();
n7.name = "n7";
local n8 = Node.new();
n8.name = "n8";

n1:addChild(n2)
n1:addChild(n3)
n1:addChild(n4)

--n5:addChild(n6)
--n5:addChild(n7)
--n5:addChild(n8)
--utils.tablePrint(n1.components);
n1:destroy(false)
--utils.tablePrint(n2);


--n5:addChild(n2)
--n5:addChild(n3)
--n5:addChild(n4)
--n5:addChild(n5)
--utils.tablePrint(n5.components);
--utils.tablePrint(n5.components);
--
--n1:replaceChild(n2,n6)
--
--print(n1.parent,n5.parent)
--utils.tablePrint(n1.components);
--utils.tablePrint(n5.components);
--
--print(n1:contains(n2))

--print(n2.parent.name,n3.parent.name)
--n2:addChild(n3);
--print(n2.parent.name,n3.parent.name)
--utils.tablePrint(n1.components);
--n3:addChild(n1);


---@type Drawable
local spr = sprite.new();
local uiData = require("uiscripts.Test")
local test = uiUtils.createByTable(uiData,nil,spr)
test:addTo(spr);

love.graphics.setBackgroundColor(0,0,0,255)
function love.load()
    
end

function love.update(dt)
end
function love.draw()
    spr:_render();
end
