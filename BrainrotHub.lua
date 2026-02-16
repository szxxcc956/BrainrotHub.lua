--[[
    SPEED HUB EDITION - ESCAPE TSUNAMI BRAINROT
    UI Style mirip Speed Hub (ringan + modern)
    Fitur: Bring Infinity/Divine/Celestial/Lucky Blox (Underground Mode)
]]

-- Pastikan pake service yang bener
local player = game:GetService("Players").LocalPlayer
local guiService = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")

-- Buat ScreenGui utama
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedHubBrainrot"
gui.Parent = player:FindFirstChild("PlayerGui") or guiService
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==================================================
-- VARIABEL KONTROL (PASTIIN PAKE getgenv)
-- ==================================================
getgenv().BringEnabled = false
getgenv().UndergroundMode = true
getgenv().AntiAFK = false
getgenv().Filter = {
    Celestial = true,
    Divine = true,
    Infinity = true,
    LuckyBlox = true
}

-- ==================================================
-- FUNGSI BRING SYSTEM (UNDERGROUND)
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
                                
                                -- Cek filter Celestial
                                if getgenv().Filter.Celestial and (name:find("celestial") or name:find("celest") or name:find("c✧")) then
                                    bring = true
                                end
                                -- Cek filter Divine
                                if getgenv().Filter.Divine and (name:find("divine") or name:find("div") or name:find("⚡d")) then
                                    bring = true
                                end
                                -- Cek filter Infinity
                                if getgenv().Filter.Infinity and (name:find("infinity") or name:find("inf") or name:find("∞") or name:find("♾️")) then
                                    bring = true
                                end
                                -- Cek filter Lucky Blox
                                if getgenv().Filter.LuckyBlox and (name:find("lucky") or name:find("blox") or name:find("box") or name:find("🎲") or name:find("🍀")) then
                                    bring = true
                                end
                                
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

-- Jalankan bring system
BringObjects()

-- ==================================================
-- SPEED HUB STYLE UI
-- ==================================================

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 480)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- Shadow
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.new(0, 0, 0)
shadow.BackgroundTransparency = 0.5
shadow.BorderSizePixel = 0
shadow.ZIndex = -1
shadow.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
header.BorderSizePixel = 0
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ SPEED HUB | BRAINROT EDITION"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 40, 0, 20)
version.Position = UDim2.new(1, -45, 0, 15)
version.BackgroundTransparency = 1
version.Text = "v2.0"
version.TextColor3 = Color3.fromRGB(150, 150, 150)
version.TextScaled = true
version.Font = Enum.Font.Gotham
version.Parent = header

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Tab menu
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0, 50)
tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

-- Fungsi buat tab
local function createTab(name, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 1, -2)
    btn.Position = UDim2.new(0, pos, 0, 1)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = tabFrame
    
    btn.MouseEnter:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
    end)
    
    return btn
end

local tabMain = createTab("MAIN", 10)
local tabFilter = createTab("FILTER", 110)
local tabSettings = createTab("SETTINGS", 210)

-- Container konten
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -110)
contentFrame.Position = UDim2.new(0, 10, 0, 100)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
contentFrame.BackgroundTransparency = 0.1
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- ==================================================
-- MAIN CONTENT
-- ==================================================
local mainContent = Instance.new("ScrollingFrame")
mainContent.Size = UDim2.new(1, 0, 1, 0)
mainContent.BackgroundTransparency = 1
mainContent.BorderSizePixel = 0
mainContent.ScrollBarThickness = 4
mainContent.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
mainContent.CanvasSize = UDim2.new(0, 0, 0, 200)
mainContent.Parent = contentFrame

-- Fungsi toggle
local function createToggle(parent, name, desc, yPos, defaultState, callback)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 45)
    bg.Position = UDim2.new(0, 10, 0, yPos)
    bg.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    bg.BackgroundTransparency = 0.3
    bg.BorderSizePixel = 0
    bg.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.Parent = bg
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(0, 150, 0, 15)
    descLabel.Position = UDim2.new(0, 15, 0, 22)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.Parent = bg
    
    local toggleBtn = Instance.new("Frame")
    toggleBtn.Size = UDim2.new(0, 50, 0, 25)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -12.5)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 90)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = bg
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 21, 0, 21)
    toggleCircle.Position = defaultState and UDim2.new(1, -26, 0.5, -10.5) or UDim2.new(0, 4, 0.5, -10.5)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBtn
    
    local state = defaultState
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = bg
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            tweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -26, 0.5, -10.5)}):Play()
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
            tweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 4, 0.5, -10.5)}):Play()
        end
        callback(state)
    end)
    
    return bg
end

-- MAIN toggles
createToggle(mainContent, "Bring System", "Aktifkan auto bring item", 10, false, function(state)
    getgenv().BringEnabled = state
end)

createToggle(mainContent, "Underground Mode", "Item lewat bawah tanah", 65, true, function(state)
    getgenv().UndergroundMode = state
end)

-- ==================================================
-- FILTER CONTENT
-- ==================================================
local filterContent = Instance.new("ScrollingFrame")
filterContent.Size = UDim2.new(1, 0, 1, 0)
filterContent.BackgroundTransparency = 1
filterContent.BorderSizePixel = 0
filterContent.ScrollBarThickness = 4
filterContent.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
filterContent.CanvasSize = UDim2.new(0, 0, 0, 300)
filterContent.Visible = false
filterContent.Parent = contentFrame

createToggle(filterContent, "✨ Celestial", "Bring item rarity Celestial", 10, true, function(state)
    getgenv().Filter.Celestial = state
end)

createToggle(filterContent, "⚡ Divine", "Bring item rarity Divine", 65, true, function(state)
    getgenv().Filter.Divine = state
end)

createToggle(filterContent, "♾️ Infinity", "Bring item rarity Infinity", 120, true, function(state)
    getgenv().Filter.Infinity = state
end)

createToggle(filterContent, "🍀 Lucky Blox", "Bring semua Lucky Blox", 175, true, function(state)
    getgenv().Filter.LuckyBlox = state
end)

-- ==================================================
-- SETTINGS CONTENT
-- ==================================================
local settingsContent = Instance.new("ScrollingFrame")
settingsContent.Size = UDim2.new(1, 0, 1, 0)
settingsContent.BackgroundTransparency = 1
settingsContent.BorderSizePixel = 0
settingsContent.ScrollBarThickness = 4
settingsContent.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
settingsContent.CanvasSize = UDim2.new(0, 0, 0, 150)
settingsContent.Visible = false
settingsContent.Parent = contentFrame

-- Anti-AFK
createToggle(settingsContent, "Anti-AFK", "Cegah disconnect", 10, false, function(state)
    getgenv().AntiAFK = state
    if state then
        spawn(function()
            while getgenv().AntiAFK do
                task.wait(60)
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:Move(Vector3.new(0,0,0), true)
                    end
                end)
            end
        end)
    end
end)

-- Tab switching
tabMain.MouseButton1Click:Connect(function()
    mainContent.Visible = true
    filterContent.Visible = false
    settingsContent.Visible = false
    
    tabMain.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    tabFilter.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabSettings.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
end)

tabFilter.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    filterContent.Visible = true
    settingsContent.Visible = false
    
    tabMain.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabFilter.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    tabSettings.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
end)

tabSettings.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    filterContent.Visible = false
    settingsContent.Visible = true
    
    tabMain.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabFilter.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabSettings.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
end)

-- Status bar
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, 25)
statusBar.Position = UDim2.new(0, 0, 1, -25)
statusBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
statusBar.BorderSizePixel = 0
statusBar.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -10, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "🟢 READY | Delta Executor | Underground: ON"
statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Font = Enum.Font.Gotham
statusText.TextSize = 12
statusText.Parent = statusBar

-- Update status
spawn(function()
    while task.wait(0.5) do
        if getgenv().BringEnabled then
            statusText.Text = "🟢 BRING ACTIVE | " .. (getgenv().UndergroundMode and "🕳️ UNDERGROUND" or "🌍 SURFACE")
        else
            statusText.Text = "🟡 BRING PAUSED | " .. (getgenv().UndergroundMode and "🕳️ UNDERGROUND" or "🌍 SURFACE")
        end
    end
end)

print("✅ SPEED HUB EDITION - BRAINROT LOADED")
