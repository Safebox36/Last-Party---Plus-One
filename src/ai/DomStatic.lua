local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

local SubFlee = require("src.ai.SubFlee")

---@class DomStatic : DomainBuilder
local DomStatic = sb_htn.DomainBuilder:new("Host Domain", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return DomStatic:Splice(SubFlee)
    :Build()
