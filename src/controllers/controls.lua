local controls = {
    baton = {},
    delta = 0,
    isHeld = false
}

function controls.init(config)
    controls.baton = require("utils.baton").new(config)
end

function controls.update(dt)
    controls.delta = math.min(0.5, controls.delta + dt)
end

return controls
