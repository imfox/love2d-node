---
--- Created by fox.
--- DateTime: 2018/3/16 21:53
---

local class = require("node.class");

---@type Message
local Message = require("node.core.Display.Message");

local exist = love.filesystem.getInfo

local utils = require("node.core.Utils.Utils");

---@class Loader : Message
local Loader = class(Message);

Loader.FONT = "FONT";
Loader.TABLE = "TABLE";
Loader.SOUND = "SOUND";
Loader.IMAGE = "IMAGE";

---@private
Loader.extKeys = {
    png = Loader.IMAGE,
    jpg = Loader.IMAGE,
    jpeg = Loader.IMAGE,
    fnt = Loader.FONT,
    ttf = Loader.FONT,
    tab = Loader.TABLE,
    mp3 = Loader.SOUND,
    wav = Loader.SOUND,
    tab = Loader.TABLE,
    table = Loader.TABLE,
}

---@private
Loader._cache = {}

---@param this Loader
function Loader.ctor(this)
    Message.ctor(this)
end

---@class LoaderArray
---@field url string
---@field type string

---@param url string | LoaderArray[]
---@param type string
---@param cache boolean
---@param compile fun()
---@return Loader
function Loader:load(url,type_,cache,compile)
    if not url then 
        return
    end

    if type(url) == "table" then
        for _, item in ipairs(url) do
            self:load(item.url,item.type)
        end
        return;
    end

    if not type_ then
        local ext = Loader.extKeys[utils.getExtension(url)];
        if ext then 
            type_ = ext;
        end
    end
    type_ = type_ or Loader.IMAGE;
    cache = cache or true;

    local data = self:getRes(url);

    if not data then 
        if not love.filesystem.getInfo(url) then
            print("error : not exits file:" .. url);
            return 
        end
    end

    if not data then 
        if type_ == Loader.IMAGE then
            data = love.graphics.newImage(url);
        elseif type_ == Loader.FONT then
            data = love.graphics.newFont(url)
        elseif type_ == Loader.TABLE then
            local content = love.filesystem.read(url);
            data = loadstring(content)();
        elseif type_ == Loader.SOUND then
            -- 这里做缓存
        elseif type_ == "IMAGEPACK" then
            -- 这里做切图
        else
            print( string.format("error : unknown type resource(不可识别的资源) type:%s path:%s",type_ ,url));
        end
        if cache then 
            self:cacheRes(url,data);
        end
    end

    if data then 
        if compile then 
            compile()
        end
    end


    return self;
end


---@param url string
---@param data any
function Loader:cacheRes(url,data)
    Loader._cache[url] = data;
end

---@param url string
function Loader:getRes(url)
    if Loader._cache[url] then 
        return Loader._cache[url];
    end
end

function Loader:clearRes(url)

end

local loader  = Loader.new()
return loader;