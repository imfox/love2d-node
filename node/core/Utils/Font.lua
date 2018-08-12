---@type Loader
local Loader = require("node.core.Net.Loader");
local Utils = require("node.core.Utils.Utils");

---@class node2d_utils_font
local Font = {}

---@private
Font._caches = {}

---@param name string
---@param font any
function Font:register(name,font)
    Font._caches[name] = font
end

---@param name string
function Font:getFont(name)
    return Font._caches[name];
end

---@param url string
---@param name string @注册名称
function Font:load(url,name)
    if not name then 
        name = Utils.stripExtension(Utils.stripPath(url));
    end
    Loader:load(url,Loader.FONT,true,Utils.call(Font._loaded,Font,url,name))
end

---@private
function Font:_loaded(url,name)
    Font:register(name,Loader:getRes(url));
end

return Font;
