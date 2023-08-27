local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

---@class SubAttack : DomainBuilder
local SubAttack = sb_htn.DomainBuilder:new("Attack Player", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return SubAttack:Select("Should attack?")
    ---@param ctx ConPartygoer
    :Condition("Witnessed player?", function(ctx)
        return ctx:HasState(ConPartygoer.ePartyState.IsTriggered)
    end)
    :Condition("Is player in room?", function(ctx)
        return ctx.room == ctx.common.player.curRoom
    end)
    :Action("Is attacking?")
    ---@param ctx ConPartygoer
    :Do(function(ctx)
        local damage = love.math.random(1, 3)
        ctx.common.player.health = ctx.common.player.health - damage
        ctx.common.dialogue.space()
        ctx.common.dialogue.add(ctx.common, ctx.common.config.config.fonts.main,
            ctx.name .. " slashes his sword at you for " .. tostring(damage) .. " damage.")
        love.timer.sleep(0.25)
        return sb_htn.Tasks.ETaskStatus.Success
    end, nil)
    :End()
    :End()
    :Build()
