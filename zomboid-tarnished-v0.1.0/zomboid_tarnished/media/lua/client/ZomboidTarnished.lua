require "ZomboidTarnished_Shared"

local function now()
    return getTimestampMs()
end

local function playerData(player)
    return ZomboidTarnished.getData(player)
end

local function spendStamina(player, amount)
    local d = playerData(player)
    d.stamina = ZomboidTarnished.clamp(d.stamina - amount, 0, ZomboidTarnished.MAX_STAMINA)
    return d.stamina >= 0
end

local function regenStamina(player, amount)
    local d = playerData(player)
    d.stamina = ZomboidTarnished.clamp(d.stamina + amount, 0, ZomboidTarnished.MAX_STAMINA)
end

local function onPlayerUpdate(player)
    local d = playerData(player)
    local t = now()

    if d.rollUntil and t < d.rollUntil then
        -- Prototype dodge window: combat systems can treat this state as an i-frame.
        player:setInvulnerable(true)
    elseif d.rollUntil and t >= d.rollUntil then
        d.rollUntil = 0
        player:setInvulnerable(false)
    end

    if not player:isMoving() and (not d.lastHitAt or t - d.lastHitAt > 500) then
        regenStamina(player, 1.5)
    else
        regenStamina(player, 0.35)
    end
end

local function onKeyPressed(key)
    local player = getSpecificPlayer(0)
    if not player then return end
    local d = playerData(player)

    -- Space = prototype dodge roll.
    -- The movement animation is intentionally left to the host game; this state is
    -- consumed by the combat layer and keeps the first build dependency-light.
    if key == Keyboard.KEY_SPACE and d.stamina >= ZomboidTarnished.ROLL_COST then
        spendStamina(player, ZomboidTarnished.ROLL_COST)
        d.rollUntil = now() + 450
        d.lastHitAt = now()
    end
end

local function onWeaponSwing(player, weapon)
    if not player or not weapon then return end
    local d = playerData(player)
    if d.stamina < ZomboidTarnished.ATTACK_COST then
        return
    end
    spendStamina(player, ZomboidTarnished.ATTACK_COST)
    d.lastHitAt = now()
end

local function onZombieDead(zombie)
    local player = getSpecificPlayer(0)
    if not player or not zombie then return end
    local d = playerData(player)

    local reward = ZomboidTarnished.RUNE_BASE
    local health = zombie:getHealth() or 1
    reward = reward + math.floor(health * 2)
    d.runes = d.runes + reward
end

local function onGameStart()
    local player = getSpecificPlayer(0)
    if player then
        local d = playerData(player)
        if d.stamina == nil then d.stamina = ZomboidTarnished.MAX_STAMINA end
        if d.runes == nil then d.runes = 0 end
    end
end

Events.OnGameStart.Add(onGameStart)
Events.OnPlayerUpdate.Add(onPlayerUpdate)
Events.OnKeyPressed.Add(onKeyPressed)
Events.OnWeaponSwing.Add(onWeaponSwing)
Events.OnZombieDead.Add(onZombieDead)
