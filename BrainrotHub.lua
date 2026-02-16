--[[
    BRAINROT HUB - FULL BRAINROT + LUCKY BLOX + ESP
    Created by: Xulur
    - Auto farm by rarity (pilih 1 rarity)
    - Terbang bawah tanah ke target
    - Ambil 1 brainrot, bawa ke base
    - Ulangi
    - ESP untuk Brainrot & Lucky Blox (toggle di MISC)
    - Lengkap dengan 122+ brainrot + semua lucky blox (termasuk Infinity)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local TweenService = game:GetService("TweenService")

-- ==================================================
-- VARIABEL ESP
-- ==================================================
local ESPEnabled = false
local ESPObjects = {}
local player = game.Players.LocalPlayer

-- ==================================================
-- SEMUA BRAINROT + LUCKY BLOX (LENGKAP DENGAN INFINITY)
-- ==================================================
local BrainrotLists = {
    Common = {
        "Noobini Cakenini", "Lirili Larila", "Tim Cheese", "Frulli Frulla",
        "Talpa Di Fero", "Svinino Bombondino", "Pipi Kiwi", "Pipi Corni",
        "Common Lucky Block"
    },
    Uncommon = {
        "Trippi Troppi", "Gangster Footera", "Bobrito Bandito", "Boneca Ambalabu",
        "Cacto Hipopotamo", "Ta Ta Ta Sahur", "Tric Tric Baraboom", "67", "Pipi Avocado",
        "Uncommon Lucky Block"
    },
    Rare = {
        "Cappuccino Assassino", "Brr Brr Patapim", "Trulimero Trulicina", "Bambini Crostini",
        "Bananita Dolphinita", "Perochello Lemonchello", "Avocadini Guffo", "Salamino Penguino",
        "Penguino Cocosino", "Ti Ti Ti Sahur",
        "Rare Lucky Block"
    },
    Epic = {
        "Burbaloni Luliloli", "Chimpanzini Bananini", "Ballerina Cappuccina", "Chef Crabracadabra",
        "Lionel Cactuseli", "Glorbo Fruttodrillo", "Strawberrelli Flamingelli", "Pandaccini Bananini",
        "Sigma Boy", "Pi Pi Watermelon", "Blueberrinni Octopussini", "Cocosini Mama", "Guesto Angelic",
        "Epic Lucky Block"
    },
    Legendary = {
        "Frigo Camelo", "Orangutini Ananasini", "Rhino Toasterino", "Bombardiro Crocodilo",
        "Spioniro Golubiro", "Bombombini Gusini", "Zibra Zubra Zibralini", "Tigrilini Watermelini",
        "Cavallo Virtuoso", "Gorillo Watermelondrillo", "Avocadorilla", "Ganganzelli Trulala",
        "Eaglucci Cocosucci",
        "Legendary Lucky Block"
    },
    Mythical = {
        "Cocofanto Elefanto", "Giraffa Celeste", "Tralalero Tralala", "Los Crocodillitos",
        "Tigroligre Frutonni", "Udin Din Din Dun", "Trenostruzzo Turbo 3000", "Trippi Troppi Troppa Trippa",
        "Orcalero Orcala", "Piccione Macchina", "Tukanno Bananno", "Ballerino Lololo",
        "Mythical Lucky Block", "Alien Lucky Block"
    },
    Cosmic = {
        "La Vacca Saturno", "Torrtuginni Dragonfrutini", "Los Tralaleritos", "Las Tralaleritas",
        "Las Vaquitas Saturnitas", "Graipuss Medussi", "Pot Hotspot", "Chicleteira Bicicleteira",
        "La Grande Combinasion", "Nuclearo Dinossauro", "Garama and Madundung", "Dragon Cannelloni",
        "Agarrini la Palini", "Chimpanzini Spiderini", "Dariungini Pandanneli", "Vroosh Boosh",
        "Cosmic Lucky Block"
    },
    Secret = {
        "Matteo", "Gattatino Neonino", "Statutino Libertino", "Unclito Samito",
        "Gattatino Nyanino", "Espresso Signora", "Los Tungtungtungcitos", "Aura Farma",
        "Rainbow 67", "Fragola La La La", "Mastodontico Telepiedone", "Capybara Monitora",
        "Patatino Astronauta", "Onionello Penguini", "Patito Dinerito", "Caffe Trinity",
        "Eek Eek Eek Sahur", "Los Combinasionas",
        "Secret Lucky Block", "Radioactive Lucky Block", "UFO Lucky Block"
    },
    Celestial = {
        "Job Job Sahur", "Dug Dug Dug", "Bisonte Gupitere", "Alessio",
        "Esok Sekolah", "Rattini Machini", "Zung Zung Zung Lazur", "Money Elephant",
        "Capuccino Policia", "Los Orcaleritos", "Avocadini Antilopini", "Diamantusa",
        "La Malita",
        "Celestial Lucky Block", "Admin Lucky Block"
    },
    Divine = {
        "Galactio Fantasma",      -- $88.8M/s 
        "Din Din Vaultero",       -- $55M/s 
        "Strawberry Elephant",    -- $50M/s 
        "Grappellino D'Oro",      -- $48.5M/s 
        "Martino Gravitino",      -- $45M/s 
        "Burgerini Bearini",      -- $40M/s 
        "Bulbito Bandito Traktorito", -- $30M/s 
        "Divine Lucky Block"
    },
    Infinity = {
        "Infinity Lucky Block",    -- Muncul pas Admin Abuse 
        "Infinity Brainrot"
    }
}

-- ==================================================
-- FUNGSI CEK RARITY (OTOMATIS DARI LIST)
-- ==================================================
local function getBrainrotRarity(name)
    local n = name:lower()
    
    for rarity, list in pairs(BrainrotLists) do
        for _, brainrotName in ipairs(list) do
            if n:find(brainrotName:lower()) or brainrotName:lower():find(n) then
                return rarity
            end
        end
    end
    return nil
end

-- ==================================================
-- FUNGSI ESP
-- ==================================================
local function createESP(obj, rarity)
    if not obj or not obj:IsA("BasePart") then return end
    
    -- Warna berdasarkan rarity
    local colors = {
        Common = Color3.fromRGB(128, 128, 128),     -- Abu-abu
        Uncommon = Color3.fromRGB(0, 255, 0),       -- Hijau
        Rare = Color3.fromRGB(0, 0, 255),           -- Biru
        Epic = Color3.fromRGB(128, 0, 128),         -- Ungu
        Legendary = Color3.fromRGB(255, 165, 0),    -- Orange
        Mythical = Color3.fromRGB(255, 192, 203),   -- Pink
        Cosmic = Color3.fromRGB(0, 255, 255),       -- Cyan
        Secret = Color3.fromRGB(255, 0, 255),       -- Magenta
        Celestial = Color3.fromRGB(255, 215, 0),    -- Emas
        Divine = Color3.fromRGB(255, 0, 0),         -- Merah
        Infinity = Color3.fromRGB(255, 255, 255)    -- Putih (paling langka)
    }
    
    local color = colors[rarity] or Color3.fromRGB(255, 255, 255)
    
    -- Buat Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "BrainrotESP_" .. rarity
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = obj
    
    -- Buat Billboard untuk nama
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPName"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj
    
    local bg = Instance.new("Frame", billboard)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.3
    bg.BorderSizePixel = 0
    
    local nameLabel = Instance.new("TextLabel", bg)
    nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = obj.Name
    nameLabel.TextColor3 = color
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    
    local rarityLabel = Instance.new("TextLabel", bg)
    rarityLabel.Size = UDim2.new(1, 0, 0.4, 0)
    rarityLabel.Position = UDim2.new(0, 0, 0.6, 0)
    rarityLabel.BackgroundTransparency = 1
    rarityLabel.Text = rarity
    rarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    rarityLabel.TextScaled = true
    rarityLabel.Font = Enum.Font.Gotham
    
    table.insert(ESPObjects, {obj = obj, highlight = highlight, billboard = billboard})
end

local function clearESP()
    for _, esp in ipairs(ESPObjects) do
        pcall(function()
            if esp.highlight then esp.highlight:Destroy() end
            if esp.billboard then esp.billboard:Destroy() end
        end)
    end
    ESPObjects = {}
end

local function updateESP()
    clearESP()
    if not ESPEnabled then return end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
            local rarity = getBrainrotRarity(obj.Name)
            if rarity then
                createESP(obj, rarity)
            end
        end
    end
end

-- ESP Loop
spawn(function()
    while task.wait(2) do
        if ESPEnabled then
            pcall(updateESP)
        end
    end
end)

-- ==================================================
-- KONFIGURASI AWAL
-- ==================================================
getgenv().C = {
    FarmEnabled = false,
    FlySpeed = 30,
    UndergroundLevel = 0,
    BasePosition = Vector3.new(0, 5, 50),
    TargetRarity = "Celestial",
    Common = false, Uncommon = false, Rare = false, Epic = false,
    Legendary = false, Mythical = false, Cosmic = false,
    Secret = false, Celestial = true, Divine = false, Infinity = false,
    RemoveWalls = false,
    RemoveVIP = false,
    ESPEnabled = false,
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
-- FUNGSI SMOOTH FLY
-- ==================================================
local function smoothFly(targetPos, duration)
    local player = game.Players.LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = player.Character.HumanoidRootPart
    local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
    tween:Play()
    tween.Completed:Wait()
end

-- ==================================================
-- CARI BRAINROT TARGET
-- ==================================================
local function findTargetBrainrot()
    local targetRarity = getgenv().C.TargetRarity
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
            if getBrainrotRarity(obj.Name) == targetRarity then return obj end
        end
    end
    return nil
end

-- ==================================================
-- AMBIL BRAINROT
-- ==================================================
local function takeBrainrot(obj)
    if not obj then return end
    local player = game.Players.LocalPlayer
    if not player.Character then return end
    local hrp = player.Character.HumanoidRootPart
    
    if obj:FindFirstChild("ClickDetector") then
        fireclickdetector(obj.ClickDetector)
    elseif obj:FindFirstChild("TouchInterest") then
        firetouchinterest(hrp, obj, 0)
        task.wait(0.05)
        firetouchinterest(hrp, obj, 1)
    else
        obj.CFrame = hrp.CFrame * CFrame.new(0, -3, 2)
    end
    
    Rayfield:Notify({
        Title = "✅ Taken!",
        Content = obj.Name .. " (" .. getgenv().C.TargetRarity .. ")",
        Duration = 1.5
    })
end

-- ==================================================
-- AUTO FARM LOOP
-- ==================================================
spawn(function()
    while task.wait(0.5) do
        if getgenv().C.FarmEnabled then pcall(function()
            local player = game.Players.LocalPlayer
            if not player.Character then return end
            local hrp = player.Character.HumanoidRootPart
            local basePos = getgenv().C.BasePosition
            local underground = getgenv().C.UndergroundLevel
            local target = findTargetBrainrot()
            
            if target then
                -- 1. TURUN KE BAWAH TANAH
                smoothFly(Vector3.new(hrp.Position.X, underground, hrp.Position.Z), 1)
                
                -- 2. TERBANG KE TARGET (di bawah tanah)
                local targetUnderground = Vector3.new(target.Position.X, underground, target.Position.Z)
                local distance = (targetUnderground - Vector3.new(hrp.Position.X, underground, hrp.Position.Z)).Magnitude
                smoothFly(targetUnderground, distance / getgenv().C.FlySpeed)
                
                -- 3. NAIK KE TARGET
                smoothFly(target.Position, 1)
                
                -- 4. AMBIL BRAINROT
                takeBrainrot(target)
                task.wait(0.5)
                
                -- 5. TURUN LAGI
                smoothFly(Vector3.new(target.Position.X, underground, target.Position.Z), 1)
                
                -- 6. TERBANG KEMBALI KE BASE
                local baseUnderground = Vector3.new(basePos.X, underground, basePos.Z)
                local returnDistance = (baseUnderground - Vector3.new(target.Position.X, underground, target.Position.Z)).Magnitude
                smoothFly(baseUnderground, returnDistance / getgenv().C.FlySpeed)
                
                -- 7. NAIK KE BASE
                smoothFly(basePos, 1)
            else
                Rayfield:Notify({
                    Title = "⚠️ Tidak ada brainrot",
                    Content = "Rarity: " .. getgenv().C.TargetRarity,
                    Duration = 2
                })
                task.wait(3)
            end
        end) end
    end
end)

-- ==================================================
-- REMOVE WALL
-- ==================================================
spawn(function()
    while task.wait(1) do pcall(function()
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
    end) end
end)

-- ==================================================
-- CREATE WINDOW
-- ==================================================
local Window = Rayfield:CreateWindow({
    Name = "🧠 BRAINROT HUB • Xulur",
    LoadingTitle = "BRAINROT HUB",
    LoadingSubtitle = "Full Brainrot + Lucky Blox + ESP",
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
local HomeSection = HomeTab:CreateSection("Created by Xulur")

HomeTab:CreateButton({
    Name = "📱 JOIN DISCORD",
    Callback = function()
        setclipboard("https://discord.gg/brainrothub")
        Rayfield:Notify({Title = "Discord Link Copied!", Duration = 2})
    end,
})

-- ==================================================
-- MAIN TAB
-- ==================================================
local MainTab = Window:CreateTab("📋 MAIN", 4483362458)
local MainSection = MainTab:CreateSection("Auto Farm by Xulur")

MainTab:CreateToggle({
    Name = "🚀 AKTIFKAN AUTO FARM",
    CurrentValue = false,
    Flag = "FarmToggle",
    Callback = function(Value)
        getgenv().C.FarmEnabled = Value
        Rayfield:Notify({
            Title = Value and "Auto Farm ON" or "Auto Farm OFF",
            Content = Value and "Mencari brainrot + lucky blox (termasuk Infinity)" or "Dimatiin",
            Duration = 1.5
        })
    end,
})

MainTab:CreateDropdown({
    Name = "🎯 Target Rarity",
    Options = {"Common", "Uncommon", "Rare", "Epic", "Legendary", 
               "Mythical", "Cosmic", "Secret", "Celestial", "Divine", "Infinity"},
    CurrentOption = "Celestial",
    Flag = "RarityDropdown",
    Callback = function(opt)
        getgenv().C.TargetRarity = opt
        getgenv().C.Common = (opt == "Common")
        getgenv().C.Uncommon = (opt == "Uncommon")
        getgenv().C.Rare = (opt == "Rare")
        getgenv().C.Epic = (opt == "Epic")
        getgenv().C.Legendary = (opt == "Legendary")
        getgenv().C.Mythical = (opt == "Mythical")
        getgenv().C.Cosmic = (opt == "Cosmic")
        getgenv().C.Secret = (opt == "Secret")
        getgenv().C.Celestial = (opt == "Celestial")
        getgenv().C.Divine = (opt == "Divine")
        getgenv().C.Infinity = (opt == "Infinity")
        
        Rayfield:Notify({Title = "Target Rarity", Content = opt, Duration = 1})
    end,
})

MainTab:CreateSlider({
    Name = "⚡ Kecepatan Terbang",
    Range = {10, 50},
    Increment = 5,
    Suffix = "stud/detik",
    CurrentValue = 30,
    Flag = "SpeedSlider",
    Callback = function(v) getgenv().C.FlySpeed = v end,
})

MainTab:CreateInput({
    Name = "📍 Base Position (X Y Z)",
    CurrentValue = "0, 5, 50",
    Flag = "BasePos",
    Callback = function(v)
        local x, y, z = v:match("([%d.-]+),?%s*([%d.-]+),?%s*([%d.-]+)")
        if x and y and z then
            getgenv().C.BasePosition = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
            Rayfield:Notify({Title = "Base Updated", Content = tostring(getgenv().C.BasePosition), Duration = 2})
        end
    end,
})

-- ==================================================
-- MISC TAB (DENGAN ESP)
-- ==================================================
local MiscTab = Window:CreateTab("🛠️ MISC", 4483362458)
local MiscSection = MiscTab:CreateSection("ESP & Lainnya")

MiscTab:CreateToggle({
    Name = "👁️ ESP BRAINROT & LUCKY BLOX",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        getgenv().C.ESPEnabled = Value
        ESPEnabled = Value
        if Value then
            Rayfield:Notify({Title = "ESP ON", Content = "Menampilkan semua brainrot + lucky blox", Duration = 2})
            updateESP()
        else
            Rayfield:Notify({Title = "ESP OFF", Content = "ESP dimatikan", Duration = 2})
            clearESP()
        end
    end,
})

MiscTab:CreateParagraph({
    Title = "🎨 Warna ESP",
    Content = [[• Common: Abu-abu
• Uncommon: Hijau
• Rare: Biru
• Epic: Ungu
• Legendary: Orange
• Mythical: Pink
• Cosmic: Cyan
• Secret: Magenta
• Celestial: Emas
• Divine: Merah
• Infinity: Putih]]
})

-- ==================================================
-- WALL TAB
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
-- RARITY INFO TAB
-- ==================================================
local InfoTab = Window:CreateTab("📊 INFO", 4483362458)
local InfoSection = InfoTab:CreateSection("Info Lucky Blox & Infinity")

InfoTab:CreateParagraph({
    Title = "🎲 LUCKY BLOX LENGKAP",
    Content = [[• Common s/d Legendary: Drop brainrot sesuai rarity
• Mythical Lucky Block: Drop Mythical
• Cosmic Lucky Block: Drop Cosmic
• Secret Lucky Block: Drop Secret
• Celestial Lucky Block: Muncul pas Wacky Waves
• Divine Lucky Block: Pas Wacky Waves/Admin Abuse
• Radioactive Lucky Block: Event Radioactive
• UFO Lucky Block: Event UFO
• Alien Lucky Block: Beli pakai Robux
• Admin Lucky Block: P
