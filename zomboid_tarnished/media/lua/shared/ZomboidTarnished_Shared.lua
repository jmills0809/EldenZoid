ZomboidTarnished = ZomboidTarnished or {}
ZomboidTarnished.VERSION = "0.1.0"
ZomboidTarnished.MAX_STAMINA = 100
ZomboidTarnished.ATTACK_COST = 8
ZomboidTarnished.ROLL_COST = 25
ZomboidTarnished.RUNE_BASE = 10

function ZomboidTarnished.getData(player)
    local data = player:getModData()
    if data.ZomboidTarnished == nil then
        data.ZomboidTarnished = {
            runes = 0,
            stamina = ZomboidTarnished.MAX_STAMINA,
            poise = 0,
            lastHitAt = 0,
            rollUntil = 0,
            safehouseRested = false,
        }
    end
    return data.ZomboidTarnished
end

function ZomboidTarnished.clamp(v, lo, hi)
    if v < lo then return lo end
    if v > hi then return hi end
    return v
end
