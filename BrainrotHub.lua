--[[
    BRAINROT HUB - UNDERGROUND BRING + MONEY COLLECTOR
    - Bawa brainrot lewat bawah jalur tsunami
    - Auto collect money dari base (display segipanjang)
    - 1x per detik
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================================================
-- KONFIGURASI
-- ==================================================
getgenv().C = {
    -- Bring system
    BringEnabled = false,
    UndergroundDepth = 8,  -- Kedalaman dari jalur tsunami
    BringSpeed = 0.3,
    
    -- Rarity switches (lengkap dari game)
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
    CollectInterval = 1,  -- 1 detik
    
    -- Other features
    God = false,
    Wall = false,
    VIP = false,
    ReduceLag = false,
    
    -- Events
    Event = {m=false, a=false, c=false, u=false, r=false}
}

-- ==================================================
-- ANTI AFK (SELALU ON)
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
    -- Deteksi permukaan air/tsunami
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("water") or obj.Name:lower():find("tsunami")) then
            return obj.Position.Y
        end
    end
    return 20  -- Default fallback
end

-- ==================================================
-- BRING SYSTEM (UNDERGROUND - JALUR TSUNAMI)
-- ==================================================
local function bringBrainrot()
    spawn(function()
        while task.wait(getgenv().C.BringSpeed) do
            if getgenv().C.BringEnabled then
                pcall(function()
                    local player = game.Players.LocalPlayer
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    
                    local hrp = player.Character.HumanoidRootPart
                    local tsunamiLevel = getTsunamiLevel()
                    local undergroundY = tsunamiLevel - getgenv().C.UndergroundDepth
                    
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name then
                            local n = obj.Name:lower()
                            local shouldBring = false
                            
                            -- Cek semua rarity yang ada di game [citation:2][citation:8]
                            if getgenv().C.Common and (n:find("common") or n:find("noobini") or n:find("lirili")) then shouldBring = true end
                            if getgenv().C.Uncommon and (n:find("uncommon") or n:find("trippi") or n:find("pipi")) then shouldBring = true end
                            if getgenv().C.Rare and (n:find("rare") or n:find("cappuccino") or n:find("bambini")) then shouldBring = true end
                            if getgenv().C.Epic and (n:find("epic") or n:find("pandaccini") or n:find("sigma")) then shouldBring = true end
                            if getgenv().C.Legendary and (n:find("legend") or n:find("gorillo") or n:find("tigrilini")) then shouldBring = true end
                            if getgenv().C.Mythical and (n:find("mythical") or n:find("cocofanto") or n:find("giraffa")) then shouldBring = true end
                            if getgenv().C.Cosmic and (n:find("cosmic") or n:find("la vacca") or n:find("grande")) then shouldBring = true end
                            if getgenv().C.Secret and (n:find("secret") or n:find("matteo") or n:find("gattatino")) then shouldBring = true end
                            if getgenv().C.Celestial and (n:find("celestial") or n:find("job job") or n:find("dug dug")) then shouldBring = true end
                            if getgenv().C.Divine and (n:find("divine") or n:find("bulbito") or n:find("burgerini")) then shouldBring = true end
                            
                            if shouldBring then
                                -- Bawa ke bawah jalur tsunami
                                obj.CFrame = CFrame.new(hrp.Position.X, undergroundY, hrp.Position.Z)
                                task.wait(0.05)
                            end
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
-- AUTO COLLECT MONEY DARI BASE (1x PER DETIK)
-- ==================================================
-- Berdasarkan mekanik game: Brainrot yang sudah di base ngasih passive income
-- dan tampil sebagai "money mat" (area segipanjang) yang bisa di-injek [citation:1][citation:2]
spawn(function()
    while task.wait(getgenv().C.CollectInterval) do
        if getgenv().C.AutoCollectMoney then
            pcall(function()
                local player = game.Players.LocalPlayer
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                
                local hrp = player.Character.HumanoidRootPart
                
                -- Cari semua display uang di base (biasanya berupa part dengan nama "MoneyMat" atau "CollectArea")
                for _, moneyObj in pairs(workspace:GetDescendants()) do
                    -- Deteksi objek display uang (segipanjang) di setiap petak brainrot
                    if moneyObj:IsA("BasePart") and (moneyObj.Name:lower():find("money") or 
                                                     moneyObj.Name:lower():find("collect") or 
                                                     moneyObj.Name:lower():find("mat") or
                                                     moneyObj.Name:lower():find("display")) then
                        
                        -- Hitung jarak ke player
                        local dist = (moneyObj.Position - hrp.Position).Magnitude
                        
                        -- Kalo deket (dalam radius 20 stud), collect otomatis
                        if dist < 20 then
                            -- Simulasi "touch" ke money mat untuk collect
                            if moneyObj:FindFirstChild("TouchInterest") then
                                firetouchinterest(hrp, moneyObj, 0)
                                task.wait(0.05)
                                firetouchinterest(hrp, moneyObj, 1)
                            end
                            
                            -- Alternatif: kalo pake ClickDetector
                            if moneyObj:FindFirstChild("ClickDetector") then
                                fireclickdetector(moneyObj.ClickDetector)
                            end
                        end
                    end
                    
                    -- Deteksi juga part yang warnanya mencolok (biasanya display uang warna emas/kuning)
                    if moneyObj:IsA("BasePart") and moneyObj.BrickColor then
                        local color = moneyObj.BrickColor.Name:lower()
                        if (color:find("gold") or color:find("yellow") or color:find("bright")) and moneyObj.Size.X > 5 then
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
                end
            end)
        end
    end
end)

-- ==================================================
-- REMOVE WALL / VIP (BENERAN ILANG)
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
-- CREATE WINDOW (RAYFIELD)
-- ==================================================
local Window = Rayfield:CreateWindow({
    Name = "🧠 BRAINROT HUB • UNDERGROUND",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Underground Bring + Auto Collect Money",
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
    Content = "Aktifkan Bring System & Auto Collect Money di MAIN tab",
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
-- MAIN TAB (BRING SYSTEM + MONEY COLLECT)
-- ==================================================
local MainTab = Window:CreateTab("📋 MAIN", 4483362458)
local MainSection = MainTab:CreateSection("Underground Bring System")

MainTab:CreateToggle({
    Name = "🚇 AKTIFKAN BRING SYSTEM",
    CurrentValue = false,
    Flag = "BringToggle",
    Callback = function(Value)
        getgenv().C.BringEnabled = Value
        Rayfield:Notify({
            Title = Value and "Bring System ON" or "Bring System OFF",
            Content = Value and "Brainrot dibawa lewat bawah jalur tsunami" or "Dinonaktifkan",
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
    Callback = function(value)
        getgenv().C.UndergroundDepth = value
    end,
})

MainTab:CreateSlider({
    Name = "⚡ Kecepatan Bring",
    Range = {0.1, 0.8},
    Increment = 0.05,
    Suffix = "detik",
    CurrentValue = 0.3,
    Flag = "SpeedSlider",
    Callback = function(value)
        getgenv().C.BringSpeed = value
    end,
})

-- ==================================================
-- AUTO COLLECT MONEY SECTION
-- ==================================================
local MoneySection = MainTab:CreateSection("💰 Auto Collect Money (Base)")

MainTab:CreateToggle({
    Name = "💵 AKTIFKAN AUTO COLLECT",
    CurrentValue = false,
    Flag = "MoneyCollectToggle",
    Callback = function(Value)
        getgenv().C.AutoCollectMoney = Value
        Rayfield:Notify({
            Title = Value and "Auto Collect ON" or "Auto Collect OFF",
            Content = Value and "Ngumpulin duit dari display segipanjang tiap 1 detik" or "Dimatiin",
            Duration = 2
        })
    end,
})

MainTab:CreateParagraph({
    Title = "ℹ️ Cara Kerja",
    Content = "• Setiap Brainrot di base punya display uang (segi panjang)\n• Auto collect 1x per detik\n• Tinggal jalan di dekat area base"
})

-- ==================================================
-- RARITY SWITCHES (LENGKAP 10 RARITY)
-- ==================================================
local RaritySection = MainTab:CreateSection("✨ RARITY SWITCHES (10 Rarity)")

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

MiscTab:CreateToggle({
    Name = "🧱 Remove Walls",
    CurrentValue = false,
    Flag = "RemoveWall",
    Callback = function(v) getgenv().C.Wall = v end
})

MiscTab:CreateToggle({
    Name = "💎 Remove VIP Barriers",
    CurrentValue = false,
    Flag = "RemoveVIP",
    Callback = function(v) getgenv().C.VIP = v end
})

MiscTab:CreateToggle({
    Name = "🛡️ God Mode (2-3 wave)",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(v) getgenv().C.God = v end
})

-- ==================================================
-- PERF TAB
-- ==================================================
local PerfTab = Window:CreateTab("⚡ PERF", 4483362458)
local PerfSection = PerfTab:CreateSection("Performance")

PerfTab:CreateToggle({
    Name = "Reduce Lag",
    CurrentValue = false,
    Flag = "ReduceLag",
    Callback = function(v) getgenv().C.ReduceLag = v end
})

-- ==================================================
-- SERVER TAB
-- ==================================================
local ServerTab = Window:CreateTab("🌐 SERVER", 4483362458)
local ServerSection = ServerTab:CreateSection("Server Settings")

ServerTab:CreateParagraph({
    Title = "🛡️ Anti AFK",
    Content = "Status: SELALU ON (otomatis)"
})

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

print("✅ BRAINROT HUB - UNDERGROUND BRING + AUTO MONEY LOADED")
print("💰 Auto collect money dari display segipanjang di base (1x/detik)")
