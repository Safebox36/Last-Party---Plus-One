local sb_htn = require("utils.sb_htn.interop")
local ConPartygoer = require("src.ai.ConPartygoer")

---@class SubBlock : DomainBuilder
local SubBlock = sb_htn.DomainBuilder:new("Block Player Powers", sb_htn.Factory.DefaultFactory:new(), ConPartygoer)

return SubBlock:Select("Should block?")
    ---@param ctx ConPartygoer
    :Condition("Witnessed player?", function(ctx)
        return ctx:HasState(ConPartygoer.ePartyState.IsTriggered)
    end)
    ---@param ctx ConPartygoer
    :Condition("Is player in room?", function(ctx)
        return ctx.room == ctx.common.player.curRoom
    end)
    :Action("Is blocking?")
    ---@param ctx ConPartygoer
    :Do(function(ctx)
        ctx.common.player.mana = -1
        ctx.common.dialogue.space()
        ctx.common.dialogue.add(ctx.common, ctx.common.config.config.fonts.main,
            ctx.name .. " has nullified your powers.")
        love.timer.sleep(0.25)
        return sb_htn.Tasks.ETaskStatus.Success
    end, nil)
    :End()
    :End()
    :Build()
