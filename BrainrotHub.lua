--[[ BRAINROT HUB by Xulur ]]
local R=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local T=game:GetService("TweenService")
local P=game.Players.LocalPlayer
local U=game:GetService("UserInputService")
local ESP={}

--== BRAINROT DATABASE (HEX) ==--
local B={Cmn={"Noobini Cakenini","Lirili Larila","Tim Cheese","Frulli Frulla","Talpa Di Fero","Svinino Bombondino","Pipi Kiwi","Pipi Corni","Cmn LcKy"},Unc={"Trippi Troppi","Gangster Footera","Bobrito Bandito","Boneca Ambalabu","Cacto Hipopotamo","Ta Ta Ta Sahur","Tric Tric Baraboom","67","Pipi Avocado","Unc LcKy"},Rr={"Cappuccino Assassino","Brr Brr Patapim","Trulimero Trulicina","Bambini Crostini","Bananita Dolphinita","Perochello Lemonchello","Avocadini Guffo","Salamino Penguino","Penguino Cocosino","Ti Ti Ti Sahur","Rr LcKy"},Ep={"Burbaloni Luliloli","Chimpanzini Bananini","Ballerina Cappuccina","Chef Crabracadabra","Lionel Cactuseli","Glorbo Fruttodrillo","Strawberrelli Flamingelli","Pandaccini Bananini","Sigma Boy","Pi Pi Watermelon","Blueberrinni Octopussini","Cocosini Mama","Guesto Angelic","Ep LcKy"},Lg={"Frigo Camelo","Orangutini Ananasini","Rhino Toasterino","Bombardiro Crocodilo","Spioniro Golubiro","Bombombini Gusini","Zibra Zubra Zibralini","Tigrilini Watermelini","Cavallo Virtuoso","Gorillo Watermelondrillo","Avocadorilla","Ganganzelli Trulala","Eaglucci Cocosucci","Lg LcKy"},Myth={"Cocofanto Elefanto","Giraffa Celeste","Tralalero Tralala","Los Crocodillitos","Tigroligre Frutonni","Udin Din Din Dun","Trenostruzzo Turbo 3000","Trippi Troppi Troppa Trippa","Orcalero Orcala","Piccione Macchina","Tukanno Bananno","Ballerino Lololo","Myth LcKy","Alien LcKy"},Cos={"La Vacca Saturno","Torrtuginni Dragonfrutini","Los Tralaleritos","Las Tralaleritas","Las Vaquitas Saturnitas","Graipuss Medussi","Pot Hotspot","Chicleteira Bicicleteira","La Grande Combinasion","Nuclearo Dinossauro","Garama and Madundung","Dragon Cannelloni","Agarrini la Palini","Chimpanzini Spiderini","Dariungini Pandanneli","Vroosh Boosh","Cos LcKy"},Sec={"Matteo","Gattatino Neonino","Statutino Libertino","Unclito Samito","Gattatino Nyanino","Espresso Signora","Los Tungtungtungcitos","Aura Farma","Rainbow 67","Fragola La La La","Mastodontico Telepiedone","Capybara Monitora","Patatino Astronauta","Onionello Penguini","Patito Dinerito","Caffe Trinity","Eek Eek Eek Sahur","Los Combinasionas","Sec LcKy","Radioactive LcKy","UFO LcKy"},Cel={"Job Job Sahur","Dug Dug Dug","Bisonte Gupitere","Alessio","Esok Sekolah","Rattini Machini","Zung Zung Zung Lazur","Money Elephant","Capuccino Policia","Los Orcaleritos","Avocadini Antilopini","Diamantusa","La Malita","Cel LcKy","Admin LcKy"},Div={"Galactio Fantasma","Din Din Vaultero","Strawberry Elephant","Grappellino D'Oro","Martino Gravitino","Burgerini Bearini","Bulbito Bandito Traktorito","Div LcKy"},Inf={"Infinity LcKy","Infinity Brainrot"}}

--== RARITY CHECK ==--
local function G(n)local l=n:lower()for r,v in pairs(B)do for _,b in ipairs(v)do if l:find(b:lower())or b:lower():find(l)then return r end end end end

--== ESP FUNCTION ==--
local function E(o,r)if not o then return end
local c={Cmn=Color3.fromRGB(128,128,128),Unc=Color3.fromRGB(0,255,0),Rr=Color3.fromRGB(0,0,255),Ep=Color3.fromRGB(128,0,128),Lg=Color3.fromRGB(255,165,0),Myth=Color3.fromRGB(255,192,203),Cos=Color3.fromRGB(0,255,255),Sec=Color3.fromRGB(255,0,255),Cel=Color3.fromRGB(255,215,0),Div=Color3.fromRGB(255,0,0),Inf=Color3.fromRGB(255,255,255)}
local h=Instance.new("Highlight")h.FillColor=c[r]or Color3.new(1,1,1)h.OutlineColor=Color3.new(1,1,1)h.FillTransparency=0.5h.Parent=o
local b=Instance.new("BillboardGui")b.Size=UDim2.new(0,200,0,50)b.StudsOffset=Vector3.new(0,3,0)b.AlwaysOnTop=true b.Parent=o
local bg=Instance.new("Frame",b)bg.Size=UDim2.new(1,0,1,0)bg.BackgroundColor3=Color3.new(0,0,0)bg.BackgroundTransparency=0.3
local t=Instance.new("TextLabel",bg)t.Size=UDim2.new(1,0,0.6,0)t.Text=o.Name t.TextColor3=c[r]or Color3.new(1,1,1)t.TextScaled=true t.Font=Enum.Font.GothamBold
local rl=Instance.new("TextLabel",bg)rl.Size=UDim2.new(1,0,0.4,0)rl.Position=UDim2.new(0,0,0.6,0)rl.Text=r rl.TextColor3=Color3.new(1,1,1)rl.TextScaled=true rl.Font=Enum.Font.Gotham
table.insert(ESP,{obj=o,hl=h,bb=b})end

local function C()for _,e in ipairs(ESP)do pcall(function()e.hl:Destroy()e.bb:Destroy()end)end ESP={}end

local function U()if not Cfg.ESP then return end C()for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name and o.Parent and not o.Parent:IsA("Player")then local r=G(o.Name)if r then E(o,r)end end end end

--== CONFIG ==--
Cfg={Farm=false,Fly=30,Under=0,Base=Vector3.new(0,5,50),Target="Cel",Cmn=false,Unc=false,Rr=false,Ep=false,Lg=false,Myth=false,Cos=false,Sec=false,Cel=true,Div=false,Inf=false,Wall=false,VIP=false,ESP=false}

--== ANTI AFK ==--
spawn(function()while wait(60)do pcall(function()if P.Character and P.Character:FindFirstChild("Humanoid")then P.Character.Humanoid:Move(Vector3.new(0,0,0),true)end end)end end)

--== FLY ==--
local function F(p,d)if not P.Character or not P.Character:FindFirstChild("HumanoidRootPart")then return end
local h=P.Character.HumanoidRootPart
local tw=T:Create(h,TweenInfo.new(d,Enum.EasingStyle.Linear),{CFrame=CFrame.new(p)})tw:Play()tw.Completed:Wait()end

--== FIND TARGET ==--
local function FND()local t=Cfg.Target for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name and o.Parent and not o.Parent:IsA("Player")then if G(o.Name)==t then return o end end end end

--== TAKE ==--
local function TAKE(o)if not o then return end if not P.Character then return end local h=P.Character.HumanoidRootPart
if o:FindFirstChild("ClickDetector")then fireclickdetector(o.ClickDetector)
elseif o:FindFirstChild("TouchInterest")then firetouchinterest(h,o,0)wait(0.05)firetouchinterest(h,o,1)
else o.CFrame=h.CFrame*CFrame.new(0,-3,2)end
R:Notify({Title="✅ Taken!",Content=o.Name,Duration=1.5})end

--== FARM LOOP ==--
spawn(function()while wait(0.5)do if Cfg.Farm then pcall(function()if not P.Character then return end
local h=P.Character.HumanoidRootPart local b=Cfg.Base local u=Cfg.Under local t=FND()
if t then
F(Vector3.new(h.Position.X,u,h.Position.Z),1)
local tu=Vector3.new(t.Position.X,u,t.Position.Z)
F(tu,(tu-Vector3.new(h.Position.X,u,h.Position.Z)).Magnitude/Cfg.Fly)
F(t.Position,1)TAKE(t)wait(0.5)
F(Vector3.new(t.Position.X,u,t.Position.Z),1)
local bu=Vector3.new(b.X,u,b.Z)F(bu,(bu-Vector3.new(t.Position.X,u,t.Position.Z)).Magnitude/Cfg.Fly)F(b,1)
else R:Notify({Title="⚠️ Kosong",Content=Cfg.Target,Duration=2})wait(3)end end)end end end)

--== REMOVE WALL ==--
spawn(function()while wait(1)do pcall(function()for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name then local n=o.Name:lower()
if Cfg.Wall and(n:find("wall")or n:find("dinding")or n:find("tembok")or n:find("pagar")or n:find("fence"))and not n:find("vip")then o.CanCollide=false o.Transparency=1 end
if Cfg.VIP and(n:find("vip")or n:find("v.i.p"))then o.CanCollide=false o.Transparency=1 end end end end)end end)

--== ESP LOOP ==--
spawn(function()while wait(2)do if Cfg.ESP then pcall(U)end end end)

--== UI ==--
local W=R:CreateWindow({Name="🧠 BRAINROT HUB • Xulur",LoadingTitle="BRAINROT",LoadingSubtitle="Auto Farm + ESP",ConfigurationSaving={Enabled=true,FolderName="BrainrotHub",FileName="Config"},KeySystem=false})
local H=W:CreateTab("🏠 HOME")local HS=H:CreateSection("Xulur")
H:CreateButton({Name="📱 DISCORD",Callback=function()setclipboard("discord.gg/brainrothub")R:Notify({Title="Copied!",Duration=1})end})

local M=W:CreateTab("📋 MAIN")local MS=M:CreateSection("Auto Farm")
M:CreateToggle({Name="🚀 AUTO FARM",CurrentValue=false,Flag="Farm",Callback=function(v)Cfg.Farm=v end})
M:CreateDropdown({Name="🎯 TARGET",Options={"Cmn","Unc","Rr","Ep","Lg","Myth","Cos","Sec","Cel","Div","Inf"},CurrentOption="Cel",Flag="Rarity",Callback=function(o)Cfg.Target=o
Cfg.Cmn=(o=="Cmn")Cfg.Unc=(o=="Unc")Cfg.Rr=(o=="Rr")Cfg.Ep=(o=="Ep")Cfg.Lg=(o=="Lg")Cfg.Myth=(o=="Myth")Cfg.Cos=(o=="Cos")Cfg.Sec=(o=="Sec")Cfg.Cel=(o=="Cel")Cfg.Div=(o=="Div")Cfg.Inf=(o=="Inf")end})
M:CreateSlider({Name="⚡ SPEED",Range={10,50},Increment=5,CurrentValue=30,Flag="Speed",Callback=function(v)Cfg.Fly=v end})
M:CreateInput({Name="📍 BASE (X,Y,Z)",CurrentValue="0,5,50",Flag="Base",Callback=function(v)local x,y,z=v:match("([%d.-]+),?%s*([%d.-]+),?%s*([%d.-]+)")if x and y and z then Cfg.Base=Vector3.new(x+0,y+0,z+0)end end})

local X=W:CreateTab("🛠️ MISC")local XS=X:CreateSection("ESP & Tools")
X:CreateToggle({Name="👁️ ESP",CurrentValue=false,Flag="ESP",Callback=function(v)Cfg.ESP=v if v then U()else C()end end})
X:CreateParagraph({Title="🎨 WARNA ESP",Content="Cmn:Abu|Unc:Hijau|Rr:Biru|Ep:Ungu|Lg:Orange|Myth:Pink|Cos:Cyan|Sec:Magenta|Cel:Emas|Div:Merah|Inf:Putih"})

local WALL=W:CreateTab("🧱 WALLS")local WS=WALL:CreateSection("Remove")
WALL:CreateToggle({Name="🧱 WALLS",CurrentValue=false,Flag="Wall",Callback=function(v)Cfg.Wall=v end})
WALL:CreateToggle({Name="💎 VIP",CurrentValue=false,Flag="VIP",Callback=function(v)Cfg.VIP=v end})

local I=W:CreateTab("📊 INFO")local IS=I:CreateSection("Lucky Info")
I:CreateParagraph({Title="🎲 LUCKY BLOX",Content="Infinity: Admin Abuse\nCelestial: Wacky Waves\nDivine: Wacky/Admin\nRadioactive/UFO/Alien: Event"})

R:LoadConfiguration()print("✅ BRAINROT HUB by Xulur - LOADED")
