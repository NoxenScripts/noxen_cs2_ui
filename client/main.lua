CS2_UI = {}
CS2_UI.IsActive = false
CS2_UI.CurrentTeam = 2 -- 1 = Terrorist, 2 = Anti-Terrorist
CS2_UI.TeamsColors = {
    [1] = {250, 224, 174},
    [2] = {160, 217, 255},
}

CS2_UI.TopScoresTeam1 = 0
CS2_UI.TopScoresTeam2 = 0
CS2_UI.TopScoresTime = "1:39"

CS2_UI.ShouldPlayKillAnimation = false
CS2_UI.KillAnimationCache = {
    progress = 1,
    alpha = 0,
}

CS2_UI.Kills = 0

function CS2_UI.Toggle()
    if CS2_UI.IsActive then
        CS2_UI.IsActive = false
    end

    CS2_UI.IsActive = true
    Citizen.CreateThread(function()
        while CS2_UI.IsActive do
            CS2_UI.Draw()
            Wait(1)
        end
    end)
end

function CS2_UI.Draw()
    local pPed = PlayerPedId()
    local pArmor = tostring(GetPedArmour(pPed))
    local pHealth = GetEntityHealth(pPed)
    local pMaxHealth = GetEntityMaxHealth(pPed)
    local pHealthPercent = math.floor((pHealth / pMaxHealth) * 100)
    local DoesPedHasWeaponInHand, weaponHash = GetCurrentPedWeapon(pPed)
    local gotAmmo, ammoInClip = GetAmmoInClip(pPed, weaponHash)
    local totalAmmo = GetAmmoInPedWeapon(pPed, weaponHash) - ammoInClip
    local teamTag = "_t"
    if CS2_UI.CurrentTeam == 2 then
        teamTag = "_ct"
    end

    if CS2_UI.ShouldPlayKillAnimation then
        local x, y = UI.ConvertToPixel(419, 63)
        UI.DrawSpriteSimple("noxen_ui_cs2", "kill_glow", 0.5, 0.90, x, y, 0.0, CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], CS2_UI.KillAnimationCache.alpha, {centerDraw = true}, function() end)

        if CS2_UI.KillAnimationCache.progress == 1 then
            CS2_UI.KillAnimationCache.alpha = CS2_UI.KillAnimationCache.alpha + 5
            if CS2_UI.KillAnimationCache.alpha >= 255 then
                CS2_UI.KillAnimationCache.progress = 2
            end
        end

        if CS2_UI.KillAnimationCache.progress == 2 then
            CS2_UI.KillAnimationCache.alpha = CS2_UI.KillAnimationCache.alpha - 5
            if CS2_UI.KillAnimationCache.alpha <= 0 then
                CS2_UI.ShouldPlayKillAnimation = false
            end
        end
    end

    if CS2_UI.Kills > 0 then
        local x, y = UI.ConvertToPixel(33, 44)
        UI.DrawSpriteSimple("noxen_ui_cs2", "kill_card_count", 0.498, 0.887, x, y, 0.0, CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255, {centerDraw = true}, function() end)
        UI.DrawTexts(0.498, 0.878, CS2_UI.Kills, true, 0.30, {CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255}, 2, false, false, false, false)
    end

    local x, y = UI.ConvertToPixel(419, 63)
    UI.DrawSpriteSimple("noxen_ui_cs2", "middle_part"..teamTag, 0.5, 0.93, x, y, 0.0, 255, 255, 255, 255, {centerDraw = true}, function() end)

    local x, y = UI.ConvertToPixel(36, 45)
    UI.DrawSpriteSimple("noxen_ui_cs2", "kevlar"..teamTag, 0.33, 0.93, x, y, 0.0, 255, 255, 255, 255, {centerDraw = true}, function() end)

    UI.DrawTexts(0.33, 0.917, pArmor, true, 0.40, {CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255}, 6, false, false, false, false)

    local healthPositionX = 0.36
    local healthPositionY = 0.910
    local healthX, healthY = UI.ConvertToPixel(50, 7)
    UI.DrawTexts(healthPositionX, healthPositionY - 0.005, pHealthPercent, true, 0.80, {CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255}, 2, false, false, false, false)
    UI.DrawSlider(healthPositionX - 0.0125, healthPositionY + 0.04, healthX, healthY, {150, 150, 150, 150}, {CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255}, pHealthPercent, 100, {}, function() end)

    if DoesPedHasWeaponInHand ~= false then
        local ammoPositionX = 0.63
        local ammoPositionY = 0.910
        UI.DrawTexts(ammoPositionX, ammoPositionY - 0.005, tostring(ammoInClip), true, 0.80, {CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255}, 2, false, false, false, false)
        UI.DrawTexts(ammoPositionX + 0.025, ammoPositionY + 0.005, tostring(totalAmmo), true, 0.50, {CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255}, 6, false, false, false, false)

        local x, y = UI.ConvertToPixel(35, 35)
        UI.DrawSpriteSimple("noxen_ui_cs2", "ammo_icon", ammoPositionX + 0.045, ammoPositionY + 0.0215, x, y, 0.0, CS2_UI.TeamsColors[CS2_UI.CurrentTeam][1], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][2], CS2_UI.TeamsColors[CS2_UI.CurrentTeam][3], 255, {centerDraw = true}, function() end)
    end


    if Config.DisplayTopScore then
        local x, y = UI.ConvertToPixel(82, 116)
        UI.DrawSpriteSimple("noxen_ui_cs2", "top_scores", 0.5, 0.07, x, y, 0.0, 255, 255, 255, 255, {centerDraw = true}, function() end)

        UI.DrawTexts(0.48867186903954, 0.050694447010756, tostring(CS2_UI.TopScoresTeam1), true, 0.60, {CS2_UI.TeamsColors[1][1], CS2_UI.TeamsColors[1][2], CS2_UI.TeamsColors[1][3], 255}, 2, false, false, true, false)
        UI.DrawTexts(0.51093751192093, 0.050694447010756, tostring(CS2_UI.TopScoresTeam2), true, 0.60, {CS2_UI.TeamsColors[2][1], CS2_UI.TeamsColors[2][2], CS2_UI.TeamsColors[2][3], 255}, 2, false, false, true, false)

        UI.DrawTexts(0.49921876192093, 0.012500000186265, tostring(CS2_UI.TopScoresTime), true, 0.60, {255, 255, 255, 255}, 6, false, false, true, false)
    end
end

function CS2_UI.PlayKillAnimation()
    CS2_UI.KillAnimationCache = {
        progress = 1,
        alpha = 0,
    }
    CS2_UI.ShouldPlayKillAnimation = true
    CS2_UI.Kills = CS2_UI.Kills + 1
end

Citizen.CreateThread(function()
    while UI == nil do
        Citizen.Wait(0)
    end
    CS2_UI.Toggle()
end)

if Config.UseInternalKillDetection then
    AddEventHandler('gameEventTriggered', function(eventName, data)
        if eventName == "CEventNetworkEntityDamage" then
            local victim = data[1]
            local attacker = data[2]
            local isFatal = data[3]

            if victim and attacker then
                if isFatal then
                    local pPed = PlayerPedId()
                    if pPed == attacker then
                        if IsPedDeadOrDying(victim, true) then
                            CS2_UI.PlayKillAnimation()
                        end
                    end
                end
            end
        end
    end)
end



-- TESTS
if Config.EnableTestsCommands then
    RegisterCommand("changeteam", function()
        if CS2_UI.CurrentTeam == 1 then
            CS2_UI.CurrentTeam = 2
        else
            CS2_UI.CurrentTeam = 1
        end
    end, false)

    RegisterCommand("addkill", function()
        CS2_UI.PlayKillAnimation()
    end, false)

    RegisterCommand("addscore", function()
        CS2_UI.TopScoresTeam1 = CS2_UI.TopScoresTeam1 + 1
        CS2_UI.TopScoresTeam2 = CS2_UI.TopScoresTeam2 + 1
    end, false)

    RegisterCommand("changearmor", function()
        local pPed = PlayerPedId()
        SetPedArmour(pPed, math.random(0, 100))
    end, false)

    RegisterCommand("changehealth", function()
        local pPed = PlayerPedId()
        SetEntityHealth(pPed, math.random(101, 200))
    end, false)
end