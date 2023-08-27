---@enum eNpcType
local eNpcType = {
    guard = "guard",
    guest = "guest",
    servant = "servant",
    host = "host"
}

---@class npcFactory
local npc = {
    npcType = eNpcType
}

---@param name string
---@param room eRooms
---@param interaction function
---@param hints table<string>
---@param npcType eNpcType
---@return npc
function npc.create(name, room, interaction, hints, npcType)
    ---@class npc
    ---@field name string
    ---@field health number
    ---@field room eRooms
    ---@field interaction function
    ---@field hints table<string>
    ---@field npcType eNpcType
    local lNpc = {}
    lNpc.name = name
    lNpc.health = 5
    lNpc.room = room
    lNpc.interaction = interaction
    lNpc.hints = hints
    lNpc.npcType = npcType
    lNpc.isTriggered = false

    return lNpc
end

return npc
