local sb_htn = require("utils.sb_htn.interop")
local mc = require("utils.sb_htn.Utils.middleclass")

---@class ConPartygoer : BaseContext
---@field name string
---@field health number
---@field thirst number
---@field room eRooms
---@field interaction function
---@field hints table<string>
---@field npcType eNpcType
---@field common common
local ConPartygoer = mc.class("ConPartygoer", sb_htn.Contexts.BaseContext)

---@enum ePartyState
ConPartygoer.ePartyState =
{
    IsThirsty = 1,
    IsTriggered = 2
}

---@param name string
---@param room eRooms
---@param interaction function
---@param hints table<string>
---@param npcType eNpcType
function ConPartygoer:initialize(name, room, interaction, hints, npcType, common)
    sb_htn.Contexts.BaseContext.initialize(self)

    self.WorldState       = {}
    self.MTRDebug         = nil;
    self.LastMTRDebug     = nil;
    self.DebugMTR         = false;
    self.LogDecomposition = false;

    self.Factory          = sb_htn.Factory.DefaultFactory:new();

    for _, v in pairs(ConPartygoer.ePartyState) do
        self.WorldState[v] = 0
    end

    self.name = name
    self.health = 5
    self.thirst = math.random(3, 5)
    self.room = room
    self.interaction = interaction
    self.hints = hints
    self.npcType = npcType

    self.common = common
end

function ConPartygoer:init()
    sb_htn.Contexts.BaseContext.init(self)
end

---@param state ePartyState
---@param value boolean | nil
function ConPartygoer:HasState(state, value)
    if (value ~= nil) then
        return sb_htn.Contexts.BaseContext.HasState(self, state, (value and 1 or 0));
    else
        return sb_htn.Contexts.BaseContext.HasState(self, state, 1);
    end
end

---@param state ePartyState
---@param value boolean
function ConPartygoer:SetState(state, value, type)
    sb_htn.Contexts.BaseContext.SetState(self, state, (value and 1 or 0), true, type);
end

return ConPartygoer
