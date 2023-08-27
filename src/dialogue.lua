---@class dialogueItem
---@field font love.Font
---@field string string
---@field col table<number, number, number>

---@class dialogue
---@field log dialogueItem
local dialogue = {
    log = {}
}

---@param common common
---@param font love.Font
---@param string string
---@param col table<number, number, number> | nil
function dialogue.add(common, font, string, col)
    local width, lines = font:getWrap(string, common.config.config.dimModes[common.config.config.dim][1] - 168)
    for _, line in ipairs(lines) do
        table.insert(dialogue.log,
            {
                font = font,
                string = line,
                col = col and { col[1] / 255, col[2] / 255, col[3] / 255 } or
                    common.config.config.colourModes[common.config.config.colour].white
            })
    end
end

function dialogue.space()
    table.insert(dialogue.log, {})
end

---@param common common
function dialogue.print(common)
    local log = "Turns Taken: " .. common.player.turnCount - 1 .. "\n\n\n"
    ---@param entry dialogueItem
    for _, entry in ipairs(dialogue.log) do
        if (entry.string) then
            log = log .. entry.string .. "\n"
        else
            log = log .. "\n"
        end
    end
    love.filesystem.write("dialogue_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".txt", log)
end

return dialogue
