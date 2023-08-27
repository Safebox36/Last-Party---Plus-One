local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

local SubThirsty = require("src.ai.SubThirsty")
local SubWander = require("src.ai.SubWander")
local SubFlee = require("src.ai.SubFlee")

---@class DomWander : DomainBuilder
local DomWander = sb_htn.DomainBuilder:new("Guest and Host Domain", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return DomWander:Splice(SubFlee)
    :Splice(SubThirsty)
    :Splice(SubWander)
    :Build()
