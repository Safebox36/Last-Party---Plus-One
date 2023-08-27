local maid64 = require("utils.maid64")
local common = require("src.common")
local shuffle = require("utils.shuffle")

function love.load()
    common.config.config.init()
    common.controllers.controls.init({
        controls = common.config.config.controls,
        joystick = love.joystick.getJoysticks()[1]
    })
    common.controllers.npcs.init(common)
    common.controllers.animation.init(common)
    common.config.npcs.init(common, common.ai.contexts.ConPartygoer)
    shuffle(common.config.npcs.npcs)

    love.window.setMode(common.config.config.dimModes[common.config.config.dim][1],
        common.config.config.dimModes[common.config.config.dim][2],
        {
            resizable = true,
            minwidth = common.config.config.dimModes[common.config.config.dim][1],
            minheight = common.config.config.dimModes[common.config.config.dim][2]
        })
    love.window.maximize()
    love.window.setTitle("Last Party - Plus One")
    love.window.setIcon(common.config.config.favicon)
    maid64.setup(common.config.config.dimModes[common.config.config.dim][1],
        common.config.config.dimModes[common.config.config.dim][2])

    ---@param value love.Image
    for _, value in pairs(common.config.config.logo) do
        value:setFilter("nearest", "nearest")
    end
    ---@param value love.Image
    for _, value in pairs(common.config.config.map) do
        value:setFilter("nearest", "nearest")
    end
    ---@param value love.Image
    for _, value in pairs(common.config.config.icons) do
        value:setFilter("nearest", "nearest")
    end
end

function love.update(dt)
    common.controllers.controls.baton:update()
    if (common.controllers.controls.baton:pressed("screenshot")) then
        love.graphics.captureScreenshot(os.date("%Y-%m-%d_%H-%M-%S") .. ".png")
    end

    if (common.controllers.screen.active == common.controllers.screen.eScreen.title) then
        local isMaximised = love.window.isMaximized()
        if (common.controllers.controls.baton:pressed("interact")) then
            if (common.player.selNpc == 1) then
                common.controllers.screen.switch(common.controllers.screen.eScreen.game)
                common.controllers.rooms.moveToRoom(common, 1)
                table.remove(common.dialogue.log, 1)
            elseif (common.player.selNpc == 4) then
                love.event.quit()
            end
        elseif (common.controllers.controls.baton:pressed("thought")) then
            if (common.player.selNpc == 2) then
                common.config.config.dim = "beta"
                love.window.setMode(common.config.config.dimModes[common.config.config.dim][1],
                    common.config.config.dimModes[common.config.config.dim][2],
                    {
                        resizable = true,
                        minwidth = common.config.config.dimModes[common.config.config.dim][1],
                        minheight = common.config.config.dimModes[common.config.config.dim][2]
                    })
                maid64.setup(common.config.config.dimModes[common.config.config.dim][1],
                    common.config.config.dimModes[common.config.config.dim][2])
                if (isMaximised) then
                    love.window.maximize()
                end
                common.config.config.save()
            elseif (common.player.selNpc == 3) then
                common.config.config.colour = "beta"
                common.config.config.save()
            end
        elseif (common.controllers.controls.baton:pressed("power")) then
            if (common.player.selNpc == 2) then
                common.config.config.dim = "psp"
                love.window.setMode(common.config.config.dimModes[common.config.config.dim][1],
                    common.config.config.dimModes[common.config.config.dim][2],
                    {
                        resizable = true,
                        minwidth = common.config.config.dimModes[common.config.config.dim][1],
                        minheight = common.config.config.dimModes[common.config.config.dim][2]
                    })
                maid64.setup(common.config.config.dimModes[common.config.config.dim][1],
                    common.config.config.dimModes[common.config.config.dim][2])
                if (isMaximised) then
                    love.window.maximize()
                end
                common.config.config.save()
            elseif (common.player.selNpc == 3) then
                common.config.config.colour = "poly"
                common.config.config.save()
            end
        elseif (common.controllers.controls.baton:pressed("up")) then
            common.player.selNpc = math.max(1, common.player.selNpc - 1)
        elseif (common.controllers.controls.baton:pressed("down")) then
            common.player.selNpc = math.min(4, common.player.selNpc + 1)
        end
    elseif (common.controllers.screen.active == common.controllers.screen.eScreen.game) then
        if (common.controllers.animation.delta < 1) then
            common.controllers.animation.update(dt * 2)
        elseif (common.player.isTurn and (common.player.health < 1 or common.config.npcs.getTarget(common).health < 1)) then
            if (common.controllers.controls.baton:pressed("interact")) then
                common.controllers.screen.switch(common.controllers.screen.eScreen.ending)
                return
            end
        elseif (common.player.isTurn) then
            if (common.controllers.controls.baton:pressed("map")) then
                common.player.inMenu = not common.player.inMenu
                if (common.player.inMenu == false) then
                    common.player.selRoom = common.player.curRoom
                end
                return
            elseif (common.player.inMenu) then
                local selectedDirection = ""
                if (common.controllers.controls.baton:pressed("interact")) then
                    common.controllers.rooms.moveToRoom(common, common.player.selRoom)
                    return
                elseif (common.controllers.controls.baton:pressed("thought")) then
                    common.player.selRoom = common.player.curRoom
                    common.player.inMenu = false
                    return
                elseif (common.controllers.controls.baton:pressed("up")) then
                    selectedDirection = "u"
                elseif (common.controllers.controls.baton:pressed("down")) then
                    selectedDirection = "d"
                elseif (common.controllers.controls.baton:pressed("left")) then
                    selectedDirection = "l"
                elseif (common.controllers.controls.baton:pressed("right")) then
                    selectedDirection = "r"
                end
                common.controllers.rooms.selectRoom(common, selectedDirection)
            elseif (common.controllers.controls.isHeld) then
                if (common.controllers.controls.delta == 0.5) then
                    common.controllers.powers.sleepStop(common, common.player.selNpc)
                    common.controllers.controls.delta = 0
                    common.player.incrementTurn()
                    if (not common.controllers.controls.baton:down("attack")) then
                        if (common.controllers.controls.isHeld == true) then
                            common.controllers.controls.isHeld = false
                            common.powers.isActive = false
                        end
                    end
                elseif (common.controllers.controls.baton:released("attack")) then
                    if (common.controllers.controls.isHeld == true) then
                        common.controllers.controls.isHeld = false
                        common.powers.isActive = false
                    end
                end
            elseif (common.powers.isActive) then
                if (common.powers.current == common.powers.powers.blink) then
                    local selectedDirection = ""
                    if (common.controllers.controls.baton:pressed("interact")) then
                        common.controllers.powers.blink(common, common.player.selRoom)
                        common.player.incrementTurn()
                        return
                    elseif (common.controllers.controls.baton:pressed("up")) then
                        selectedDirection = "u"
                    elseif (common.controllers.controls.baton:pressed("down")) then
                        selectedDirection = "d"
                    elseif (common.controllers.controls.baton:pressed("left")) then
                        selectedDirection = "l"
                    elseif (common.controllers.controls.baton:pressed("right")) then
                        selectedDirection = "r"
                    end
                    common.controllers.powers.blinkSelect(common, selectedDirection)
                elseif (common.powers.current == common.powers.powers.eye) then
                    common.controllers.powers.eye(common)
                    common.player.incrementTurn()
                    return
                elseif (common.powers.current == common.powers.powers.rats) then
                    common.controllers.powers.rats(common)
                    common.player.incrementTurn()
                    return
                end
            else
                if (common.controllers.controls.baton:pressed("interact")) then
                    common.controllers.npcs.interactWithNpc(common, common.player.curRoom, common.player.selNpc)
                    common.player.incrementTurn()
                elseif (common.controllers.controls.baton:pressed("thought")) then
                    common.controllers.npcs.thoughtNpc(common, common.player.curRoom, common.player.selNpc)
                    common.player.incrementTurn()
                elseif (common.controllers.controls.baton:down("attack")) then
                    common.controllers.controls.update(dt)
                    if (common.controllers.controls.delta == 0.5) then
                        common.controllers.powers.sleepStart(common, common.player.selNpc)
                        common.controllers.controls.isHeld = true
                        common.powers.isActive = true
                        common.player.incrementTurn()
                    end
                elseif (common.controllers.controls.baton:released("attack")) then
                    if (common.controllers.controls.delta < 0.5) then
                        common.controllers.powers.attack(common, common.player.selNpc)
                        common.controllers.controls.delta = 0
                        common.player.incrementTurn()
                    end
                elseif (common.controllers.controls.baton:pressed("power")) then
                    common.controllers.powers.process(common, common.powers)
                elseif (common.controllers.controls.baton:pressed("up")) then
                    common.player.selNpc = math.max(1, common.player.selNpc - 1)
                elseif (common.controllers.controls.baton:pressed("down")) then
                    common.player.selNpc = math.min(
                        #common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom), common.player.selNpc + 1)
                else
                    common.controllers.powers.processSelect(common.controllers.controls.baton, common.powers)
                end
            end
        else
            common.controllers.npcs.tick(common)
            common.player.isTurn = true
            common.player.selNpc = math.min(common.player.selNpc,
                #common.controllers.npcs.getNpcsInRoom(common, common.player.curRoom))
            common.player.restoreMana()
            if (common.player.health < 1) then
                common.dialogue.space()
                common.dialogue.add(common, common.config.config.fonts.main, "You have been slain.", { 85, 85, 85 })
                common.dialogue.print(common)
            elseif (common.config.npcs.getTarget(common).health < 1) then
                common.dialogue.space()
                common.dialogue.add(common, common.config.config.fonts.main, "You have eliminated the target.")
                common.dialogue.print(common)
            end
        end
    elseif (common.controllers.screen.active == common.controllers.screen.eScreen.ending) then
        if (common.controllers.controls.baton:pressed("interact")) then
            love.event.quit("restart")
            return
        elseif (common.controllers.controls.baton:pressed("thought")) then
            love.event.quit()
            return
        end
    end
end

function love.draw()
    maid64.start(common)

    love.graphics.setFont(common.config.config.fonts.main)
    if (common.controllers.screen.active == common.controllers.screen.eScreen.title) then
        common.ui.drawTitle(common)
    elseif (common.controllers.screen.active == common.controllers.screen.eScreen.game) then
        common.ui.drawHealth(common, 8, 8, common.player.health)
        common.ui.drawMana(common, 8, maid64.sizeY - 8 - 8 * 12, common.player.mana)
        common.ui.drawNpcs(common, common.player.curRoom)
        common.ui.drawControls(common)
        common.ui.drawRoomName(common)
        common.ui.drawDialogue(common)
        if (common.controllers.animation.delta < 1) then
            common.controllers.animation.drawIcon(common, common.powers.lastActive)
        elseif (common.player.inMenu) then
            common.ui.drawMap(common, common.player.curRoom, common.player.selRoom)
        elseif (common.powers.isActive and common.powers.current == common.powers.powers.blink and common.controllers.controls.isHeld == false) then
            common.controllers.powers.blinkUi(common, common.player.selRoom)
        end
    elseif (common.controllers.screen.active == common.controllers.screen.eScreen.ending) then
        common.ui.drawEnding(common)
    end

    maid64.finish()
end

function love.resize(w, h)
    local newX, newY =
        math.floor(w / common.config.config.dimModes[common.config.config.dim][1]) *
        common.config.config.dimModes[common.config.config.dim][1],
        math.floor(h / common.config.config.dimModes[common.config.config.dim][2]) *
        common.config.config.dimModes[common.config.config.dim][2]
    maid64.resize(newX, newY, w, h)
end
