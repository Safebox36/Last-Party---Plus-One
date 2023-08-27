local animation = {
    delta = 1
}

---@param common common
function animation.init(common)
    animation.sheets = {}

    for key, value in pairs(common.config.config.icons) do
        local newKey = 0
        for nk, nv in pairs(common.powers.powers) do
            if (nk == key) then
                newKey = nv
                break
            end
        end
        animation.sheets[newKey] = {
            texture = value,
            quads = {}
        }
        for i = 1, 4 do
            table.insert(animation.sheets[newKey].quads, love.graphics.newQuad(i * 5 - 5, 0, 5, 5, value))
        end
    end
end

function animation.update(dt)
    animation.delta = math.min(1, animation.delta + dt)
end

---@param common common
---@param activePower ePowers
function animation.drawIcon(common, activePower)
    local icon = animation.sheets[activePower].quads[math.floor(animation.delta * 4 + 1)]
    local qw, qh = 5, 5
    local x, y = math.floor((common.config.config.dimModes[common.config.config.dim][1] / 8) / 2 - qw / 2) * 8,
        math.floor((common.config.config.dimModes[common.config.config.dim][2] / 8) / 2 - qh / 2) * 8
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].black)
    love.graphics.rectangle("fill", x - 24, y - 24, qw * 8 + 48, qh * 8 + 48)
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
    love.graphics.rectangle("fill", x - 16, y - 16, qw * 8 + 32, qh * 8 + 32)
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].black)
    love.graphics.rectangle("fill", x - 8, y - 8, qw * 8 + 16, qh * 8 + 16)
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
    love.graphics.draw(animation.sheets[activePower].texture, icon, x, y, 0, 8, 8)
end

return animation
