--[[
    BRAINROT HUB - FINAL (BRING = AUTO AMBIL)
    - Bring System ON → otomatis ambil brainrot
    - GA pake atur jarak
    - Rarity filter lengkap
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================================================
-- KONFIGURASI UTAMA
-- ==================================================
getgenv().C = {
    -- Bring system (otomatis ambil)
    BringEnabled = false,
    BringSpeed = 0.3,
    
    -- Rarity toggles (LENGKAP 10)
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
    
    -- Remove features
    RemoveWalls = false,
    RemoveVIP = false,
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
-- FUNGSI CEK RARITY (LENGKAP)
-- ==================================================
local function isTargetRarity(name)
    local n = name:lower()
    
    if getgenv().C.Common and (n:find("common") or n:find("noobini") or n:find("frulli") or n:find("pipi")) then return true end
    if getgenv().C.Uncommon and (n:find("uncommon") or n:find("trippi") or n:find("bobrito") or n:find("avocado")) then return true end
    if getgenv().C.Rare and (n:find("rare") or n:find("cappuccino") or n:find("bambini") or n:find("crostini")) then return true end
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
-- BRING SYSTEM (OTOMATIS AMBIL)
-- ==================================================
local function bringAndTake()
    spawn(function()
        while task.wait(getgenv().C.BringSpeed) do
            if getgenv().C.BringEnabled then
                pcall(function()
                    local player = game.Players.LocalPlayer
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                    
                    local hrp = player.Character.HumanoidRootPart
                    
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
                            if isTargetRarity(obj.Name) then
                                -- 1. Bawa brainrot ke player
                                obj.CFrame = hrp.CFrame * CFrame.new(0, -3, 2)
                                task.wait(0.05)
                                
                                -- 2. Langsung ambil (simulasi touch/click)
                                if obj:FindFirstChild("ClickDetector") then
                                    fireclickdetector(obj.ClickDetector)
                                elseif obj:FindFirstChild("TouchInterest") then
                                    firetouchinterest(hrp, obj, 0)
                                    task.wait(0.05)
                                    firetouchinterest(hrp, obj, 1)
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
bringAndTake()

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
-- CREATE WINDOW (RAYFIELD)
-- ==================================================
local Window = Rayfield:CreateWindow({
    Name = "🧠 BRAINROT HUB • FINAL",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Bring + Auto Take",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotHub",
        FileName = "Config"
    },
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
-- MAIN TAB (BRING SYSTEM + RARITY)
-- ==================================================
local MainTab = Window:CreateTab("📋 MAIN", 4483362458)
local MainSection = MainTab:CreateSection("Bring System (Otomatis Ambil)")

MainTab:CreateToggle({
    Name = "🚀 AKTIFKAN BRING SYSTEM",
    CurrentValue = false,
    Flag = "BringToggle",
    Callback = function(Value)
        getgenv().C.BringEnabled = Value
        Rayfield:Notify({
            Title = Value and "Bring ON" or "Bring OFF",
            Content = Value and "Otomatis ambil brainrot" or "Dimatiin",
            Duration = 1.5
        })
    end,
})

-- ==================================================
-- RARITY SECTION (LENGKAP 10)
-- ==================================================
local RaritySection = MainTab:CreateSection("✨ RARITY FILTERS")

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
-- WALL REMOVER TAB
-- ==================================================
local WallTab = Window:CreateTab("🧱 WALLS", 4483362458)
local WallSection = WallTab:CreateSection("Remove Obstacles")

WallTab:CreateToggle({
    Name = "🧱 REMOVE WALLS",
    CurrentValue = false,
    Flag = "RemoveWalls",
    Callback = function(v) getgenv().C.RemoveWalls = v end
})

WallTab:CreateToggle({
    Name = "💎 REMOVE VIP BARRIERS",
    CurrentValue = false,
    Flag = "RemoveVIP",
    Callback = function(v) getgenv().C.RemoveVIP = v end
})

-- ==================================================
-- LOAD CONFIG
-- ==================================================
Rayfield:LoadConfiguration()

print("✅ BRAINROT HUB - FINAL (BRING = AUTO AMBIL)")
print("🎯 Aktifkan Bring System → otomatis ambil brainrot")
