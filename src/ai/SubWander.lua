local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

---@class SubWander : DomainBuilder
local SubWander = sb_htn.DomainBuilder:new("Idling or Wandering", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return SubWander:Select("Should wander?")
    :Action("Begin to wander...")
    ---@param ctx ConPartygoer
    :Do(function(ctx)
        local shouldWander = love.math.random(5) == 1
        if (shouldWander) then
            local selDir = ""
            for _, dir in pairs(ctx.common.config.rooms.directions) do
                if (love.math.random(4) == 1) then
                    selDir = dir
                    break
                end
            end
            if (selDir ~= "") then
                local neighbours = ctx.common.config.rooms.neighbours[ctx.room][selDir]
                if (neighbours and #ctx.common.controllers.npcs.getNpcsInRoom(ctx.common, ctx.room) > 1) then
                    local newRoom = love.math.random(#neighbours)
                    if (#ctx.common.controllers.npcs.getNpcsInRoom(ctx.common, neighbours[newRoom]) < 7) then
                        if (ctx.room == ctx.common.player.curRoom) then
                            ctx.common.dialogue.space()
                            ctx.common.dialogue.add(ctx.common, ctx.common.config.config.fonts.main,
                                ctx.name .. " has left the room.")
                            love.timer.sleep(0.25)
                        end
                        ctx.room = neighbours[newRoom]
                        if (ctx.room == ctx.common.player.curRoom) then
                            ctx.common.dialogue.space()
                            ctx.common.dialogue.add(ctx.common, ctx.common.config.config.fonts.main,
                                ctx.name .. " has entered the room.")
                            love.timer.sleep(0.25)
                        end
                    end
                end
            end
        end
        return sb_htn.Tasks.ETaskStatus.Success
    end, nil)
    :End()
    :End()
    :Build()
