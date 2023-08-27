local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

---@class SubFlee : DomainBuilder
local SubFlee = sb_htn.DomainBuilder:new("Flee From Player", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return SubFlee:Select("Should flee?")
    ---@param ctx ConPartygoer
    :Condition("Is afraid of player?", function(ctx)
        for _, npc in ipairs(ctx.common.controllers.npcs.getNpcsInRoom(ctx.common, ctx.room)) do
            if (npc.health < 1) then
                return true
            end
        end
        return ctx:HasState(ConPartygoer.ePartyState.IsTriggered)
    end)
    ---@param ctx ConPartygoer
    :Condition("Is neighbouring room empty enough?", function(ctx)
        local selDir = ""
        local neighbours = nil
        while (neighbours == nil) do
            for _, dir in pairs(ctx.common.config.rooms.directions) do
                if (love.math.random(4) == 1) then
                    selDir = dir
                    break
                end
            end
            neighbours = ctx.common.config.rooms.neighbours[ctx.room][selDir]
        end
        local neighbour = neighbours[love.math.random(#neighbours)]
        if (#ctx.common.controllers.npcs.getNpcsInRoom(ctx.common, neighbour) < 7 and #ctx.common.controllers.npcs.getNpcsInRoom(ctx.common, ctx.room) > 1 and neighbour ~= ctx.common.player.curRoom) then
            ctx.room = neighbour
        else
            return false
        end
        return true
    end)
    :Action("Is fleeing?")
    ---@param ctx ConPartygoer
    :Do(function(ctx)
        ctx.common.dialogue.space()
        ctx.common.dialogue.add(ctx.common, ctx.common.config.config.fonts.main,
            ctx.name .. " has fled the room.")
        love.timer.sleep(0.25)
        return sb_htn.Tasks.ETaskStatus.Success
    end, nil)
    :End()
    :End()
    :Build()
