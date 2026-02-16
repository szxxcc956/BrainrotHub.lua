--[[
    CHLOE X STYLE - BRAINROT HUB
    UI Minimalis kayak Chloe X (item list kiri, info kanan)
    Fitur: Bring Infinity/Divine/Celestial/Lucky Blox (Underground Mode)
]]

local player = game:GetService("Players").LocalPlayer
local guiService = game:GetService("CoreGui")

-- GUI Utama
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotChloe"
gui.Parent = player:FindFirstChild("PlayerGui") or guiService
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==================================================
-- VARIABEL KONTROL
-- ==================================================
getgenv().BringEnabled = false
getgenv().UndergroundMode = true
getgenv().Filter = {
    Celestial = true,
    Divine = true,
    Infinity = true,
    LuckyBlox = true
}

-- ==================================================
-- FUNGSI BRING (UNDERGROUND)
-- ==================================================
local function BringObjects()
    spawn(function()
        while task.wait(0.3) do
            if getgenv().BringEnabled then
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and obj.Name then
                                local name = obj.Name:lower()
                                local bring = false
                                
                                if getgenv().Filter.Celestial and (name:find("celestial") or name:find("celest")) then bring = true end
                                if getgenv().Filter.Divine and (name:find("divine") or name:find("div")) then bring = true end
                                if getgenv().Filter.Infinity and (name:find("infinity") or name:find("inf") or name:find("∞")) then bring = true end
                                if getgenv().Filter.LuckyBlox and (name:find("lucky") or name:find("blox") or name:find("box")) then bring = true end
                                
                                if bring then
                                    if getgenv().UndergroundMode then
                                        obj.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 18, hrp.Position.Z)
                                    else
                                        obj.CFrame = hrp.CFrame * CFrame.new(0, -3, 5)
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

BringObjects()

-- ==================================================
-- UI CHLOE X STYLE
-- ==================================================

-- Main Frame (transparan)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 750, 0, 500)
mainFrame.Position = UDim2.new(0.5, -375, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- SIDE PANEL KIRI (Item List / Menu)
local leftPanel = Instance.new("Frame")
leftPanel.Size = UDim2.new(0, 200, 1, 0)
leftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
leftPanel.BorderSizePixel = 0
leftPanel.Parent = mainFrame

-- Header Left
local leftHeader = Instance.new("TextLabel")
leftHeader.Size = UDim2.new(1, 0, 0, 45)
leftHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
leftHeader.BorderSizePixel = 0
leftHeader.Text = "⚡ BRAINROT HUB"
leftHeader.TextColor3 = Color3.fromRGB(100, 200, 255)
leftHeader.TextScaled = true
leftHeader.Font = Enum.Font.GothamBold
leftHeader.Parent = leftPanel

-- Version
local version = Instance.new("TextLabel")
version.Size = UDim2.new(1, -20, 0, 20)
version.Position = UDim2.new(0, 10, 0, 50)
version.BackgroundTransparency = 1
version.Text = "Version 2.0 | Delta"
version.TextColor3 = Color3.fromRGB(150, 150, 150)
version.TextXAlignment = Enum.TextXAlignment.Left
version.Font = Enum.Font.Gotham
version.TextSize = 12
version.Parent = leftPanel

-- Welcome User
local welcome = Instance.new("TextLabel")
welcome.Size = UDim2.new(1, -20, 0, 25)
welcome.Position = UDim2.new(0, 10, 0, 75)
welcome.BackgroundTransparency = 1
welcome.Text = "Welcome, " .. player.Name
welcome.TextColor3 = Color3.fromRGB(255, 255, 255)
welcome.TextXAlignment = Enum.TextXAlignment.Left
welcome.Font = Enum.Font.Gotham
welcome.TextSize = 14
welcome.Parent = leftPanel

-- Status
local statusPanel = Instance.new("Frame")
statusPanel.Size = UDim2.new(1, -20, 0, 60)
statusPanel.Position = UDim2.new(0, 10, 0, 110)
statusPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
statusPanel.BorderSizePixel = 0
statusPanel.Parent = leftPanel

local statusTitle = Instance.new("TextLabel")
statusTitle.Size = UDim2.new(1, -10, 0, 20)
statusTitle.Position = UDim2.new(0, 5, 0, 5)
statusTitle.BackgroundTransparency = 1
statusTitle.Text = "STATUS"
statusTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
statusTitle.TextXAlignment = Enum.TextXAlignment.Left
statusTitle.Font = Enum.Font.GothamBold
statusTitle.TextSize = 11
statusTitle.Parent = statusPanel

local bringStatus = Instance.new("TextLabel")
bringStatus.Size = UDim2.new(1, -10, 0, 15)
bringStatus.Position = UDim2.new(0, 5, 0, 25)
bringStatus.BackgroundTransparency = 1
bringStatus.Text = "🟢 Bring: OFF"
bringStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
bringStatus.TextXAlignment = Enum.TextXAlignment.Left
bringStatus.Font = Enum.Font.Gotham
bringStatus.TextSize = 12
bringStatus.Parent = statusPanel

local underStatus = Instance.new("TextLabel")
underStatus.Size = UDim2.new(1, -10, 0, 15)
underStatus.Position = UDim2.new(0, 5, 0, 40)
underStatus.BackgroundTransparency = 1
underStatus.Text = "🕳️ Underground: ON"
underStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
underStatus.TextXAlignment = Enum.TextXAlignment.Left
underStatus.Font = Enum.Font.Gotham
underStatus.TextSize = 12
underStatus.Parent = statusPanel

-- Discord
local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, -20, 0, 35)
discordBtn.Position = UDim2.new(0, 10, 0, 180)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.BorderSizePixel = 0
discordBtn.Text = "📱 Join Discord"
discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
discordBtn.TextScaled = true
discordBtn.Font = Enum.Font.GothamBold
discordBtn.Parent = leftPanel

discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/brainrothub")
end)

-- MAIN PANEL KANAN (Menu Utama)
local rightPanel = Instance.new("Frame")
rightPanel.Size = UDim2.new(1, -200, 1, 0)
rightPanel.Position = UDim2.new(0, 200, 0, 0)
rightPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
rightPanel.BackgroundTransparency = 0.1
rightPanel.BorderSizePixel = 0
rightPanel.Parent = mainFrame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
topBar.BorderSizePixel = 0
topBar.Parent = rightPanel

local topTitle = Instance.new("TextLabel")
topTitle.Size = UDim2.new(0, 200, 1, 0)
topTitle.Position = UDim2.new(0, 15, 0, 0)
topTitle.BackgroundTransparency = 1
topTitle.Text = "Fishing / Bring Controller"
topTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
topTitle.TextXAlignment = Enum.TextXAlignment.Left
topTitle.Font = Enum.Font.Gotham
topTitle.TextSize = 16
topTitle.Parent = topBar

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ==================================================
-- MENU GRID (kayak Chloe X)
-- ==================================================
local menuGrid = Instance.new("Frame")
menuGrid.Size = UDim2.new(1, -30, 1, -100)
menuGrid.Position = UDim2.new(0, 15, 0, 55)
menuGrid.BackgroundTransparency = 1
menuGrid.Parent = rightPanel

-- Fungsi buat tombol menu
local function createMenuButton(name, yPos, defaultState, callback)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 0, 45)
    bg.Position = UDim2.new(0, 0, 0, yPos)
    bg.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    bg.BackgroundTransparency = 0.3
    bg.BorderSizePixel = 0
    bg.Parent = menuGrid
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.Parent = bg
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 70, 0, 30)
    toggle.Position = UDim2.new(1, -85, 0.5, -15)
    toggle.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 90)
    toggle.BorderSizePixel = 0
    toggle.Text = defaultState and "ON" or "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextScaled = true
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = bg
    
    local state = defaultState
    toggle.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            toggle.Text = "ON"
        else
            toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
            toggle.Text = "OFF"
        end
        callback(state)
        
        -- Update status
        if name == "Bring System" then
            bringStatus.Text = state and "🟢 Bring: ON" or "🔴 Bring: OFF"
        elseif name == "Underground Mode" then
            underStatus.Text = state and "🕳️ Underground: ON" or "🌍 Underground: OFF"
        end
    end)
    
    return bg
end

-- Menu Items
createMenuButton("Bring System", 0, false, function(state)
    getgenv().BringEnabled = state
end)

createMenuButton("Underground Mode", 55, true, function(state)
    getgenv().UndergroundMode = state
end)

-- Rarity Section
local rarityLabel = Instance.new("TextLabel")
rarityLabel.Size = UDim2.new(1, 0, 0, 30)
rarityLabel.Position = UDim2.new(0, 0, 0, 120)
rarityLabel.BackgroundTransparency = 1
rarityLabel.Text = "RARITY FILTER"
rarityLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
rarityLabel.TextXAlignment = Enum.TextXAlignment.Left
rarityLabel.Font = Enum.Font.GothamBold
rarityLabel.TextSize = 14
rarityLabel.Parent = menuGrid

-- Rarity Toggles (lebih kecil)
local function createRarityButton(name, yPos, defaultState, callback)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.5, -5, 0, 35)
    bg.Position = UDim2.new(0, 0, 0, yPos)
    bg.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    bg.BackgroundTransparency = 0.3
    bg.BorderSizePixel = 0
    bg.Parent = menuGrid
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 80, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = bg
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 25)
    toggle.Position = UDim2.new(1, -60, 0.5, -12.5)
    toggle.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 90)
    toggle.BorderSizePixel = 0
    toggle.Text = defaultState and "ON" or "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextScaled = true
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = bg
    
    local state = defaultState
    toggle.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            toggle.Text = "ON"
        else
            toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
            toggle.Text = "OFF"
        end
        callback(state)
    end)
end

-- Rarity buttons (2 kolom)
createRarityButton("✨ Celestial", 155, true, function(s) getgenv().Filter.Celestial = s end)
createRarityButton("⚡ Divine", 155, true, function(s) getgenv().Filter.Divine = s end)
createRarityButton("♾️ Infinity", 195, true, function(s) getgenv().Filter.Infinity = s end)
createRarityButton("🍀 Lucky Blox", 195, true, function(s) getgenv().Filter.LuckyBlox = s end)

-- Update status loop
spawn(function()
    while task.wait(0.5) do
        if getgenv().BringEnabled then
            bringStatus.Text = "🟢 Bring: ON"
        else
            bringStatus.Text = "🔴 Bring: OFF"
        end
        
        if getgenv().UndergroundMode then
            underStatus.Text = "🕳️ Underground: ON"
        else
            underStatus.Text = "🌍 Underground: OFF"
        end
    end
end)

print("✅ CHLOE X STYLE - BRAINROT HUB LOADED")
