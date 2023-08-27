---@class player
local player = {
    health = 10,
    mana = 10,
    curRoom = 0,
    inMenu = false,
    selRoom = 1,
    selNpc = 1,
    isTurn = true,
    turnCount = 0
}

function player.incrementTurn()
    player.isTurn = false
    player.turnCount = player.turnCount + 1
end

function player.prepareTurn()
    player.isTurn = true
end

---@param mana number
function player.usePower(mana)
    player.mana = math.max(-1, player.mana - mana - 1)
end

function player.restoreMana()
    player.mana = math.min(10, player.mana + 1)
end

return player
