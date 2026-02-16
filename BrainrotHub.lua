--[[
    BRAINROT HUB - BLUE GRADIENT EDITION
    Warna biru gradasi item, tombol - dan x abu-abu
    Tanpa shadow, tampilan clean
]]

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHub"
gui.Parent = game:GetService("CoreGui")  -- PAKAI CoreGui biar di atas
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999

-- ==================================================
-- KONFIGURASI
-- ==================================================
getgenv().C = {
    Bring = false, Money = false, God = false, Wall = false, VIP = false, ReduceLag = false,
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
-- BRING SYSTEM
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
                    o.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 15, hrp.Position.Z)
                    wait(0.03)
                end
            end
        end
    end
end) end end end)

-- ==================================================
-- COLLECT MONEY & EVENT
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
-- UI UTAMA - BIRU GRADASI
-- ==================================================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 450)
main.Position = UDim2.new(0.5, -300, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(8, 12, 20)  -- Biru gelap
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true

-- Header dengan gradasi biru
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(18, 30, 50)  -- Biru lebih terang
header.BorderSizePixel = 0

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 BRAINROT HUB"
title.TextColor3 = Color3.fromRGB(120, 200, 255)  -- Biru terang
title.TextXAlignment = "Left"
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- ==================================================
-- TOMBOL - dan X (ABU-ABU)
-- ==================================================
local minimize = Instance.new("TextButton", header)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -70, 0, 7)
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 70)  -- Abu-abu gelap
minimize.BorderSizePixel = 0
minimize.Text = "-"
minimize.TextColor3 = Color3.fromRGB(220, 220, 220)  -- Abu-abu terang
minimize.TextScaled = true
minimize.Font = Enum.Font.GothamBold

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 7)
close.BackgroundColor3 = Color3.fromRGB(80, 80, 90)  -- Abu-abu lebih terang
close.BorderSizePixel = 0
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextScaled = true
close.Font = Enum.Font.GothamBold

-- ==================================================
-- TOMBOL MINIMIZE (MUNCUL PAS DI-MINIMIZE)
-- ==================================================
local miniBtn = Instance.new("TextButton", gui)
miniBtn.Size = UDim2.new(0, 50, 0, 50)
miniBtn.Position = UDim2.new(1, -60, 1, -60)
miniBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 140)  -- Biru gelap
miniBtn.BorderSizePixel = 0
miniBtn.Text = "🧠"
miniBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
miniBtn.TextScaled = true
miniBtn.Font = Enum.Font.GothamBold
miniBtn.BackgroundTransparency = 0.1
miniBtn.Visible = false

-- Hover effect
miniBtn.MouseEnter:Connect(function() miniBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 200) end)
miniBtn.MouseLeave:Connect(function() miniBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 140) end)

-- Fungsi minimize
local minimized = false
minimize.MouseButton1Click:Connect(function()
    main.Visible = false
    miniBtn.Visible = true
    minimized = true
end)

miniBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    miniBtn.Visible = false
    minimized = false
end)

close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- ==================================================
-- MENU BAR
-- ==================================================
local mb = Instance.new("Frame", main)
mb.Size = UDim2.new(1, 0, 0, 40)
mb.Position = UDim2.new(0, 0, 0, 45)
mb.BackgroundColor3 = Color3.fromRGB(20, 30, 45)  -- Biru gelap
mb.BorderSizePixel = 0

local menus = {"🏠 HOME", "📋 MAIN", "🤖 AUTO", "⚡ PERF", "🛠️ MISC", "🌐 SERVER"}
local contents = {}

for i = 1, 6 do
    local btn = Instance.new("TextButton", mb)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = UDim2.new(0, 5 + (i-1)*100, 0, 0)
    btn.Text = menus[i]
    btn.TextColor3 = Color3.fromRGB(200, 220, 255)
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(30, 50, 80) or Color3.fromRGB(20, 35, 55)
    btn.BorderSizePixel = 0
    
    local cont = Instance.new("ScrollingFrame", main)
    cont.Size = UDim2.new(1, -20, 1, -130)
    cont.Position = UDim2.new(0, 10, 0, 90)
    cont.BackgroundTransparency = 1
    cont.Visible = i == 1
    cont.CanvasSize = UDim2.new(0,0,0,380)
    cont.ScrollBarThickness = 4
    cont.ScrollBarImageColor3 = Color3.fromRGB(80, 160, 255)  -- Biru scroll
    cont.BorderSizePixel = 0
    contents[i] = cont
    
    btn.MouseButton1Click:Connect(function()
        for j = 1, 6 do contents[j].Visible = false end
        for _, b in pairs(mb:GetChildren()) do 
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(20, 35, 55) end
        end
        cont.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    end)
end

-- ==================================================
-- FUNGSI TOGGLE (BIRU)
-- ==================================================
local function toggle(parent, text, y, def, cb)
    local bg = Instance.new("Frame", parent)
    bg.Size = UDim2.new(1, -20, 0, 40)
    bg.Position = UDim2.new(0, 10, 0, y)
    bg.BackgroundColor3 = Color3.fromRGB(18, 28, 42)  -- Biru gelap
    bg.BorderSizePixel = 0
    
    local l = Instance.new("TextLabel", bg)
    l.Size = UDim2.new(0, 160, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.Text = text
    l.TextColor3 = Color3.fromRGB(220, 235, 255)
    l.TextXAlignment = "Left"
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextSize = 15
    
    local btn = Instance.new("TextButton", bg)
    btn.Size = UDim2.new(0, 55, 0, 26)
    btn.Position = UDim2.new(1, -65, 0.5, -13)
    btn.BackgroundColor3 = def and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(60, 70, 90)  -- Biru ON, Abu OFF
    btn.Text = def and "ON" or "OFF"
    btn.TextColor3 = Color3.white
    btn.BorderSizePixel = 0
    
    local state = def
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(60, 70, 90)
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
d.BackgroundColor3 = Color3.fromRGB(50, 80, 140)  -- Biru discord
d.Text = "📱 JOIN DISCORD"
d.TextColor3 = Color3.white
d.Font = Enum.Font.GothamBold
d.BorderSizePixel = 0
d.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/brainrot") end)

local yt = Instance.new("TextButton", contents[1])
yt.Size = UDim2.new(1, -20, 0, 45)
yt.Position = UDim2.new(0, 10, 0, y+55)
yt.BackgroundColor3 = Color3.fromRGB(180, 40, 40)  -- Merah youtube (kontras)
yt.Text = "▶️ SUBSCRIBE YOUTUBE"
yt.TextColor3 = Color3.white
yt.Font = Enum.Font.GothamBold
yt.BorderSizePixel = 0
yt.MouseButton1Click:Connect(function() setclipboard("https://youtube.com/c/brainrot") end)

-- ==================================================
-- MAIN MENU
-- ==================================================
y = 10
y = toggle(contents[2], "🚀 Bring System", y, false, function(s) getgenv().C.Bring = s end)
y = toggle(contents[2], "💰 Collect Money", y, false, function(s) getgenv().C.Money = s end)

local rl = Instance.new("TextLabel", contents[2])
rl.Size = UDim2.new(1, -20, 0, 25)
rl.Position = UDim2.new(0, 10, 0, y)
rl.Text = "✨ RARITY FILTERS"
rl.TextColor3 = Color3.fromRGB(120, 200, 255)
rl.TextXAlignment = "Left"
rl.Font = Enum.Font.GothamBold
rl.BackgroundTransparency = 1
y = y + 30

local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Celestial", "Divine", "Infinity", "Lucky Blox"}
local rkeys = {"common", "unc", "rare", "epic", "leg", "cel", "div", "inf", "luck"}
for i = 1, 9 do
    local col = i % 2 == 1 and 0.02 or 0.52
    local row = math.floor((i-1)/2)
    local bg = Instance.new("Frame", contents[2])
    bg.Size = UDim2.new(0.45, 0, 0, 30)
    bg.Position = UDim2.new(col, 0, 0, y + row*35)
    bg.BackgroundColor3 = Color3.fromRGB(18, 28, 42)
    bg.BorderSizePixel = 0
    
    local l = Instance.new("TextLabel", bg)
    l.Size = UDim2.new(0, 90, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.Text = rarities[i]
    l.TextColor3 = Color3.fromRGB(200, 220, 255)
    l.TextXAlignment = "Left"
    l.BackgroundTransparency = 1
    l.TextSize = 12
    
    local b = Instance.new("TextButton", bg)
    b.Size = UDim2.new(0, 45, 0, 22)
    b.Position = UDim2.new(1, -50, 0.5, -11)
    b.BackgroundColor3 = Color3.fromRGB(0, 150, 255)  -- Biru ON
    b.Text = "ON"
    b.TextColor3 = Color3.white
    b.TextSize = 12
    b.BorderSizePixel = 0
    
    local state = true
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(60, 70, 90)
        b.Text = state and "ON" or "OFF"
        getgenv().C.Filter[rkeys[i]] = state
    end)
end

-- ==================================================
-- AUTO MENU
-- ==================================================
y = 10
y = toggle(contents[3], "💰 Money Event", y, false, function(s) getgenv().C.Event.m = s end)
y = toggle(contents[3], "🎮 Arcade Event", y, false, function(s) getgenv().C.Event.a = s end)
y = toggle(contents[3], "🍬 Candy Event", y, false, function(s) getgenv().C.Event.c = s end)
y = toggle(contents[3], "👽 UFO Event", y, false, function(s) getgenv().C.Event.u = s end)
y = toggle(contents[3], "☢️ Radioactive", y, false, function(s) getgenv().C.Event.r = s end)

-- ==================================================
-- PERF MENU
-- ==================================================
y = 10
y = toggle(contents[4], "⚡ Reduce Lag", y, false, function(s) getgenv().C.ReduceLag = s end)

-- ==================================================
-- MISC MENU
-- ==================================================
y = 10
y = toggle(contents[5], "🛡️ God Mode (2-3 wave)", y, false, function(s) getgenv().C.God = s end)
y = toggle(contents[5], "🧱 Remove Wall", y, false, function(s) getgenv().C.Wall = s end)
y = toggle(contents[5], "💎 Remove VIP Wall", y, false, function(s) getgenv().C.VIP = s end)

-- ==================================================
-- SERVER MENU
-- ==================================================
local af = Instance.new("Frame", contents[6])
af.Size = UDim2.new(1, -20, 0, 50)
af.Position = UDim2.new(0, 10, 0, 10)
af.BackgroundColor3 = Color3.fromRGB(18, 35, 25)  -- Hijau gelap (beda dikit)
af.BorderSizePixel = 0

local l = Instance.new("TextLabel", af)
l.Size = UDim2.new(0, 150, 1, 0)
l.Position = UDim2.new(0, 15, 0, 0)
l.Text = "🛡️ Anti AFK"
l.TextColor3 = Color3.fromRGB(200, 255, 200)
l.TextXAlignment = "Left"
l.BackgroundTransparency = 1
l.Font = Enum.Font.GothamBold
l.TextSize = 16

local st = Instance.new("Frame", af)
st.Size = UDim2.new(0, 55, 0, 28)
st.Position = UDim2.new(1, -65, 0.5, -14)
st.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
st.BorderSizePixel = 0

local cr = Instance.new("Frame", st)
cr.Size = UDim2.new(0, 22, 0, 22)
cr.Position = UDim2.new(1, -27, 0.5, -11)
cr.BackgroundColor3 = Color3.white
cr.BorderSizePixel = 0

local inf = Instance.new("TextLabel", contents[6])
inf.Size = UDim2.new(1, -20, 0, 30)
inf.Position = UDim2.new(0, 10, 0, 65)
inf.Text = "✓ Anti AFK selalu aktif (otomatis)"
inf.TextColor3 = Color3.fromRGB(100, 255, 100)
inf.BackgroundTransparency = 1
inf.TextXAlignment = "Left"

-- ==================================================
-- STATUS BAR
-- ==================================================
local sb = Instance.new("Frame", main)
sb.Size = UDim2.new(1, 0, 0, 25)
sb.Position = UDim2.new(0, 0, 1, -25)
sb.BackgroundColor3 = Color3.fromRGB(10, 18, 30)  -- Biru gelap
sb.BorderSizePixel = 0

local stx = Instance.new("TextLabel", sb)
stx.Size = UDim2.new(1, -10, 1, 0)
stx.Position = UDim2.new(0, 10, 0, 0)
stx.Text = "🟢 Anti AFK: ON • Bring: OFF"
stx.TextColor3 = Color3.fromRGB(100, 255, 200)
stx.TextXAlignment = "Left"
stx.BackgroundTransparency = 1
stx.TextSize = 12

spawn(function() while wait(0.5) do
    stx.Text = "🟢 Anti AFK: ON • Bring: " .. (getgenv().C.Bring and "ON" or "OFF")
end end)

print("✅ BRAINROT HUB - BLUE GRADIENT LOADED")
