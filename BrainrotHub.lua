--[[ BRAINROT HUB by Xulur - LINORIA EDITION ]]

-- Load Linoria Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Linoria/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Linoria/LinoriaLib/main/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Linoria/LinoriaLib/main/SaveManager.lua"))()

local T = game:GetService("TweenService")
local P = game.Players.LocalPlayer
local U = game:GetService("UserInputService")
local ESP = {}

--== BRAINROT DATABASE ==--
local B = {
    Common = {"Noobini Cakenini","Lirili Larila","Tim Cheese","Frulli Frulla","Talpa Di Fero","Svinino Bombondino","Pipi Kiwi","Pipi Corni","Common Lucky Block"},
    Uncommon = {"Trippi Troppi","Gangster Footera","Bobrito Bandito","Boneca Ambalabu","Cacto Hipopotamo","Ta Ta Ta Sahur","Tric Tric Baraboom","67","Pipi Avocado","Uncommon Lucky Block"},
    Rare = {"Cappuccino Assassino","Brr Brr Patapim","Trulimero Trulicina","Bambini Crostini","Bananita Dolphinita","Perochello Lemonchello","Avocadini Guffo","Salamino Penguino","Penguino Cocosino","Ti Ti Ti Sahur","Rare Lucky Block"},
    Epic = {"Burbaloni Luliloli","Chimpanzini Bananini","Ballerina Cappuccina","Chef Crabracadabra","Lionel Cactuseli","Glorbo Fruttodrillo","Strawberrelli Flamingelli","Pandaccini Bananini","Sigma Boy","Pi Pi Watermelon","Blueberrinni Octopussini","Cocosini Mama","Guesto Angelic","Epic Lucky Block"},
    Legendary = {"Frigo Camelo","Orangutini Ananasini","Rhino Toasterino","Bombardiro Crocodilo","Spioniro Golubiro","Bombombini Gusini","Zibra Zubra Zibralini","Tigrilini Watermelini","Cavallo Virtuoso","Gorillo Watermelondrillo","Avocadorilla","Ganganzelli Trulala","Eaglucci Cocosucci","Legendary Lucky Block"},
    Mythical = {"Cocofanto Elefanto","Giraffa Celeste","Tralalero Tralala","Los Crocodillitos","Tigroligre Frutonni","Udin Din Din Dun","Trenostruzzo Turbo 3000","Trippi Troppi Troppa Trippa","Orcalero Orcala","Piccione Macchina","Tukanno Bananno","Ballerino Lololo","Mythical Lucky Block","Alien Lucky Block"},
    Cosmic = {"La Vacca Saturno","Torrtuginni Dragonfrutini","Los Tralaleritos","Las Tralaleritas","Las Vaquitas Saturnitas","Graipuss Medussi","Pot Hotspot","Chicleteira Bicicleteira","La Grande Combinasion","Nuclearo Dinossauro","Garama and Madundung","Dragon Cannelloni","Agarrini la Palini","Chimpanzini Spiderini","Dariungini Pandanneli","Vroosh Boosh","Cosmic Lucky Block"},
    Secret = {"Matteo","Gattatino Neonino","Statutino Libertino","Unclito Samito","Gattatino Nyanino","Espresso Signora","Los Tungtungtungcitos","Aura Farma","Rainbow 67","Fragola La La La","Mastodontico Telepiedone","Capybara Monitora","Patatino Astronauta","Onionello Penguini","Patito Dinerito","Caffe Trinity","Eek Eek Eek Sahur","Los Combinasionas","Secret Lucky Block","Radioactive Lucky Block","UFO Lucky Block"},
    Celestial = {"Job Job Sahur","Dug Dug Dug","Bisonte Gupitere","Alessio","Esok Sekolah","Rattini Machini","Zung Zung Zung Lazur","Money Elephant","Capuccino Policia","Los Orcaleritos","Avocadini Antilopini","Diamantusa","La Malita","Celestial Lucky Block","Admin Lucky Block"},
    Divine = {"Galactio Fantasma","Din Din Vaultero","Strawberry Elephant","Grappellino D'Oro","Martino Gravitino","Burgerini Bearini","Bulbito Bandito Traktorito","Divine Lucky Block"},
    Infinity = {"Infinity Lucky Block","Infinity Brainrot"}
}

--== RARITY CHECK ==--
local function getRarity(name)
    local l = name:lower()
    for rarity, list in pairs(B) do
        for _, brainrotName in ipairs(list) do
            if l:find(brainrotName:lower()) or brainrotName:lower():find(l) then
                return rarity
            end
        end
    end
    return nil
end

--== ESP FUNCTION ==--
local function createESP(obj, rarity)
    if not obj then return end
    
    local colors = {
        Common = Color3.fromRGB(128,128,128),
        Uncommon = Color3.fromRGB(0,255,0),
        Rare = Color3.fromRGB(0,0,255),
        Epic = Color3.fromRGB(128,0,128),
        Legendary = Color3.fromRGB(255,165,0),
        Mythical = Color3.fromRGB(255,192,203),
        Cosmic = Color3.fromRGB(0,255,255),
        Secret = Color3.fromRGB(255,0,255),
        Celestial = Color3.fromRGB(255,215,0),
        Divine = Color3.fromRGB(255,0,0),
        Infinity = Color3.fromRGB(255,255,255)
    }
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = colors[rarity] or Color3.new(1,1,1)
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.FillTransparency = 0.5
    highlight.Parent = obj
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0,200,0,50)
    billboard.StudsOffset = Vector3.new(0,3,0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj
    
    local bg = Instance.new("Frame", billboard)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.new(0,0,0)
    bg.BackgroundTransparency = 0.3
    
    local nameLabel = Instance.new("TextLabel", bg)
    nameLabel.Size = UDim2.new(1,0,0.6,0)
    nameLabel.Text = obj.Name
    nameLabel.TextColor3 = colors[rarity] or Color3.new(1,1,1)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    
    local rarityLabel = Instance.new("TextLabel", bg)
    rarityLabel.Size = UDim2.new(1,0,0.4,0)
    rarityLabel.Position = UDim2.new(0,0,0.6,0)
    rarityLabel.Text = rarity
    rarityLabel.TextColor3 = Color3.new(1,1,1)
    rarityLabel.TextScaled = true
    rarityLabel.Font = Enum.Font.Gotham
    
    table.insert(ESP, {obj = obj, hl = highlight, bb = billboard})
end

local function clearESP()
    for _, e in ipairs(ESP) do
        pcall(function()
            e.hl:Destroy()
            e.bb:Destroy()
        end)
    end
    ESP = {}
end

local function updateESP()
    if not _G.ESPEnabled then return end
    clearESP()
    for _, o in pairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Name and o.Parent and not o.Parent:IsA("Player") then
            local r = getRarity(o.Name)
            if r then createESP(o, r) end
        end
    end
end

--== CONFIG ==--
local Options = {
    Farm = false,
    FlySpeed = 30,
    UnderDepth = 0,
    BasePos = Vector3.new(0,5,50),
    TargetRarity = "Celestial",
    RemoveWalls = false,
    RemoveVIP = false
}

--== ANTI AFK ==--
spawn(function()
    while wait(60) do
        pcall(function()
            if P.Character and P.Character:FindFirstChild("Humanoid") then
                P.Character.Humanoid:Move(Vector3.new(0,0,0), true)
            end
        end)
    end
end)

--== FLY FUNCTION ==--
local function flyTo(targetPos, duration)
    if not P.Character or not P.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = P.Character.HumanoidRootPart
    local tween = T:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
    tween:Play()
    tween.Completed:Wait()
end

--== FIND TARGET ==--
local function findTarget()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
            if getRarity(obj.Name) == Options.TargetRarity then
                return obj
            end
        end
    end
    return nil
end

--== TAKE OBJECT ==--
local function takeObject(obj)
    if not obj then return end
    if not P.Character then return end
    local hrp = P.Character.HumanoidRootPart
    
    if obj:FindFirstChild("ClickDetector") then
        fireclickdetector(obj.ClickDetector)
    elseif obj:FindFirstChild("TouchInterest") then
        firetouchinterest(hrp, obj, 0)
        wait(0.05)
        firetouchinterest(hrp, obj, 1)
    else
        obj.CFrame = hrp.CFrame * CFrame.new(0,-3,2)
    end
end

--== FARM LOOP ==--
spawn(function()
    while wait(0.5) do
        if Options.Farm then
            pcall(function()
                if not P.Character then return end
                local hrp = P.Character.HumanoidRootPart
                local target = findTarget()
                
                if target then
                    -- Turun
                    flyTo(Vector3.new(hrp.Position.X, Options.UnderDepth, hrp.Position.Z), 1)
                    
                    -- Terbang ke target
                    local targetUnder = Vector3.new(target.Position.X, Options.UnderDepth, target.Position.Z)
                    local dist = (targetUnder - Vector3.new(hrp.Position.X, Options.UnderDepth, hrp.Position.Z)).Magnitude
                    flyTo(targetUnder, dist / Options.FlySpeed)
                    
                    -- Naik ke target
                    flyTo(target.Position, 1)
                    
                    -- Ambil
                    takeObject(target)
                    wait(0.5)
                    
                    -- Turun
                    flyTo(Vector3.new(target.Position.X, Options.UnderDepth, target.Position.Z), 1)
                    
                    -- Kembali ke base
                    local baseUnder = Vector3.new(Options.BasePos.X, Options.UnderDepth, Options.BasePos.Z)
                    local returnDist = (baseUnder - Vector3.new(target.Position.X, Options.UnderDepth, target.Position.Z)).Magnitude
                    flyTo(baseUnder, returnDist / Options.FlySpeed)
                    
                    -- Naik ke base
                    flyTo(Options.BasePos, 1)
                end
            end)
        end
    end
end)

--== REMOVE WALL ==--
spawn(function()
    while wait(1) do
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name then
                    local n = obj.Name:lower()
                    
                    if Options.RemoveWalls and (n:find("wall") or n:find("dinding") or n:find("tembok") or n:find("pagar") or n:find("fence")) and not n:find("vip") then
                        obj.CanCollide = false
                        obj.Transparency = 1
                    end
                    
                    if Options.RemoveVIP and (n:find("vip") or n:find("v.i.p")) then
                        obj.CanCollide = false
                        obj.Transparency = 1
                    end
                end
            end
        end)
    end
end)

--== ESP LOOP ==--
spawn(function()
    while wait(2) do
        if _G.ESPEnabled then
            pcall(updateESP)
        end
    end
end)

--== LINORIA WINDOW ==--
local Window = Library:CreateWindow({
    Title = "🧠 Brainrot Hub • Xulur",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

--== HOME TAB ==--
local HomeTab = Window:AddTab("🏠 Home")
local HomeGroup = HomeTab:AddLeftGroupbox("Info")

HomeGroup:AddButton({
    Text = "📱 Discord",
    Func = function()
        setclipboard("discord.gg/brainrothub")
        Library:Notify("Discord link copied!")
    end
})

--== MAIN TAB ==--
local MainTab = Window:AddTab("📋 Main")
local FarmGroup = MainTab:AddLeftGroupbox("Auto Farm")

FarmGroup:AddToggle("FarmToggle", {
    Text = "🚀 Auto Farm",
    Default = false,
    Callback = function(v) Options.Farm = v end
})

FarmGroup:AddDropdown("RarityDropdown", {
    Text = "🎯 Target Rarity",
    Values = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical", "Cosmic", "Secret", "Celestial", "Divine", "Infinity"},
    Default = 9, -- Celestial
    Callback = function(v) Options.TargetRarity = v end
})

FarmGroup:AddSlider("SpeedSlider", {
    Text = "⚡ Fly Speed",
    Default = 30,
    Min = 10,
    Max = 50,
    Rounding = 1,
    Callback = function(v) Options.FlySpeed = v end
})

FarmGroup:AddSlider("DepthSlider", {
    Text = "📏 Underground Depth",
    Default = 0,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Callback = function(v) Options.UnderDepth = v end
})

--== ESP TAB ==--
local ESPTab = Window:AddTab("👁️ ESP")
local ESPGroup = ESPTab:AddLeftGroupbox("ESP Settings")

ESPGroup:AddToggle("ESPToggle", {
    Text = "Enable ESP",
    Default = false,
    Callback = function(v)
        _G.ESPEnabled = v
        if v then updateESP() else clearESP() end
    end
})

--== WALL TAB ==--
local WallTab = Window:AddTab("🧱 Walls")
local WallGroup = WallTab:AddLeftGroupbox("Remove Obstacles")

WallGroup:AddToggle("WallToggle", {
    Text = "Remove Walls",
    Default = false,
    Callback = function(v) Options.RemoveWalls = v end
})

WallGroup:AddToggle("VIPToggle", {
    Text = "Remove VIP Barriers",
    Default = false,
    Callback = function(v) Options.RemoveVIP = v end
})

--== INFO TAB ==--
local InfoTab = Window:AddTab("📊 Info")
local InfoGroup = InfoTab:AddLeftGroupbox("Lucky Blox Info")

InfoGroup:AddLabel("🎲 Lucky Blox Types:")
InfoGroup:AddLabel("• Common s/d Legendary: Drop biasa")
InfoGroup:AddLabel("• Mythical: Drop Mythical")
InfoGroup:AddLabel("• Cosmic: Drop Cosmic")
InfoGroup:AddLabel("• Secret: Drop Secret")
InfoGroup:AddLabel("• Celestial: Wacky Waves")
InfoGroup:AddLabel("• Divine: Admin Abuse")
InfoGroup:AddLabel("• Infinity: Admin Abuse (langka)")
InfoGroup:AddLabel("• Radioactive/UFO: Event")

--== SETTINGS TAB (OTOMATIS DARI LINORIA) ==--
local SettingsTab = Window:AddTab("⚙️ Settings")
local MenuGroup = SettingsTab:AddLeftGroupbox("Menu Settings")

MenuGroup:AddButton({
    Text = "Toggle UI",
    Func = function() Library:ToggleUI() end
})

Library:SetWatermark("🧠 Brainrot Hub • Xulur")

-- Load managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetFolder("BrainrotHub")
ThemeManager:SetFolder("BrainrotHub")

SaveManager:BuildConfigSection(SettingsTab:AddLeftGroupbox("Configuration"))
ThemeManager:ApplyToGroupbox(MenuGroup)

-- Finish
Library:Notify("✅ Brainrot Hub Loaded!")
print("✅ BRAINROT HUB - LINORIA EDITION LOADED")
