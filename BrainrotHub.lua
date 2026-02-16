--[[
    BRAINROT HUB - PROXIMITY TAKE SYSTEM
    - Deteksi brainrot terdekat
    - Muncul prompt "TAKE [nama] (E)" 
    - Tekan E untuk ambil
    - Bisa juga auto take (toggle)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ==================================================
-- KONFIGURASI AREA (ISI KOORDINAT LO!)
-- ==================================================
local AreaData = {
    ["Common"] = {
        Position = Vector3.new(100, 20, 50),
        GapPosition = Vector3.new(95, 5, 50),
    },
    ["Uncommon"] = { Position = Vector3.new(200, 20, 50), GapPosition = Vector3.new(195, 5, 55) },
    ["Rare"] = { Position = Vector3.new(300, 20, 50), GapPosition = Vector3.new(295, 5, 45) },
    ["Epic"] = { Position = Vector3.new(400, 20, 50), GapPosition = Vector3.new(405, 5, 50) },
    ["Legendary"] = { Position = Vector3.new(500, 20, 50), GapPosition = Vector3.new(495, 5, 40) },
    ["Mythical"] = { Position = Vector3.new(600, 20, 50), GapPosition = Vector3.new(605, 5, 60) },
    ["Cosmic"] = { Position = Vector3.new(700, 20, 50), GapPosition = Vector3.new(695, 5, 50) },
    ["Secret"] = { Position = Vector3.new(800, 20, 50), GapPosition = Vector3.new(805, 5, 45) },
    ["Celestial"] = { Position = Vector3.new(900, 20, 50), GapPosition = Vector3.new(895, 5, 55) },
    ["Divine"] = { Position = Vector3.new(1000, 20, 50), GapPosition = Vector3.new(1005, 5, 50) },
}

-- ==================================================
-- KONFIGURASI SCRIPT
-- ==================================================
getgenv().C = {
    -- Proximity system
    ProximityDistance = 15,
    AutoTake = false,
    
    -- Fly system
    FlyEnabled = false,
    TsunamiDepth = 8,
    FlySpeed = 2,
    TargetArea = "Celestial",
    UseGap = true,
    
    -- Rarity toggles
    Common = true, Uncommon = true, Rare = true, Epic = true,
    Legendary = true, Mythical = true, Cosmic = true,
    Secret = true, Celestial = true, Divine = true,
    
    -- Other
    RemoveWalls = false,
    RemoveVIP = false,
    God = false,
    ReduceLag = false,
}

-- ==================================================
-- VARIABEL PROXIMITY
-- ==================================================
local nearestBrainrot = nil
local promptGui = nil
local player = game.Players.LocalPlayer

-- ==================================================
-- FUNGSI CEK RARITY
-- ==================================================
local function isTargetRarity(name)
    local n = name:lower()
    
    if getgenv().C.Common and (n:find("common") or n:find("noobini") or n:find("frulli") or n:find("pipi")) then return true end
    if getgenv().C.Uncommon and (n:find("uncommon") or n:find("trippi") or n:find("bobrito") or n:find("avocado")) then return true end
    if getgenv().C.Rare and (n:find("rare") or n:find("cappuccino") or n:find("bambini") or n:find("trulimero")) then return true end
    if getgenv().C.Epic and (n:find("epic") or n:find("burbaloni") or n:find("sigma") or n:find("pandaccini")) then return true end
    if getgenv().C.Legendary and (n:find("legend") or n:find("bombardilo") or n:find("gorillo") or n:find("tigrilini")) then return true end
    if getgenv().C.Mythical and (n:find("mythical") or n:find("cocofanto") or n:find("tralalero") or n:find("giraffa")) then return true end
    if getgenv().C.Cosmic and (n:find("cosmic") or n:find("vacca") or n:find("nuclearo") or n:find("pot")) then return true end
    if getgenv().C.Secret and (n:find("secret") or n:find("matteo") or n:find("gattatino") or n:find("fragola")) then return true end
    if getgenv().C.Celestial and (n:find("celestial") or n:find("job") or n:find("dug") or n:find("bisonte")) then return true end
    if getgenv().C.Divine and (n:find("divine") or n:find("bulbito") or n:find("burgerini")) then return true end
    
    return false
end

-- ==================================================
-- FUNGSI MEMBUAT PROMPT (KAYAK DI SS)
-- ==================================================
local function createPrompt(obj)
    -- Hapus prompt lama
    if promptGui then
        promptGui:Destroy()
        promptGui = nil
    end
    
    -- Buat BillboardGui baru
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BrainrotPrompt"
    billboard.Size = UDim2.new(0, 200, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj
    
    -- Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    bg.BackgroundTransparency = 0.2
    bg.BorderSizePixel = 0
    bg.Parent = billboard
    
    -- Nama brainrot
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "📦 " .. obj.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = bg
    
    -- Prompt "TAKE [E]"
    local takeLabel = Instance.new("TextLabel")
    takeLabel.Size = UDim2.new(1, 0, 0.5, 0)
    takeLabel.Position = UDim2.new(0, 0, 0.5, 0)
    takeLabel.BackgroundTransparency = 1
    takeLabel.Text = "⚡ TAKE [E]"
    takeLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- Emas
    takeLabel.TextScaled = true
    takeLabel.Font = Enum.Font.GothamBold
    takeLabel.Parent = bg
    
    promptGui = billboard
    nearestBrainrot = obj
end

-- ==================================================
-- FUNGSI AMBIL BRAINROT
-- ==================================================
local function takeBrainrot(obj)
    if not obj then return end
    
    pcall(function()
        -- Simulasi klik/take
        if obj:FindFirstChild("ClickDetector") then
            fireclickdetector(obj.ClickDetector)
        elseif obj:FindFirstChild("TouchInterest") then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                firetouchinterest(hrp, obj, 0)
                task.wait(0.1)
                firetouchinterest(hrp, obj, 1)
            end
        end
        
        -- Notifikasi
        Rayfield:Notify({
            Title = "✅ Collected!",
            Content = obj.Name,
            Duration = 1.5
        })
        
        -- Hapus prompt
        if promptGui then
            promptGui:Destroy()
            promptGui = nil
            nearestBrainrot = nil
        end
    end)
end

-- ==================================================
-- LOOP DETEKSI BRAINROT TERDEKAT
-- ==================================================
spawn(function()
    while task.wait(0.3) do
        pcall(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            
            local hrp = player.Character.HumanoidRootPart
            local closestDist = getgenv().C.ProximityDistance + 1
            local closestObj = nil
            
            -- Cari brainrot terdekat
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
                    if isTargetRarity(obj.Name) then
                        local dist = (obj.Position - hrp.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestObj = obj
                        end
                    end
                end
            end
            
            -- Update prompt
            if closestObj and closestDist <= getgenv().C.ProximityDistance then
                if closestObj ~= nearestBrainrot then
                    createPrompt(closestObj)
                end
            else
                if promptGui then
                    promptGui:Destroy()
                    promptGui = nil
                    nearestBrainrot = nil
                end
            end
            
            -- Auto take kalo aktif
            if getgenv().C.AutoTake and nearestBrainrot then
                takeBrainrot(nearestBrainrot)
                task.wait(0.5)
            end
        end)
    end
end)

-- ==================================================
-- DETEKSI TEKAN TOMBOL E
-- ==================================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E and nearestBrainrot then
        takeBrainrot(nearestBrainrot)
    end
end)

-- ==================================================
-- FUNGSI TERBANG KE AREA (SINGKAT)
-- ==================================================
local function flyToArea(areaName)
    local area = AreaData[areaName]
    if not area or not player.Character then return end
    
    local tsunamiLevel = 20  -- Ganti pake deteksi tsunami kalo perlu
    local startPos = player.Character.HumanoidRootPart.Position
    local targetPos = getgenv().C.UseGap and area.GapPosition or area.Position
    
    -- Turun
    local downPos = Vector3.new(startPos.X, tsunamiLevel - getgenv().C.TsunamiDepth, startPos.Z)
    local t1 = TweenService:Create(player.Character.HumanoidRootPart, 
        TweenInfo.new(getgenv().C.FlySpeed, Enum.EasingStyle.Quad), 
        {CFrame = CFrame.new(downPos)})
    t1:Play()
    t1.Completed:Wait()
    
    -- Terbang horizontal
    local midPos = Vector3.new(targetPos.X, tsunamiLevel - getgenv().C.TsunamiDepth, targetPos.Z)
    local t2 = TweenService:Create(player.Character.HumanoidRootPart, 
        TweenInfo.new(getgenv().C.FlySpeed * 1.5, Enum.EasingStyle.Quad), 
        {CFrame = CFrame.new(midPos)})
    t2:Play()
    t2.Completed:Wait()
    
    -- Naik
    local t3 = TweenService:Create(player.Character.HumanoidRootPart, 
        TweenInfo.new(getgenv().C.FlySpeed, Enum.EasingStyle.Quad), 
        {CFrame = CFrame.new(targetPos)})
    t3:Play()
    t3.Completed:Wait()
end

-- ==================================================
-- REMOVE WALL FUNCTION
-- ==================================================
spawn(function()
    while task.wait(1) do
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name then
                    local n = obj.Name:lower()
                    
                    if getgenv().C.RemoveWalls and (
                        n:find("wall") or n:find("dinding") or n:find("tembok") or 
                        n:find("pagar") or n:find("fence") or n:find("barrier")
                    ) and not n:find("vip") then
                        obj.CanCollide = false
                        obj.Transparency = 1
                    end
                    
                    if getgenv().C.RemoveVIP and (
                        n:find("vip") or n:find("v.i.p") or n:find("premium")
                    ) then
                        obj.CanCollide = false
                        obj.Transparency = 1
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
    Name = "🧠 BRAINROT HUB • PROXIMITY TAKE",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Tekan E untuk ambil brainrot",
    ConfigurationSaving = {Enabled = true, FolderName = "BrainrotHub", FileName = "Config"},
    KeySystem = false,
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

-- ==================================================
-- MAIN TAB (PROXIMITY)
-- ==================================================
local MainTab = Window:CreateTab("📋 MAIN", 4483362458)
local MainSection = MainTab:CreateSection("Proximity Take System")

MainTab:CreateParagraph({
    Title = "ℹ️ Cara Pakai",
    Content = "1. Deketin brainrot (max 15 stud)\n2. Muncul prompt TAKE [E]\n3. Tekan E untuk ambil"
})

MainTab:CreateSlider({
    Name = "📏 Jarak Deteksi",
    Range = {5, 30},
    Increment = 1,
    Suffix = "stud",
    CurrentValue = 15,
    Flag = "DistanceSlider",
    Callback = function(v) getgenv().C.ProximityDistance = v end,
})

MainTab:CreateToggle({
    Name = "🤖 Auto Take (otomatis ambil)",
    CurrentValue = false,
    Flag = "AutoTake",
    Callback = function(v) getgenv().C.AutoTake = v end,
})

-- ==================================================
-- AREA TAB
-- ==================================================
local AreaTab = Window:CreateTab("🗺️ AREA", 4483362458)
local AreaSection = AreaTab:CreateSection("Fly ke Area")

AreaTab:CreateDropdown({
    Name = "Pilih Area",
    Options = {"Common", "Uncommon", "Rare", "Epic", "Legendary", 
               "Mythical", "Cosmic", "Secret", "Celestial", "Divine"},
    CurrentOption = "Celestial",
    Flag = "AreaDropdown",
    Callback = function(opt) getgenv().C.TargetArea = opt end,
})

AreaTab:CreateToggle({
    Name = "🕳️ Land di GAP",
    CurrentValue = true,
    Flag = "GapToggle",
    Callback = function(v) getgenv().C.UseGap = v end
})

AreaTab:CreateToggle({
    Name = "🚀 FLY NOW",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(v)
        if v then
            flyToArea(getgenv().C.TargetArea)
            task.wait(1)
            getgenv().C.FlyEnabled = false
        end
    end,
})

-- ==================================================
-- RARITY TAB
-- ==================================================
local RarityTab = Window:CreateTab("✨ RARITY", 4483362458)
local RaritySection = RarityTab:CreateSection("Filter Brainrot")

RarityTab:CreateToggle({Name = "Common", CurrentValue = true, Flag = "Common", Callback = function(v) getgenv().C.Common = v end})
RarityTab:CreateToggle({Name = "Uncommon", CurrentValue = true, Flag = "Uncommon", Callback = function(v) getgenv().C.Uncommon = v end})
RarityTab:CreateToggle({Name = "Rare", CurrentValue = true, Flag = "Rare", Callback = function(v) getgenv().C.Rare = v end})
RarityTab:CreateToggle({Name = "Epic", CurrentValue = true, Flag = "Epic", Callback = function(v) getgenv().C.Epic = v end})
RarityTab:CreateToggle({Name = "Legendary", CurrentValue = true, Flag = "Legendary", Callback = function(v) getgenv().C.Legendary = v end})
RarityTab:CreateToggle({Name = "Mythical", CurrentValue = true, Flag = "Mythical", Callback = function(v) getgenv().C.Mythical = v end})
RarityTab:CreateToggle({Name = "Cosmic", CurrentValue = true, Flag = "Cosmic", Callback = function(v) getgenv().C.Cosmic = v end})
RarityTab:CreateToggle({Name = "Secret", CurrentValue = true, Flag = "Secret", Callback = function(v) getgenv().C.Secret = v end})
RarityTab:CreateToggle({Name = "Celestial", CurrentValue = true, Flag = "Celestial", Callback = function(v) getgenv().C.Celestial = v end})
RarityTab:CreateToggle({Name = "Divine", CurrentValue = true, Flag = "Divine", Callback = function(v) getgenv().C.Divine = v end})

-- ==================================================
-- WALL TAB
-- ==================================================
local WallTab = Window:CreateTab("🧱 WALLS", 4483362458)
local WallSection = WallTab:CreateSection("Remove Walls")

WallTab:CreateToggle({Name = "Remove Walls", CurrentValue = false, Flag = "RemoveWalls", Callback = function(v) getgenv().C.RemoveWalls = v end})
WallTab:CreateToggle({Name = "Remove VIP", CurrentValue = false, Flag = "RemoveVIP", Callback = function(v) getgenv().C.RemoveVIP = v end})

-- ==================================================
-- LOAD CONFIG
-- ==================================================
Rayfield:LoadConfiguration()

print("✅ BRAINROT HUB - PROXIMITY TAKE LOADED")
print("🎯 Tekan E untuk ambil brainrot terdekat")
