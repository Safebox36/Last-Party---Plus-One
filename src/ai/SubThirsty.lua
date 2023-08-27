local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

---@class SubThirsty : DomainBuilder
local SubThirsty = sb_htn.DomainBuilder:new("Check Thirst", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

local navList = {
    3,
    1,
    5,
    5,
    6
}

return SubThirsty:Select("Should get drink?")
    ---@param ctx ConPartygoer
    :Condition("Is thirst low?", function(ctx)
        return ctx:HasState(ConPartygoer.ePartyState.IsThirsty)
    end)
    ---@param ctx ConPartygoer
    :Condition("Is dining hall empty enough?", function(ctx)
        return #ctx.common.controllers.npcs.getNpcsInRoom(ctx.common, ctx.room) < 7 and
            #ctx.common.controllers.npcs.getNpcsInRoom(ctx.common, 6) < 7
    end)
    :Action("Is thirsty?")
    ---@param ctx ConPartygoer
    :Do(function(ctx)
        if (ctx.room == ctx.common.player.curRoom) then
            ctx.common.dialogue.space()
            ctx.common.dialogue.add(ctx.common, ctx.common.config.config.fonts.main,
                ctx.name .. " has left the room.")
            love.timer.sleep(0.25)
        end
        if (ctx.room ~= 6) then
            ctx.room = navList[ctx.room]
        end
        if (ctx.room == ctx.common.player.curRoom) then
            ctx.common.dialogue.space()
            ctx.common.dialogue.add(ctx.common, ctx.common.config.config.fonts.main,
                ctx.name .. " has entered the room.")
            love.timer.sleep(0.25)
        end
        return sb_htn.Tasks.ETaskStatus.Success
    end, nil)
    ---@param ctx ConPartygoer
    :Effect("Is no longer thisty...", sb_htn.Effects.EEffectType.PlanAndExecute, function(ctx, type)
        if (ctx.room == 6) then
            ctx:SetState(ConPartygoer.ePartyState.IsThirsty, false, type)
        end
    end)
    :End()
    :End()
    :Build()
