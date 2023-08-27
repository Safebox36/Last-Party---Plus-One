---@enum ePowers
local lPowers = {
    blink = 1,
    eye = 2,
    rats = 3,
    thought = 4,
    sleep = 5,
    kill = 6
}

---@class powers
local powers = {
    current = lPowers.blink,
    lastActive = 1,
    isActive = false,
    powers = lPowers
}

return powers
