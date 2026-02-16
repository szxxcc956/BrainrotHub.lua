--[[
    BRAINROT HUB - SMOOTH TWEEN FLY
    - Terbang ke atas (200 stud)
    - Ambil brainrot
    - Balik ke base
    - FLY MULUS pake TweenService (ga spam jump)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local TweenService = game:GetService("TweenService")

-- ==================================================
-- KONFIGURASI
-- ==================================================
getgenv().C = {
    -- Bring system
    BringEnabled = false,
    FlyHeight = 200,          -- Terbang ke atas 200 stud
    FlySpeed = 2,             -- Durasi tween (detik)
    
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
-- FUNGSI FLY MULUS PAKE TWEEN
-- ==================================================
local function smoothFly(targetPos, duration)
    local player = game.Players.LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = player.Character.HumanoidRootPart
    local startPos = hrp.Position
    
    -- Tween info (pake easing biar mulus)
    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Quad,  -- Easing biar halus
        Enum.EasingDirection.InOut,
        0,
        false,
        0
    )
    
    -- Buat tween
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
    tween:Play()
    
    -- Tunggu sampe selesai
    tween.Completed:Wait()
end

-- ==================================================
-- FUNGSI SAVE BASE POSITION
-- ==================================================
local basePosition = nil

local function saveBasePosition()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        basePosition = player.Character.HumanoidRootPart.Position
        Rayfield:Notify({
            Title = "Base Position Saved",
            Content = "Posisi base tersimpan",
            Duration = 2
        })
    end
end

-- ==================================================
-- MAIN BRING LOOP
-- ==================================================
local function bringBrainrot()
    spawn(function()
        while task.wait(0.5) do
            if getgenv().C.BringEnabled then
                pcall(function()
                    local player = game.Players.LocalPlayer
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    
                    -- Kalo base position belum disimpan, save otomatis
                    if not basePosition then
                        basePosition = player.Character.HumanoidRootPart.Position
                    end
                    
                    local hrp = player.Character.HumanoidRootPart
                    
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
                    
                    -- Kalo ada target
                    if closestTarget then
                        -- FASE 1: TERBANG KE ATAS (200 stud)
                        local upPos = Vector3.new(hrp.Position.X, getgenv().C.FlyHeight, hrp.Position.Z)
                        Rayfield:Notify({
                            Title = "Flying Up",
                            Content = "Naik ke ketinggian 200 stud",
                            Duration = 1
                        })
                        smoothFly(upPos, getgenv().C.FlySpeed)
                        
                        -- FASE 2: TERBANG KE TARGET (di ketinggian yang sama)
                        local targetPos = Vector3.new(closestTarget.Position.X, getgenv().C.FlyHeight, closestTarget.Position.Z)
                        Rayfield:Notify({
                            Title = "Flying to Brainrot",
                            Content = closestTarget.Name,
                            Duration = 1
                        })
                        smoothFly(targetPos, getgenv().C.FlySpeed)
                        
                        -- FASE 3: TURUN AMBIL BRAINROT
                        local collectPos = Vector3.new(closestTarget.Position.X, closestTarget.Position.Y + 3, closestTarget.Position.Z)
                        smoothFly(collectPos, 1)
                        
                        -- Collect brainrot (simulasi touch)
                        if closestTarget:FindFirstChild("TouchInterest") then
                            firetouchinterest(hrp, closestTarget, 0)
                            task.wait(0.1)
                            firetouchinterest(hrp, closestTarget, 1)
                        end
                        
                        Rayfield:Notify({
                            Title = "Collected!",
                            Content = closestTarget.Name,
                            Duration = 1
                        })
                        
                        -- FASE 4: BALIK KE BASE (dengan ketinggian 200 stud dulu)
                        if basePosition then
                            -- Naik lagi ke 200 stud
                            local upAgain = Vector3.new(basePosition.X, getgenv().C.FlyHeight, basePosition.Z)
                            smoothFly(upAgain, getgenv().C.FlySpeed)
                            
                            -- Turun ke base
                            smoothFly(basePosition, getgenv().C.FlySpeed)
                            
                            Rayfield:Notify({
                                Title = "Back to Base",
                                Content = "Kembali ke posisi awal",
                                Duration = 1
                            })
                        end
                        
                        task.wait(0.5)  -- Cooldown
                    end
                end)
            end
        end
    end)
end

-- Jalankan bring system
bringBrainrot()

-- ==================================================
-- AUTO COLLECT MONEY
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
    Name = "🧠 BRAINROT HUB • SMOOTH FLY",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Tween Fly (Ga Spam Jump)",
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
    Content = "Smooth Tween Fly - Ga Spam Jump",
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
local MainSection = MainTab:CreateSection("Smooth Fly System")

MainTab:CreateToggle({
    Name = "🚀 AKTIFKAN FLY SYSTEM",
    CurrentValue = false,
    Flag = "BringToggle",
    Callback = function(Value)
        getgenv().C.BringEnabled = Value
    end,
})

MainTab:CreateButton({
    Name = "📍 SAVE BASE POSITION",
    Callback = function()
        saveBasePosition()
    end,
})

MainTab:CreateSlider({
    Name = "📏 Ketinggian Fly",
    Range = {100, 500},
    Increment = 10,
    Suffix = "stud",
    CurrentValue = 200,
    Flag = "HeightSlider",
    Callback = function(v) getgenv().C.FlyHeight = v end,
})

MainTab:CreateSlider({
    Name = "⚡ Durasi Fly (detik)",
    Range = {1, 5},
    Increment = 0.5,
    Suffix = "detik",
    CurrentValue = 2,
    Flag = "SpeedSlider",
    Callback = function(v) getgenv().C.FlySpeed = v end,
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

print("✅ BRAINROT HUB - SMOOTH TWEEN FLY LOADED")
print("🚀 Fly pake Tween (ga spam jump) - Naik 200 stud, ambil, balik base")
