--[[
    BRAINROT HUB - RAYFIELD EDITION (FIX COMPLETE)
    - Hold F + Proximity Trigger (harus deket)
    - Display prompt di brainrot
    - Remove Wall beneran ilang
    - Remove VIP beneran ilang barrier
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================================================
-- KONFIGURASI
-- ==================================================
getgenv().C = {
    -- Main
    HoldF = false,
    ProximityDistance = 15,  -- Jarak trigger (15 stud)
    
    -- Toggles
    Money = false,
    God = false,
    Wall = false,
    VIP = false,
    ReduceLag = false,
    
    -- Events
    Event = {m=false, a=false, c=false, u=false, r=false},
    
    -- Filters
    Filter = {common=true, unc=true, rare=true, epic=true, leg=true, cel=true, div=true, inf=true, luck=true}
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
-- PROXIMITY TRIGGER + HOLD F
-- ==================================================
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

-- Variable buat nyimpen objek terdekat
local nearestObject = nil
local objectHighlight = nil
local objectDistance = math.huge

-- Fungsi buat bikin highlight/prompt di objek
local function createHighlight(obj)
    if not obj then return end
    
    -- Hapus highlight lama
    if objectHighlight then
        objectHighlight:Destroy()
        objectHighlight = nil
    end
    
    -- Buat highlight baru
    local highlight = Instance.new("Highlight")
    highlight.Name = "BrainrotHighlight"
    highlight.FillColor = Color3.fromRGB(255, 215, 0)  -- Emas
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = obj
    
    -- Billboard buat prompt "HOLD F"
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FPrompt"
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "⚡ HOLD F"
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextScaled = true
    text.Font = Enum.Font.GothamBold
    text.TextStrokeTransparency = 0.3
    text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    text.Parent = billboard
    
    objectHighlight = highlight
    nearestObject = obj
end

-- Loop buat deteksi objek terdekat
spawn(function()
    while task.wait(0.2) do
        pcall(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                if objectHighlight then objectHighlight:Destroy() objectHighlight = nil end
                nearestObject = nil
                return
            end
            
            local hrp = player.Character.HumanoidRootPart
            local closestDist = getgenv().C.ProximityDistance + 1
            local closestObj = nil
            
            -- Scan objek di sekitar
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
                    local n = obj.Name:lower()
                    local isTarget = false
                    
                    -- Cek filter
                    if getgenv().C.Filter.common and n:find("common") then isTarget = true end
                    if getgenv().C.Filter.unc and n:find("uncommon") then isTarget = true end
                    if getgenv().C.Filter.rare and n:find("rare") then isTarget = true end
                    if getgenv().C.Filter.epic and n:find("epic") then isTarget = true end
                    if getgenv().C.Filter.leg and (n:find("legend") or n:find("leg")) then isTarget = true end
                    if getgenv().C.Filter.cel and (n:find("celestial") or n:find("celest")) then isTarget = true end
                    if getgenv().C.Filter.div and (n:find("divine") or n:find("div")) then isTarget = true end
                    if getgenv().C.Filter.inf and (n:find("infinity") or n:find("inf") or n:find("∞")) then isTarget = true end
                    if getgenv().C.Filter.luck and (n:find("lucky") or n:find("blox") or n:find("box") or n:find("🎲") or n:find("🍀")) then isTarget = true end
                    
                    if isTarget then
                        local dist = (obj.Position - hrp.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestObj = obj
                        end
                    end
                end
            end
            
            -- Update highlight
            if closestObj and closestDist <= getgenv().C.ProximityDistance then
                if closestObj ~= nearestObject then
                    createHighlight(closestObj)
                end
            else
                if objectHighlight then
                    objectHighlight:Destroy()
                    objectHighlight = nil
                    nearestObject = nil
                end
            end
        end)
    end
end)

-- ==================================================
-- HOLD F FUNCTION (BRING DENGAN TWEEN)
-- ==================================================
local function bringObject(obj)
    if not obj or not obj:IsA("BasePart") then return end
    
    pcall(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            
            -- Tween halus ke posisi player (bawah tanah)
            local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local targetPos = Vector3.new(hrp.Position.X, hrp.Position.Y - 12, hrp.Position.Z)
            
            local tween = TweenService:Create(obj, tweenInfo, {CFrame = CFrame.new(targetPos)})
            tween:Play()
            
            -- Efek notifikasi kecil
            Rayfield:Notify({
                Title = "Collected!",
                Content = obj.Name,
                Duration = 0.8
            })
            
            -- Hapus highlight setelah diambil
            if objectHighlight then
                objectHighlight:Destroy()
                objectHighlight = nil
                nearestObject = nil
            end
        end
    end)
end

-- Detect Hold F
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        getgenv().C.HoldF = true
        
        -- Loop selama F di-hold
        spawn(function()
            while getgenv().C.HoldF do
                if nearestObject and objectHighlight then
                    bringObject(nearestObject)
                    task.wait(0.3)  -- Cooldom ambil
                end
                task.wait(0.1)
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
-- REMOVE WALL (BENERAN ILANG)
-- ==================================================
spawn(function()
    while task.wait(1) do
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name then
                    local n = obj.Name:lower()
                    
                    -- Remove Wall biasa
                    if getgenv().C.Wall and (n:find("wall") or n:find("dinding") or n:find("tembok")) and not n:find("vip") then
                        obj.CanCollide = false
                        obj.Transparency = 1  -- Beneran ilang (transparan total)
                        obj.Material = Enum.Material.Air
                    end
                    
                    -- Remove VIP Wall / Barrier
                    if getgenv().C.VIP and (n:find("vip") or n:find("v.i.p") or n:find("barrier") or n:find("pagar") or n:find("gate")) then
                        obj.CanCollide = false
                        obj.Transparency = 1  -- Beneran ilang
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
    Name = "🧠 BRAINROT HUB • PROXIMITY",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Hold F to Collect (Proximity)",
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
    Content = "DEKETIN brainrot → muncul HOLD F → tekan F untuk bring",
    Duration = 5
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
local MainSection = MainTab:CreateSection("Proximity Bring System")

MainTab:CreateParagraph({
    Title = "ℹ️ Cara Pakai",
    Content = "1. Deketin brainrot/Lucky Blox (max 15 stud)\n2. Muncul tulisan HOLD F\n3. Tekan & tahan F untuk bring\n4. Tween fly halus ke player"
})

MainTab:CreateSlider({
    Name = "🎯 Proximity Distance",
    Range = {5, 30},
    Increment = 1,
    Suffix = "stud",
    CurrentValue = 15,
    Flag = "ProxDistance",
    Callback = function(value)
        getgenv().C.ProximityDistance = value
    end,
})

MainTab:CreateToggle({
    Name = "💰 Collect Money (Base)",
    CurrentValue = false,
    Flag = "MoneyToggle",
    Callback = function(Value) getgenv().C.Money = Value end,
})

-- Rarity Filter Section
local RaritySection = MainTab:CreateSection("✨ RARITY FILTERS")

MainTab:CreateToggle({Name = "Common", CurrentValue = true, Flag = "Common", Callback = function(v) getgenv().C.Filter.common = v end})
MainTab:CreateToggle({Name = "Uncommon", CurrentValue = true, Flag = "Uncommon", Callback = function(v) getgenv().C.Filter.unc = v end})
MainTab:CreateToggle({Name = "Rare", CurrentValue = true, Flag = "Rare", Callback = function(v) getgenv().C.Filter.rare = v end})
MainTab:CreateToggle({Name = "Epic", CurrentValue = true, Flag = "Epic", Callback = function(v) getgenv().C.Filter.epic = v end})
MainTab:CreateToggle({Name = "Legendary", CurrentValue = true, Flag = "Legendary", Callback = function(v) getgenv().C.Filter.leg = v end})
MainTab:CreateToggle({Name = "✨ Celestial", CurrentValue = true, Flag = "Celestial", Callback = function(v) getgenv().C.Filter.cel = v end})
MainTab:CreateToggle({Name = "⚡ Divine", CurrentValue = true, Flag = "Divine", Callback = function(v) getgenv().C.Filter.div = v end})
MainTab:CreateToggle({Name = "♾️ Infinity", CurrentValue = true, Flag = "Infinity", Callback = function(v) getgenv().C.Filter.inf = v end})
MainTab:CreateToggle({Name = "🍀 Lucky Blox", CurrentValue = true, Flag = "LuckyBlox", Callback = function(v) getgenv().C.Filter.luck = v end})

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
    Callback = function(Value)
        getgenv().C.Wall = Value
        if Value then
            Rayfield:Notify({Title = "Remove Walls ON", Content = "Semua tembok ilang", Duration = 2})
        end
    end,
})

MiscTab:CreateToggle({
    Name = "💎 Remove VIP Barriers",
    CurrentValue = false,
    Flag = "RemoveVIP",
    Callback = function(Value)
        getgenv().C.VIP = Value
        if Value then
            Rayfield:Notify({Title = "Remove VIP ON", Content = "Barrier VIP ilang", Duration = 2})
        end
    end,
})

MiscTab:CreateToggle({
    Name = "🛡️ God Mode (2-3 wave)",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(Value) getgenv().C.God = Value end,
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
    Callback = function(Value) getgenv().C.ReduceLag = Value end,
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

-- ==================================================
-- BACKGROUND FUNCTIONS
-- ==================================================

-- Auto collect money & events
spawn(function() 
    while task.wait(0.5) do 
        pcall(function()
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

-- God Mode
spawn(function() 
    local wave = 0 
    while task.wait(1) do 
        if getgenv().C.God then 
            pcall(function()
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
                                    Rayfield:Notify({Title = "God Mode Off", Content = "Sudah 3 wave", Duration = 2})
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Reduce Lag
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

print("✅ BRAINROT HUB - PROXIMITY + HOLD F LOADED")
print("🎯 DEKETIN brainrot → muncul HOLD F → tahan F buat bring")
