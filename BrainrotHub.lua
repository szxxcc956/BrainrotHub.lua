--[[
    BRAINROT HUB - COMPRESSED EDITION (505 baris)
    6 Menu: HOME, MAIN, AUTO, PERF, MISC, SERVER
    Fitur: Bring Pattern M, Event Tokens, God Mode 2-3 wave, Anti AFK auto ON
]]

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHub"
gui.Parent = player:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
gui.ResetOnSpawn = false

-- ==================================================
-- KONFIGURASI
-- ==================================================
getgenv().C = {
    Bring = false, Money = false, God = false, Wall = false, VIP = false,
    Event = {m=false, a=false, c=false, u=false, r=false},
    Filter = {common=true, unc=true, rare=true, epic=true, leg=true, cel=true, div=true, inf=true, luck=true}
}

-- ==================================================
-- ANTI AFK (SELALU ON)
-- ==================================================
spawn(function() while wait(60) do 
    pcall(function() if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:Move(Vector3.new(0,0,0), true)
    end end)
end end)

-- ==================================================
-- BRING SYSTEM (PATTERN M)
-- ==================================================
spawn(function() while wait(0.3) do if getgenv().C.Bring then pcall(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        for _, o in pairs(workspace:GetDescendants()) do
            if o:IsA("BasePart") and o.Name then
                local n = o.Name:lower()
                local bring = false
                if (getgenv().C.Filter.common and n:find("common")) or (getgenv().C.Filter.unc and n:find("uncommon")) or
                   (getgenv().C.Filter.rare and n:find("rare")) or (getgenv().C.Filter.epic and n:find("epic")) or
                   (getgenv().C.Filter.leg and (n:find("legend") or n:find("leg"))) or
                   (getgenv().C.Filter.cel and (n:find("celestial") or n:find("celest"))) or
                   (getgenv().C.Filter.div and (n:find("divine") or n:find("div"))) or
                   (getgenv().C.Filter.inf and (n:find("infinity") or n:find("inf") or n:find("∞"))) or
                   (getgenv().C.Filter.luck and (n:find("lucky") or n:find("blox") or n:find("box"))) then
                    bring = true
                end
                if bring then
                    local t = tick() % 3
                    if t < 1 then o.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y-15, hrp.Position.Z)
                    elseif t < 2 then o.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y+10, hrp.Position.Z)
                    else o.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y-15, hrp.Position.Z) end
                    wait(0.03)
                end
            end
        end
    end
end) end end end)

-- ==================================================
-- COLLECT MONEY & EVENT TOKENS
-- ==================================================
spawn(function() while wait(0.5) do pcall(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        for _, o in pairs(workspace:GetDescendants()) do
            if o:IsA("BasePart") and o.Name then
                local n = o.Name:lower()
                if (getgenv().C.Money and (n:find("coin") or n:find("cash") or n:find("money"))) or
                   (getgenv().C.Event.m and n:find("money")) or (getgenv().C.Event.a and n:find("arcade")) or
                   (getgenv().C.Event.c and (n:find("candy") or n:find("sweet"))) or
                   (getgenv().C.Event.u and (n:find("ufo") or n:find("alien"))) or
                   (getgenv().C.Event.r and (n:find("radio") or n:find("nuklir"))) then
                    o.CFrame = hrp.CFrame * CFrame.new(0, -5, 3)
                    wait(0.03)
                end
            end
        end
    end
end) end end)

-- ==================================================
-- REMOVE WALL
-- ==================================================
spawn(function() while wait(2) do pcall(function()
    for _, o in pairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Name then
            local n = o.Name:lower()
            if getgenv().C.Wall and n:find("wall") and not n:find("vip") then o.CanCollide = false o.Transparency = 0.8 end
            if getgenv().C.VIP and (n:find("vip") or n:find("v.i.p")) then o.CanCollide = false o.Transparency = 0.8 end
        end
    end
end) end end)

-- ==================================================
-- GOD MODE (2-3 WAVE)
-- ==================================================
spawn(function() local wave = 0 while wait(1) do if getgenv().C.God then pcall(function()
    for _, o in pairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and (o.Name:lower():find("water") or o.Name:lower():find("wave")) then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                if (o.Position - hrp.Position).Magnitude < 20 then
                    wave = wave + 1
                    if wave <= 3 then hrp.Velocity = Vector3.new(0,50,0)
                    else getgenv().C.God = false wave = 0 end
                end
            end
        end
    end
end) end end end)

-- ==================================================
-- REDUCE LAG
-- ==================================================
spawn(function() while wait(3) do if getgenv().C.ReduceLag then pcall(function()
    settings().Rendering.QualityLevel = 1
    game:GetService("Lighting").GlobalShadows = false
    for _, o in pairs(workspace:GetDescendants()) do
        if o:IsA("ParticleEmitter") or o:IsA("Smoke") or o:IsA("Fire") then o.Enabled = false end
    end
end) end end end)

-- ==================================================
-- UI FRAME
-- ==================================================
local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0, 600, 0, 400)
f.Position = UDim2.new(0.5, -300, 0.8, -200)
f.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
f.Active = true; f.Draggable = true

local h = Instance.new("Frame", f)
h.Size = UDim2.new(1, 0, 0, 40)
h.BackgroundColor3 = Color3.fromRGB(18, 18, 25)

local t = Instance.new("TextLabel", h)
t.Size = UDim2.new(1, -40, 1, 0)
t.Position = UDim2.new(0, 10, 0, 0)
t.BackgroundTransparency = 1
t.Text = "🧠 BRAINROT HUB • ULTIMATE"
t.TextColor3 = Color3.fromRGB(100, 200, 255)
t.TextXAlignment = "Left"
t.Font = Enum.Font.GothamBold
t.TextSize = 18

local c = Instance.new("TextButton", h)
c.Size = UDim2.new(0, 30, 0, 30)
c.Position = UDim2.new(1, -35, 0, 5)
c.BackgroundColor3 = Color3.fromRGB(210, 60, 60)
c.Text = "✕"
c.TextColor3 = Color3.white
c.MouseButton1Click:Connect(function() gui:Destroy() end)

-- ==================================================
-- MENU BAR
-- ==================================================
local mb = Instance.new("Frame", f)
mb.Size = UDim2.new(1, 0, 0, 35)
mb.Position = UDim2.new(0, 0, 0, 40)
mb.BackgroundColor3 = Color3.fromRGB(22, 22, 30)

local menus = {"🏠 HOME", "📋 MAIN", "🤖 AUTO", "⚡ PERF", "🛠️ MISC", "🌐 SERVER"}
local contents = {}

for i = 1, 6 do
    local btn = Instance.new("TextButton", mb)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = UDim2.new(0, 5 + (i-1)*100, 0, 0)
    btn.Text = menus[i]
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(45,45,60) or Color3.fromRGB(28,28,38)
    
    local cont = Instance.new("ScrollingFrame", f)
    cont.Size = UDim2.new(1, -20, 1, -120)
    cont.Position = UDim2.new(0, 10, 0, 85)
    cont.BackgroundTransparency = 1
    cont.Visible = i == 1
    cont.CanvasSize = UDim2.new(0,0,0,380)
    cont.ScrollBarThickness = 4
    cont.ScrollBarImageColor3 = Color3.fromRGB(100,180,255)
    contents[i] = cont
    
    btn.MouseButton1Click:Connect(function()
        for j = 1, 6 do contents[j].Visible = false end
        for j, b in ipairs(mb:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(28,28,38) end end
        cont.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(45,45,60)
    end)
end

-- ==================================================
-- FUNGSI TOGGLE
-- ==================================================
local function tog(parent, text, y, def, cb)
    local bg = Instance.new("Frame", parent)
    bg.Size = UDim2.new(1, -20, 0, 40)
    bg.Position = UDim2.new(0, 10, 0, y)
    bg.BackgroundColor3 = Color3.fromRGB(25,25,35)
    
    local l = Instance.new("TextLabel", bg)
    l.Size = UDim2.new(0, 160, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.Text = text
    l.TextColor3 = Color3.white
    l.TextXAlignment = "Left"
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextSize = 15
    
    local btn = Instance.new("TextButton", bg)
    btn.Size = UDim2.new(0, 55, 0, 26)
    btn.Position = UDim2.new(1, -65, 0.5, -13)
    btn.BackgroundColor3 = def and Color3.fromRGB(0,170,0) or Color3.fromRGB(75,75,85)
    btn.Text = def and "ON" or "OFF"
    btn.TextColor3 = Color3.white
    
    local state = def
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(75,75,85)
        btn.Text = state and "ON" or "OFF"
        cb(state)
    end)
    return y + 45
end

-- ==================================================
-- HOME MENU
-- ==================================================
local y = 10
local d = Instance.new("TextButton", contents[1])
d.Size = UDim2.new(1, -20, 0, 45)
d.Position = UDim2.new(0, 10, 0, y)
d.BackgroundColor3 = Color3.fromRGB(88,101,242)
d.Text = "📱 JOIN DISCORD"
d.TextColor3 = Color3.white
d.Font = Enum.Font.GothamBold
d.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/brainrot") end)

local yt = Instance.new("TextButton", contents[1])
yt.Size = UDim2.new(1, -20, 0, 45)
yt.Position = UDim2.new(0, 10, 0, y+55)
yt.BackgroundColor3 = Color3.fromRGB(255,0,0)
yt.Text = "▶️ SUBSCRIBE YOUTUBE"
yt.TextColor3 = Color3.white
yt.Font = Enum.Font.GothamBold
yt.MouseButton1Click:Connect(function() setclipboard("https://youtube.com/c/brainrot") end)

-- ==================================================
-- MAIN MENU (Bring + Money + Rarity)
-- ==================================================
y = 10
y = tog(contents[2], "🚀 Bring System", y, false, function(s) getgenv().C.Bring = s end)
y = tog(contents[2], "💰 Collect Money", y, false, function(s) getgenv().C.Money = s end)

local rl = Instance.new("TextLabel", contents[2])
rl.Size = UDim2.new(1, -20, 0, 25)
rl.Position = UDim2.new(0, 10, 0, y)
rl.Text = "✨ RARITY FILTERS"
rl.TextColor3 = Color3.fromRGB(160,160,255)
rl.TextXAlignment = "Left"
rl.Font = Enum.Font.GothamBold
rl.BackgroundTransparency = 1
y = y + 30

local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Celestial", "Divine", "Infinity", "Lucky Blox"}
local rkeys = {"common", "unc", "rare", "epic", "leg", "cel", "div", "inf", "luck"}
local rx = 0
for i = 1, 9 do
    local col = i % 2 == 1 and 0.02 or 0.52
    local row = math.floor((i-1)/2)
    local bg = Instance.new("Frame", contents[2])
    bg.Size = UDim2.new(0.45, 0, 0, 30)
    bg.Position = UDim2.new(col, 0, 0, y + row*35)
    bg.BackgroundColor3 = Color3.fromRGB(22,22,30)
    
    local l = Instance.new("TextLabel", bg)
    l.Size = UDim2.new(0, 90, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.Text = rarities[i]
    l.TextColor3 = Color3.fromRGB(220,220,220)
    l.TextXAlignment = "Left"
    l.BackgroundTransparency = 1
    l.TextSize = 12
    
    local b = Instance.new("TextButton", bg)
    b.Size = UDim2.new(0, 45, 0, 22)
    b.Position = UDim2.new(1, -50, 0.5, -11)
    b.BackgroundColor3 = Color3.fromRGB(0,170,0)
    b.Text = "ON"
    b.TextColor3 = Color3.white
    b.TextSize = 12
    
    local state = true
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(75,75,85)
        b.Text = state and "ON" or "OFF"
        getgenv().C.Filter[rkeys[i]] = state
    end)
end
y = y + 170

-- ==================================================
-- AUTO MENU (Event Tokens)
-- ==================================================
y = 10
local events = {"💰 Money Event", "🎮 Arcade Event", "🍬 Candy Event", "👽 UFO Event", "☢️ Radioactive"}
local ekeys = {"m", "a", "c", "u", "r"}
for i = 1, 5 do
    y = tog(contents[3], events[i], y, false, function(s) getgenv().C.Event[ekeys[i]] = s end)
end

-- ==================================================
-- PERF MENU
-- ==================================================
y = 10
y = tog(contents[4], "⚡ Reduce Lag", y, false, function(s) getgenv().C.ReduceLag = s end)

-- ==================================================
-- MISC MENU
-- ==================================================
y = 10
y = tog(contents[5], "🛡️ God Mode (2-3 wave)", y, false, function(s) getgenv().C.God = s end)
y = tog(contents[5], "🧱 Remove Wall", y, false, function(s) getgenv().C.Wall = s end)
y = tog(contents[5], "💎 Remove VIP Wall", y, false, function(s) getgenv().C.VIP = s end)

-- ==================================================
-- SERVER MENU (Anti AFK)
-- ==================================================
local af = Instance.new("Frame", contents[6])
af.Size = UDim2.new(1, -20, 0, 50)
af.Position = UDim2.new(0, 10, 0, 10)
af.BackgroundColor3 = Color3.fromRGB(25,35,25)

local l = Instance.new("TextLabel", af)
l.Size = UDim2.new(0, 150, 1, 0)
l.Position = UDim2.new(0, 15, 0, 0)
l.Text = "🛡️ Anti AFK"
l.TextColor3 = Color3.white
l.TextXAlignment = "Left"
l.BackgroundTransparency = 1
l.Font = Enum.Font.GothamBold
l.TextSize = 16

local st = Instance.new("Frame", af)
st.Size = UDim2.new(0, 55, 0, 28)
st.Position = UDim2.new(1, -65, 0.5, -14)
st.BackgroundColor3 = Color3.fromRGB(0,200,0)

local cr = Instance.new("Frame", st)
cr.Size = UDim2.new(0, 22, 0, 22)
cr.Position = UDim2.new(1, -27, 0.5, -11)
cr.BackgroundColor3 = Color3.white

local inf = Instance.new("TextLabel", contents[6])
inf.Size = UDim2.new(1, -20, 0, 30)
inf.Position = UDim2.new(0, 10, 0, 65)
inf.Text = "✓ Anti AFK selalu aktif (otomatis)"
inf.TextColor3 = Color3.fromRGB(100,255,100)
inf.BackgroundTransparency = 1
inf.TextXAlignment = "Left"

-- ==================================================
-- STATUS BAR
-- ==================================================
local sb = Instance.new("Frame", f)
sb.Size = UDim2.new(1, 0, 0, 25)
sb.Position = UDim2.new(0, 0, 1, -25)
sb.BackgroundColor3 = Color3.fromRGB(10,10,15)

local stx = Instance.new("TextLabel", sb)
stx.Size = UDim2.new(1, -10, 1, 0)
stx.Position = UDim2.new(0, 10, 0, 0)
stx.Text = "🟢 Anti AFK: ON • Bring: OFF"
stx.TextColor3 = Color3.fromRGB(0,255,100)
stx.TextXAlignment = "Left"
stx.BackgroundTransparency = 1
stx.TextSize = 12

spawn(function() while wait(0.5) do
    stx.Text = "🟢 Anti AFK: ON • Bring: " .. (getgenv().C.Bring and "ON" or "OFF")
end end)

print("✅ BRAINROT HUB LOADED - 505 LINES")
