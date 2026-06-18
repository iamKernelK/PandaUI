-- [[ VunixUI Pro | Elite Panda Edition 2026 ]]
-- [[ Fully Optimized, Ultra-Professional Layout & Zero-Lag Performance ]]

local VunixLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

-- ألوان ثيم الباندا الاحترافي المطور مع لمسات الخيزران المشع
local Theme = {
    Background = Color3.fromRGB(14, 14, 16),       -- أسود عميق (فخم)
    Sidebar = Color3.fromRGB(22, 22, 25),          -- رمادي الفحم (فرو الباندا الداكن)
    ElementBg = Color3.fromRGB(26, 26, 30),        -- خلفية الأزرار والعناصر
    ElementHover = Color3.fromRGB(34, 34, 40),     -- عند تمرير الماوس
    ActiveTabBg = Color3.fromRGB(38, 38, 44),      -- التاب المختار
    Text = Color3.fromRGB(255, 255, 255),          -- أبيض ناصع
    SubText = Color3.fromRGB(155, 155, 160),       -- رمادي هادئ
    Accent = Color3.fromRGB(74, 222, 128),         -- أخضر الخيزران النيون (Bamboo Green)
    ToggleOn = Color3.fromRGB(74, 222, 128),
    ToggleOff = Color3.fromRGB(50, 50, 55),
    Danger = Color3.fromRGB(248, 113, 113)
}

local function GetSafeUIFolder()
    if gethui then
        local success, result = pcall(gethui)
        if success and result then return result end
    end
    return pcall(function() return CoreGui end) and CoreGui or Player:WaitForChild("PlayerGui")
end

local function SmoothTween(obj, props, time)
    local tween = TweenService:Create(obj, TweenInfo.new(time or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

-- ════════════════════════════════════════════════
-- إنشاء النافذة والواجهة الرئيسية
-- ════════════════════════════════════════════════
function VunixLib:CreateWindow(Config)
    local hubName = Config.Title or "Panda Hub Ultra"
    
    local ScreenGuiParent = GetSafeUIFolder()
    if ScreenGuiParent:FindFirstChild("VunixPandaElite") then 
        ScreenGuiParent.VunixPandaElite:Destroy() 
    end

    local ScreenGui = Instance.new("ScreenGui", ScreenGuiParent)
    ScreenGui.Name = "VunixPandaElite"
    ScreenGui.ResetOnSpawn = false

    -- [الميزة الجديدة] زر فتح القائمة العائم (تحت شعار روبلوكس مباشرة في أعلى اليسار)
    local OpenPill = Instance.new("TextButton", ScreenGui)
    OpenPill.Size = UDim2.fromOffset(42, 42)
    OpenPill.Position = UDim2.new(0, 15, 0, 65) -- موقع استراتيجي تحت قائمة روبلوكس الإفتراضية
    OpenPill.BackgroundColor3 = Theme.Sidebar
    OpenPill.Text = "🐾"
    OpenPill.TextColor3 = Theme.Accent
    OpenPill.Font = Enum.Font.GothamBold
    OpenPill.TextSize = 18
    OpenPill.Visible = false
    OpenPill.AutoButtonColor = false
    Instance.new("UICorner", OpenPill).CornerRadius = UDim.new(1, 0) -- دائري بالكامل
    local OpenStroke = Instance.new("UIStroke", OpenPill)
    OpenStroke.Color = Theme.Accent
    OpenStroke.Width = 1.5

    -- النافذة الأساسية المحدثة
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.fromOffset(620, 420)
    Main.Position = UDim2.new(0.5, -310, 0.5, -210)
    Main.BackgroundColor3 = Theme.Background
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = Theme.ElementHover
    MainStroke.Width = 1

    -- شريط التحكم العلوي الأنيق
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 50) -- تم زيادة الارتفاع ليعطي فخامة ومساحة
    TopBar.BackgroundTransparency = 1

    local HubTitle = Instance.new("TextLabel", TopBar)
    HubTitle.Size = UDim2.new(0, 350, 1, 0)
    HubTitle.Position = UDim2.new(0, 20, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = "🐼  " .. hubName
    HubTitle.TextColor3 = Theme.Text
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextSize = 15
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left

    local Controls = Instance.new("Frame", TopBar)
    Controls.Size = UDim2.new(0, 80, 1, 0)
    Controls.Position = UDim2.new(1, -95, 0, 0)
    Controls.BackgroundTransparency = 1

    local ControlsLayout = Instance.new("UIListLayout", Controls)
    ControlsLayout.FillDirection = Enum.FillDirection.Horizontal
    ControlsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ControlsLayout.Padding = UDim.new(0, 8)

    local function CreateTopButton(iconText, color)
        local btn = Instance.new("TextButton", Controls)
        btn.Size = UDim2.fromOffset(26, 26)
        btn.BackgroundColor3 = Theme.ElementBg
        btn.Text = iconText
        btn.TextColor3 = color or Theme.SubText
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end

    local MinimizeBtn = CreateTopButton("—")
    local CloseBtn = CreateTopButton("✕", Theme.Danger)

    -- نظام سحب فائق السلاسة ومحسن بالكامل
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- نافذة تأكيد الإغلاق الاحترافية
    local DialogOverlay = Instance.new("Frame", Main)
    DialogOverlay.Size = UDim2.new(1, 0, 1, 0)
    DialogOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    DialogOverlay.BackgroundTransparency = 1
    DialogOverlay.Visible = false
    DialogOverlay.ZIndex = 100

    local DialogBox = Instance.new("Frame", DialogOverlay)
    DialogBox.Size = UDim2.fromOffset(290, 135)
    DialogBox.Position = UDim2.new(0.5, -145, 0.5, -67)
    DialogBox.BackgroundColor3 = Theme.Sidebar
    Instance.new("UICorner", DialogBox).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", DialogBox).Color = Theme.ElementHover

    local DialogTitle = Instance.new("TextLabel", DialogBox)
    DialogTitle.Size = UDim2.new(1, -20, 0, 35)
    DialogTitle.Position = UDim2.fromOffset(15, 10)
    DialogTitle.BackgroundTransparency = 1
    DialogTitle.Text = "Exit Script?"
    DialogTitle.TextColor3 = Theme.Text
    DialogTitle.Font = Enum.Font.GothamBold
    DialogTitle.TextSize = 14
    DialogTitle.TextXAlignment = Enum.TextXAlignment.Left

    local CancelBtn = Instance.new("TextButton", DialogBox)
    CancelBtn.Size = UDim2.new(0.44, 0, 0, 34)
    CancelBtn.Position = UDim2.new(0, 15, 1, -49)
    CancelBtn.BackgroundColor3 = Theme.ElementBg
    CancelBtn.Text = "Cancel"
    CancelBtn.TextColor3 = Theme.Text
    CancelBtn.Font = Enum.Font.GothamMedium
    CancelBtn.TextSize = 12
    Instance.new("UICorner", CancelBtn).CornerRadius = UDim.new(0, 6)

    local ConfirmBtn = Instance.new("TextButton", DialogBox)
    ConfirmBtn.Size = UDim2.new(0.44, 0, 0, 34)
    ConfirmBtn.Position = UDim2.new(1, -143, 1, -49)
    ConfirmBtn.BackgroundColor3 = Theme.Danger
    ConfirmBtn.Text = "Close"
    ConfirmBtn.TextColor3 = Theme.Text
    ConfirmBtn.Font = Enum.Font.GothamMedium
    ConfirmBtn.TextSize = 12
    Instance.new("UICorner", ConfirmBtn).CornerRadius = UDim.new(0, 6)

    CloseBtn.MouseButton1Click:Connect(function()
        DialogOverlay.Visible = true
        SmoothTween(DialogOverlay, {BackgroundTransparency = 0.4}, 0.2)
    end)
    CancelBtn.MouseButton1Click:Connect(function()
        SmoothTween(DialogOverlay, {BackgroundTransparency = 1}, 0.2).Completed:Connect(function()
            DialogOverlay.Visible = false
        end)
    end)
    ConfirmBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- تفعيل أزرار التصغير والفتح الذكية
    MinimizeBtn.MouseButton1Click:Connect(function()
        Main.Visible = false
        OpenPill.Visible = true
        SmoothTween(OpenPill, {Size = UDim2.fromOffset(42, 42)}, 0.2)
    end)
    OpenPill.MouseButton1Click:Connect(function()
        OpenPill.Visible = false
        Main.Visible = true
    end)

    -- ════════════════════════════════════════════════
    -- القائمة الجانبية (Tabs) والمحتوى الأيمن
    -- ════════════════════════════════════════════════
    -- [تعديل هائل هنا] تم إنزال الموضع إلى Y=55 لإنهاء الالتصاق بالعنوان وجعله أقصر بالطول بذكاء ومتناسق
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 155, 1, -70)
    Sidebar.Position = UDim2.new(0, 15, 0, 55)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

    -- صندوق المحتوى الأيمن للعناصر (منظم ومنفصل بالكامل)
    local ContentContainer = Instance.new("Frame", Main)
    ContentContainer.Size = UDim2.new(1, -200, 1, -70)
    ContentContainer.Position = UDim2.new(0, 185, 0, 55)
    ContentContainer.BackgroundTransparency = 1

    local TabsScroll = Instance.new("ScrollingFrame", Sidebar)
    TabsScroll.Size = UDim2.new(1, 0, 1, -16)
    TabsScroll.Position = UDim2.new(0, 0, 0, 8)
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.ScrollBarThickness = 0
    local TabsLayout = Instance.new("UIListLayout", TabsScroll)
    TabsLayout.Padding = UDim.new(0, 5)
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local WindowObj = {}
    local ActiveTab = nil

    function WindowObj:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton", TabsScroll)
        TabBtn.Size = UDim2.new(1, -16, 0, 36)
        TabBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = "   " .. tabName
        TabBtn.TextColor3 = Theme.SubText
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 12
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        -- خط المؤشر الجانبي للتاب النشط متوهج بلون البامبو الأخضر
        local Indicator = Instance.new("Frame", TabBtn)
        Indicator.Size = UDim2.new(0, 3, 0, 0)
        Indicator.Position = UDim2.new(0, 2, 0.5, 0)
        Indicator.BackgroundColor3 = Theme.Accent
        Indicator.AnchorPoint = Vector2.new(0, 0.5)
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

        local TabPage = Instance.new("ScrollingFrame", ContentContainer)
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Theme.ElementHover
        TabPage.Visible = false
        
        local PageLayout = Instance.new("UIListLayout", TabPage)
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            if ActiveTab then
                ActiveTab.Page.Visible = false
                ActiveTab.Btn.BackgroundTransparency = 1
                ActiveTab.Btn.TextColor3 = Theme.SubText
                SmoothTween(ActiveTab.Indicator, {Size = UDim2.new(0, 3, 0, 0)}, 0.12)
            end
            ActiveTab = {Page = TabPage, Btn = TabBtn, Indicator = Indicator}
            TabPage.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.BackgroundColor3 = Theme.ActiveTabBg
            TabBtn.TextColor3 = Theme.Text
            SmoothTween(Indicator, {Size = UDim2.new(0, 3, 0, 18)}, 0.12)
        end)

        if not ActiveTab then
            ActiveTab = {Page = TabPage, Btn = TabBtn, Indicator = Indicator}
            TabPage.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.BackgroundColor3 = Theme.ActiveTabBg
            TabBtn.TextColor3 = Theme.Text
            Indicator.Size = UDim2.new(0, 3, 0, 18)
        end

        local Elements = {}

        -- [العناصر اليمنى الاحترافية جداً] 
        
        -- 1. عناوين الأقسام (Sections)
        function Elements:CreateSection(title)
            local SecFrame = Instance.new("Frame", TabPage)
            SecFrame.Size = UDim2.new(1, 0, 0, 25)
            SecFrame.BackgroundTransparency = 1
            
            local SecLabel = Instance.new("TextLabel", SecFrame)
            SecLabel.Size = UDim2.new(1, 0, 1, 0)
            SecLabel.BackgroundTransparency = 1
            SecLabel.Text = "• " .. string.upper(title)
            SecLabel.TextColor3 = Theme.Accent
            SecLabel.Font = Enum.Font.GothamBold
            SecLabel.TextSize = 11
            SecLabel.TextXAlignment = Enum.TextXAlignment.Left
        end

        -- 2. زر المتبدل الاحترافي (Toggle Switch)
        function Elements:CreateToggle(title, defaultState, callback)
            local State = defaultState or false
            local ToggleBg = Instance.new("TextButton", TabPage)
            ToggleBg.Size = UDim2.new(1, 0, 0, 42)
            ToggleBg.BackgroundColor3 = Theme.ElementBg
            ToggleBg.Text = ""
            ToggleBg.AutoButtonColor = false
            Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 7)
            local ElementStroke = Instance.new("UIStroke", ToggleBg)
            ElementStroke.Color = Theme.Sidebar

            local TitleLabel = Instance.new("TextLabel", ToggleBg)
            TitleLabel.Size = UDim2.new(1, -70, 1, 0)
            TitleLabel.Position = UDim2.new(0, 14, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Track = Instance.new("Frame", ToggleBg)
            Track.Size = UDim2.fromOffset(36, 18)
            Track.Position = UDim2.new(1, -50, 0.5, -9)
            Track.BackgroundColor3 = State and Theme.ToggleOn or Theme.ToggleOff
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

            local Knob = Instance.new("Frame", Track)
            Knob.Size = UDim2.fromOffset(14, 14)
            Knob.Position = State and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
            Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            ToggleBg.MouseButton1Click:Connect(function()
                State = not State
                SmoothTween(Track, {BackgroundColor3 = State and Theme.ToggleOn or Theme.ToggleOff}, 0.15)
                SmoothTween(Knob, {Position = State and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}, 0.15)
                if callback then pcall(callback, State) end
            end)
            
            ToggleBg.MouseEnter:Connect(function() SmoothTween(ElementStroke, {Color = Theme.ElementHover}, 0.15) end)
            ToggleBg.MouseLeave:Connect(function() SmoothTween(ElementStroke, {Color = Theme.Sidebar}, 0.15) end)
        end

        -- 3. الزر التفاعلي القوي (Button)
        function Elements:CreateButton(title, callback)
            local BtnBg = Instance.new("TextButton", TabPage)
            BtnBg.Size = UDim2.new(1, 0, 0, 42)
            BtnBg.BackgroundColor3 = Theme.ElementBg
            BtnBg.Text = ""
            BtnBg.AutoButtonColor = false
            Instance.new("UICorner", BtnBg).CornerRadius = UDim.new(0, 7)
            local ElementStroke = Instance.new("UIStroke", BtnBg)
            ElementStroke.Color = Theme.Sidebar

            local TitleLabel = Instance.new("TextLabel", BtnBg)
            TitleLabel.Size = UDim2.new(1, -20, 1, 0)
            TitleLabel.Position = UDim2.new(0, 14, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ClickIndicator = Instance.new("Frame", BtnBg)
            ClickIndicator.Size = UDim2.new(0, 3, 1, 0)
            ClickIndicator.Position = UDim2.new(1, -3, 0, 0)
            ClickIndicator.BackgroundColor3 = Theme.Accent
            ClickIndicator.BackgroundTransparency = 1
            Instance.new("UICorner", ClickIndicator).CornerRadius = UDim.new(0, 4)

            BtnBg.MouseEnter:Connect(function() 
                SmoothTween(BtnBg, {BackgroundColor3 = Theme.ElementHover}, 0.15)
                SmoothTween(ClickIndicator, {BackgroundTransparency = 0}, 0.15)
            end)
            BtnBg.MouseLeave:Connect(function() 
                SmoothTween(BtnBg, {BackgroundColor3 = Theme.ElementBg}, 0.15)
                SmoothTween(ClickIndicator, {BackgroundTransparency = 1}, 0.15)
            end)
            BtnBg.MouseButton1Click:Connect(function() 
                if callback then pcall(callback) end 
            end)
        end

        -- 4. المنزلق الاحترافي السلس (Slider)
        function Elements:CreateSlider(title, min, max, default, callback)
            local SliderBg = Instance.new("Frame", TabPage)
            SliderBg.Size = UDim2.new(1, 0, 0, 50)
            SliderBg.BackgroundColor3 = Theme.ElementBg
            Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 7)

            local TitleLabel = Instance.new("TextLabel", SliderBg)
            TitleLabel.Size = UDim2.new(1, -80, 0, 22)
            TitleLabel.Position = UDim2.new(0, 14, 0, 6)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ValueLabel = Instance.new("TextLabel", SliderBg)
            ValueLabel.Size = UDim2.new(0, 50, 0, 22)
            ValueLabel.Position = UDim2.new(1, -64, 0, 6)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(default)
            ValueLabel.TextColor3 = Theme.Accent
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

            local TrackBg = Instance.new("Frame", SliderBg)
            TrackBg.Size = UDim2.new(1, -28, 0, 5)
            TrackBg.Position = UDim2.new(0, 14, 0, 36)
            TrackBg.BackgroundColor3 = Theme.ToggleOff
            Instance.new("UICorner", TrackBg).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame", TrackBg)
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Theme.Accent
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

            local Dragging = false
            local function UpdateSlider(input)
                local pos = math.clamp((input.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + ((max - min) * pos))
                ValueLabel.Text = tostring(value)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                if callback then pcall(callback, value) end
            end

            TrackBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true; UpdateSlider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then Dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input)
                end
            end)
        end

        -- 5. القائمة المنسدلة الذكية (Dropdown)
        function Elements:CreateDropdown(title, list, callback)
            local Expanded = false
            local DropBg = Instance.new("Frame", TabPage)
            DropBg.Size = UDim2.new(1, 0, 0, 42)
            DropBg.BackgroundColor3 = Theme.ElementBg
            DropBg.ClipsDescendants = true
            Instance.new("UICorner", DropBg).CornerRadius = UDim.new(0, 7)

            local MainBtn = Instance.new("TextButton", DropBg)
            MainBtn.Size = UDim2.new(1, 0, 0, 42)
            MainBtn.BackgroundTransparency = 1
            MainBtn.Text = ""

            local TitleLabel = Instance.new("TextLabel", MainBtn)
            TitleLabel.Size = UDim2.new(1, -40, 1, 0)
            TitleLabel.Position = UDim2.new(0, 14, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Indicator = Instance.new("TextLabel", MainBtn)
            Indicator.Size = UDim2.new(0, 30, 1, 0)
            Indicator.Position = UDim2.new(1, -35, 0, 0)
            Indicator.BackgroundTransparency = 1
            Indicator.Text = "▼"
            Indicator.TextColor3 = Theme.SubText
            Indicator.Font = Enum.Font.GothamBold
            Indicator.TextSize = 10

            local OptionsContainer = Instance.new("Frame", DropBg)
            OptionsContainer.Size = UDim2.new(1, -12, 0, #list * 32)
            OptionsContainer.Position = UDim2.new(0, 6, 0, 42)
            OptionsContainer.BackgroundTransparency = 1
            local OptionLayout = Instance.new("UIListLayout", OptionsContainer)
            OptionLayout.Padding = UDim.new(0, 3)

            for _, option in ipairs(list) do
                local OptBtn = Instance.new("TextButton", OptionsContainer)
                OptBtn.Size = UDim2.new(1, 0, 0, 28)
                OptBtn.BackgroundColor3 = Theme.Sidebar
                OptBtn.Text = tostring(option)
                OptBtn.TextColor3 = Theme.SubText
                OptBtn.Font = Enum.Font.GothamMedium
                OptBtn.TextSize = 11
                Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 5)

                OptBtn.MouseButton1Click:Connect(function()
                    TitleLabel.Text = title .. " : " .. tostring(option)
                    Expanded = false
                    SmoothTween(DropBg, {Size = UDim2.new(1, 0, 0, 42)}, 0.15)
                    Indicator.Text = "▼"
                    if callback then pcall(callback, option) end
                end)
            end

            MainBtn.MouseButton1Click:Connect(function()
                Expanded = not Expanded
                local targetHeight = Expanded and (46 + (#list * 32)) or 42
                SmoothTween(DropBg, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.15)
                Indicator.Text = Expanded and "▲" or "▼"
            end)
        end

        -- 6. صندوق إدخال القيم الاحترافي (TextBox)
        function Elements:CreateTextBox(title, placeholder, callback)
            local BoxBg = Instance.new("Frame", TabPage)
            BoxBg.Size = UDim2.new(1, 0, 0, 42)
            BoxBg.BackgroundColor3 = Theme.ElementBg
            Instance.new("UICorner", BoxBg).CornerRadius = UDim.new(0, 7)

            local TitleLabel = Instance.new("TextLabel", BoxBg)
            TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
            TitleLabel.Position = UDim2.new(0, 14, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local InputBox = Instance.new("TextBox", BoxBg)
            InputBox.Size = UDim2.new(0.42, 0, 0, 28)
            InputBox.Position = UDim2.new(1, -156, 0.5, -14)
            InputBox.BackgroundColor3 = Theme.Sidebar
            InputBox.Text = ""
            InputBox.PlaceholderText = placeholder or "Type value..."
            InputBox.TextColor3 = Theme.Accent
            InputBox.PlaceholderColor3 = Theme.SubText
            InputBox.Font = Enum.Font.GothamMedium
            InputBox.TextSize = 11
            Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 5)
            local BoxStroke = Instance.new("UIStroke", InputBox)
            BoxStroke.Color = Theme.ElementHover

            InputBox.FocusLost:Connect(function()
                if callback then pcall(callback, InputBox.Text) end
            end)
        end

        return Elements
    end

    return WindowObj
end

return VunixLib
