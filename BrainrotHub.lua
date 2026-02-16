--[[
    BRAINROT HUB - ULTIMATE EDITION
    UI Minimalis Keren dengan 6 Menu (HOME, MAIN, AUTOMATIC, PERFORMANCE, MISC, SERVER)
    Fitur: Bring Pattern M (bawah-atas-bawah), Event Token Collector, God Mode Limited, dll
    Anti AFK Auto ON
]]

local player = game:GetService("Players").LocalPlayer
local guiService = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- GUI Utama
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHub_Ultimate"
gui.Parent = player:FindFirstChild("PlayerGui") or guiService
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100

-- ==================================================
-- VARIABEL KONTROL
-- ==================================================
getgenv().Config = {
    -- Main
    BringEnabled = false,
    BringPattern = "M", -- Pattern M (bawah-atas-bawah)
    CollectMoney = false,
    
    -- Filters
    Filter = {
        Common = true,
        Uncommon = true,
        Rare = true,
        Epic = true,
        Legendary = true,
        Celestial = true,
        Divine = true,
        Infinity = true,
        LuckyBlox = true
    },
    
    -- Event tokens
    EventMoney = false,
    EventArcade = false,
    EventCandy = false,
    EventUFO = false,
    EventRadioactive = false,
    
    -- Misc
    GodMode = false,
    RemoveWall = false,
    RemoveVIPWall = false,
    
    -- Performance
    ReduceLag = false,
    
    -- Anti AFK (selalu ON)
    AntiAFK = true
}

-- ==================================================
-- ANTI AFK (SELALU ON)
-- ==================================================
spawn(function()
    while task.wait(60) do
        if getgenv().Config.AntiAFK then
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:Move(Vector3.new(0,0,0), true)
                    -- Simulasi gerakan kecil biar ga ke-detek
                    local randomDir = Vector3.new(math.random(-1,1), 0, math.random(-1,1))
                    player.Character.Humanoid:Move(randomDir, true)
                    task.wait(0.1)
                    player.Character.Humanoid:Move(Vector3.new(0,0,0), true)
                end
            end)
        end
    end
end)

-- ==================================================
-- FUNGSI BRING DENGAN PATTERN M
-- ==================================================
local function BringWithPattern(obj, hrp)
    if not obj or not hrp then return end
    
    -- Pattern M: Turun - Naik - Turun (kayak huruf M)
    local basePos = hrp.Position
    local amplitude = 15 -- Tinggi naik/turun
    local frequency = 2 -- Kecepatan
    
    -- Simulasi pergerakan M (tanpa loop berhenti)
    local time = tick() % 3 -- 3 detik siklus
    
    if time < 1 then
        -- Fase 1: Turun ke bawah
        obj.CFrame = CFrame.new(basePos.X, basePos.Y - amplitude, basePos.Z)
    elseif time < 2 then
        -- Fase 2: Naik ke atas
        obj.CFrame = CFrame.new(basePos.X, basePos.Y + amplitude, basePos.Z)
    else
        -- Fase 3: Turun lagi
        obj.CFrame = CFrame.new(basePos.X, basePos.Y - amplitude, basePos.Z)
    end
end

-- ==================================================
-- FUNGSI BRING SYSTEM
-- ==================================================
local function BringObjects()
    spawn(function()
        while task.wait(0.3) do
            if getgenv().Config.BringEnabled then
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and obj.Name then
                                local name = obj.Name:lower()
                                local bring = false
                                
                                -- Filter berdasarkan rarity
                                if getgenv().Config.Filter.Common and (name:find("common") or name:find("com")) then bring = true end
                                if getgenv().Config.Filter.Uncommon and (name:find("uncommon") or name:find("uncom")) then bring = true end
                                if getgenv().Config.Filter.Rare and (name:find("rare")) then bring = true end
                                if getgenv().Config.Filter.Epic and (name:find("epic")) then bring = true end
                                if getgenv().Config.Filter.Legendary and (name:find("legend") or name:find("leg")) then bring = true end
                                if getgenv().Config.Filter.Celestial and (name:find("celestial") or name:find("celest")) then bring = true end
                                if getgenv().Config.Filter.Divine and (name:find("divine") or name:find("div")) then bring = true end
                                if getgenv().Config.Filter.Infinity and (name:find("infinity") or name:find("inf") or name:find("∞")) then bring = true end
                                if getgenv().Config.Filter.LuckyBlox and (name:find("lucky") or name:find("blox") or name:find("box")) then bring = true end
                                
                                if bring then
                                    if getgenv().Config.BringPattern == "M" then
                                        BringWithPattern(obj, hrp)
                                    else
                                        -- Default: underground
                                        obj.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 18, hrp.Position.Z)
                                    end
                                    task.wait(0.03)
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
end

-- ==================================================
-- FUNGSI COLLECT MONEY DI BASE
-- ==================================================
local function CollectMoney()
    spawn(function()
        while task.wait(0.5) do
            if getgenv().Config.CollectMoney then
                pcall(function()
                    -- Cari uang di sekitar base
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name:lower():find("coin") or obj.Name:lower():find("cash") or obj.Name:lower():find("money") then
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local hrp = player.Character.HumanoidRootPart
                                local dist = (obj.Position - hrp.Position).Magnitude
                                
                                -- Kalo deket, bring ke player
                                if dist < 50 then
                                    obj.CFrame = hrp.CFrame * CFrame.new(0, -5, 3)
                                    task.wait(0.05)
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
end

-- ==================================================
-- FUNGSI EVENT TOKEN COLLECTOR
-- ==================================================
local function CollectEventTokens()
    spawn(function()
        while task.wait(0.7) do
            pcall(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name then
                            local name = obj.Name:lower()
                            
                            -- Money Event
                            if getgenv().Config.EventMoney and (name:find("money") or name:find("coin") or name:find("cash")) then
                                obj.CFrame = hrp.CFrame * CFrame.new(0, -5, 2)
                                task.wait(0.03)
                            end
                            
                            -- Arcade Event
                            if getgenv().Config.EventArcade and (name:find("arcade") or name:find("token") or name:find("coin")) then
                                obj.CFrame = hrp.CFrame * CFrame.new(0, -5, 2)
                                task.wait(0.03)
                            end
                            
                            -- Candy Event
                            if getgenv().Config.EventCandy and (name:find("candy") or name:find("sweet") or name:find("lolipop")) then
                                obj.CFrame = hrp.CFrame * CFrame.new(0, -5, 2)
                                task.wait(0.03)
                            end
                            
                            -- UFO Event
                            if getgenv().Config.EventUFO and (name:find("ufo") or name:find("alien") or name:find("space")) then
                                obj.CFrame = hrp.CFrame * CFrame.new(0, -5, 2)
                                task.wait(0.03)
                            end
                            
                            -- Radioactive Event
                            if getgenv().Config.EventRadioactive and (name:find("radio") or name:find("nuklir") or name:find("green")) then
                                obj.CFrame = hrp.CFrame * CFrame.new(0, -5, 2)
                                task.wait(0.03)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- ==================================================
-- FUNGSI REMOVE WALL / VIP WALL
-- ==================================================
local function RemoveWalls()
    spawn(function()
        while task.wait(2) do
            pcall(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name then
                        local name = obj.Name:lower()
                        
                        -- Remove Wall
                        if getgenv().Config.RemoveWall and (name:find("wall") and not name:find("vip")) then
                            obj.CanCollide = false
                            obj.Transparency = 0.8
                        end
                        
                        -- Remove VIP Wall
                        if getgenv().Config.RemoveVIPWall and (name:find("vip") or name:find("v.i.p") or name:find("vipwall")) then
                            obj.CanCollide = false
                            obj.Transparency = 0.8
                        end
                    end
                end
            end)
        end
    end)
end

-- ==================================================
-- FUNGSI GOD MODE (Tahan Wave 2-3)
-- ==================================================
local function GodMode()
    spawn(function()
        local waveCount = 0
        while task.wait(1) do
            if getgenv().Config.GodMode then
                pcall(function()
                    -- Deteksi wave/tsunami
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name:lower():find("water") or obj.Name:lower():find("tsunami") or obj.Name:lower():find("wave") then
                            -- Kalo kena wave, hitung
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local hrp = player.Character.HumanoidRootPart
                                local dist = (obj.Position - hrp.Position).Magnitude
                                
                                if dist < 20 then
                                    waveCount = waveCount + 1
                                    
                                    -- Cuma tahan 2-3 wave
                                    if waveCount <= 3 then
                                        -- Push player ke atas biar ga tenggelam
                                        hrp.Velocity = Vector3.new(0, 50, 0)
                                    else
                                        -- Wave ke-4, matiin god mode
                                        getgenv().Config.GodMode = false
                                        waveCount = 0
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
end

-- ==================================================
-- FUNGSI REDUCE LAG
-- ==================================================
local function ReduceLag()
    spawn(function()
        while task.wait(3) do
            if getgenv().Config.ReduceLag then
                pcall(function()
                    -- Settings grafis minimal
                    settings().Rendering.QualityLevel = 1
                    game:GetService("Lighting").GlobalShadows = false
                    game:GetService("Lighting").FogEnd = 100
                    
                    -- Matiin particle
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then
                            obj.Enabled = false
                        end
                        
                        -- Transparansi objek jauh
                        if obj:IsA("BasePart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = player.Character.HumanoidRootPart
                            local dist = (obj.Position - hrp.Position).Magnitude
                            if dist > 100 then
                                obj.Transparency = 0.9
                            end
                        end
                    end
                end)
            end
        end
    end)
end

-- Jalankan semua fungsi
BringObjects()
CollectMoney()
CollectEventTokens()
RemoveWalls()
GodMode()
ReduceLag()

-- ==================================================
-- UI MINIMALIS KEREN (6 MENU)
-- ==================================================

-- Main Frame (bawah tengah, ukuran pas)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 650, 0, 450)
mainFrame.Position = UDim2.new(0.5, -325, 0.85, -225)  -- Bawah tengah
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- Shadow effect
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 15, 1, 15)
shadow.Position = UDim2.new(0, -8, 0, -8)
shadow.BackgroundColor3 = Color3.new(0, 0, 0)
shadow.BackgroundTransparency = 0.6
shadow.BorderSizePixel = 0
shadow.ZIndex = -1
shadow.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
header.BorderSizePixel = 0
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 BRAINROT HUB • ULTIMATE"
title.TextColor3 = Color3.fromRGB(120, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = header

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 50, 1, 0)
version.Position = UDim2.new(1, -55, 0, 0)
version.BackgroundTransparency = 1
version.Text = "v3.0"
version.TextColor3 = Color3.fromRGB(140, 140, 140)
version.Font = Enum.Font.Gotham
version.TextSize = 14
version.Parent = header

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(210, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ==================================================
-- MENU BAR (6 MENU)
-- ==================================================
local menuBar = Instance.new("Frame")
menuBar.Size = UDim2.new(1, 0, 0, 40)
menuBar.Position = UDim2.new(0, 0, 0, 45)
menuBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
menuBar.BorderSizePixel = 0
menuBar.Parent = mainFrame

-- Fungsi buat menu button
local menuButtons = {}
local menuContents = {}

local function createMenuButton(name, icon, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = UDim2.new(0, pos, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = menuBar
    
    btn.MouseEnter:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(55, 55, 75) then
            tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        end
    end)
    
    return btn
end

-- Buat 6 menu button
menuButtons[1] = createMenuButton("HOME", "🏠", 5)
menuButtons[2] = createMenuButton("MAIN", "📋", 110)
menuButtons[3] = createMenuButton("AUTO", "🤖", 215)
menuButtons[4] = createMenuButton("PERF", "⚡", 320)
menuButtons[5] = createMenuButton("MISC", "🛠️", 425)
menuButtons[6] = createMenuButton("SERVER", "🌐", 530)

-- Container konten
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -20, 1, -110)
contentContainer.Position = UDim2.new(0, 10, 0, 95)
contentContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
contentContainer.BackgroundTransparency = 0.2
contentContainer.BorderSizePixel = 0
contentContainer.Parent = mainFrame

-- ==================================================
-- FUNGSI BUAT SCROLLING FRAME PER MENU
-- ==================================================
local function createMenuContent()
    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = Color3.fromRGB(100, 180, 255)
    frame.CanvasSize = UDim2.new(0, 0, 0, 400)
    frame.Visible = false
    frame.Parent = contentContainer
    return frame
end

-- Buat konten untuk setiap menu
for i = 1, 6 do
    menuContents[i] = createMenuContent()
end

-- ==================================================
-- FUNGSI BUAT TOGGLE
-- ==================================================
local function createToggle(parent, name, desc, yPos, defaultState, callback)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 45)
    bg.Position = UDim2.new(0, 10, 0, yPos)
    bg.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    bg.BackgroundTransparency = 0.2
    bg.BorderSizePixel = 0
    bg.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    labe
