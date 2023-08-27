local npcs = {
    npcs = {}
}

---@param common common
local function guardResponse(common)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, "Guard", { 85, 170, 85 })
    common.dialogue.add(common, common.config.config.fonts.guard, "  " .. "Hope you're enjoying the party, sir.")
end

---@param common common
local function cunningSlayerResponse(common)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main,
        "He does not respond, though you can feel him scowling beneath his mask.")
end

---@param common common
---@param name string
local function femaleGuestResponse(common, name)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, name, { 170, 255, 255 })
    local n = love.math.random(3)
    local responses = {
        "Hmm?",
        "Are you with the MacBeths?",
        "Beautiful estate, isn't it?"
    }
    common.dialogue.add(common, common.config.config.fonts.guest, "  " .. responses[n])
end

---@param common common
---@param name string
local function maleGuestResponse(common, name)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, name, { 170, 255, 255 })
    local n = love.math.random(3)
    local responses = {
        "Can I help you?",
        "I don't know you, and I don't want to.",
        "Not as good as last year's party."
    }
    common.dialogue.add(common, common.config.config.fonts.guest, "  " .. responses[n])
end

---@param common common
local function servantResponse(common)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, "Servant", { 85, 170, 85 })
    local n = love.math.random(3)
    local responses = {
        "Hello sir, can I get you anything?",
        "Lovely evening, sir.",
        "Not as good as last year's party."
    }
    common.dialogue.add(common, common.config.config.fonts.servant, "  " .. responses[n])
end

---@param common common
local function elanorResponse(common)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, "Elanor", { 255, 170, 85 })
    local n = love.math.random(3)
    local responses = {
        "Oh, another one. Welcome to my sisters' party.",
        "Might you leave me alone, sir?",
        "Thank y-, oh you're not the staff.\nMy apologies, I thought you were here with another drink."
    }
    common.dialogue.add(common, common.config.config.fonts.guest, "  " .. responses[n])
end

---@param common common
local function emoryResponse(common)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, "Emory", { 255, 170, 85 })
    local n = love.math.random(3)
    local responses = {
        "Welcome to our party. I hope you're enjoying yourself.",
        "Gloria, gloria, corona de la Matria,\nsoberana luz, que es oro en tu Pendon.",
        "Thank y-, oh you're not the staff.\nMy apologies, I thought you were here with another drink."
    }
    common.dialogue.add(common, common.config.config.fonts.guest, "  " .. responses[n])
end

local function edithResponse(common)
    common.dialogue.space()
    common.dialogue.add(common, common.config.config.fonts.main, "Edith", { 255, 170, 85 })
    local n = love.math.random(3)
    local responses = {
        "Welcome to my party. I don't believe you've had the pleasure.",
        "Well aren't you a fascinating individual...",
        "Tell me, are you free this evening?"
    }
    common.dialogue.add(common, common.config.config.fonts.guest, "  " .. responses[n])
end

---@param common common
---@param npcFactory npcFactory
---@param conPartygoer ConPartygoer
function npcs.init(common, --[[npcFactory]] conPartygoer)
    -- table.insert(npcs.npcs, npcFactory.create("Guard", common.config.rooms.names[1], guardResponse, common.config.hints, "guard"))
    -- table.insert(npcs.npcs, npcFactory.create("Cunning Slayer", common.config.rooms.names[1], cunningSlayerResponse, common.config.hints, "guard"))
    -- table.insert(npcs.npcs, npcFactory.create("Betsy", common.config.rooms.names[1], femaleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Iliana", common.config.rooms.names[1], femaleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Thomas", common.config.rooms.names[1], maleGuestResponse, common.config.hints, "guest"))

    -- table.insert(npcs.npcs, npcFactory.create("Gerald", common.config.rooms.names[2], maleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Eliza", common.config.rooms.names[2], femaleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Compton", common.config.rooms.names[2], maleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Servant", common.config.rooms.names[2], servantResponse, common.config.hints, "servant"))

    -- table.insert(npcs.npcs, npcFactory.create("Elanor", common.config.rooms.names[3], elanorResponse, common.config.hints, "host"))
    -- table.insert(npcs.npcs, npcFactory.create("Servant", common.config.rooms.names[3], servantResponse, common.config.hints, "servant"))
    -- table.insert(npcs.npcs, npcFactory.create("Jessamine", common.config.rooms.names[3], femaleGuestResponse, common.config.hints, "guest"))

    -- table.insert(npcs.npcs, npcFactory.create("Moriarty", common.config.rooms.names[4], maleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Jean-Luc", common.config.rooms.names[4], maleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("William", common.config.rooms.names[4], maleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Beverly", common.config.rooms.names[4], femaleGuestResponse, common.config.hints, "guest"))

    -- table.insert(npcs.npcs, npcFactory.create("Emory", common.config.rooms.names[5], emoryResponse, common.config.hints, "host"))
    -- table.insert(npcs.npcs, npcFactory.create("Servant", common.config.rooms.names[5], servantResponse, common.config.hints, "servant"))

    -- table.insert(npcs.npcs, npcFactory.create("Joseph", common.config.rooms.names[6], maleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Francisco", common.config.rooms.names[6], maleGuestResponse, common.config.hints, "guest"))
    -- table.insert(npcs.npcs, npcFactory.create("Servant", common.config.rooms.names[6], servantResponse, common.config.hints, "servant"))
    -- table.insert(npcs.npcs, npcFactory.create("Guard", common.config.rooms.names[6], guardResponse, common.config.hints, "guard"))
    -- table.insert(npcs.npcs, npcFactory.create("Cunning Slayer", common.config.rooms.names[6], cunningSlayerResponse, common.config.hints, "guard"))
    -- table.insert(npcs.npcs, npcFactory.create("Edith", common.config.rooms.names[6], edithResponse, common.config.hints, "host"))

    table.insert(npcs.npcs,
        conPartygoer:new("Guard", 1, guardResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guard],
            common.npc.npcType.guard, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Cunning Slayer", 1, cunningSlayerResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guard],
            common.npc.npcType.guard, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Betsy", 1, femaleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Iliana", 1, femaleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Thomas", 1, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))

    table.insert(npcs.npcs,
        conPartygoer:new("Gerald", 2, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Eliza", 2, femaleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Compton", 2, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Servant", 2, servantResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]]
            [common.npc.npcType.servant], common.npc.npcType.servant, common))

    table.insert(npcs.npcs,
        conPartygoer:new("Elanor", 3, elanorResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.host],
            common.npc.npcType.host, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Servant", 3, servantResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]]
            [common.npc.npcType.servant], common.npc.npcType.servant, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Jessamine", 3, femaleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))

    table.insert(npcs.npcs,
        conPartygoer:new("Moriarty", 4, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Jean-Luc", 4, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("William", 4, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Beverly", 4, femaleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))

    table.insert(npcs.npcs,
        conPartygoer:new("Emory", 5, emoryResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.host],
            common.npc.npcType.host, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Servant", 5, servantResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]]
            [common.npc.npcType.servant], common.npc.npcType.servant, common))

    table.insert(npcs.npcs,
        conPartygoer:new("Joseph", 6, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Francisco", 6, maleGuestResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guest],
            common.npc.npcType.guest, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Servant", 6, servantResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]]
            [common.npc.npcType.servant], common.npc.npcType.servant, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Guard", 6, guardResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guard],
            common.npc.npcType.guard, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Cunning Slayer", 6, cunningSlayerResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.guard],
            common.npc.npcType.guard, common))
    table.insert(npcs.npcs,
        conPartygoer:new("Edith", 6, edithResponse,
            common.config.hints[common.config.config.targetModes[common.config.config.target]][common.npc.npcType.host],
            common.npc.npcType.host, common))

    ---@param npc ConPartygoer
    for _, npc in ipairs(npcs.npcs) do
        npc:init()
    end
end

---@param common common
---@return ConPartygoer | nil
function npcs.getTarget(common)
    local targetName = common.config.config.targetModes[common.config.config.target]
    ---@param npc ConPartygoer
    for _, npc in ipairs(npcs.npcs) do
        if (npc.name == targetName) then
            return npc
        end
    end
    return nil
end

return npcs
