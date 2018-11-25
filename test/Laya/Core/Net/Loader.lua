local Class = require("Node.Core.Class");
local EventDispatcher = require("Node.Core.Event.EventDispatcher");
local Utils = require("Node.Laya.Utils.Utils");
local lily = require("Node.Lib.lily.lily");

local exist = love.filesystem.getInfo

---@class Laya_Core_Net_Loader : Node_Core_Event_EventDispatcher
local Loader = Class(EventDispatcher);

Loader.FONT = "FONT";
Loader.TABLE = "TABLE";
Loader.SOUND = "SOUND";
Loader.IMAGE = "IMAGE";
Loader.TXT = "TXT";

---@private
Loader.extKeys = {
    png = Loader.IMAGE,
    jpg = Loader.IMAGE,
    jpeg = Loader.IMAGE,
    fnt = Loader.FONT,
    ttf = Loader.FONT,
    mp3 = Loader.SOUND,
    wav = Loader.SOUND,
    txt = Loader.TXT,
}

---@private
Loader._cache = {}
---@param this Laya_Core_Net_Loader
function Loader.ctor(this)
    EventDispatcher.ctor(this)
end

---@class LoaderArray
---@field url string
---@field type string

---@param url string | LoaderArray[]
---@param type string
---@param cache boolean
---@param compile fun()
---@return Laya_Core_Net_Loader
function Loader:load(url, type_, cache, compile)
    if not url then
        return
    end

    if type(url) == "table" then
        for _, item in ipairs(url) do
            self:load(item.url, item.type)
        end
        return ;
    end

    if not type_ then
        local ext = Loader.extKeys[Utils.getExtension(url)];
        if ext then
            type_ = ext;
        end
    end
    type_ = type_ or Loader.IMAGE;
    cache = cache or true;

    local data = self:getRes(url);

    if not data then
        if not exist(url) then
            print("error : not exits file:" .. url);
            return
        end
    end

    if not data then
        if type_ == Loader.IMAGE then
            --data = love.graphics.newImage(url);
            self:_loadImage(url, compile)
            return ;
        elseif type_ == Loader.FONT then
            data = love.graphics.newFont(url)
        elseif type_ == Loader.TXT then
            data = love.filesystem.read(url);
        elseif type_ == Loader.TABLE then
            local content = love.filesystem.read(url);
            data = loadstring(content)();
        elseif type_ == Loader.SOUND then
            -- 这里做缓存
        elseif type_ == "IMAGEPACK" then
            -- 这里做切图
        else
            print(string.format("error : unknown type resource(不可识别的资源) type:%s path:%s", type_, url));
        end
        if cache then
            self.cacheRes(url, data);
        end
    end

    if data then
        if compile then
            compile()
        end
    end

    return self;
end

---@param url string | LoaderArray[]
---@param type string
---@param cache boolean
---@param compile fun()
---@return Laya_Core_Net_Loader
function Loader:loadAsync(url, type_, cache, compile)
    if not url then
        return
    end

    if type(url) == "table" then
        for _, item in ipairs(url) do
            self:load(item.url, item.type)
        end
        return ;
    end

    if not type_ then
        local ext = Loader.extKeys[Utils.getExtension(url)];
        if ext then
            type_ = ext;
        end
    end
    type_ = type_ or Loader.IMAGE;
    cache = cache or true;

    local data = self:getRes(url);

    if not data then
        if not exist(url) then
            print("error : not exits file:" .. url);
            return
        end
    end

    if not data then
        if type_ == Loader.IMAGE then
            --data = love.graphics.newImage(url);
            self:_loadImage(url, compile)
            return ;
        elseif type_ == Loader.FONT then
            data = love.graphics.newFont(url)
        elseif type_ == Loader.TXT then
            data = love.filesystem.read(url);
        elseif type_ == Loader.TABLE then
            local content = love.filesystem.read(url);
            data = loadstring(content)();
        elseif type_ == Loader.SOUND then
            -- 这里做缓存
        elseif type_ == "IMAGEPACK" then
            -- 这里做切图
        else
            print(string.format("error : unknown type resource(不可识别的资源) type:%s path:%s", type_, url));
        end
        if cache then
            self.cacheRes(url, data);
        end
    end

    if data then
        if compile then
            compile()
        end
    end

    return self;
end

function Loader:_loadImage(url, onComplete)
    lily.newImage(url):onComplete(function(userdata, image)
        Loader.cacheRes(url, image);
        onComplete();
    end)
end

---@param url string
---@param data any
function Loader.cacheRes(url, data)
    Loader._cache[url] = data;
end

---@param url string
function Loader.getRes(url)
    if Loader._cache[url] then
        return Loader._cache[url];
    end
end

function Loader.clearRes(url)
    if Loader._cache[url] then
        if Loader._cache[url].release then
            Loader._cache[url]:release();
        end
        Loader._cache[url] = nil;
    end
end
Loader.instance = Loader.new();
return Loader;