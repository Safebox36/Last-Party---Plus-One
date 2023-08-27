local npcs = {}

---@type Planner
npcs.planner = {}

---@param common common
---@param curRoom number
---@return ConPartygoer[]
function npcs.getNpcsInRoom(common, curRoom)
    local npcList = {}
    ---@param npc ConPartygoer
    for _, npc in ipairs(common.config.npcs.npcs) do
        if (npc.room == curRoom) then
            table.insert(npcList, npc)
        end
    end
    return npcList
end

---@param common common
---@param curRoom number
---@param selNpc number
function npcs.interactWithNpc(common, curRoom, selNpc)
    local npc = npcs.getNpcsInRoom(common, curRoom)[selNpc]
    if (npc.health < 1 or npc:HasState(common.ai.contexts.ConPartygoer.ePartyState.IsTriggered)) then
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main, npc.name .. " cannot be interacted with.")
    else
        npc.interaction(common, npc.name)
    end
end

---@param common common
---@param curRoom number
---@param selNpc number
function npcs.thoughtNpc(common, curRoom, selNpc)
    common.powers.lastActive = common.powers.powers.thought
    common.controllers.animation.delta = 0
    local npc = npcs.getNpcsInRoom(common, curRoom)[selNpc]
    if (npc.hints == nil) then
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main, npc.name .. "'s mind cannot be read.")
    else
        local rand = love.math.random(#npc.hints)
        local colour = npc.npcType == common.npc.npcType.guard and { 85, 170, 85 } or
            npc.npcType == common.npc.npcType.guest and { 170, 255, 255 } or
            npc.npcType == common.npc.npcType.servant and { 85, 170, 85 } or
            npc.npcType == common.npc.npcType.host and { 255, 170, 85 }
        local font = npc.npcType == common.npc.npcType.guard and common.config.config.fonts.guard or
            (npc.npcType == common.npc.npcType.guest or npc.npcType == common.npc.npcType.guest) and
            common.config.config.fonts.guest or
            npc.npcType == common.npc.npcType.servant and common.config.config.fonts.servant
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main, npc.name, colour)
        common.dialogue.space()
        common.dialogue.add(common, font, "(" .. npc.hints[rand] .. ")")
    end
end

---@param common common
function npcs.tick(common)
    local selectedNpc = common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom)[common.player.selNpc]
    ---@param npc ConPartygoer
    for _, npc in ipairs(common.config.npcs.npcs) do
        if (npc.health > 0 and not (selectedNpc.name == npc.name and common.player.curRoom == npc.room and common.powers.isActive and common.powers.lastActive == common.powers.powers.sleep)) then
            if (npc.name == "Guard") then
                npcs.planner:Tick(common.ai.domains.DomGuard, npc, false)
            elseif (npc.name == "Cunning Slayer") then
                npcs.planner:Tick(common.ai.domains.DomCunning, npc, false)
            elseif (npc.name == "Emory") then
                npcs.planner:Tick(common.ai.domains.DomStatic, npc, false)
            else
                npcs.planner:Tick(common.ai.domains.DomWander, npc, false)
            end
        end
    end
end

---@param common common
function npcs.init(common)
    npcs.planner = require("utils.sb_htn.Planners.Planner"):new(common.ai.contexts.ConPartygoer)
end

return npcs
