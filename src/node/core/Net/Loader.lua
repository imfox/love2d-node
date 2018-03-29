---
--- Created by fox.
--- DateTime: 2018/3/16 21:53
---

local class = require("node.class");

---@type Message
local Message = require("node.core.Display.Message");


---@class Loader : Message
local Loader = class(Message);

---@param this Loader
function Loader.ctor(this)
    this:super()
    this.loads = {};
    this.images = {};
    this.fonts = {};
end


---@field public images <string,table>[]
---@param type string
---@param path string
---@param cache boolean
---@return Loader
function Loader.load(this,path,type,cache)
    type = type or "IMAGE";
    cache = cache or true;

    if type == "IMAGE" then
        this.images[path] = love.graphics.newImage(path);
    elseif type == "FONT" then
        -- 这里做缓存
    elseif type == "IMAGEPACK" then
        -- 这里做切图
    else
        print( string.format("error ; unknown type resource(不可识别的资源) type:%s path:%s",type ,path));
    end

    if not this:isExist(path) then
        table.insert(this.loads,path)
    end
    return this;
end


---@param this Loader
---@param path string
---@return boolean
function Loader.isExist(this, path)
    for _, p in ipairs(this.loads) do
        if p == path then
            return true;
        end
    end
    return false;
end


---@param this Loader
---@param skin string
---@return Image
function Loader.getImage(this,skin)
    if skin == "" or skin == nil or not love.filesystem.exists(skin) then
        return nil;
    end
    if this.images[skin] == nil then
        this.images[skin] = love.graphics.newImage(skin);
    end
    return this.images[skin];
end


---@param this Loader
---@param path string
---@return Font
function Loader.getFont(this, path)
    if path == "" or path == nil or not love.filesystem.exists(path) then
        return nil;
    end
    if this.fonts[path] == nil then
        this.fonts[path] = love.graphics.newFont(path);
    end
    return this.fonts[path];
end


local loader  = Loader.new()
return loader;