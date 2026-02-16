--[[ BRAINROT HUB by Xulur - SPEED HUB UI ]]

-- Load Speed Hub
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()

-- Tunggu Speed Hub load
repeat wait() until _G.SpeedHubX and _G.SpeedHubX.CreateWindow

-- Setup variables
local T = game:GetService("TweenService")
local P = game.Players.LocalPlayer
local ESP = {}

--== BRAINROT DATABASE ==--
local RarityData = {
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
    for rarity, list in pairs(RarityData) do
        for _, brainrotName in ipairs(list) do
            if l:find(brainrotName:lower()) or brainrotName:lower():find(l) then
                return rarity
            end
        end
    end
    return nil
end

--== CONFIG ==--
local Config = {
    Farm = false,
    FlySpeed = 30,
    UnderDepth = 0,
    BasePos = Vector3.new(0,5,50),
    TargetRarity = "Celestial",
    RemoveWalls = false,
    RemoveVIP = false,
    ESPEnabled = false
}

--== CREATE WINDOW ==--
local Window = _G.SpeedHubX:CreateWindow({
    Name = "🧠 BRAINROT HUB",
    Subtitle = "by Xulur",
    LoadingTitle = "Loading...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotHub",
        FileName = "Config"
    }
})

--== HOME TAB ==--
local HomeTab = Window:CreateTab("🏠 HOME")
local HomeSection = HomeTab:CreateSection("Info")

HomeSection:CreateButton("📱 DISCORD", function()
    setclipboard("discord.gg/brainrothub")
    _G.SpeedHubX:Notify("Discord link copied!")
end)

--== FARM TAB ==--
local FarmTab = Window:CreateTab("⚙️ FARM")
local FarmSection = FarmTab:CreateSection("Auto Farm Settings")

FarmSection:CreateToggle("🚀 Auto Farm", function(value)
    Config.Farm = value
    _G.SpeedHubX:Notify(value and "Farm ON" or "Farm OFF")
end)

FarmSection:CreateDropdown("🎯 Target Rarity", {
    "Common", "Uncommon", "Rare", "Epic", "Legendary",
    "Mythical", "Cosmic", "Secret", "Celestial", "Divine", "Infinity"
}, function(option)
    Config.TargetRarity = option
end)

FarmSection:CreateSlider("⚡ Fly Speed", 10, 50, function(value)
    Config.FlySpeed = value
end)

FarmSection:CreateSlider("📏 Underground Depth", 0, 20, function(value)
    Config.UnderDepth = value
end)

--== ESP TAB ==--
local ESPTab = Window:CreateTab("👁️ ESP")
local ESPSection = ESPTab:CreateSection("ESP Settings")

ESPSection:CreateToggle("Enable ESP", function(value)
    Config.ESPEnabled = value
    _G.SpeedHubX:Notify(value and "ESP ON" or "ESP OFF")
end)

--== WALL TAB ==--
local WallTab = Window:CreateTab("🧱 WALLS")
local WallSection = WallTab:CreateSection("Remove Obstacles")

WallSection:CreateToggle("Remove Walls", function(value)
    Config.RemoveWalls = value
end)

WallSection:CreateToggle("Remove VIP", function(value)
    Config.RemoveVIP = value
end)

--== INFO TAB ==--
local InfoTab = Window:CreateTab("📊 INFO")
local InfoSection = InfoTab:CreateSection("Lucky Blox Info")

InfoSection:CreateLabel("• Common - Legendary: Drop biasa")
InfoSection:CreateLabel("• Mythical: Drop Mythical")
InfoSection:CreateLabel("• Cosmic: Drop Cosmic")
InfoSection:CreateLabel("• Secret: Drop Secret")
InfoSection:CreateLabel("• Celestial: Wacky Waves")
InfoSection:CreateLabel("• Divine: Admin Abuse")
InfoSection:CreateLabel("• Infinity: Admin Abuse (langka)")

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
            if getRarity(obj.Name) == Config.TargetRarity then
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
        if Config.Farm then
            pcall(function()
                if not P.Character then return end
                local hrp = P.Character.HumanoidRootPart
                local target = findTarget()
                
                if target then
                    -- Turun
                    flyTo(Vector3.new(hrp.Position.X, Config.UnderDepth, hrp.Position.Z), 1)
                    
                    -- Terbang ke target
                    local targetUnder = Vector3.new(target.Position.X, Config.UnderDepth, target.Position.Z)
                    local dist = (targetUnder - Vector3.new(hrp.Position.X, Config.UnderDepth, hrp.Position.Z)).Magnitude
                    flyTo(targetUnder, dist / Config.FlySpeed)
                    
                    -- Naik ke target
                    flyTo(target.Position, 1)
                    
                    -- Ambil
                    takeObject(target)
                    wait(0.5)
                    
                    -- Turun
                    flyTo(Vector3.new(target.Position.X, Config.UnderDepth, target.Position.Z), 1)
                    
                    -- Kembali ke base
                    local baseUnder = Vector3.new(Config.BasePos.X, Config.UnderDepth, Config.BasePos.Z)
                    local returnDist = (baseUnder - Vector3.new(target.Position.X, Config.UnderDepth, target.Position.Z)).Magnitude
                    flyTo(baseUnder, returnDist / Config.FlySpeed)
                    
                    -- Naik ke base
                    flyTo(Config.BasePos, 1)
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
                    
                    if Config.RemoveWalls and (n:find("wall") or n:find("dinding") or n:find("tembok") or n:find("pagar") or n:find("fence")) and not n:find("vip") then
                        obj.CanCollide = false
                        obj.Transparency = 1
                    end
                    
                    if Config.RemoveVIP and (n:find("vip") or n:find("v.i.p")) then
                        obj.CanCollide = false
                        obj.Transparency = 1
                    end
                end
            end
        end)
    end
end)

--== ESP FUNCTION ==--
local function updateESP()
    if not Config.ESPEnabled then return end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name and obj.Parent and not obj.Parent:IsA("Player") then
            local rarity = getRarity(obj.Name)
            if rarity then
                -- Color based on rarity
                local color
                if rarity == "Common" then color = Color3.fromRGB(128,128,128)
                elseif rarity == "Uncommon" then color = Color3.fromRGB(0,255,0)
                elseif rarity == "Rare" then color = Color3.fromRGB(0,0,255)
                elseif rarity == "Epic" then color = Color3.fromRGB(128,0,128)
                elseif rarity == "Legendary" then color = Color3.fromRGB(255,165,0)
                elseif rarity == "Mythical" then color = Color3.fromRGB(255,192,203)
                elseif rarity == "Cosmic" then color = Color3.fromRGB(0,255,255)
                elseif rarity == "Secret" then color = Color3.fromRGB(255,0,255)
                elseif rarity == "Celestial" then color = Color3.fromRGB(255,215,0)
                elseif rarity == "Divine" then color = Color3.fromRGB(255,0,0)
                elseif rarity == "Infinity" then color = Color3.fromRGB(255,255,255)
                end
                
                if color then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = color
                    highlight.OutlineColor = Color3.new(1,1,1)
                    highlight.FillTransparency = 0.5
                    highlight.Parent = obj
                    
                    local billboard = Instance.new("BillboardGui")
                    billboard.Size = UDim2.new(0,150,0,30)
                    billboard.StudsOffset = Vector3.new(0,2,0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = obj
                    
                    local text = Instance.new("TextLabel", billboard)
                    text.Size = UDim2.new(1,0,1,0)
                    text.BackgroundTransparency = 1
                    text.Text = obj.Name
                    text.TextColor3 = color
                    text.TextScaled = true
                    text.Font = Enum.Font.GothamBold
                    text.TextStrokeTransparency = 0.3
                end
            end
        end
    end
end

--== ESP LOOP ==--
spawn(function()
    while wait(2) do
        if Config.ESPEnabled then
            pcall(updateESP)
        end
    end
end)

-- Finish
_G.SpeedHubX:Notify("✅ Brainrot Hub Loaded!")
print("✅ BRAINROT HUB - SPEED HUB UI LOADED")
