--[[
    BRAINROT HUB - RAYFIELD EDITION
    Fitur: Hold F untuk bring brainrot (tween fly)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================================================
-- KONFIGURASI
-- ==================================================
getgenv().C = {
    Bring = false, Money = false, God = false, Wall = false, VIP = false, ReduceLag = false,
    Event = {m=false, a=false, c=false, u=false, r=false},
    Filter = {common=true, unc=true, rare=true, epic=true, leg=true, cel=true, div=true, inf=true, luck=true},
    HoldF = false
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
-- TWEEN SERVICE BUAT FLY HALUS
-- ==================================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- ==================================================
-- FUNGSI BRING DENGAN TWEEN (HOLD F)
-- ==================================================
local function bringWithTween(obj, targetPos)
    if not obj or not obj:IsA("BasePart") then return end
    
    -- Info tween (terbang halus)
    local tweenInfo = TweenInfo.new(
        0.5,  -- Duration (0.5 detik)
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    
    -- Buat tween
    local tween = TweenService:Create(obj, tweenInfo, {CFrame = CFrame.new(targetPos)})
    tween:Play()
end

-- ==================================================
-- DETECT HOLD F
-- ==================================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        getgenv().C.HoldF = true
        
        -- Mulai loop bring selama F di-hold
        spawn(function()
            while getgenv().C.HoldF do
                pcall(function()
                    local player = game.Players.LocalPlayer
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and obj.Name then
                                local n = obj.Name:lower()
                                local bring = false
                                
                                if (getgenv().C.Filter.common and n:find("common")) or 
                                   (getgenv().C.Filter.unc and n:find("uncommon")) or
                                   (getgenv().C.Filter.rare and n:find("rare")) or 
                                   (getgenv().C.Filter.epic and n:find("epic")) or
                                   (getgenv().C.Filter.leg and (n:find("legend") or n:find("leg"))) or
                                   (getgenv().C.Filter.cel and (n:find("celestial") or n:find("celest"))) or
                                   (getgenv().C.Filter.div and (n:find("divine") or n:find("div"))) or
                                   (getgenv().C.Filter.inf and (n:find("infinity") or n:find("inf") or n:find("∞"))) or
                                   (getgenv().C.Filter.luck and (n:find("lucky") or n:find("blox") or n:find("box"))) then
                                    bring = true
                                end
                                
                                if bring then
                                    -- Posisi target (di deket player, bawah tanah)
                                    local targetPos = Vector3.new(hrp.Position.X, hrp.Position.Y - 10, hrp.Position.Z)
                                    bringWithTween(obj, targetPos)
                                    task.wait(0.1)  -- Delay biar ga overload
                                end
                            end
                        end
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F then
        getgenv().C.HoldF = false
    end
end)

-- ==================================================
-- CREATE WINDOW
-- ==================================================
local Window = Rayfield:CreateWindow({
    Name = "🧠 BRAINROT HUB • HOLLYWOOD",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Hold F to Collect",
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
    KeySettings = {
        Title = "Brainrot Hub",
        Subtitle = "Key System",
        Note = "Join Discord for key",
        FileName = "BrainrotKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"brainrot123"}
    }
})

-- ==================================================
-- NOTIFIKASI AWAL
-- ==================================================
Rayfield:Notify({
    Title = "Brainrot Hub Loaded!",
    Content = "HOLD F untuk bring brainrot (tween fly) | Tekan K untuk toggle UI",
    Duration = 4,
    Image = 4483362458,
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
        Rayfield:Notify({
            Title = "Discord Link Copied!",
            Content = "Link sudah di clipboard",
            Duration = 2
        })
    end,
})

HomeTab:CreateButton({
    Name = "▶️ SUBSCRIBE YOUTUBE",
    Callback = function()
        setclipboard("https://youtube.com/@brainrothub")
        Rayfield:Notify({
            Title = "YouTube Link Copied!",
            Content = "Link sudah di clipboard",
            Duration = 2
        })
    end,
})

-- ==================================================
-- MAIN TAB
-- ==================================================
local MainTab = Window:CreateTab("📋 MAIN", 4483362458)
local MainSection = MainTab:CreateSection("Bring System")

-- Info Hold F
MainTab:CreateParagraph({
    Title = "ℹ️ Cara Pakai",
    Content = "HOLD F untuk bring brainrot\nTween fly halus (0.5 detik)"
})

-- Collect Money Toggle
MainTab:CreateToggle({
    Name = "💰 Collect Money (Base)",
    CurrentValue = false,
    Flag = "MoneyToggle",
    Callback = function(Value)
        getgenv().C.Money = Value
    end,
})

-- Rarity Filter Section
local RaritySection = MainTab:CreateSection("✨ RARITY FILTERS")

MainTab:CreateToggle({
    Name = "Common",
    CurrentValue = true,
    Flag = "Common",
    Callback = function(Value) getgenv().C.Filter.common = Value end,
})

MainTab:CreateToggle({
    Name = "Uncommon",
    CurrentValue = true,
    Flag = "Uncommon",
    Callback = function(Value) getgenv().C.Filter.unc = Value end,
})

MainTab:CreateToggle({
    Name = "Rare",
    CurrentValue = true,
    Flag = "Rare",
    Callback = function(Value) getgenv().C.Filter.rare = Value end,
})

MainTab:CreateToggle({
    Name = "Epic",
    CurrentValue = true,
    Flag = "Epic",
    Callback = function(Value) getgenv().C.Filter.epic = Value end,
})

MainTab:CreateToggle({
    Name = "Legendary",
    CurrentValue = true,
    Flag = "Legendary",
    Callback = function(Value) getgenv().C.Filter.leg = Value end,
})

MainTab:CreateToggle({
    Name = "✨ Celestial",
    CurrentValue = true,
    Flag = "Celestial",
    Callback = function(Value) getgenv().C.Filter.cel = Value end,
})

MainTab:CreateToggle({
    Name = "⚡ Divine",
    CurrentValue = true,
    Flag = "Divine",
    Callback = function(Value) getgenv().C.Filter.div = Value end,
})

MainTab:CreateToggle({
    Name = "♾️ Infinity",
    CurrentValue = true,
    Flag = "Infinity",
    Callback = function(Value) getgenv().C.Filter.inf = Value end,
})

MainTab:CreateToggle({
    Name = "🍀 Lucky Blox",
    CurrentValue = true,
    Flag = "LuckyBlox",
    Callback = function(Value) getgenv().C.Filter.luck = Value end,
})

-- ==================================================
-- AUTO TAB (EVENT TOKENS)
-- ==================================================
local AutoTab = Window:CreateTab("🤖 AUTO", 4483362458)
local AutoSection = AutoTab:CreateSection("Event Token Collector")

AutoTab:CreateToggle({
    Name = "💰 Money Event",
    CurrentValue = false,
    Flag = "EventMoney",
    Callback = function(Value) getgenv().C.Event.m = Value end,
})

AutoTab:CreateToggle({
    Name = "🎮 Arcade Event",
    CurrentValue = false,
    Flag = "EventArcade",
    Callback = function(Value) getgenv().C.Event.a = Value end,
})

AutoTab:CreateToggle({
    Name = "🍬 Candy Event",
    CurrentValue = false,
    Flag = "EventCandy",
    Callback = function(Value) getgenv().C.Event.c = Value end,
})

AutoTab:CreateToggle({
    Name = "👽 UFO Event",
    CurrentValue = false,
    Flag = "EventUFO",
    Callback = function(Value) getgenv().C.Event.u = Value end,
})

AutoTab:CreateToggle({
    Name = "☢️ Radioactive",
    CurrentValue = false,
    Flag = "EventRadio",
    Callback = function(Value) getgenv().C.Event.r = Value end,
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
    Callback = function(Value)
        getgenv().C.ReduceLag = Value
    end,
})

PerfTab:CreateParagraph({
    Title = "Info",
    Content = "• Matikan efek grafis\n• Turunkan kualitas\n• Nonaktifkan particle"
})

-- ==================================================
-- MISC TAB
-- ==================================================
local MiscTab = Window:CreateTab("🛠️ MISC", 4483362458)
local MiscSection = MiscTab:CreateSection("Miscellaneous")

MiscTab:CreateToggle({
    Name = "🛡️ God Mode (2-3 wave)",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(Value) getgenv().C.God = Value end,
})

MiscTab:CreateToggle({
    Name = "🧱 Remove Wall",
    CurrentValue = false,
    Flag = "RemoveWall",
    Callback = function(Value) getgenv().C.Wall = Value end,
})

MiscTab:CreateToggle({
    Name = "💎 Remove VIP Wall",
    CurrentValue = false,
    Flag = "RemoveVIP",
    Callback = function(Value) getgenv().C.VIP = Value end,
})

-- ==================================================
-- SERVER TAB
-- ==================================================
local ServerTab = Window:CreateTab("🌐 SERVER", 4483362458)
local ServerSection = ServerTab:CreateSection("Server Settings")

ServerTab:CreateParagraph({
    Title = "🛡️ Anti AFK",
    Content = "Status: SELALU ON (otomatis)\nTidak bisa dimatikan"
})

ServerTab:CreateParagraph({
    Title = "Info",
    Content = "• Anti AFK aktif setiap 60 detik\n• Simulasi gerakan kecil"
})

-- ==================================================
-- COLLECT MONEY & EVENT FUNCTION (AUTO)
-- ==================================================
spawn(function() 
    while task.wait(0.5) do 
        pcall(function()
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                for _, o in pairs(workspace:GetDescendants()) do
                    if o:IsA("BasePart") and o.Name then
                        local n = o.Name:lower()
                        if (getgenv().C.Money and (n:find("coin") or n:find("cash") or n:find("money"))) or
                           (getgenv().C.Event.m and n:find("money")) or 
                           (getgenv().C.Event.a and n:find("arcade")) or
                           (getgenv().C.Event.c and (n:find("candy") or n:find("sweet"))) or
                           (getgenv().C.Event.u and (n:find("ufo") or n:find("alien"))) or
                           (getgenv().C.Event.r and (n:find("radio") or n:find("nuklir"))) then
                            o.CFrame = hrp.CFrame * CFrame.new(0, -5, 3)
                            task.wait(0.03)
                        end
                    end
                end
            end
        end)
    end
end)

-- ==================================================
-- REMOVE WALL FUNCTION
-- ==================================================
spawn(function() 
    while task.wait(2) do 
        pcall(function()
            for _, o in pairs(workspace:GetDescendants()) do
                if o:IsA("BasePart") and o.Name then
                    local n = o.Name:lower()
                    if getgenv().C.Wall and n:find("wall") and not n:find("vip") then 
                        o.CanCollide = false 
                        o.Transparency = 0.8 
                    end
                    if getgenv().C.VIP and (n:find("vip") or n:find("v.i.p")) then 
                        o.CanCollide = false 
                        o.Transparency = 0.8 
                    end
                end
            end
        end)
    end
end)

-- ==================================================
-- GOD MODE FUNCTION (2-3 WAVE)
-- ==================================================
spawn(function() 
    local wave = 0 
    while task.wait(1) do 
        if getgenv().C.God then 
            pcall(function()
                local player = game.Players.LocalPlayer
                for _, o in pairs(workspace:GetDescendants()) do
                    if o:IsA("BasePart") and (o.Name:lower():find("water") or o.Name:lower():find("wave")) then
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = player.Character.HumanoidRootPart
                            if (o.Position - hrp.Position).Magnitude < 20 then
                                wave = wave + 1
                                if wave <= 3 then 
                                    hrp.Velocity = Vector3.new(0, 50, 0)
                                else
                                    getgenv().C.God = false 
                                    wave = 0
                                    Rayfield:Notify({
                                        Title = "God Mode Off",
                                        Content = "Sudah 3 wave, auto mati",
                                        Duration = 2
                                    })
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
-- LOAD CONFIGURATION
-- ==================================================
Rayfield:LoadConfiguration()

print("✅ BRAINROT HUB - HOLD F + TWEEN FLY LOADED")
print("🎯 HOLD F untuk bring brainrot (tween fly halus)")
