local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

local SubBlock = require("src.ai.SubBlock")

---@class DomCunning : DomainBuilder
local DomCunning = sb_htn.DomainBuilder:new("Guard Domain", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return DomCunning:Splice(SubBlock)
    :Build()
