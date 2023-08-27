local ui = {}

---@param common common
---@param x number
---@param y number
---@param val number
---@param fullCol table<number,number,number>
---@param emptyCol table<number,number,number>
local function drawBar(common, x, y, val, fullCol, emptyCol)
    love.graphics.setColor(fullCol[1] / 255, fullCol[2] / 255, fullCol[3] / 255)
    love.graphics.print("-", x, y - 1)
    love.graphics.print("-", x, y + 11 * 8 - 1)
    for i = 1, 10 do
        local hasVal = val >= 11 - i
        if (hasVal) then
            love.graphics.setColor(fullCol[1] / 255, fullCol[2] / 255, fullCol[3] / 255)
        else
            love.graphics.setColor(emptyCol[1] / 255, emptyCol[2] / 255, emptyCol[3] / 255)
        end
        love.graphics.print(hasVal and "$" or "~", x, y + i * 8 - 1)
    end
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
end

---@param common common
---@param x number
---@param y number
---@param val number
function ui.drawHealth(common, x, y, val)
    drawBar(common, x, y, val, { 255, 0, 0 }, { 85, 0, 0 })
end

---@param common common
---@param x number
---@param y number
---@param val number
function ui.drawMana(common, x, y, val)
    drawBar(common, x, y, math.max(0, val), { 0, 85, 255 }, { 0, 0, 170 })
end

---@param common common
---@param curRoom number
---@param selRoom number
function ui.drawMap(common, curRoom, selRoom)
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
    love.graphics.draw(common.config.config.map[curRoom], x, y, 0, 8, 8)
    if (selRoom ~= curRoom) then
        love.graphics.setColor(255 / 255, 85 / 255, 85 / 255)
        love.graphics.draw(common.config.config.map[selRoom], x, y, 0, 8, 8)
        love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
    end
end

---@param common common
---@param curRoom number
function ui.drawNpcs(common, curRoom)
    local npcs = common.controllers.npcs.getNpcsInRoom(common, curRoom)
    local w = love.graphics.getCanvas():getWidth()
    if (common.player.isTurn and common.controllers.controls.isHeld == false) then
        love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].black)
        love.graphics.rectangle("fill",
            w - common.config.config.fonts.main:getWidth(npcs[common.player.selNpc].name) - 32,
            8 * common.player.selNpc - 8, 24, 24)
        love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
        love.graphics.rectangle("fill",
            w - common.config.config.fonts.main:getWidth(npcs[common.player.selNpc].name) - 24, 8 * common.player.selNpc,
            8, 8)
    end
    ---@param npc npc
    for offset, npc in ipairs(npcs) do
        if (npc.health < 1) then
            love.graphics.setColor(85 / 255, 85 / 255, 85 / 255)
        elseif (npc.npcType == common.npc.npcType.guard) then
            love.graphics.setColor(85 / 255, 170 / 255, 85 / 255)
        elseif (npc.npcType == common.npc.npcType.guest) then
            love.graphics.setColor(170 / 255, 255 / 255, 255 / 255)
        elseif (npc.npcType == common.npc.npcType.servant) then
            love.graphics.setColor(85 / 255, 170 / 255, 85 / 255)
        elseif (npc.npcType == common.npc.npcType.host) then
            love.graphics.setColor(255 / 255, 170 / 255, 85 / 255)
        end
        love.graphics.printf(npc.name, -8, 8 * offset - 1, w, "right")
    end
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
end

---@param common common
function ui.drawDialogue(common)
    common.controllers.dialogue.draw(common, common.dialogue)
end

---@param common common
function ui.drawControls(common)
    local w, h = love.graphics.getCanvas():getDimensions()
    local top, right, bottom, left =
        (common.player.health < 1 or common.config.npcs.getTarget(common).health < 1) and "" or
        ((common.player.inMenu or common.player.isTurn == false or common.powers.isActive) and "") or
        (common.powers.current == common.powers.powers.blink and "Shift Room" or common.powers.current == common.powers.powers.eye and "Mind's Eye" or common.powers.current == common.powers.powers.rats and "Summon Rats"),
        (common.player.health < 1 or common.config.npcs.getTarget(common).health < 1) and "Review" or
        ((common.player.inMenu and common.player.curRoom ~= common.player.selRoom or common.powers.isActive and common.powers.current == common.powers.powers.blink) and "Move" or (common.player.inMenu == false and common.player.isTurn) and "Interact" or ""),
        (common.player.health < 1 or common.config.npcs.getTarget(common).health < 1) and "" or
        ((common.player.inMenu and "Cancel") or (common.powers.isActive == false and common.player.isTurn and "Read Thought") or ""),
        (common.player.health < 1 or common.config.npcs.getTarget(common).health < 1) and "" or
        ((common.player.isTurn and common.player.inMenu == false and common.powers.isActive == false and "Dagger / KO") or "")
    love.graphics.setColor(255 / 255, 85 / 255, 85 / 255)
    love.graphics.rectangle("fill", w - 24, h - 40, 8, 8)
    love.graphics.printf(top, -32, h - 40 - 1, w, "right")
    love.graphics.setColor(85 / 255, 255 / 255, 85 / 255)
    love.graphics.rectangle("fill", w - 16, h - 24, 8, 8)
    love.graphics.printf(right, -24, h - 24 - 1, w, "right")
    love.graphics.setColor(85 / 255, 255 / 255, 255 / 255)
    love.graphics.rectangle("fill", w - 24, h - 16, 8, 8)
    love.graphics.printf(bottom, -32, h - 16 - 1, w, "right")
    love.graphics.setColor(170 / 255, 85 / 255, 255 / 255)
    love.graphics.rectangle("fill", w - 32, h - 32, 8, 8)
    love.graphics.printf(left, -40, h - 32 - 1, w, "right")
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
end

---@param common common
function ui.drawRoomName(common)
    local w, h = love.graphics.getCanvas():getDimensions()
    love.graphics.printf(common.config.rooms.names[common.player.curRoom], -8, h - 56, w, "right")
end

---@param common common
function ui.drawTitle(common)
    local w, h = love.graphics.getCanvas():getDimensions()
    local top, right, bottom =
        common.player.selNpc == 2 and "(480x272)" or common.player.selNpc == 3 and "(Monitor Glow)" or "",
        (common.player.selNpc == 1 or common.player.selNpc == 4) and "Select" or "",
        common.player.selNpc == 2 and "(384x216)" or common.player.selNpc == 3 and "(Beta)" or ""
    love.graphics.setColor(255 / 255, 85 / 255, 85 / 255)
    love.graphics.rectangle("fill", w - 24, h - 40, 8, 8)
    love.graphics.printf(top, -32, h - 40 - 1, w, "right")
    love.graphics.setColor(85 / 255, 255 / 255, 85 / 255)
    love.graphics.rectangle("fill", w - 16, h - 24, 8, 8)
    love.graphics.printf(right, -24, h - 24 - 1, w, "right")
    love.graphics.setColor(85 / 255, 255 / 255, 255 / 255)
    love.graphics.rectangle("fill", w - 24, h - 16, 8, 8)
    love.graphics.printf(bottom, -32, h - 16 - 1, w, "right")
    love.graphics.setColor(170 / 255, 85 / 255, 255 / 255)
    love.graphics.rectangle("fill", w - 32, h - 32, 8, 8)

    local dim = common.config.config.dimModes[common.config.config.dim]
    local col = common.config.config.colour
    local logo = common.config.config.logo[common.config.config.dim]
    local items = {
        "Join Party",
        "Resolution (" .. dim[1] .. "x" .. dim[2] .. ")",
        "Palette (" .. (col == "beta" and "Beta" or "Monitor Glow") .. ")",
        "Leave Party"
    }
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
    love.graphics.draw(logo, w / 2 - logo:getWidth() / 2, h / 4 - logo:getHeight() / 2)
    for index, item in ipairs(items) do
        love.graphics.printf(item, 8, h - 48 + (8 * index) - 1, w)
    end
    love.graphics.rectangle("fill", 16 + common.config.config.fonts.main:getWidth(items[common.player.selNpc]),
        h - 48 + (8 * common.player.selNpc) - 1, 8, 8)
end

---@param common common
function ui.drawEnding(common)
    local w, h = love.graphics.getCanvas():getDimensions()
    local right, bottom = "Return to Title",
        "Quit"
    love.graphics.setColor(255 / 255, 85 / 255, 85 / 255)
    love.graphics.rectangle("fill", w - 24, h - 40, 8, 8)
    love.graphics.setColor(85 / 255, 255 / 255, 85 / 255)
    love.graphics.rectangle("fill", w - 16, h - 24, 8, 8)
    love.graphics.printf(right, -24, h - 24 - 1, w, "right")
    love.graphics.setColor(85 / 255, 255 / 255, 255 / 255)
    love.graphics.rectangle("fill", w - 24, h - 16, 8, 8)
    love.graphics.printf(bottom, -32, h - 16 - 1, w, "right")
    love.graphics.setColor(170 / 255, 85 / 255, 255 / 255)
    love.graphics.rectangle("fill", w - 32, h - 32, 8, 8)

    local dim = common.config.config.dimModes[common.config.config.dim]
    local col = common.config.config.colour
    local logo = common.config.config.logo[common.config.config.dim]
    local npcsWitnesses = 0
    local npcsIncapacitated = 0
    local npcsKilled = 0
    local target = common.config.npcs.getTarget(common)
    ---@param npc ConPartygoer
    for _, npc in ipairs(common.config.npcs.npcs) do
        if (npc:HasState(common.ai.contexts.ConPartygoer.ePartyState.IsTriggered) and (npc.name ~= target.name or npc.name == target.name and target.health > 0)) then
            npcsWitnesses = npcsWitnesses + 1
        end
        if (npc.name ~= target.name) then
            if (npc.health == -5) then
                npcsIncapacitated = npcsIncapacitated + 1
            elseif (npc.health == 0) then
                npcsKilled = npcsKilled + 1
            end
        end
    end
    local stats = {
        "Witnesses:   " .. string.format("%2s", npcsWitnesses),
        "Incapacited: " .. string.format("%2s", npcsIncapacitated),
        "Killed:      " .. string.format("%2s", npcsKilled),
    }
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
    love.graphics.draw(logo, w / 2 - logo:getWidth() / 2, h / 4 - logo:getHeight() / 2)
    for index, stat in ipairs(stats) do
        love.graphics.printf(stat, math.floor((w / 8) / 2 - (common.config.config.fonts.main:getWidth(stat) / 8) / 2) * 8,
            h - 48 + (8 * index) - 1, w)
    end
    local endingMessage = ""
    if (common.player.health < 1) then
        endingMessage = "You were slain\nin the " ..
            common.config.rooms.names[common.player.curRoom] .. "\nafter " .. common.player.turnCount - 1 .. " turns."
    elseif (common.config.npcs.getTarget(common).health < 1) then
        endingMessage = "You elimated " ..
            target.name ..
            "\nin the " ..
            common.config.rooms.names[common.player.curRoom] .. "\nafter " .. common.player.turnCount - 1 .. " turns."
    end
    love.graphics.printf(endingMessage,
        math.floor((w / 8) / 2 - (common.config.config.fonts.main:getWidth(endingMessage) / 8) / 2) * 8,
        math.floor((h / 8) / 2) * 8 - 1, w)
end

return ui
