---@class common
local common = {
    player = require("src.player"),
    npc = require("src.npc"),
    powers = require("src.powers"),
    ui = require("src.ui"),
    dialogue = require("src.dialogue"),
    controllers = {
        controls = require("src.controllers.controls"),
        powers = require("src.controllers.powers"),
        dialogue = require("src.controllers.dialogue"),
        rooms = require("src.controllers.rooms"),
        npcs = require("src.controllers.npcs"),
        animation = require("src.controllers.animation"),
        screen = require("src.controllers.screen")
    },
    config = {
        config = require("config.config"),
        rooms = require("config.rooms"),
        npcs = require("config.npcs"),
        hints = require("config.hints")
    },
    ai = {
        contexts = {
            ConPartygoer = require("src.ai.ConPartygoer")
        },
        subDomains = {
            SubAttack = require("src.ai.SubAttack"),
            SubBlock = require("src.ai.SubBlock"),
            SubFlee = require("src.ai.SubFlee"),
            SubThirsty = require("src.ai.SubThirsty"),
            SubWander = require("src.ai.SubWander")
        },
        domains = {
            DomCunning = require("src.ai.DomCunning"),
            DomGuard = require("src.ai.DomGuard"),
            DomStatic = require("src.ai.DomStatic"),
            DomWander = require("src.ai.DomWander")
        }
    }
}

return common
