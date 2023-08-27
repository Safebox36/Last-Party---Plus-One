local powersController = {}

---@param baton any
---@param powers powers
function powersController.processSelect(baton, powers)
    if (baton:pressed("powBlink")) then
        powers.current = powers.powers.blink
    elseif (baton:pressed("powEye")) then
        powers.current = powers.powers.eye
    elseif (baton:pressed("powRats")) then
        powers.current = powers.powers.rats
    end
end

---@param common common
---@param powers powers
function powersController.process(common, powers)
    if (powers.current == powers.powers.blink) then
        common.player.usePower(5)
    elseif (powers.current == powers.powers.eye) then
        common.player.usePower(3)
    elseif (powers.current == powers.powers.rats) then
        common.player.usePower(7)
    end
    common.powers.isActive = true
    common.powers.lastActive = common.powers.current
    common.controllers.animation.delta = 0
end

---@param common common
---@param selRoom number
function powersController.blinkUi(common, selRoom)
    local x, y =
        math.floor((common.config.config.dimModes[common.config.config.dim][1] / 8) / 2 -
            common.config.config.map[-1]:getWidth() / 2) * 8,
        math.floor((common.config.config.dimModes[common.config.config.dim][2] / 8) / 2 -
            common.config.config.map[-1]:getHeight() / 2) * 8
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].black)
    love.graphics.rectangle("fill", x - 8, y - 8, common.config.config.map[-1]:getWidth() * 8 + 16,
        common.config.config.map[-1]:getHeight() * 8 + 16)
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
    love.graphics.draw(common.config.config.map[-1], x, y, 0, 8, 8)
    love.graphics.setColor(255 / 255, 85 / 255, 85 / 255)
    love.graphics.draw(common.config.config.map[selRoom], x, y, 0, 8, 8)
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
end

---@param common common
---@param dir eDir
function powersController.blinkSelect(common, dir)
    if (dir == "") then
        return
    end
    if (common.config.rooms.neighbours[common.player.selRoom][dir]) then
        if (common.player.curRoom == common.player.selRoom) then
            common.player.selRoom = common.config.rooms.neighbours[common.player.selRoom][dir][1]
        else
            for _, firstNeighbour in ipairs(common.config.rooms.neighbours[common.player.selRoom][dir]) do
                common.player.selRoom = firstNeighbour
                if (firstNeighbour == common.player.curRoom) then
                    common.player.selRoom = common.config.rooms.neighbours[common.player.selRoom][dir][1]
                end
            end
        end
    end
end

---@param common common
---@param selRoom number
function powersController.blink(common, selRoom)
    common.player.curRoom = selRoom
    common.player.selNpc = math.min(common.player.selNpc, #common.controllers.npcs.getNpcsInRoom(common, selRoom))
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main,
        "You shifted to the " .. common.config.rooms.names[selRoom] .. ".")
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, common.config.rooms.names[selRoom])
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, common.config.rooms.descriptions[selRoom])
    common.powers.isActive = false
end

---@param common common
function powersController.eye(common)
    ---@param npc ConPartygoer
    common.dialogue.space()
    for _, npc in ipairs(common.config.npcs.npcs) do
        if (npc.hints == nil) then
            common.dialogue.add(common, common.config.config.fonts.main,
                npc.name .. " is in the " .. common.config.rooms.names[npc.room] .. ".")
        end
    end
    common.powers.isActive = false
end

---@param common common
function powersController.rats(common)
    local damage = love.math.random(3)
    ---@param npc ConPartygoer
    for _, npc in ipairs(common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom)) do
        npc.health = math.max(0, npc.health - damage)
        npc:SetState(common.ai.contexts.ConPartygoer.ePartyState.IsTriggered, true)
    end
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main,
        "You summoned rats that attack everyone in the room for " .. tostring(damage) .. " damage.")
    common.powers.isActive = false
end

---@param common common
---@param selNpc number
function powersController.attack(common, selNpc)
    common.powers.lastActive           = common.powers.powers.kill
    common.controllers.animation.delta = 0
    local npc                          = common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom)[selNpc]
    if (npc.health < 1) then
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main,
            "You slash your sword at the " .. (npc.health == 0 and "corpse" or "body") .. " of " .. npc.name .. ".")
    else
        local damage = love.math.random(3)
        npc.health = math.max(0, npc.health - damage)
        for _, oNpc in ipairs(common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom)) do
            oNpc:SetState(common.ai.contexts.ConPartygoer.ePartyState.IsTriggered, true)
        end
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main,
            "You slash your sword at " .. npc.name .. " for " .. tostring(damage) .. " damage.")
    end
    common.powers.isActive = false
end

---@param common common
---@param selNpc number
function powersController.sleepStart(common, selNpc)
    common.powers.lastActive           = common.powers.powers.sleep
    common.controllers.animation.delta = 0
    local npc                          = common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom)[selNpc]
    if (npc.health < 1) then
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main,
            "You try to stranglehold the " .. (npc.health == 0 and "corpse" or "body") .. " of " .. npc.name .. ".")
        common.controllers.controls.delta = 0
        common.powers.isActive = false
    else
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main,
            "You begin to stranglehold " .. npc.name .. ".")
    end
end

---@param common common
---@param selNpc number
function powersController.sleepStop(common, selNpc)
    local npc  = common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom)[selNpc]
    npc.health = -5
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main,
        "You knocked out " .. npc.name .. ".")
    love.timer.sleep(0.25)
    common.powers.isActive = false
end

return powersController
