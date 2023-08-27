local rooms = {}

---@param common common
---@param dir eDir
function rooms.selectRoom(common, dir)
    if (dir == "") then
        return
    end
    if (common.config.rooms.neighbours[common.player.selRoom][dir]) then
        if (common.player.curRoom == common.player.selRoom) then
            common.player.selRoom = common.config.rooms.neighbours[common.player.selRoom][dir][1]
        else
            for _, firstNeighbour in ipairs(common.config.rooms.neighbours[common.player.selRoom][dir]) do
                for direction, neighbours in pairs(common.config.rooms.neighbours[firstNeighbour]) do
                    for _, secondNeighbour in ipairs(neighbours) do
                        if (secondNeighbour == common.player.curRoom) then
                            common.player.selRoom = firstNeighbour
                            return
                        end
                    end
                end
                if (firstNeighbour == common.player.curRoom) then
                    common.player.selRoom = common.config.rooms.neighbours[common.player.selRoom][dir][1]
                end
            end
        end
    end
end

---@param common common
---@param selRoom number
function rooms.moveToRoom(common, selRoom)
    if (common.player.curRoom ~= selRoom) then
        common.player.curRoom = selRoom
        common.player.selNpc = math.min(common.player.selNpc, #common.controllers.npcs.getNpcsInRoom(common, selRoom))
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main, common.config.rooms.names[selRoom])
        common.dialogue.space()
        common.dialogue.add(common, common.config.config.fonts.main, common.config.rooms.descriptions[selRoom])
        common.player.inMenu = false
        common.player.turnCount = common.player.turnCount + 1
    end
end

return rooms
