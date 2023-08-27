local mc = require("utils.sb_htn.Utils.middleclass")
local Selector = require("utils.sb_htn.Tasks.CompoundTasks.Selector")

---@class TaskRoot : Selector
local TaskRoot = mc.class("TaskRoot", Selector)

return TaskRoot
