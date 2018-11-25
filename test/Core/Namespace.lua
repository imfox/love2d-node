local display = {}
display.Node = require("Node.Core.Display.Node");
display.Drawable = require("Node.Core.Display.Drawable");
display.Stage = require("Node.Core.Display.Stage");

local event = {};
event.EventDispatcher = require("Node.Core.Event.EventDispatcher");
event.Event = require("Node.Core.Event.Event");
event.TouchEvent = require("Node.Core.Event.TouchEvent");

local utils = {};
utils.Utils = require("Node.Core.Utils.Utils");
utils.Handler = require("Node.Core.Utils.Handler");

---@class Node_Core_Namespace
local namespace = {};
namespace.display = display;
namespace.event = event;
namespace.utils = utils;

------------------------------------------
namespace.Node = display.Node;
namespace.Drawable = display.Drawable;
namespace.Stage = display.Stage;

namespace.EventDispatcher = event.EventDispatcher;
namespace.Event = event.Event;
namespace.TouchEvent = event.TouchEvent;

namespace.Utils = utils.Utils;
namespace.Handler = utils.Handler;

return namespace;


