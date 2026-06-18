-- [[ Panda Hub Ultra | Ultimate Smooth Edition 2026 ]]
-- [[ Coded for Maximum Performance & Flawless UI/UX ]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local VunixLib = {}

-- 🎨 ثيم الباندا الاحترافي (ألوان مريحة وفخمة جداً)
local Theme = {
    Background = Color3.fromRGB(12, 12, 14),       -- أسود عميق للخلفية
    Sidebar = Color3.fromRGB(18, 18, 20),          -- رمادي داكن للقائمة
    ElementBg = Color3.fromRGB(24, 24, 27),        -- خلفية العناصر
    Hover = Color3.fromRGB(32, 32, 36),            -- لون عند لمس العنصر
    Text = Color3.fromRGB(255, 255, 255),          -- أبيض ناصع
    SubText = Color3.fromRGB(140, 140, 145),       -- رمادي خفيف للنصوص الثانوية
    Accent = Color3.fromRGB(74, 222, 128),         -- أخضر بامبو فاقع (جميل جداً)
    Danger = Color3.fromRGB(250, 90, 90)           -- أحمر للتحذيرات والإغلاق
}

-- 🛡️ نظام حماية لضمان ظهور الـ UI في جميع المحاكيات
local function GetSafeFolder()
    local success, folder = pcall(function() return gethui() end)
    if success and folder then return folder end
    success, folder = pcall(function() return game:GetService("CoreGui") end)
    if success and folder then return folder end
    return Player:WaitForChild("PlayerGui")
end

-- 🪄 نظام أنميشن فائق السلاسة
local function SmoothTween(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

-- 🚀 دالة بناء الواجهة الأساسية
function VunixLib:CreateWindow(Config)
    local Title = Config.Title or "Panda Hub"
    
    local TargetFolder = GetSafeFolder()
    if TargetFolder:FindFirstChild("PandaUI_Pro") then
        TargetFolder.PandaUI_Pro:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PandaUI_Pro"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = TargetFolder

    -- زر الفتح العائم (بأنميشن ناعم)
    local OpenButton = Instance.new("TextButton")
    OpenButton.Size = UDim2.fromOffset(45, 45)
    OpenButton.Position = UDim2.new(0, 15, 0, 15)
    OpenButton.BackgroundColor3 = Theme.Sidebar
    OpenButton.Text = "🐼"
    OpenButton.TextSize = 20
    OpenButton.Visible = false
    OpenButton.AutoButtonColor = false
    OpenButton.Parent = ScreenGui
    Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", OpenButton).Color = Theme.Accent

    -- النافذة الرئيسية (الكونتينر)
    local Main = Instance.new("Frame")
    Main.Size = UDim2.fromOffset(600, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = Theme.Background
    Main.ClipsDescendants = true
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = Theme.Hover

    -- أنميشن دخول النافذة (Pop-in Effect)
    Main.Size = UDim2.fromOffset(550, 350)
    Main.Position = UDim2.new(0.5, -275, 0.5, -175)
    Main.GroupTransparency = 1
    SmoothTween(Main, {Size = UDim2.fromOffset(600, 400), Position = UDim2.new(0.5, -300, 0.5, -200), GroupTransparency = 0}, 0.5)

    -- الشريط العلوي
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = Main

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 300, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🐾 " .. Title
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.fromOffset(28, 28)
    CloseBtn.Position = UDim2.new(1, -40, 0.5, -14)
    CloseBtn.BackgroundColor3 = Theme.ElementBg
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Theme.Danger
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.AutoButtonColor = false
    CloseBtn.Parent = TopBar
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.fromOffset(28, 28)
    MinBtn.Position = UDim2.new(1, -75, 0.5, -14)
    MinBtn.BackgroundColor3 = Theme.ElementBg
    MinBtn.Text = "—"
    MinBtn.TextColor3 = Theme.Text
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 12
    MinBtn.AutoButtonColor = false
    MinBtn.Parent = TopBar
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

    -- نظام السحب (Drag) المطور (بدون أي تقطيع)
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- تفاعل أزرار الإغلاق والتصغير
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    MinBtn.MouseButton1Click:Connect(function()
        SmoothTween(Main, {Size = UDim2.fromOffset(550, 350), Position = UDim2.new(0.5, -275, 0.5, -175), GroupTransparency = 1}, 0.3).Completed:Connect(function()
            Main.Visible = false
            OpenButton.Visible = true
            OpenButton.Size = UDim2.fromOffset(0,0)
            SmoothTween(OpenButton, {Size = UDim2.fromOffset(45, 45)}, 0.3)
        end)
    end)
    OpenButton.MouseButton1Click:Connect(function()
        SmoothTween(OpenButton, {Size = UDim2.fromOffset(0, 0)}, 0.2).Completed:Connect(function()
            OpenButton.Visible = false
            Main.Visible = true
            SmoothTween(Main, {Size = UDim2.fromOffset(600, 400), Position = UDim2.new(0.5, -300, 0.5, -200), GroupTransparency = 0}, 0.4)
        end)
    end)

    -- القائمة الجانبية (Tabs Sidebar)
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 160, 1, -70)
    Sidebar.Position = UDim2.new(0, 15, 0, 55)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = Main
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
    
    local TabList = Instance.new("UIListLayout", Sidebar)
    TabList.Padding = UDim.new(0, 6)
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    
    local TabPadding = Instance.new("UIPadding", Sidebar)
    TabPadding.PaddingTop = UDim.new(0, 10)

    -- منطقة عرض المحتوى (Content Area)
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -200, 1, -70)
    ContentContainer.Position = UDim2.new(0, 185, 0, 55)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = Main

    local TabsInfo = {}
    local CurrentTab = nil

    local WindowFunctions = {}

    function WindowFunctions:CreateTab(Name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, -20, 0, 36)
        TabBtn.BackgroundColor3 = Theme.ElementBg
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = "   " .. Name
        TabBtn.TextColor3 = Theme.SubText
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 13
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.AutoButtonColor = false
        TabBtn.Parent = Sidebar
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 3, 0, 0)
        Indicator.Position = UDim2.new(0, 0, 0.5, 0)
        Indicator.AnchorPoint = Vector2.new(0, 0.5)
        Indicator.BackgroundColor3 = Theme.Accent
        Indicator.Parent = TabBtn
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Theme.Accent
        Page.Visible = false
        Page.Parent = ContentContainer

        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            if CurrentTab == Page then return end
            if CurrentTab then
                CurrentTab.Visible = false
                for _, info in pairs(TabsInfo) do
                    if info.Page == CurrentTab then
                        SmoothTween(info.Btn, {BackgroundTransparency = 1, TextColor3 = Theme.SubText}, 0.2)
                        SmoothTween(info.Indicator, {Size = UDim2.new(0, 3, 0, 0)}, 0.2)
                    end
                end
            end
            CurrentTab = Page
            Page.Visible = true
            SmoothTween(TabBtn, {BackgroundTransparency = 0, TextColor3 = Theme.Text}, 0.2)
            SmoothTween(Indicator, {Size = UDim2.new(0, 3, 0, 20)}, 0.2)
        end)

        if not CurrentTab then
            CurrentTab = Page
            Page.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.TextColor3 = Theme.Text
            Indicator.Size = UDim2.new(0, 3, 0, 20)
        end

        table.insert(TabsInfo, {Btn = TabBtn, Page = Page, Indicator = Indicator})

        local Elements = {}

        -- Section (عنوان جانبي)
        function Elements:CreateSection(title)
            local Sec = Instance.new("TextLabel")
            Sec.Size = UDim2.new(1, 0, 0, 25)
            Sec.BackgroundTransparency = 1
            Sec.Text = "• " .. string.upper(title)
            Sec.TextColor3 = Theme.Accent
            Sec.Font = Enum.Font.GothamBold
            Sec.TextSize = 11
            Sec.TextXAlignment = Enum.TextXAlignment.Left
            Sec.Parent = Page
        end

        -- Toggle (الزر المتبدل السلس)
        function Elements:CreateToggle(title, default, callback)
            local State = default or false
            
            local ToggleBg = Instance.new("TextButton")
            ToggleBg.Size = UDim2.new(1, -10, 0, 42)
            ToggleBg.BackgroundColor3 = Theme.ElementBg
            ToggleBg.Text = ""
            ToggleBg.AutoButtonColor = false
            ToggleBg.Parent = Page
            Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 6)
            local Stroke = Instance.new("UIStroke", ToggleBg)
            Stroke.Color = Theme.Sidebar

            local Lbl = Instance.new("TextLabel", ToggleBg)
            Lbl.Size = UDim2.new(1, -60, 1, 0)
            Lbl.Position = UDim2.new(0, 15, 0, 0)
            Lbl.BackgroundTransparency = 1
            Lbl.Text = title
            Lbl.TextColor3 = Theme.Text
            Lbl.Font = Enum.Font.GothamMedium
            Lbl.TextSize = 13
            Lbl.TextXAlignment = Enum.TextXAlignment.Left

            local Track = Instance.new("Frame", ToggleBg)
            Track.Size = UDim2.fromOffset(40, 20)
            Track.Position = UDim2.new(1, -55, 0.5, -10)
            Track.BackgroundColor3 = State and Theme.Accent or Theme.Hover
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

            local Knob = Instance.new("Frame", Track)
            Knob.Size = UDim2.fromOffset(16, 16)
            Knob.Position = State and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            ToggleBg.MouseEnter:Connect(function() SmoothTween(Stroke, {Color = Theme.Hover}, 0.2) end)
            ToggleBg.MouseLeave:Connect(function() SmoothTween(Stroke, {Color = Theme.Sidebar}, 0.2) end)

            ToggleBg.MouseButton1Click:Connect(function()
                State = not State
                SmoothTween(Track, {BackgroundColor3 = State and Theme.Accent or Theme.Hover}, 0.25)
                SmoothTween(Knob, {Position = State and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}, 0.25)
                if callback then task.spawn(callback, State) end
            end)
        end

        -- Button (زر الضغط مع تأثير النقر)
        function Elements:CreateButton(title, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 42)
            Btn.BackgroundColor3 = Theme.ElementBg
            Btn.Text = ""
            Btn.AutoButtonColor = false
            Btn.Parent = Page
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
            local Stroke = Instance.new("UIStroke", Btn)
            Stroke.Color = Theme.Sidebar

            local Lbl = Instance.new("TextLabel", Btn)
            Lbl.Size = UDim2.new(1, 0, 1, 0)
            Lbl.Position = UDim2.new(0, 15, 0, 0)
            Lbl.BackgroundTransparency = 1
            Lbl.Text = title
            Lbl.TextColor3 = Theme.Text
            Lbl.Font = Enum.Font.GothamMedium
            Lbl.TextSize = 13
            Lbl.TextXAlignment = Enum.TextXAlignment.Left

            Btn.MouseEnter:Connect(function() SmoothTween(Btn, {BackgroundColor3 = Theme.Hover}, 0.2) end)
            Btn.MouseLeave:Connect(function() SmoothTween(Btn, {BackgroundColor3 = Theme.ElementBg}, 0.2) end)
            
            Btn.MouseButton1Down:Connect(function() SmoothTween(Btn, {Size = UDim2.new(1, -14, 0, 38)}, 0.1) end)
            Btn.MouseButton1Up:Connect(function() SmoothTween(Btn, {Size = UDim2.new(1, -10, 0, 42)}, 0.1) end)

            Btn.MouseButton1Click:Connect(function()
                if callback then task.spawn(callback) end
            end)
        end

        -- Slider (منزلق القيم الخرافي)
        function Elements:CreateSlider(title, min, max, default, callback)
            local SliderBg = Instance.new("Frame", Page)
            SliderBg.Size = UDim2.new(1, -10, 0, 55)
            SliderBg.BackgroundColor3 = Theme.ElementBg
            Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 6)

            local Lbl = Instance.new("TextLabel", SliderBg)
            Lbl.Size = UDim2.new(1, -80, 0, 25)
            Lbl.Position = UDim2.new(0, 15, 0, 5)
            Lbl.BackgroundTransparency = 1
            Lbl.Text = title
            Lbl.TextColor3 = Theme.Text
            Lbl.Font = Enum.Font.GothamMedium
            Lbl.TextSize = 13
            Lbl.TextXAlignment = Enum.TextXAlignment.Left

            local ValLbl = Instance.new("TextLabel", SliderBg)
            ValLbl.Size = UDim2.new(0, 50, 0, 25)
            ValLbl.Position = UDim2.new(1, -65, 0, 5)
            ValLbl.BackgroundTransparency = 1
            ValLbl.Text = tostring(default)
            ValLbl.TextColor3 = Theme.Accent
            ValLbl.Font = Enum.Font.GothamBold
            ValLbl.TextSize = 13
            ValLbl.TextXAlignment = Enum.TextXAlignment.Right

            local Track = Instance.new("Frame", SliderBg)
            Track.Size = UDim2.new(1, -30, 0, 6)
            Track.Position = UDim2.new(0, 15, 0, 38)
            Track.BackgroundColor3 = Theme.Hover
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame", Track)
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Theme.Accent
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local function update(input)
                local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + ((max - min) * pos))
                ValLbl.Text = tostring(val)
                SmoothTween(Fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1)
                if callback then task.spawn(callback, val) end
            end

            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; update(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    update(input)
                end
            end)
        end

        return Elements
    end

    return WindowFunctions
end


-- ==========================================================
-- 🛑 هذا هو كود التشغيل! (Loader) لا تحذفه لكي تظهر الواجهة
-- ==========================================================

-- 1. إنشاء النافذة الرئيسية
local Window = VunixLib:CreateWindow({
    Title = "Panda Hub Premium v3"
})

-- 2. إنشاء قائمة الأقسام (Tabs)
local CombatTab = Window:CreateTab("⚔️ Combat")
local PlayerTab = Window:CreateTab("👤 Player")
local SettingsTab = Window:CreateTab("⚙️ Settings")

-- 3. وضع العناصر في الأقسام (صممناها بشكل خيالي وسلس)

-- قسم القتال
CombatTab:CreateSection("Aimbot Settings")
CombatTab:CreateToggle("Enable Silent Aim", false, function(state)
    print("Silent Aim: ", state)
end)
CombatTab:CreateSlider("Hitbox Extender", 1, 10, 2, function(value)
    print("Hitbox Size: ", value)
end)

CombatTab:CreateSection("Visuals")
CombatTab:CreateToggle("ESP Players", false, function(state)
    print("ESP Enabled: ", state)
end)

-- قسم اللاعب
PlayerTab:CreateSection("Movement Exploits")
PlayerTab:CreateSlider("WalkSpeed", 16, 200, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
PlayerTab:CreateSlider("JumpPower", 50, 300, 50, function(value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

PlayerTab:CreateButton("Fly (Toggle)", function()
    print("Fly Activated!")
end)

-- قسم الإعدادات
SettingsTab:CreateSection("UI Settings")
SettingsTab:CreateButton("Unload UI", function()
    local folder = GetSafeFolder()
    if folder:FindFirstChild("PandaUI_Pro") then
        folder.PandaUI_Pro:Destroy()
    end
end)