local mc = require("utils.sb_htn.Utils.middleclass")
local ICompoundTask = require("utils.sb_htn.Tasks.CompoundTasks.ICompoundTask")

---@class IDecomposeAll : ICompoundTask
local IDecomposeAll = mc.class("IDecomposeAll", ICompoundTask)

return IDecomposeAll
