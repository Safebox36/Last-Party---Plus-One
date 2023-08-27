local dialogue = {}

---@param common common
---@param dialogue dialogue
function dialogue.draw(common, dialogue)
    if (#dialogue.log <= common.config.config.dimModes[common.config.config.dim][2] / 8 - 3) then
        ---@param dialogueItem dialogueItem
        for index, dialogueItem in ipairs(dialogue.log) do
            if (dialogueItem.col) then
                love.graphics.setFont(dialogueItem.font)
                love.graphics.setColor(dialogueItem.col)
                love.graphics.printf(dialogueItem.string, 24, index * 8 - 1,
                    common.config.config.dimModes[common.config.config.dim][1] - 168)
            end
        end
    else
        local offset = 0
        for i = #dialogue.log - (common.config.config.dimModes[common.config.config.dim][2] / 8 - 3), #dialogue.log do
            offset = offset + 1
            ---@type dialogueItem
            local dialogueItem = dialogue.log[i]
            if (dialogueItem.col) then
                love.graphics.setFont(dialogueItem.font)
                love.graphics.setColor(dialogueItem.col)
                love.graphics.printf(dialogueItem.string, 24, offset * 8 - 1,
                    common.config.config.dimModes[common.config.config.dim][1] - 168)
            end
        end
    end
    love.graphics.setFont(common.config.config.fonts.main)
    love.graphics.setColor(common.config.config.colourModes[common.config.config.colour].white)
end

return dialogue
