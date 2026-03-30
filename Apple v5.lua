local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "🍎 Apple Hub | V5 Banana Killer (GOD)",
    SubTitle = "By Quoc Hoa",
    TabWidth = 180, Size = UDim2.fromOffset(600, 540), Acrylic = true, Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl 
})

-- [[ HỆ THỐNG BIẾN ĐIỀU KHIỂN ]]
_G.AutoFarm = false
_G.AutoChest = false
_G.BringMob = true
_G.FastAttack = true
_G.AutoStats = false
_G.StatPoint = "Melee"
_G.SelectWeapon = "Melee"
_G.AutoRaid = false
_G.InfiniteDash = false
_G.AutoMaterial = false
_G.SelectMaterial = ""

-- [[ TỔNG HỢP CÁC TAB ]]
local Tabs = {
    Home = Window:AddTab({ Title = "Tab Home", Icon = "home" }),
    Farming = Window:AddTab({ Title = "Tab Farming", Icon = "shovels" }),
    Setting = Window:AddTab({ Title = "Tab Setting", Icon = "settings" }),
    Fishing = Window:AddTab({ Title = "Tab Fishing", Icon = "fish" }),
    QuestItem = Window:AddTab({ Title = "Tab Quest And Item", Icon = "clipboard-list" }),
    SeaEvent = Window:AddTab({ Title = "Tab Sea Event", Icon = "waves" }),
    MirageRace = Window:AddTab({ Title = "Tab Mirage And Race", Icon = "compass" }),
    VolcanoEvent = Window:AddTab({ Title = "Tab Volcano Event", Icon = "flame" }),
    StatsEsp = Window:AddTab({ Title = "Tab Stats And Esp", Icon = "bar-chart" }),
    FruitRaid = Window:AddTab({ Title = "Tab Fruit And Raid", Icon = "zap" })
}

-- ============================================
-- TAB FARMING - GIỐNG Y HỆT ẢNH
-- ============================================

-- Search section or Function
Tabs.Farming:AddParagraph({
    Title = "🔍 Search section or Function",
    Content = ""
})

-- Ô tìm kiếm
Tabs.Farming:AddInput("SearchInput", {
    Title = "",
    Default = "",
    Placeholder = "Nhập từ khóa tìm kiếm...",
    Callback = function(Value)
        if Value ~= "" then
            Fluent:Notify({
                Title = "🔍 Tìm kiếm",
                Content = "Đang tìm: " .. Value,
                Duration = 2
            })
        end
    end
})

-- Danh sách Tab (dạng chip)
Tabs.Farming:AddParagraph({
    Title = "",
    Content = "┌─────────────────────────────────────────────────┐"
})
Tabs.Farming:AddParagraph({
    Title = "",
    Content = " Tab Home    Tab Farming    Tab Setting    Tab Fishing"
})
Tabs.Farming:AddParagraph({
    Title = "",
    Content = " Tab Quest And Item    Tab Sea Event    Tab Mirage And Race"
})
Tabs.Farming:AddParagraph({
    Title = "",
    Content = " Tab Volcano Event    Tab Stats And Esp    Tab Fruit And Raid"
})
Tabs.Farming:AddParagraph({
    Title = "",
    Content = "└─────────────────────────────────────────────────┘"
})

-- Main Section
Tabs.Farming:AddSection("Main")

-- Select Weapon: Melee (dạng button chứ ko phải dropdown để giống ảnh)
local WeaponBtn = Tabs.Farming:AddButton({
    Title = "Select Weapon: Melee",
    Callback = function()
        local weapons = {"Melee", "Sword", "Blox Fruit"}
        local current = _G.SelectWeapon
        local idx = 0
        for i, v in ipairs(weapons) do
            if v == current then idx = i end
        end
        local nextIdx = idx % #weapons + 1
        _G.SelectWeapon = weapons[nextIdx]
        WeaponBtn:SetTitle("Select Weapon: " .. _G.SelectWeapon)
        Fluent:Notify({
            Title = "⚔️ Vũ khí",
            Content = "Đã chọn: " .. _G.SelectWeapon,
            Duration = 1
        })
    end
})
WeaponBtn:SetTitle("Select Weapon: " .. _G.SelectWeapon)

-- Select Fast Delay Last Attack (dạng button)
local DelayBtn = Tabs.Farming:AddButton({
    Title = "Select Fast Delay Last Attack: 0.2s",
    Callback = function()
        local delays = {"0.1s", "0.2s", "0.3s", "0.5s", "0.7s", "1s"}
        local current = "0.2s"
        local idx = 1
        DelayBtn:SetTitle("Select Fast Delay Last Attack: " .. delays[(idx % #delays) + 1])
    end
})
DelayBtn:SetTitle("Select Fast Delay Last Attack: 0.2s")

-- Auto Farm Level Section
Tabs.Farming:AddSection("Auto Farm Level")

-- Auto Farm Nearest
local FarmNearest = Tabs.Farming:AddToggle("AutoFarmNearest", {
    Title = "Auto Farm Nearest",
    Default = false
})
FarmNearest:OnChanged(function()
    _G.AutoFarm = FarmNearest.Value
end)

-- Auto Factory Raid
local FactoryRaid = Tabs.Farming:AddToggle("Auto Factory Raid", {
    Title = "Auto Factory Raid",
    Default = false
})
FactoryRaid:OnChanged(function()
    if FactoryRaid.Value then
        Fluent:Notify({Title = "🏭 Factory", Content = "Auto Factory Raid đã bật", Duration = 2})
    end
end)

-- Auto Pirate Raid
local PirateRaid = Tabs.Farming:AddToggle("Auto Pirate Raid", {
    Title = "Auto Pirate Raid",
    Default = false
})
PirateRaid:OnChanged(function()
    if PirateRaid.Value then
        Fluent:Notify({Title = "🏴‍☠️ Pirate", Content = "Auto Pirate Raid đã bật", Duration = 2})
    end
end)

-- Thêm Auto Chest (giữ từ bản gốc)
local ChestToggle = Tabs.Farming:AddToggle("Auto Chest", {
    Title = "Auto Chest",
    Default = false
})
ChestToggle:OnChanged(function()
    _G.AutoChest = ChestToggle.Value
end)

-- ============================================
-- TAB QUEST AND ITEM
-- ============================================
Tabs.QuestItem:AddSection("Farm Material")

Tabs.QuestItem:AddDropdown("SelectMaterial", {
    Title = "Chọn Nguyên Liệu",
    Values = {
        "Magma Ore", "Leather", "Fish Tail", 
        "Mystic Droplet", "Vampire Fang", "Radioactive Material",
        "Dragon Scale", "Conjured Cocoa", "Bones"
    },
    Default = "Bones",
    Callback = function(Value)
        _G.SelectMaterial = Value
    end
})

local MatToggle = Tabs.QuestItem:AddToggle("AutoMat", {
    Title = "Auto Farm Nguyên Liệu",
    Default = false
})
MatToggle:OnChanged(function()
    _G.AutoMaterial = MatToggle.Value
end)

-- ============================================
-- TAB SETTING
-- ============================================
Tabs.Setting:AddSection("Player Settings")

local DashToggle = Tabs.Setting:AddToggle("InfDash", {
    Title = "Vô Hạn Dash (Lướt)",
    Default = false
})
DashToggle:OnChanged(function()
    _G.InfiniteDash = DashToggle.Value
end)

Tabs.Setting:AddSlider("WalkSpeed", {
    Title = "Tốc Độ Chạy",
    Default = 20,
    Min = 20,
    Max = 300,
    Rounding = 0,
    Callback = function(V)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V
        end
    end
})

Tabs.Setting:AddButton({
    Title = "Server Hop",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- ============================================
-- TAB FRUIT AND RAID
-- ============================================
Tabs.FruitRaid:AddSection("Raid & Fruit")

local RaidToggle = Tabs.FruitRaid:AddToggle("AutoRaid", {
    Title = "Auto Start & Kill Raid",
    Default = false
})
RaidToggle:OnChanged(function()
    _G.AutoRaid = RaidToggle.Value
end)

Tabs.FruitRaid:AddButton({
    Title = "Auto Nhặt Fruit",
    Callback = function()
        for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:IsA("Tool") and v.Name:find("Fruit") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                task.wait(0.1)
            end
        end
    end
})

-- ============================================
-- TAB COMBAT TOOLS
-- ============================================
local CombatTab = Window:AddTab({ Title = "Combat Tools", Icon = "swords" })
CombatTab:AddSection("Combat Settings")

local BringMobToggle = CombatTab:AddToggle("BringMob", {
    Title = "Gom Quái (Bring Mob)",
    Default = true
})
BringMobToggle:OnChanged(function()
    _G.BringMob = BringMobToggle.Value
end)

local FastAttackToggle = CombatTab:AddToggle("FastAttack", {
    Title = "Fast Attack (Đánh nhanh)",
    Default = true
})
FastAttackToggle:OnChanged(function()
    _G.FastAttack = FastAttackToggle.Value
end)

-- ============================================
-- HỆ THỐNG LOGIC VẬN HÀNH (GIỮ NGUYÊN)
-- ============================================

task.spawn(function()
    while true do
        task.wait()
        if _G.AutoFarm or _G.AutoMaterial then
            pcall(function()
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(50, 50))
                
                if _G.BringMob then
                    local enemies = game:GetService("Workspace").Enemies:GetChildren()
                    for _, v in pairs(enemies) do
                        if not (_G.AutoFarm or _G.AutoMaterial) then break end
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                            v.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.15)
        if _G.AutoChest then
            local chests = game:GetService("Workspace"):GetChildren()
            for i, v in pairs(chests) do
                if not _G.AutoChest then break end
                if v.Name:find("Chest") and v:IsA("BasePart") then
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.2)
                    end)
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.InfiniteDash then
            pcall(function()
                if getrenv()._G.Characters.Dash then
                    debug.setupvalue(getrenv()._G.Characters.Dash, 3, 0)
                end
            end)
        end
    end
end)

-- ============================================
-- NÚT TRÒN 🍎
-- ============================================
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "AppleHubButton"
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 200)
ToggleButton.Text = "🍎"
ToggleButton.TextSize = 30
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Draggable = true
local UICorner = Instance.new("UICorner", ToggleButton)
UICorner.CornerRadius = UDim.new(1, 0)

ToggleButton.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
    task.wait(0.01)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)

-- ============================================
-- KHỞI TẠO
-- ============================================
Window:SelectTab(Tabs.Farming)
Fluent:Notify({
    Title = "🍎 Apple Hub V5",
    Content = "✅ Giao diện Tab Farming đã giống ảnh!",
    Duration = 5
})
