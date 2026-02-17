--[[ BRAINROT HUB by Xulur - RAYFIELD EDITION ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local T = game:GetService("TweenService")
local P = game.Players.LocalPlayer

-- Database brainrot (diringkas)
local R = {
    Cmn={"Noobini","Lirili","Tim Cheese","Frulli","Talpa","Svinino","Pipi Kiwi","Pipi Corni","Cmn LcKy"},
    Unc={"Trippi","Gangster","Bobrito","Boneca","Cacto","Ta Ta Ta","Tric Tric","67","Pipi Avocado","Unc LcKy"},
    Rr={"Cappuccino","Brr Brr","Trulimero","Bambini","Bananita","Perochello","Avocadini","Salamino","Penguino","Ti Ti Ti","Rr LcKy"},
    Ep={"Burbaloni","Chimpanzini","Ballerina","Chef","Lionel","Glorbo","Strawberrelli","Pandaccini","Sigma Boy","Pi Pi","Blueberrinni","Cocosini","Guesto","Ep LcKy"},
    Lg={"Frigo","Orangutini","Rhino","Bombardiro","Spioniro","Bombombini","Zibra","Tigrilini","Cavallo","Gorillo","Avocadorilla","Ganganzelli","Eaglucci","Lg LcKy"},
    Mth={"Cocofanto","Giraffa","Tralalero","Los Crocodillitos","Tigroligre","Udin","Trenostruzzo","Trippi Troppi","Orcalero","Piccione","Tukanno","Ballerino","Mth LcKy","Alien LcKy"},
    Cos={"La Vacca","Torrtuginni","Los Tralaleritos","Las Tralaleritas","Las Vaquitas","Graipuss","Pot Hotspot","Chicleteira","La Grande","Nuclearo","Garama","Dragon","Agarrini","Chimpanzini","Dariungini","Vroosh","Cos LcKy"},
    Sec={"Matteo","Gattatino","Statutino","Unclito","Gattatino Nyanino","Espresso","Los Tungtungtungcitos","Aura Farma","Rainbow 67","Fragola","Mastodontico","Capybara","Patatino","Onionello","Patito","Caffe Trinity","Eek Eek","Los Combinasionas","Sec LcKy","Radioactive LcKy","UFO LcKy"},
    Cel={"Job Job","Dug Dug","Bisonte","Alessio","Esok Sekolah","Rattini","Zung Zung","Money Elephant","Capuccino Policia","Los Orcaleritos","Avocadini Antilopini","Diamantusa","La Malita","Cel LcKy","Admin LcKy"},
    Div={"Galactio","Din Din","Strawberry Elephant","Grappellino","Martino","Burgerini","Bulbito","Div LcKy"},
    Inf={"Infinity LcKy","Infinity Brainrot"}
}

local function getRarity(n)
    local l=n:lower() for r,v in pairs(R) do for _,b in ipairs(v) do if l:find(b:lower())or b:lower():find(l)then return r end end end
end

local Cfg = {Farm=false,Fly=30,Under=0,Base=Vector3.new(0,5,50),Target="Cel",Wall=false,VIP=false,ESP=false}

-- Anti AFK
spawn(function()while wait(60)do pcall(function()if P.Character and P.Character:FindFirstChild("Humanoid")then P.Character.Humanoid:Move(Vector3.new(0,0,0),true)end end)end end)

-- Fly
local function F(p,d)
    if not P.Character or not P.Character:FindFirstChild("HumanoidRootPart")then return end
    local h=P.Character.HumanoidRootPart;T:Create(h,TweenInfo.new(d,Enum.EasingStyle.Linear),{CFrame=CFrame.new(p)}):Play();wait(d)
end

-- Cari target
local function target()
    for _,o in pairs(workspace:GetDescendants())do
        if o:IsA("BasePart")and o.Name and o.Parent and not o.Parent:IsA("Player")and getRarity(o.Name)==Cfg.Target then return o end
    end
end

-- Ambil
local function take(o)
    if not o or not P.Character then return end
    local h=P.Character.HumanoidRootPart
    if o:FindFirstChild("ClickDetector")then fireclickdetector(o.ClickDetector)
    elseif o:FindFirstChild("TouchInterest")then firetouchinterest(h,o,0)wait(0.05)firetouchinterest(h,o,1)
    else o.CFrame=h.CFrame*CFrame.new(0,-3,2)end
end

-- Farm loop
spawn(function()while wait(0.5)do if Cfg.Farm then pcall(function()
    if not P.Character then return end
    local h=P.Character.HumanoidRootPart;local t=target()
    if t then
        F(Vector3.new(h.Position.X,Cfg.Under,h.Position.Z),1)
        local tu=Vector3.new(t.Position.X,Cfg.Under,t.Position.Z)
        F(tu,(tu-Vector3.new(h.Position.X,Cfg.Under,h.Position.Z)).Magnitude/Cfg.Fly)
        F(t.Position,1);take(t);wait(0.5)
        F(Vector3.new(t.Position.X,Cfg.Under,t.Position.Z),1)
        local bu=Vector3.new(Cfg.Base.X,Cfg.Under,Cfg.Base.Z)
        F(bu,(bu-Vector3.new(t.Position.X,Cfg.Under,t.Position.Z)).Magnitude/Cfg.Fly)
        F(Cfg.Base,1)
    end
end)end end end)

-- Remove wall
spawn(function()while wait(1)do pcall(function()
    for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name then
        local n=o.Name:lower()
        if Cfg.Wall and(n:find("wall")or n:find("dinding")or n:find("pagar")or n:find("fence"))and not n:find("vip")then o.CanCollide=false o.Transparency=1 end
        if Cfg.VIP and(n:find("vip")or n:find("v.i.p"))then o.CanCollide=false o.Transparency=1 end
    end end
end)end end)

-- ESP colors
local col={Cmn=Color3.fromRGB(128,128,128),Unc=Color3.fromRGB(0,255,0),Rr=Color3.fromRGB(0,0,255),Ep=Color3.fromRGB(128,0,128),
Lg=Color3.fromRGB(255,165,0),Mth=Color3.fromRGB(255,192,203),Cos=Color3.fromRGB(0,255,255),Sec=Color3.fromRGB(255,0,255),
Cel=Color3.fromRGB(255,215,0),Div=Color3.fromRGB(255,0,0),Inf=Color3.fromRGB(255,255,255)}

-- ESP loop
spawn(function()while wait(2)do if Cfg.ESP then pcall(function()
    for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name and o.Parent and not o.Parent:IsA("Player")then
        local r=getRarity(o.Name)
        if r and col[r]then
            local h=Instance.new("Highlight")h.FillColor=col[r]h.OutlineColor=Color3.new(1,1,1)h.FillTransparency=0.5h.Parent=o
            local b=Instance.new("BillboardGui")b.Size=UDim2.new(0,150,0,30)b.StudsOffset=Vector3.new(0,2,0)b.AlwaysOnTop=true b.Parent=o
            local t=Instance.new("TextLabel",b)t.Size=UDim2.new(1,0,1,0)t.BackgroundTransparency=1 t.Text=o.Name t.TextColor3=col[r]t.TextScaled=true t.Font=Enum.Font.GothamBold
        end
    end end
end)end end end)

-- RAYFIELD WINDOW
local Window = Rayfield:CreateWindow({Name="🧠 Brainrot Hub • Xulur",LoadingTitle="Brainrot Hub",LoadingSubtitle="by Xulur",ConfigurationSaving={Enabled=true,FolderName="BrainrotHub",FileName="Config"},KeySystem=false})

-- HOME
local Home = Window:CreateTab("🏠 Home",nil)
local HomeSec = Home:CreateSection("Info")
HomeSec:CreateButton({Name="📱 Discord",Callback=function()setclipboard("discord.gg/brainrothub")Rayfield:Notify({Title="Copied!",Duration=1})end})

-- MAIN
local Main = Window:CreateTab("📋 Main",nil)
local FarmSec = Main:CreateSection("Auto Farm")
FarmSec:CreateToggle({Name="🚀 Auto Farm",CurrentValue=false,Flag="Farm",Callback=function(v)Cfg.Farm=v end})
FarmSec:CreateDropdown({Name="🎯 Target",Options={"Cmn","Unc","Rr","Ep","Lg","Mth","Cos","Sec","Cel","Div","Inf"},CurrentOption="Cel",Flag="Rarity",Callback=function(o)Cfg.Target=o end})
FarmSec:CreateSlider({Name="⚡ Speed",Range={10,50},Increment=5,CurrentValue=30,Flag="Speed",Callback=function(v)Cfg.Fly=v end})
FarmSec:CreateSlider({Name="📏 Depth",Range={0,20},Increment=1,CurrentValue=0,Flag="Depth",Callback=function(v)Cfg.Under=v end})
FarmSec:CreateInput({Name="📍 Base (X,Y,Z)",CurrentValue="0,5,50",Flag="Base",Callback=function(v)local x,y,z=v:match("([%d.-]+),?%s*([%d.-]+),?%s*([%d.-]+)")if x and y and z then Cfg.Base=Vector3.new(x+0,y+0,z+0)end end})

-- ESP
local ESPTab = Window:CreateTab("👁️ ESP",nil)
local ESPSec = ESPTab:CreateSection("ESP Settings")
ESPSec:CreateToggle({Name="Enable ESP",CurrentValue=false,Flag="ESP",Callback=function(v)Cfg.ESP=v end})

-- WALL
local Wall = Window:CreateTab("🧱 Walls",nil)
local WallSec = Wall:CreateSection("Remove")
WallSec:CreateToggle({Name="Remove Walls",CurrentValue=false,Flag="Wall",Callback=function(v)Cfg.Wall=v end})
WallSec:CreateToggle({Name="Remove VIP",CurrentValue=false,Flag="VIP",Callback=function(v)Cfg.VIP=v end})

-- INFO
local Info = Window:CreateTab("📊 Info",nil)
local InfoSec = Info:CreateSection("Lucky Info")
InfoSec:CreateParagraph({Title="Info",Content="• Cmn-Lg: Drop biasa\n• Mth: Drop Mythical\n• Cos: Drop Cosmic\n• Sec: Drop Secret\n• Cel: Wacky Waves\n• Div: Admin Abuse\n• Inf: Admin Abuse (langka)"})

Rayfield:LoadConfiguration()
Rayfield:Notify({Title="✅ Brainrot Hub Loaded!",Duration=2})
