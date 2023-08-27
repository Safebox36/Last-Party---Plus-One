local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

local SubAttack = require("src.ai.SubAttack")

---@class DomGuard : DomainBuilder
local DomGuard = sb_htn.DomainBuilder:new("Guard Domain", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return DomGuard:Splice(SubAttack)
    :Build()
