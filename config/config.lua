local dkjson = require("utils.dkjson")

local config = {
    logo = {
        beta = love.graphics.newImage("assets/logo.png"),
        psp = love.graphics.newImage("assets/logo-large.png")
    },
    favicon = love.image.newImageData("assets/icon.png"),
    dimModes = {
        beta = { 384, 216 },
        psp = { 480, 272 }
    },
    dim = "psp",
    fonts = {
        main = love.graphics.newFont("assets/fonts/ZX Maverick.ttf", 8),
        guest = love.graphics.newFont("assets/fonts/ZX Venice.ttf", 8),
        guard = love.graphics.newFont("assets/fonts/Noted.ttf", 8),
        servant = love.graphics.newFont("assets/fonts/First Pass.ttf", 8)
    },
    colourModes = {
        beta = {
            black = { 0, 0, 0 },
            white = { 1, 1, 1 }
        },
        poly = {
            black = { 34 / 255, 35 / 255, 35 / 255 },
            white = { 240 / 255, 246 / 255, 240 / 255 }
        }
    },
    colour = "poly",
    map = {
        [-1] = love.graphics.newImage("assets/map/sprBase.png"),
        [1] = love.graphics.newImage("assets/map/spr1.png"),
        [2] = love.graphics.newImage("assets/map/spr2.png"),
        [3] = love.graphics.newImage("assets/map/spr3.png"),
        [4] = love.graphics.newImage("assets/map/spr4.png"),
        [5] = love.graphics.newImage("assets/map/spr5.png"),
        [6] = love.graphics.newImage("assets/map/spr6.png")
    },
    icons = {
        blink = love.graphics.newImage("assets/powers/sprBlink.png"),
        eye = love.graphics.newImage("assets/powers/sprEye.png"),
        rats = love.graphics.newImage("assets/powers/sprRats.png"),
        thought = love.graphics.newImage("assets/powers/sprThought.png"),
        sleep = love.graphics.newImage("assets/powers/sprSleep.png"),
        kill = love.graphics.newImage("assets/powers/sprKill.png")
    },
    controls = {
        up = { "key:w", "axis:lefty-" },
        down = { "key:s", "axis:lefty+" },
        left = { "key:a", "axis:leftx-" },
        right = { "key:d", "axis:leftx+" },

        attack = { "key:j", "button:x" },
        power = { "key:i", "button:y" },
        thought = { "key:k", "button:a" },
        interact = { "key:l", "button:b" },

        map = { "key:tab", "button:dpup" },

        powBlink = { "key:1", "button:dpleft" },
        powEye = { "key:2", "button:dpright" },
        powRats = { "key:3", "button:dpdown" },

        screenshot = { "key:f11", "button:misc1" }
    },
    targetModes = {
        "Edith",
        "Emory",
        "Elanor"
    },
    target = 0
}

function config.init()
    if (config.load() == false) then
        config.save()
    end
    config.target = love.math.random(3)
end

function config.load()
    local data = love.filesystem.read("config.json")
    if (data) then
        local object = dkjson.decode(data, 1, nil)
        config.dim = object.dim
        config.colour = object.colour
        return true
    end
    return false
end

function config.save()
    local data = dkjson.encode({ dim = config.dim, colour = config.colour })
    love.filesystem.write("config.json", data)
end

return config
