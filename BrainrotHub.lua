--[[
    BRAINROT HUB - PLAYER FLY TO BRAINROT (UNDERGROUND)
    - Player terbang gradual ke brainrot target
    - Di bawah jalur tsunami (kedalaman 5-10 stud)
    - Otomatis collect pas nyampe
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================================================
-- KONFIGURASI
-- ==================================================
getgenv().C = {
    -- Bring system
    BringEnabled = false,
    UndergroundDepth = 8,
    FlySpeed = 25,           -- Kecepatan player terbang
    CollectDistance = 5,      -- Jarak collect otomatis
    
    -- Rarity switches
    Common = true,
    Uncommon = true,
    Rare = true,
    Epic = true,
    Legendary = true,
    Mythical = true,
    Cosmic = true,
    Secret = true,
    Celestial = true,
    Divine = true,
    
    -- Money collect
    AutoCollectMoney = false,
    
    -- Other features
    God = false,
    Wall = false,
    VIP = false,
    ReduceLag = false,
    
    -- Events
    Event = {m=false, a=false, c=false, u=false, r=false}
}

-- ==================================================
-- ANTI AFK
-- ==================================================
spawn(function() while wait(60) do 
    pcall(function() 
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:Move(Vector3.new(0,0,0), true)
        end
    end)
end end)

-- ==================================================
-- FUNGSI DETEKSI JALUR TSUNAMI
-- ==================================================
local function getTsunamiLevel()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("water") or obj.Name:lower():find("tsunami") or obj.Name:lower():find("wave")) then
            return obj.Position.Y
        end
    end
    return 20
end

-- ==================================================
-- FUNGSI TERBANG GRADUAL KE TARGET
-- ==================================================
local function flyToTarget(targetPos)
    local player = game.Players.LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local currentPos = hrp.Position
    local distance = (targetPos - currentPos).Magnitude
    
    -- Kalo udah deket, berhenti
    if distance < getgenv().C.CollectDistance then
        return true
    end
    
    -- Hitung arah dan langkah gerak
    local direction = (targetPos - currentPos).Unit
    local moveVector = direction * math.min(getgenv().C.FlySpeed, distance)
    
    -- Pindahkan player gradual
    hrp.CFrame = hrp.CFrame + moveVector
    return false
end

-- ==================================================
-- MAIN BRING LOOP (PLAYER TERBANG KE BRAINROT)
-- ==================================================
local function bringBrainrot()
    spawn(function()
        while task.wait(0.1) do
            if getgenv().C.BringEnabled then
                pcall(function()
                    local player = game.Players.LocalPlayer
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    
                    local tsunamiLevel = getTsunamiLevel()
                    local undergroundY = tsunamiLevel - getgenv().C.UndergroundDepth
                    
                    -- Cari brainrot terdekat yang sesuai rarity
                    local closestTarget = nil
                    local closestDist = math.huge
                    
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
                            local n = obj.Name:lower()
                            local isTarget = false
                            
                            -- Cek rarity
                            if getgenv().C.Common and n:find("common") then isTarget = true end
                            if getgenv().C.Uncommon and n:find("uncommon") then isTarget = true end
                            if getgenv().C.Rare and n:find("rare") then isTarget = true end
                            if getgenv().C.Epic and n:find("epic") then isTarget = true end
                            if getgenv().C.Legendary and (n:find("legend") or n:find("leg")) then isTarget = true end
                            if getgenv().C.Mythical and (n:find("mythical") or n:find("myth")) then isTarget = true end
                            if getgenv().C.Cosmic and (n:find("cosmic") or n:find("cosmo")) then isTarget = true end
                            if getgenv().C.Secret and (n:find("secret") or n:find("hidden")) then isTarget = true end
                            if getgenv().C.Celestial and (n:find("celestial") or n:find("celest")) then isTarget = true end
                            if getgenv().C.Divine and (n:find("divine") or n:find("div")) then isTarget = true end
                            
                            if isTarget then
                                local dist = (obj.Position - player.Character.HumanoidRootPart.Position).Magnitude
                                if dist < closestDist then
                                    closestDist = dist
                                    closestTarget = obj
                                end
                            end
                        end
                    end
                    
                    -- Kalo ada target, terbang ke dia (di kedalaman tsunami)
                    if closestTarget then
                        local targetPos = Vector3.new(closestTarget.Position.X, undergroundY, closestTarget.Position.Z)
                        local arrived = flyToTarget(targetPos)
                        
                        -- Kalo udah nyampe, collect otomatis (simulasi touch)
                        if arrived then
                            if closestTarget:FindFirstChild("TouchInterest") then
                                local hrp = player.Character.HumanoidRootPart
                                firetouchinterest(hrp, closestTarget, 0)
                                task.wait(0.05)
                                firetouchinterest(hrp, closestTarget, 1)
                            end
                            
                            -- Notifikasi kecil
                            Rayfield:Notify({
                                Title = "Collected!",
                                Content = closestTarget.Name,
                                Duration = 1
                            })
                            
                            task.wait(0.3)  -- Cooldown setelah collect
                        end
                    end
                end)
            end
        end
    end)
end

-- Jalankan bring system
bringBrainrot()

-- ==================================================
-- AUTO COLLECT MONEY DARI BASE
-- ==================================================
spawn(function()
    while task.wait(1) do
        if getgenv().C.AutoCollectMoney then
            pcall(function()
                local player = game.Players.LocalPlayer
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                
                local hrp = player.Character.HumanoidRootPart
                
                for _, moneyObj in pairs(workspace:GetDescendants()) do
                    if moneyObj:IsA("BasePart") and (moneyObj.Name:lower():find("money") or 
                                                     moneyObj.Name:lower():find("collect") or 
                                                     moneyObj.Name:lower():find("mat")) then
                        
                        local dist = (moneyObj.Position - hrp.Position).Magnitude
                        if dist < 20 then
                            if moneyObj:FindFirstChild("TouchInterest") then
                                firetouchinterest(hrp, moneyObj, 0)
                                task.wait(0.05)
                                firetouchinterest(hrp, moneyObj, 1)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ==================================================
-- REMOVE WALL / VIP
-- ==================================================
spawn(function()
    while task.wait(1) do
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name then
                    local n = obj.Name:lower()
                    
                    if getgenv().C.Wall and (n:find("wall") or n:find("dinding") or n:find("tembok")) and not n:find("vip") then
                        obj.CanCollide = false
                        obj.Transparency = 1
                        obj.Material = Enum.Material.Air
                    end
                    
                    if getgenv().C.VIP and (n:find("vip") or n:find("v.i.p") or n:find("barrier") or n:find("pagar")) then
                        obj.CanCollide = false
                        obj.Transparency = 1
                        obj.Material = Enum.Material.Air
                    end
                end
            end
        end)
    end
end)

-- ==================================================
-- CREATE WINDOW
-- ==================================================
local Window = Rayfield:CreateWindow({
    Name = "🧠 BRAINROT HUB • PLAYER FLY",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Player terbang ke brainrot (underground)",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
})

-- ==================================================
-- NOTIFIKASI AWAL
-- ==================================================
Rayfield:Notify({
    Title = "Brainrot Hub Loaded!",
    Content = "Player terbang ke brainrot (bawah jalur tsunami)",
    Duration = 4
})

-- ==================================================
-- HOME TAB
-- ==================================================
local HomeTab = Window:CreateTab("🏠 HOME", 4483362458)
local HomeSection = HomeTab:CreateSection("Community")

HomeTab:CreateButton({
    Name = "📱 JOIN DISCORD",
    Callback = function()
        setclipboard("https://discord.gg/brainrothub")
        Rayfield:Notify({Title = "Discord Link Copied!", Duration = 2})
    end,
})

HomeTab:CreateButton({
    Name = "▶️ SUBSCRIBE YOUTUBE",
    Callback = function()
        setclipboard("https://youtube.com/@brainrothub")
        Rayfield:Notify({Title = "YouTube Link Copied!", Duration = 2})
    end,
})

-- ==================================================
-- MAIN TAB
-- ==================================================
local MainTab = Window:CreateTab("📋 MAIN", 4483362458)
local MainSection = MainTab:CreateSection("Player Fly System")

MainTab:CreateToggle({
    Name = "🚀 AKTIFKAN FLY TO BRAINROT",
    CurrentValue = false,
    Flag = "BringToggle",
    Callback = function(Value)
        getgenv().C.BringEnabled = Value
        Rayfield:Notify({
            Title = Value and "Fly ON" or "Fly OFF",
            Content = Value and "Player terbang ke brainrot (bawah jalur tsunami)" or "Dinonaktifkan",
            Duration = 2
        })
    end,
})

MainTab:CreateSlider({
    Name = "📏 Kedalaman (dari jalur tsunami)",
    Range = {3, 15},
    Increment = 1,
    Suffix = "stud",
    CurrentValue = 8,
    Flag = "DepthSlider",
    Callback = function(v) getgenv().C.UndergroundDepth = v end,
})

MainTab:CreateSlider({
    Name = "⚡ Kecepatan Terbang",
    Range = {10, 50},
    Increment = 5,
    Suffix = "stud/detik",
    CurrentValue = 25,
    Flag = "SpeedSlider",
    Callback = function(v) getgenv().C.FlySpeed = v end,
})

MainTab:CreateSlider({
    Name = "📐 Jarak Collect",
    Range = {3, 10},
    Increment = 1,
    Suffix = "stud",
    CurrentValue = 5,
    Flag = "CollectDist",
    Callback = function(v) getgenv().C.CollectDistance = v end,
})

-- Money collect toggle
MainTab:CreateToggle({
    Name = "💰 Auto Collect Money (Base)",
    CurrentValue = false,
    Flag = "MoneyToggle",
    Callback = function(v) getgenv().C.AutoCollectMoney = v end
})

-- ==================================================
-- RARITY SWITCHES
-- ==================================================
local RaritySection = MainTab:CreateSection("✨ RARITY SWITCHES")

MainTab:CreateToggle({Name = "Common", CurrentValue = true, Flag = "Common", Callback = function(v) getgenv().C.Common = v end})
MainTab:CreateToggle({Name = "Uncommon", CurrentValue = true, Flag = "Uncommon", Callback = function(v) getgenv().C.Uncommon = v end})
MainTab:CreateToggle({Name = "Rare", CurrentValue = true, Flag = "Rare", Callback = function(v) getgenv().C.Rare = v end})
MainTab:CreateToggle({Name = "Epic", CurrentValue = true, Flag = "Epic", Callback = function(v) getgenv().C.Epic = v end})
MainTab:CreateToggle({Name = "Legendary", CurrentValue = true, Flag = "Legendary", Callback = function(v) getgenv().C.Legendary = v end})
MainTab:CreateToggle({Name = "Mythical", CurrentValue = true, Flag = "Mythical", Callback = function(v) getgenv().C.Mythical = v end})
MainTab:CreateToggle({Name = "Cosmic", CurrentValue = true, Flag = "Cosmic", Callback = function(v) getgenv().C.Cosmic = v end})
MainTab:CreateToggle({Name = "Secret", CurrentValue = true, Flag = "Secret", Callback = function(v) getgenv().C.Secret = v end})
MainTab:CreateToggle({Name = "Celestial", CurrentValue = true, Flag = "Celestial", Callback = function(v) getgenv().C.Celestial = v end})
MainTab:CreateToggle({Name = "Divine", CurrentValue = true, Flag = "Divine", Callback = function(v) getgenv().C.Divine = v end})

-- ==================================================
-- AUTO TAB (EVENT TOKENS)
-- ==================================================
local AutoTab = Window:CreateTab("🤖 AUTO", 4483362458)
local AutoSection = AutoTab:CreateSection("Event Token Collector")

AutoTab:CreateToggle({Name = "💰 Money Event", CurrentValue = false, Flag = "EventMoney", Callback = function(v) getgenv().C.Event.m = v end})
AutoTab:CreateToggle({Name = "🎮 Arcade Event", CurrentValue = false, Flag = "EventArcade", Callback = function(v) getgenv().C.Event.a = v end})
AutoTab:CreateToggle({Name = "🍬 Candy Event", CurrentValue = false, Flag = "EventCandy", Callback = function(v) getgenv().C.Event.c = v end})
AutoTab:CreateToggle({Name = "👽 UFO Event", CurrentValue = false, Flag = "EventUFO", Callback = function(v) getgenv().C.Event.u = v end})
AutoTab:CreateToggle({Name = "☢️ Radioactive", CurrentValue = false, Flag = "EventRadio", Callback = function(v) getgenv().C.Event.r = v end})

-- ==================================================
-- MISC TAB
-- ==================================================
local MiscTab = Window:CreateTab("🛠️ MISC", 4483362458)
local MiscSection = MiscTab:CreateSection("World Bypass")

MiscTab:CreateToggle({Name = "🧱 Remove Walls", CurrentValue = false, Flag = "RemoveWall", Callback = function(v) getgenv().C.Wall = v end})
MiscTab:CreateToggle({Name = "💎 Remove VIP Barriers", CurrentValue = false, Flag = "RemoveVIP", Callback = function(v) getgenv().C.VIP = v end})
MiscTab:CreateToggle({Name = "🛡️ God Mode (2-3 wave)", CurrentValue = false, Flag = "GodMode", Callback = function(v) getgenv().C.God = v end})

-- ==================================================
-- PERF TAB
-- ==================================================
local PerfTab = Window:CreateTab("⚡ PERF", 4483362458)
local PerfSection = PerfTab:CreateSection("Performance")

PerfTab:CreateToggle({Name = "Reduce Lag", CurrentValue = false, Flag = "ReduceLag", Callback = function(v) getgenv().C.ReduceLag = v end})

-- ==================================================
-- SERVER TAB
-- ==================================================
local ServerTab = Window:CreateTab("🌐 SERVER", 4483362458)
local ServerSection = ServerTab:CreateSection("Server Settings")

ServerTab:CreateParagraph({Title = "🛡️ Anti AFK", Content = "Status: SELALU ON (otomatis)"})

-- ==================================================
-- REDUCE LAG FUNCTION
-- ==================================================
spawn(function() 
    while task.wait(3) do 
        if getgenv().C.ReduceLag then 
            pcall(function()
                settings().Rendering.QualityLevel = 1
                game:GetService("Lighting").GlobalShadows = false
                for _, o in pairs(workspace:GetDescendants()) do
                    if o:IsA("ParticleEmitter") or o:IsA("Smoke") or o:IsA("Fire") then 
                        o.Enabled = false 
                    end
                end
            end)
        end
    end
end)

-- ==================================================
-- LOAD CONFIG
-- ==================================================
Rayfield:LoadConfiguration()

print("✅ BRAINROT HUB - PLAYER FLY TO BRAINROT LOADED")
print("🚀 Player terbang gradual ke brainrot (bawah jalur tsunami)")
