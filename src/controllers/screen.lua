---@enum eScreen
local eScreen = {
    title = 1,
    game = 2,
    ending = 3
}

local screen = {
    eScreen = eScreen,
    active = 1
}

---@param newScreen eScreen
function screen.switch(newScreen)
    screen.active = newScreen
end

return screen
