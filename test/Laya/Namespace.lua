--[[
    Dependent
        https://github.com/MikuAuahDark/lily.git
        https://github.com/kikito/tween.lua
--]]
local net = {}
net.Loader = require("Node.Laya.Core.Net.Loader");

local ui = {}
ui.Component = require("Node.Laya.UI.Component");
ui.Image = require("Node.Laya.UI.Image");
ui.Box = require("Node.Laya.UI.Box");
ui.Dialog = require("Node.Laya.UI.Dialog");
ui.View = require("Node.Laya.UI.View");
ui.ScaleButton = require("Node.Laya.UI.ScaleButton");
ui.Label = require("Node.Laya.UI.Label");

local event = {}
event.Event = require("Node.Laya.Core.Event.Event");

local utils = {}
utils.Tween = require("Node.Laya.Utils.Tween");
utils.Ease = require("Node.Laya.Utils.Ease");
utils.Font = require("Node.Laya.Utils.Font");

---@class Laya_Namespace
local namespace = {}
namespace.net = net;
namespace.ui = ui;
namespace.event = event;
namespace.utils = utils;

------------------------
namespace.Loader = net.Loader.instance;
namespace.Event = event.Event;
namespace.Image = ui.Image;
namespace.Box = ui.Box;
namespace.View = ui.View;
namespace.Dialog = ui.Dialog;
namespace.Label = ui.Label;
namespace.Tween = utils.Tween;
namespace.Ease = utils.Ease;
namespace.Font = utils.Font;

return namespace;

