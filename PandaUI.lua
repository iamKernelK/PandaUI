-- [[ VunixUI | Premium Hybrid Edition 2026 - Developed & Optimized ]]
-- [[ Merged and Optimized: Ultimate Animated Controls & Categories ]]

local VunixLib = {}
local TweenService = game:GetService("TweenService") --[span_2](start_span)[span_2](end_span)
local UserInputService = game:GetService("UserInputService") --[span_3](start_span)[span_3](end_span)
local CoreGui = game:GetService("CoreGui") --[span_4](start_span)[span_4](end_span)
local Players = game:GetService("Players") --[span_5](start_span)[span_5](end_span)
local Lighting = game:GetService("Lighting") --[span_6](start_span)[span_6](end_span)

local Player = Players.LocalPlayer --[span_7](start_span)[span_7](end_span)
local StartTime = tick() --[span_8](start_span)[span_8](end_span)

-- إعدادات الألوان والثيم الهجين (Neon Cyan & Ultra Dark Premium)[span_9](start_span)[span_9](end_span)
local Theme = {
    Background = Color3.fromRGB(12, 12, 14), --[span_10](start_span)[span_10](end_span)
    Sidebar = Color3.fromRGB(18, 18, 22), --[span_11](start_span)[span_11](end_span)
    ElementBg = Color3.fromRGB(24, 24, 28), --[span_12](start_span)[span_12](end_span)
    ElementHover = Color3.fromRGB(35, 35, 40), --[span_13](start_span)[span_13](end_span)
    ActiveTabBg = Color3.fromRGB(45, 45, 52), --[span_14](start_span)[span_14](end_span)
    Text = Color3.fromRGB(255, 255, 255), --[span_15](start_span)[span_15](end_span)
    Accent = Color3.fromRGB(0, 255, 255), --[span_16](start_span)[span_16](end_span)
    GradientStart = Color3.fromRGB(140, 0, 255), --[span_17](start_span)[span_17](end_span)
    SubText = Color3.fromRGB(160, 160, 170) --[span_18](start_span)[span_18](end_span)
}

-- دالة جلب المجلد الآمن للواجهة[span_19](start_span)[span_19](end_span)
local function GetSafeUIFolder()
    if gethui then --[span_20](start_span)[span_20](end_span)
        local success, result = pcall(gethui) --[span_21](start_span)[span_21](end_span)
        if success and result then return result end --[span_22](start_span)[span_22](end_span)
    end
    return pcall(function() return CoreGui end) and CoreGui or Player:WaitForChild("PlayerGui") --[span_23](start_span)[span_23](end_span)
end

-- دالة الأنميشن والتنعيم السريع[span_24](start_span)[span_24](end_span)
local function Tween(obj, props, time)
    return TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play() --[span_25](start_span)[span_25](end_span)
end

-- تطبيق التدرج اللوني الفخم[span_26](start_span)[span_26](end_span)
local function ApplyPremiumGradient(parent)
    local Gradient = Instance.new("UIGradient") --[span_27](start_span)[span_27](end_span)
    Gradient.Color = ColorSequence.new({ --[span_28](start_span)[span_28](end_span)
        ColorSequenceKeypoint.new(0, Theme.GradientStart), --[span_29](start_span)[span_29](end_span)
        ColorSequenceKeypoint.new(1, Theme.Accent) --[span_30](start_span)[span_30](end_span)
    })
    Gradient.Rotation = 45 --[span_31](start_span)[span_31](end_span)
    Gradient.Parent = parent --[span_32](start_span)[span_32](end_span)
    return Gradient --[span_33](start_span)[span_33](end_span)
end

function VunixLib:CreateWindow(Config)
    local hubName = Config.Title or "Vunix Prime" --[span_34](start_span)[span_34](end_span)
    local logoId = Config.LogoId or "17829927053" --[span_35](start_span)[span_35](end_span)
    
    local ScreenGuiParent = GetSafeUIFolder() --[span_36](start_span)[span_36](end_span)
    if ScreenGuiParent:FindFirstChild("VunixPremiumHub") then  --[span_37](start_span)[span_37](end_span)
        ScreenGuiParent.VunixPremiumHub:Destroy()  --[span_38](start_span)[span_38](end_span)
    end

    local ScreenGui = Instance.new("ScreenGui", ScreenGuiParent) --[span_39](start_span)[span_39](end_span)
    ScreenGui.Name = "VunixPremiumHub" --[span_40](start_span)[span_40](end_span)
    ScreenGui.ResetOnSpawn = false --[span_41](start_span)[span_41](end_span)

    -- تأثير الـ Blur الخلفي[span_42](start_span)[span_42](end_span)
    local BlurInstance = Lighting:FindFirstChild("VunixPremiumBlur") --[span_43](start_span)[span_43](end_span)
    if BlurInstance then BlurInstance:Destroy() end --[span_44](start_span)[span_44](end_span)
    
    local function ToggleBlur(state)
        if state then --[span_45](start_span)[span_45](end_span)
            BlurInstance = Instance.new("BlurEffect", Lighting) --[span_46](start_span)[span_46](end_span)
            BlurInstance.Name = "VunixPremiumBlur" --[span_47](start_span)[span_47](end_span)
            BlurInstance.Size = 0 --[span_48](start_span)[span_48](end_span)
            TweenService:Create(BlurInstance, TweenInfo.new(0.5), {Size = 8}):Play() --[span_49](start_span)[span_49](end_span)
        else
            if BlurInstance then --[span_50](start_span)[span_50](end_span)
                local t = TweenService:Create(BlurInstance, TweenInfo.new(0.4), {Size = 0}) --[span_51](start_span)[span_51](end_span)
                t:Play() --[span_52](start_span)[span_52](end_span)
                t.Completed:Connect(function() if BlurInstance then BlurInstance:Destroy() end end) --[span_53](start_span)[span_53](end_span)
            end
        end
    end

    -- زر الفتح الدائري العائم (عند إغلاق القائمة)[span_54](start_span)[span_54](end_span)
    local OpenBtn = Instance.new("ImageButton", ScreenGui) --[span_55](start_span)[span_55](end_span)
    OpenBtn.Name = "OpenVunix" --[span_56](start_span)[span_56](end_span)
    OpenBtn.Size = UDim2.fromOffset(50, 50) --[span_57](start_span)[span_57](end_span)
    OpenBtn.Position = UDim2.new(0, 20, 0, 60) --[span_58](start_span)[span_58](end_span)
    OpenBtn.BackgroundColor3 = Color3.new(1, 1, 1) --[span_59](start_span)[span_59](end_span)
    OpenBtn.BackgroundTransparency = 0.8 --[span_60](start_span)[span_60](end_span)
    OpenBtn.Image = "rbxassetid://" .. tostring(logoId) --[span_61](start_span)[span_61](end_span)
    OpenBtn.Visible = false --[span_62](start_span)[span_62](end_span)
    Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0) --[span_63](start_span)[span_63](end_span)
    ApplyPremiumGradient(OpenBtn) --[span_64](start_span)[span_64](end_span)
    
    local OpenStroke = Instance.new("UIStroke", OpenBtn) --[span_65](start_span)[span_65](end_span)
    OpenStroke.Thickness = 2 --[span_66](start_span)[span_66](end_span)
    ApplyPremiumGradient(OpenStroke) --[span_67](start_span)[span_67](end_span)

    -- النافذة الرئيسية (Main Frame)[span_68](start_span)[span_68](end_span)
    local Main = Instance.new("CanvasGroup", ScreenGui) --[span_69](start_span)[span_69](end_span)
    Main.Size = UDim2.fromOffset(660, 460) --[span_70](start_span)[span_70](end_span)
    Main.Position = UDim2.new(0.5, -330, -0.6, 0) --[span_71](start_span)[span_71](end_span)
    Main.BackgroundColor3 = Theme.Background --[span_72](start_span)[span_72](end_span)
    Main.ClipsDescendants = true --[span_73](start_span)[span_73](end_span)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14) --[span_74](start_span)[span_74](end_span)
    
    local MainStroke = Instance.new("UIStroke", Main) --[span_75](start_span)[span_75](end_span)
    MainStroke.Thickness = 1.5 --[span_76](start_span)[span_76](end_span)
    ApplyPremiumGradient(MainStroke) --[span_77](start_span)[span_77](end_span)

    -- أنميشن التشغيل الأول الذكي[span_78](start_span)[span_78](end_span)
    ToggleBlur(true) --[span_79](start_span)[span_79](end_span)
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { --[span_80](start_span)[span_80](end_span)
        Position = UDim2.new(0.5, -330, 0.5, -230), --[span_81](start_span)[span_81](end_span)
        GroupTransparency = 0 --[span_82](start_span)[span_82](end_span)
    }):Play() --[span_83](start_span)[span_83](end_span)

    -- الشريط العلوي (TopBar) مع نظام السحب[span_84](start_span)[span_84](end_span)
    local TopBar = Instance.new("Frame", Main) --[span_85](start_span)[span_85](end_span)
    TopBar.Size = UDim2.new(1, 0, 0, 50) --[span_86](start_span)[span_86](end_span)
    TopBar.BackgroundTransparency = 1 --[span_87](start_span)[span_87](end_span)

    local LogoImg = Instance.new("ImageLabel", TopBar) --[span_88](start_span)[span_88](end_span)
    LogoImg.Size = UDim2.fromOffset(28, 28) --[span_89](start_span)[span_89](end_span)
    LogoImg.Position = UDim2.new(0, 15, 0.5, -14) --[span_90](start_span)[span_90](end_span)
    LogoImg.BackgroundTransparency = 1 --[span_91](start_span)[span_91](end_span)
    LogoImg.Image = "rbxassetid://" .. tostring(logoId) --[span_92](start_span)[span_92](end_span)

    local HubTitle = Instance.new("TextLabel", TopBar) --[span_93](start_span)[span_93](end_span)
    HubTitle.Size = UDim2.new(0, 300, 1, 0) --[span_94](start_span)[span_94](end_span)
    HubTitle.Position = UDim2.new(0, 52, 0, 0) --[span_95](start_span)[span_95](end_span)
    HubTitle.BackgroundTransparency = 1 --[span_96](start_span)[span_96](end_span)
    HubTitle.Text = hubName --[span_97](start_span)[span_97](end_span)
    HubTitle.TextColor3 = Theme.Text --[span_98](start_span)[span_98](end_span)
    HubTitle.Font = Enum.Font.GothamBold --[span_99](start_span)[span_99](end_span)
    HubTitle.TextSize = 18 --[span_100](start_span)[span_100](end_span)
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left --[span_101](start_span)[span_101](end_span)
    ApplyPremiumGradient(HubTitle) --[span_102](start_span)[span_102](end_span)

    -- [التعديل هنا]: زر التصغير (-) يطفي الواجهة ويظهر الزر العائم
    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Size = UDim2.fromOffset(30, 30)
    MinBtn.Position = UDim2.new(1, -70, 0.5, -15)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Theme.Text
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 22

    MinBtn.MouseButton1Click:Connect(function()
        ToggleBlur(false)
        local closeTween = TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset, 1.5, 0),
            GroupTransparency = 1
        })
        closeTween:Play()
        closeTween.Completed:Connect(function() Main.Visible = false; OpenBtn.Visible = true end)
    end)

    -- [التعديل هنا]: زر الإغلاق (x) يحذف الواجهة بالكامل
    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.fromOffset(30, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 65, 65) -- لون أحمر مميز
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16

    CloseBtn.MouseButton1Click:Connect(function()
        ToggleBlur(false)
        ScreenGui:Destroy()
    end)

    -- برمجة نظام السحب (Dragging)[span_103](start_span)[span_103](end_span)
    local dragging, dragStart, startPos --[span_104](start_span)[span_104](end_span)
    TopBar.InputBegan:Connect(function(input) --[span_105](start_span)[span_105](end_span)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then --[span_106](start_span)[span_106](end_span)
            dragging = true; dragStart = input.Position; startPos = Main.Position --[span_107](start_span)[span_107](end_span)
        end
    end)
    TopBar.InputEnded:Connect(function(input) --[span_108](start_span)[span_108](end_span)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end --[span_109](start_span)[span_109](end_span)
    end)
    UserInputService.InputChanged:Connect(function(input) --[span_110](start_span)[span_110](end_span)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then --[span_111](start_span)[span_111](end_span)
            local delta = input.Position - dragStart --[span_112](start_span)[span_112](end_span)
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) --[span_113](start_span)[span_113](end_span)
        end
    end)

    OpenBtn.MouseButton1Click:Connect(function() --[span_114](start_span)[span_114](end_span)
        OpenBtn.Visible = false --[span_115](start_span)[span_115](end_span)
        Main.Position = UDim2.new(0.5, -330, -0.6, 0) --[span_116](start_span)[span_116](end_span)
        Main.Visible = true --[span_117](start_span)[span_117](end_span)
        ToggleBlur(true) --[span_118](start_span)[span_118](end_span)
        TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { --[span_119](start_span)[span_119](end_span)
            Position = UDim2.new(0.5, -330, 0.5, -230), --[span_120](start_span)[span_120](end_span)
            GroupTransparency = 0 --[span_121](start_span)[span_121](end_span)
        }):Play() --[span_122](start_span)[span_122](end_span)
    end)

    -- الشريط الجانبي (Sidebar)[span_123](start_span)[span_123](end_span)
    local Sidebar = Instance.new("Frame", Main) --[span_124](start_span)[span_124](end_span)
    Sidebar.Size = UDim2.new(0, 190, 1, -105) --[span_125](start_span)[span_125](end_span)
    Sidebar.Position = UDim2.new(0, 12, 0, 50) --[span_126](start_span)[span_126](end_span)
    Sidebar.BackgroundColor3 = Theme.Sidebar --[span_127](start_span)[span_127](end_span)
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10) --[span_128](start_span)[span_128](end_span)
    local SidebarStroke = Instance.new("UIStroke", Sidebar) --[span_129](start_span)[span_129](end_span)
    SidebarStroke.Color = Color3.fromRGB(35, 35, 45) --[span_130](start_span)[span_130](end_span)
    SidebarStroke.Thickness = 1 --[span_131](start_span)[span_131](end_span)

    -- حقل البحث الذكي (Search)[span_132](start_span)[span_132](end_span)
    local SearchBoxBg = Instance.new("Frame", Sidebar) --[span_133](start_span)[span_133](end_span)
    SearchBoxBg.Size = UDim2.new(1, -20, 0, 35) --[span_134](start_span)[span_134](end_span)
    SearchBoxBg.Position = UDim2.new(0, 10, 0, 12) --[span_135](start_span)[span_135](end_span)
    SearchBoxBg.BackgroundColor3 = Theme.ElementBg --[span_136](start_span)[span_136](end_span)
    Instance.new("UICorner", SearchBoxBg).CornerRadius = UDim.new(0, 8) --[span_137](start_span)[span_137](end_span)
    local SearchStroke = Instance.new("UIStroke", SearchBoxBg) --[span_138](start_span)[span_138](end_span)
    SearchStroke.Color = Color3.fromRGB(45, 45, 55) --[span_139](start_span)[span_139](end_span)

    local SearchIcon = Instance.new("ImageLabel", SearchBoxBg) --[span_140](start_span)[span_140](end_span)
    SearchIcon.Size = UDim2.fromOffset(16, 16) --[span_141](start_span)[span_141](end_span)
    SearchIcon.Position = UDim2.new(0, 10, 0.5, -8) --[span_142](start_span)[span_142](end_span)
    SearchIcon.BackgroundTransparency = 1 --[span_143](start_span)[span_143](end_span)
    SearchIcon.Image = "rbxassetid://118685771787843" --[span_144](start_span)[span_144](end_span)
    SearchIcon.ImageColor3 = Theme.SubText --[span_145](start_span)[span_145](end_span)

    local SearchBox = Instance.new("TextBox", SearchBoxBg) --[span_146](start_span)[span_146](end_span)
    SearchBox.Size = UDim2.new(1, -40, 1, 0) --[span_147](start_span)[span_147](end_span)
    SearchBox.Position = UDim2.new(0, 35, 0, 0) --[span_148](start_span)[span_148](end_span)
    SearchBox.BackgroundTransparency = 1 --[span_149](start_span)[span_149](end_span)
    SearchBox.Text = "" --[span_150](start_span)[span_150](end_span)
    SearchBox.PlaceholderText = "Search features..." --[span_151](start_span)[span_151](end_span)
    SearchBox.TextColor3 = Theme.Text --[span_152](start_span)[span_152](end_span)
    SearchBox.Font = Enum.Font.GothamMedium --[span_153](start_span)[span_153](end_span)
    SearchBox.TextSize = 12 --[span_154](start_span)[span_154](end_span)
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left --[span_155](start_span)[span_155](end_span)

    -- منطقة التابات المنسدلة (Tabs Scroll)[span_156](start_span)[span_156](end_span)
    local TabsScroll = Instance.new("ScrollingFrame", Sidebar) --[span_157](start_span)[span_157](end_span)
    TabsScroll.Size = UDim2.new(1, 0, 1, -60) --[span_158](start_span)[span_158](end_span)
    TabsScroll.Position = UDim2.new(0, 0, 0, 55) --[span_159](start_span)[span_159](end_span)
    TabsScroll.BackgroundTransparency = 1 --[span_160](start_span)[span_160](end_span)
    TabsScroll.ScrollBarThickness = 0 --[span_161](start_span)[span_161](end_span)
    local TabsLayout = Instance.new("UIListLayout", TabsScroll) --[span_162](start_span)[span_162](end_span)
    TabsLayout.Padding = UDim.new(0, 6) --[span_163](start_span)[span_163](end_span)
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center --[span_164](start_span)[span_164](end_span)

    -- حاوي المحتوى الأساسي (Content Container)[span_165](start_span)[span_165](end_span)
    local ContentContainer = Instance.new("Frame", Main) --[span_166](start_span)[span_166](end_span)
    ContentContainer.Size = UDim2.new(1, -225, 1, -115) --[span_167](start_span)[span_167](end_span)
    ContentContainer.Position = UDim2.new(0, 215, 0, 55) --[span_168](start_span)[span_168](end_span)
    ContentContainer.BackgroundTransparency = 1 --[span_169](start_span)[span_169](end_span)

    -- شاشة عرض نتائج البحث (Search Overlay)[span_170](start_span)[span_170](end_span)
    local SearchOverlay = Instance.new("ScrollingFrame", ContentContainer) --[span_171](start_span)[span_171](end_span)
    SearchOverlay.Size = UDim2.new(1, 0, 1, 0) --[span_172](start_span)[span_172](end_span)
    SearchOverlay.BackgroundTransparency = 1 --[span_173](start_span)[span_173](end_span)
    SearchOverlay.Visible = false --[span_174](start_span)[span_174](end_span)
    SearchOverlay.ZIndex = 50 --[span_175](start_span)[span_175](end_span)
    SearchOverlay.ScrollBarThickness = 2 --[span_176](start_span)[span_176](end_span)
    local SearchLayout = Instance.new("UIListLayout", SearchOverlay) --[span_177](start_span)[span_177](end_span)
    SearchLayout.Padding = UDim.new(0, 8) --[span_178](start_span)[span_178](end_span)

    -- نظام الإحصائيات والمعلومات السفلي (Footer)[span_179](start_span)[span_179](end_span)
    local Footer = Instance.new("Frame", Main) --[span_180](start_span)[span_180](end_span)
    Footer.Size = UDim2.new(1, 0, 0, 50) --[span_181](start_span)[span_181](end_span)
    Footer.Position = UDim2.new(0, 0, 1, -50) --[span_182](start_span)[span_182](end_span)
    Footer.BackgroundColor3 = Color3.fromRGB(10, 10, 12) --[span_183](start_span)[span_183](end_span)
    
    local FooterLine = Instance.new("Frame", Footer) --[span_184](start_span)[span_184](end_span)
    FooterLine.Size = UDim2.new(1, 0, 0, 1) --[span_185](start_span)[span_185](end_span)
    ApplyPremiumGradient(FooterLine) --[span_186](start_span)[span_186](end_span)

    local PlayerAvatar = Instance.new("ImageLabel", Footer) --[span_187](start_span)[span_187](end_span)
    PlayerAvatar.Size = UDim2.fromOffset(32, 32) --[span_188](start_span)[span_188](end_span)
    PlayerAvatar.Position = UDim2.new(0, 15, 0.5, -16) --[span_189](start_span)[span_189](end_span)
    PlayerAvatar.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) --[span_190](start_span)[span_190](end_span)
    Instance.new("UICorner", PlayerAvatar).CornerRadius = UDim.new(1, 0) --[span_191](start_span)[span_191](end_span)
    ApplyPremiumGradient(Instance.new("UIStroke", PlayerAvatar)) --[span_192](start_span)[span_192](end_span)

    local PlayerNameLabel = Instance.new("TextLabel", Footer) --[span_193](start_span)[span_193](end_span)
    PlayerNameLabel.Size = UDim2.new(0, 180, 0, 32) --[span_194](start_span)[span_194](end_span)
    PlayerNameLabel.Position = UDim2.new(0, 55, 0.5, -16) --[span_195](start_span)[span_195](end_span)
    PlayerNameLabel.BackgroundTransparency = 1 --[span_196](start_span)[span_196](end_span)
    PlayerNameLabel.Text = Player.DisplayName --[span_197](start_span)[span_197](end_span)
    PlayerNameLabel.TextColor3 = Theme.Text --[span_198](start_span)[span_198](end_span)
    PlayerNameLabel.Font = Enum.Font.GothamMedium --[span_199](start_span)[span_199](end_span)
    PlayerNameLabel.TextSize = 12 --[span_200](start_span)[span_200](end_span)
    PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left --[span_201](start_span)[span_201](end_span)

    local StatsContainer = Instance.new("Frame", Footer) --[span_202](start_span)[span_202](end_span)
    StatsContainer.Size = UDim2.new(0, 250, 1, 0) --[span_203](start_span)[span_203](end_span)
    StatsContainer.Position = UDim2.new(1, -265, 0, 0) --[span_204](start_span)[span_204](end_span)
    StatsContainer.BackgroundTransparency = 1 --[span_205](start_span)[span_205](end_span)

    local TimePlayedLabel = Instance.new("TextLabel", StatsContainer) --[span_206](start_span)[span_206](end_span)
    TimePlayedLabel.Size = UDim2.new(1, 0, 0, 20) --[span_207](start_span)[span_207](end_span)
    TimePlayedLabel.Position = UDim2.new(0, 0, 0, 6) --[span_208](start_span)[span_208](end_span)
    TimePlayedLabel.BackgroundTransparency = 1 --[span_209](start_span)[span_209](end_span)
    TimePlayedLabel.TextColor3 = Theme.SubText --[span_210](start_span)[span_210](end_span)
    TimePlayedLabel.Font = Enum.Font.Gotham --[span_211](start_span)[span_211](end_span)
    TimePlayedLabel.TextSize = 11 --[span_212](start_span)[span_212](end_span)
    TimePlayedLabel.TextXAlignment = Enum.TextXAlignment.Right --[span_213](start_span)[span_213](end_span)

    local LocalTimeLabel = Instance.new("TextLabel", StatsContainer) --[span_214](start_span)[span_214](end_span)
    LocalTimeLabel.Size = UDim2.new(1, 0, 0, 20) --[span_215](start_span)[span_215](end_span)
    LocalTimeLabel.Position = UDim2.new(0, 0, 0, 24) --[span_216](start_span)[span_216](end_span)
    LocalTimeLabel.BackgroundTransparency = 1 --[span_217](start_span)[span_217](end_span)
    LocalTimeLabel.TextColor3 = Theme.Text --[span_218](start_span)[span_218](end_span)
    LocalTimeLabel.Font = Enum.Font.GothamBold --[span_219](start_span)[span_219](end_span)
    LocalTimeLabel.TextSize = 11 --[span_220](start_span)[span_220](end_span)
    LocalTimeLabel.TextXAlignment = Enum.TextXAlignment.Right --[span_221](start_span)[span_221](end_span)
    ApplyPremiumGradient(LocalTimeLabel) --[span_222](start_span)[span_222](end_span)

    task.spawn(function() --[span_223](start_span)[span_223](end_span)
        while true do --[span_224](start_span)[span_224](end_span)
            local duration = math.floor(tick() - StartTime) --[span_225](start_span)[span_225](end_span)
            local hours, minutes, seconds = math.floor(duration / 3600), math.floor((duration % 3600) / 60), duration % 60 --[span_226](start_span)[span_226](end_span)
            TimePlayedLabel.Text = string.format("Time Played: %02d:%02d:%02d", hours, minutes, seconds) --[span_227](start_span)[span_227](end_span)
            LocalTimeLabel.Text = "Local Time: " .. os.date("%X") --[span_228](start_span)[span_228](end_span)
            task.wait(1) --[span_229](start_span)[span_229](end_span)
        end
    end)

    local AllElements = {} --[span_230](start_span)[span_230](end_span)
    local ActiveTab = nil --[span_231](start_span)[span_231](end_span)

    local WindowObj = {} --[span_232](start_span)[span_232](end_span)

    -- [1] دالة إنشاء قائمة تصنيف منسدلة (Category)[span_233](start_span)[span_233](end_span)
    function WindowObj:CreateCategory(catName)
        local CatFrame = Instance.new("Frame", TabsScroll) --[span_234](start_span)[span_234](end_span)
        CatFrame.Size = UDim2.new(1, -16, 0, 36) --[span_235](start_span)[span_235](end_span)
        CatFrame.BackgroundTransparency = 1 --[span_236](start_span)[span_236](end_span)
        CatFrame.ClipsDescendants = true --[span_237](start_span)[span_237](end_span)

        local CatFrameStroke = Instance.new("UIStroke", CatFrame) --[span_238](start_span)[span_238](end_span)
        CatFrameStroke.Color = Color3.fromRGB(40, 40, 50) --[span_239](start_span)[span_239](end_span)
        CatFrameStroke.Thickness = 1 --[span_240](start_span)[span_240](end_span)

        local CatBtn = Instance.new("TextButton", CatFrame) --[span_241](start_span)[span_241](end_span)
        CatBtn.Size = UDim2.new(1, 0, 0, 36) --[span_242](start_span)[span_242](end_span)
        CatBtn.BackgroundTransparency = 1 --[span_243](start_span)[span_243](end_span)
        CatBtn.Text = "  ▼  " .. catName --[span_244](start_span)[span_244](end_span)
        CatBtn.TextColor3 = Theme.SubText --[span_245](start_span)[span_245](end_span)
        CatBtn.Font = Enum.Font.GothamBold --[span_246](start_span)[span_246](end_span)
        CatBtn.TextSize = 12 --[span_247](start_span)[span_247](end_span)
        CatBtn.TextXAlignment = Enum.TextXAlignment.Left --[span_248](start_span)[span_248](end_span)

        local SubTabsLayout = Instance.new("UIListLayout", CatFrame) --[span_249](start_span)[span_249](end_span)
        SubTabsLayout.Padding = UDim.new(0, 4) --[span_250](start_span)[span_250](end_span)
        SubTabsLayout.SortOrder = Enum.SortOrder.LayoutOrder --[span_251](start_span)[span_251](end_span)

        local Expanded = false --[span_252](start_span)[span_252](end_span)
        CatBtn.MouseButton1Click:Connect(function() --[span_253](start_span)[span_253](end_span)
            Expanded = not Expanded --[span_254](start_span)[span_254](end_span)
            local targetHeight = Expanded and (SubTabsLayout.AbsoluteContentSize.Y + 10) or 36 --[span_255](start_span)[span_255](end_span)
            Tween(CatFrame, {Size = UDim2.new(1, -16, 0, targetHeight)}) --[span_256](start_span)[span_256](end_span)
            CatBtn.Text = Expanded and ("  ▲  " .. catName) or ("  ▼  " .. catName) --[span_257](start_span)[span_257](end_span)
            Tween(CatBtn, {TextColor3 = Expanded and Theme.Accent or Theme.SubText}) --[span_258](start_span)[span_258](end_span)
        end)

        local CatObj = {} --[span_259](start_span)[span_259](end_span)

        -- [2] دالة إنشاء خانة (Tab) داخل التصنيف مع تحسينات التصميم[span_260](start_span)[span_260](end_span)
        function CatObj:CreateTab(tabConfig)
            local tabName = tabConfig.Name --[span_261](start_span)[span_261](end_span)
            local tabIcon = tabConfig.Icon --[span_262](start_span)[span_262](end_span)

            local TabBtn = Instance.new("TextButton", CatFrame) --[span_263](start_span)[span_263](end_span)
            TabBtn.Size = UDim2.new(1, -10, 0, 32) --[span_264](start_span)[span_264](end_span)
            TabBtn.BackgroundColor3 = Theme.ElementBg --[span_265](start_span)[span_265](end_span)
            TabBtn.BackgroundTransparency = 0 -- إزالة الشفافية ليكون صلب حسب رغبتك
            TabBtn.Text = "" --[span_266](start_span)[span_266](end_span)
            Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6) --[span_267](start_span)[span_267](end_span)
            
            local TabBtnStroke = Instance.new("UIStroke", TabBtn) --[span_268](start_span)[span_268](end_span)
            TabBtnStroke.Color = Color3.fromRGB(45, 45, 55) --[span_269](start_span)[span_269](end_span)
            TabBtnStroke.Thickness = 1 --[span_270](start_span)[span_270](end_span)

            local TabLabel = Instance.new("TextLabel", TabBtn) --[span_271](start_span)[span_271](end_span)
            TabLabel.Size = UDim2.new(1, -35, 1, 0) --[span_272](start_span)[span_272](end_span)
            TabLabel.Position = UDim2.new(0, tabIcon and 32 or 12, 0, 0) --[span_273](start_span)[span_273](end_span)
            TabLabel.BackgroundTransparency = 1 --[span_274](start_span)[span_274](end_span)
            TabLabel.Text = tabName --[span_275](start_span)[span_275](end_span)
            TabLabel.TextColor3 = Theme.Text --[span_276](start_span)[span_276](end_span)
            TabLabel.Font = Enum.Font.GothamMedium --[span_277](start_span)[span_277](end_span)
            TabLabel.TextSize = 12 --[span_278](start_span)[span_278](end_span)
            TabLabel.TextXAlignment = Enum.TextXAlignment.Left --[span_279](start_span)[span_279](end_span)

            if tabIcon then --[span_280](start_span)[span_280](end_span)
                local IconImg = Instance.new("ImageLabel", TabBtn) --[span_281](start_span)[span_281](end_span)
                IconImg.Size = UDim2.fromOffset(14, 14) --[span_282](start_span)[span_282](end_span)
                IconImg.Position = UDim2.new(0, 10, 0.5, -7) --[span_283](start_span)[span_283](end_span)
                IconImg.BackgroundTransparency = 1 --[span_284](start_span)[span_284](end_span)
                IconImg.Image = tabIcon --[span_285](start_span)[span_285](end_span)
            end

            -- صفحة المحتوى الخاصة بالتاب[span_286](start_span)[span_286](end_span)
            local TabPage = Instance.new("ScrollingFrame", ContentContainer) --[span_287](start_span)[span_287](end_span)
            TabPage.Size = UDim2.new(1, 0, 1, 0) --[span_288](start_span)[span_288](end_span)
            TabPage.BackgroundTransparency = 1 --[span_289](start_span)[span_289](end_span)
            TabPage.ScrollBarThickness = 3 --[span_290](start_span)[span_290](end_span)
            TabPage.Visible = false --[span_291](start_span)[span_291](end_span)
            
            local PageLayout = Instance.new("UIListLayout", TabPage) --[span_292](start_span)[span_292](end_span)
            PageLayout.Padding = UDim.new(0, 8) --[span_293](start_span)[span_293](end_span)
            PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[span_294](start_span)[span_294](end_span)
                TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15) --[span_295](start_span)[span_295](end_span)
            end)

            -- معالجة نظام الضغط والتفتيح وتفعيل الحدود للخانات النشطة (Active States)[span_296](start_span)[span_296](end_span)
            TabBtn.MouseButton1Click:Connect(function() --[span_297](start_span)[span_297](end_span)
                if ActiveTab then --[span_298](start_span)[span_298](end_span)
                    ActiveTab.Page.Visible = false --[span_299](start_span)[span_299](end_span)
                    ActiveTab.Btn.BackgroundColor3 = Theme.ElementBg --[span_300](start_span)[span_300](end_span)
                    ActiveTab.Stroke.Color = Color3.fromRGB(45, 45, 55) --[span_301](start_span)[span_301](end_span)
                    ActiveTab.Stroke.Thickness = 1 --[span_302](start_span)[span_302](end_span)
                end
                
                -- تفتيح الخانة النشطة وإعطائها إطار نيون واضح[span_303](start_span)[span_303](end_span)
                ActiveTab = {Page = TabPage, Btn = TabBtn, Stroke = TabBtnStroke} --[span_304](start_span)[span_304](end_span)
                TabPage.Visible = true --[span_305](start_span)[span_305](end_span)
                TabBtn.BackgroundColor3 = Theme.ActiveTabBg --[span_306](start_span)[span_306](end_span)
                TabBtnStroke.Color = Theme.Accent --[span_307](start_span)[span_307](end_span)
                TabBtnStroke.Thickness = 1.5 --[span_308](start_span)[span_308](end_span)
            end)

            local Elements = {} --[span_309](start_span)[span_309](end_span)

            -- 1. إضافة عنوان قسم (Section)[span_310](start_span)[span_310](end_span)
            function Elements:CreateSection(title)
                local SecLabel = Instance.new("TextLabel", TabPage) --[span_311](start_span)[span_311](end_span)
                SecLabel.Size = UDim2.new(1, 0, 0, 25) --[span_312](start_span)[span_312](end_span)
                SecLabel.BackgroundTransparency = 1 --[span_313](start_span)[span_313](end_span)
                SecLabel.Text = "— " .. title --[span_314](start_span)[span_314](end_span)
                SecLabel.TextColor3 = Theme.Accent --[span_315](start_span)[span_315](end_span)
                SecLabel.Font = Enum.Font.GothamBold --[span_316](start_span)[span_316](end_span)
                SecLabel.TextSize = 13 --[span_317](start_span)[span_317](end_span)
                SecLabel.TextXAlignment = Enum.TextXAlignment.Left --[span_318](start_span)[span_318](end_span)
            end

            -- 2. إضافة زر تفاعلي (Button) مع أنميشن Bounce وتحسين الشكل[span_319](start_span)[span_319](end_span)
            function Elements:CreateButton(btnName, callback)
                local BtnBg = Instance.new("TextButton", TabPage) --[span_320](start_span)[span_320](end_span)
                BtnBg.Size = UDim2.new(1, -10, 0, 42) --[span_321](start_span)[span_321](end_span)
                BtnBg.BackgroundColor3 = Theme.ElementBg --[span_322](start_span)[span_322](end_span)
                BtnBg.Text = "" --[span_323](start_span)[span_323](end_span)
                BtnBg.AutoButtonColor = false --[span_324](start_span)[span_324](end_span)
                Instance.new("UICorner", BtnBg).CornerRadius = UDim.new(0, 6) --[span_325](start_span)[span_325](end_span)
                
                local BtnStroke = Instance.new("UIStroke", BtnBg) --[span_326](start_span)[span_326](end_span)
                BtnStroke.Color = Color3.fromRGB(45, 45, 55) --[span_327](start_span)[span_327](end_span)

                local BtnText = Instance.new("TextLabel", BtnBg) --[span_328](start_span)[span_328](end_span)
                BtnText.Size = UDim2.new(1, 0, 1, 0) --[span_329](start_span)[span_329](end_span)
                BtnText.BackgroundTransparency = 1 --[span_330](start_span)[span_330](end_span)
                BtnText.Text = btnName --[span_331](start_span)[span_331](end_span)
                BtnText.TextColor3 = Theme.Text --[span_332](start_span)[span_332](end_span)
                BtnText.Font = Enum.Font.GothamBold --[span_333](start_span)[span_333](end_span)
                BtnText.TextSize = 13 --[span_334](start_span)[span_334](end_span)

                BtnBg.MouseEnter:Connect(function() Tween(BtnBg, {BackgroundColor3 = Theme.ElementHover}) end) --[span_335](start_span)[span_335](end_span)
                BtnBg.MouseLeave:Connect(function() Tween(BtnBg, {BackgroundColor3 = Theme.ElementBg}) end) --[span_336](start_span)[span_336](end_span)
                
                BtnBg.MouseButton1Click:Connect(function() --[span_337](start_span)[span_337](end_span)
                    Tween(BtnText, {TextSize = 11}, 0.1) --[span_338](start_span)[span_338](end_span)
                    task.wait(0.08) --[span_339](start_span)[span_339](end_span)
                    Tween(BtnText, {TextSize = 13}, 0.1) --[span_340](start_span)[span_340](end_span)
                    if callback then pcall(callback) end --[span_341](start_span)[span_341](end_span)
                end)
                
                table.insert(AllElements, {Name = btnName, Obj = BtnBg, ParentPage = TabPage}) --[span_342](start_span)[span_342](end_span)
            end

            -- 3. إضافة سلايدر دقيق (Slider) بمؤشر تفاعلي عريض[span_343](start_span)[span_343](end_span)
            function Elements:CreateSlider(slConfig)
                local Min = slConfig.Min or 0 --[span_344](start_span)[span_344](end_span)
                local Max = slConfig.Max or 100 --[span_345](start_span)[span_345](end_span)
                local Default = slConfig.Default or Min --[span_346](start_span)[span_346](end_span)
                local callback = slConfig.Callback --[span_347](start_span)[span_347](end_span)

                local SlBg = Instance.new("Frame", TabPage) --[span_348](start_span)[span_348](end_span)
                SlBg.Size = UDim2.new(1, -10, 0, 60) --[span_349](start_span)[span_349](end_span)
                SlBg.BackgroundColor3 = Theme.ElementBg --[span_350](start_span)[span_350](end_span)
                Instance.new("UICorner", SlBg).CornerRadius = UDim.new(0, 6) --[span_351](start_span)[span_351](end_span)
                local SlStroke = Instance.new("UIStroke", SlBg) --[span_352](start_span)[span_352](end_span)
                SlStroke.Color = Color3.fromRGB(45, 45, 55) --[span_353](start_span)[span_353](end_span)

                local Title = Instance.new("TextLabel", SlBg) --[span_354](start_span)[span_354](end_span)
                Title.Size = UDim2.new(1, -80, 0, 20) --[span_355](start_span)[span_355](end_span)
                Title.Position = UDim2.new(0, 12, 0, 8) --[span_356](start_span)[span_356](end_span)
                Title.BackgroundTransparency = 1 --[span_357](start_span)[span_357](end_span)
                Title.Text = slConfig.Name --[span_358](start_span)[span_358](end_span)
                Title.TextColor3 = Theme.Text --[span_359](start_span)[span_359](end_span)
                Title.Font = Enum.Font.GothamMedium --[span_360](start_span)[span_360](end_span)
                Title.TextSize = 13 --[span_361](start_span)[span_361](end_span)
                Title.TextXAlignment = Enum.TextXAlignment.Left --[span_362](start_span)[span_362](end_span)

                local ValueLabel = Instance.new("TextLabel", SlBg) --[span_363](start_span)[span_363](end_span)
                ValueLabel.Size = UDim2.new(0, 60, 0, 20) --[span_364](start_span)[span_364](end_span)
                ValueLabel.Position = UDim2.new(1, -72, 0, 8) --[span_365](start_span)[span_365](end_span)
                ValueLabel.BackgroundTransparency = 1 --[span_366](start_span)[span_366](end_span)
                ValueLabel.Text = tostring(Default) --[span_367](start_span)[span_367](end_span)
                ValueLabel.TextColor3 = Theme.Accent --[span_368](start_span)[span_368](end_span)
                ValueLabel.Font = Enum.Font.GothamBold --[span_369](start_span)[span_369](end_span)
                ValueLabel.TextSize = 12 --[span_370](start_span)[span_370](end_span)
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right --[span_371](start_span)[span_371](end_span)

                local TrackBg = Instance.new("Frame", SlBg) --[span_372](start_span)[span_372](end_span)
                TrackBg.Size = UDim2.new(1, -24, 0, 8) --[span_373](start_span)[span_373](end_span)
                TrackBg.Position = UDim2.new(0, 12, 0, 38) --[span_374](start_span)[span_374](end_span)
                TrackBg.BackgroundColor3 = Color3.fromRGB(35, 35, 40) --[span_375](start_span)[span_375](end_span)
                Instance.new("UICorner", TrackBg).CornerRadius = UDim.new(1, 0) --[span_376](start_span)[span_376](end_span)

                local Fill = Instance.new("Frame", TrackBg) --[span_377](start_span)[span_377](end_span)
                Fill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0) --[span_378](start_span)[span_378](end_span)
                Fill.BackgroundColor3 = Theme.Accent --[span_379](start_span)[span_379](end_span)
                Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0) --[span_380](start_span)[span_380](end_span)

                local Dragging = false --[span_381](start_span)[span_381](end_span)
                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1) --[span_382](start_span)[span_382](end_span)
                    local value = math.floor(Min + ((Max - Min) * pos)) --[span_383](start_span)[span_383](end_span)
                    ValueLabel.Text = tostring(value) --[span_384](start_span)[span_384](end_span)
                    Tween(Fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1) --[span_385](start_span)[span_385](end_span)
                    if callback then pcall(callback, value) end --[span_386](start_span)[span_386](end_span)
                end

                TrackBg.InputBegan:Connect(function(input) --[span_387](start_span)[span_387](end_span)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then --[span_388](start_span)[span_388](end_span)
                        Dragging = true; UpdateSlider(input) --[span_389](start_span)[span_389](end_span)
                    end
                end)
                UserInputService.InputEnded:Connect(function(input) --[span_390](start_span)[span_390](end_span)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then Dragging = false end --[span_391](start_span)[span_391](end_span)
                end)
                UserInputService.InputChanged:Connect(function(input) --[span_392](start_span)[span_392](end_span)
                    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then --[span_393](start_span)[span_393](end_span)
                        UpdateSlider(input) --[span_394](start_span)[span_394](end_span)
                    end
                end)
                
                table.insert(AllElements, {Name = slConfig.Name, Obj = SlBg, ParentPage = TabPage}) --[span_395](start_span)[span_395](end_span)
            end

            -- 4. إضافة قائمة اختيار منسدلة (Selector / Dropdown)[span_396](start_span)[span_396](end_span)
            function Elements:CreateSelector(labelText, options, callback)
                local DropdownActive = false --[span_397](start_span)[span_397](end_span)
                local Container = Instance.new("Frame", TabPage) --[span_398](start_span)[span_398](end_span)
                Container.Size = UDim2.new(1, -10, 0, 42) --[span_399](start_span)[span_399](end_span)
                Container.BackgroundColor3 = Theme.ElementBg --[span_400](start_span)[span_400](end_span)
                Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6) --[span_401](start_span)[span_401](end_span)
                local ContainerStroke = Instance.new("UIStroke", Container) --[span_402](start_span)[span_402](end_span)
                ContainerStroke.Color = Color3.fromRGB(45, 45, 55) --[span_403](start_span)[span_403](end_span)

                local Label = Instance.new("TextLabel", Container) --[span_404](start_span)[span_404](end_span)
                Label.Size = UDim2.new(0.4, 0, 1, 0) --[span_405](start_span)[span_405](end_span)
                Label.Position = UDim2.new(0, 12, 0, 0) --[span_406](start_span)[span_406](end_span)
                Label.BackgroundTransparency = 1 --[span_407](start_span)[span_407](end_span)
                Label.Text = labelText --[span_408](start_span)[span_408](end_span)
                Label.TextColor3 = Theme.Text --[span_409](start_span)[span_409](end_span)
                Label.Font = Enum.Font.GothamBold --[span_410](start_span)[span_410](end_span)
                Label.TextSize = 13 --[span_411](start_span)[span_411](end_span)
                Label.TextXAlignment = Enum.TextXAlignment.Left --[span_412](start_span)[span_412](end_span)

                local SelectorBtn = Instance.new("TextButton", Container) --[span_413](start_span)[span_413](end_span)
                SelectorBtn.Size = UDim2.new(0.52, 0, 0, 28) --[span_414](start_span)[span_414](end_span)
                SelectorBtn.Position = UDim2.new(0.45, 0, 0.5, -14) --[span_415](start_span)[span_415](end_span)
                SelectorBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42) --[span_416](start_span)[span_416](end_span)
                SelectorBtn.Text = "Select..." --[span_417](start_span)[span_417](end_span)
                SelectorBtn.TextColor3 = Theme.SubText --[span_418](start_span)[span_418](end_span)
                SelectorBtn.Font = Enum.Font.GothamMedium --[span_419](start_span)[span_419](end_span)
                SelectorBtn.TextSize = 12 --[span_420](start_span)[span_420](end_span)
                Instance.new("UICorner", SelectorBtn).CornerRadius = UDim.new(0, 4) --[span_421](start_span)[span_421](end_span)
                Instance.new("UIStroke", SelectorBtn).Color = Color3.fromRGB(55, 55, 65) --[span_422](start_span)[span_422](end_span)

                local DropFrame = Instance.new("ScrollingFrame", TabPage) --[span_423](start_span)[span_423](end_span)
                DropFrame.Size = UDim2.new(1, -10, 0, 0) --[span_424](start_span)[span_424](end_span)
                DropFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25) --[span_425](start_span)[span_425](end_span)
                DropFrame.Visible = false --[span_426](start_span)[span_426](end_span)
                DropFrame.ScrollBarThickness = 2 --[span_427](start_span)[span_427](end_span)
                Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 6) --[span_428](start_span)[span_428](end_span)
                local DropStroke = Instance.new("UIStroke", DropFrame) --[span_429](start_span)[span_429](end_span)
                DropStroke.Color = Theme.Accent --[span_430](start_span)[span_430](end_span)

                local DropLayout = Instance.new("UIListLayout", DropFrame) --[span_431](start_span)[span_431](end_span)
                DropLayout.Padding = UDim.new(0, 4) --[span_432](start_span)[span_432](end_span)

                local function RefreshOptions()
                    for _, c in ipairs(DropFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end --[span_433](start_span)[span_433](end_span)
                    local actualOptions = (options == "Players") and {} or options --[span_434](start_span)[span_434](end_span)
                    if options == "Players" then --[span_435](start_span)[span_435](end_span)
                        for _, p in pairs(Players:GetPlayers()) do if p ~= Player then table.insert(actualOptions, p.Name) end end --[span_436](start_span)[span_436](end_span)
                    end

                    for _, optName in ipairs(actualOptions) do --[span_437](start_span)[span_437](end_span)
                        local LocBtn = Instance.new("TextButton", DropFrame) --[span_438](start_span)[span_438](end_span)
                        LocBtn.Size = UDim2.new(1, -8, 0, 28) --[span_439](start_span)[span_439](end_span)
                        LocBtn.BackgroundColor3 = Theme.ElementBg --[span_440](start_span)[span_440](end_span)
                        LocBtn.Text = optName --[span_441](start_span)[span_441](end_span)
                        LocBtn.TextColor3 = Theme.Text --[span_442](start_span)[span_442](end_span)
                        LocBtn.Font = Enum.Font.Gotham --[span_443](start_span)[span_443](end_span)
                        LocBtn.TextSize = 12 --[span_444](start_span)[span_444](end_span)
                        Instance.new("UICorner", LocBtn).CornerRadius = UDim.new(0, 4) --[span_445](start_span)[span_445](end_span)

                        LocBtn.MouseButton1Click:Connect(function() --[span_446](start_span)[span_446](end_span)
                            SelectorBtn.Text = optName --[span_447](start_span)[span_447](end_span)
                            DropdownActive = false --[span_448](start_span)[span_448](end_span)
                            Tween(DropFrame, {Size = UDim2.new(1, -10, 0, 0)}, 0.2) --[span_449](start_span)[span_449](end_span)
                            task.wait(0.2) DropFrame.Visible = false --[span_450](start_span)[span_450](end_span)
                            if callback then pcall(callback, optName) end --[span_451](start_span)[span_451](end_span)
                        end)
                    end
                end

                SelectorBtn.MouseButton1Click:Connect(function() --[span_452](start_span)[span_452](end_span)
                    DropdownActive = not DropdownActive --[span_453](start_span)[span_453](end_span)
                    if DropdownActive then --[span_454](start_span)[span_454](end_span)
                        RefreshOptions() --[span_455](start_span)[span_455](end_span)
                        DropFrame.Visible = true --[span_456](start_span)[span_456](end_span)
                        Tween(DropFrame, {Size = UDim2.new(1, -10, 0, math.clamp(DropLayout.AbsoluteContentSize.Y + 6, 40, 120))}, 0.3) --[span_457](start_span)[span_457](end_span)
                    else
                        local tw = TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, 0)}) --[span_458](start_span)[span_458](end_span)
                        tw:Play() tw.Completed:Connect(function() if not DropdownActive then DropFrame.Visible = false end end) --[span_459](start_span)[span_459](end_span)
                    end
                end)

                table.insert(AllElements, {Name = labelText, Obj = Container, ParentPage = TabPage}) --[span_460](start_span)[span_460](end_span)
            end

            -- 5. إضافة حقل إدخال نصوص (Textbox) مع تأثير الفلاش النصي الاحترافي[span_461](start_span)[span_461](end_span)
            function Elements:CreateTextbox(labelText, placeholder, callback)
                local Container = Instance.new("Frame", TabPage) --[span_462](start_span)[span_462](end_span)
                Container.Size = UDim2.new(1, -10, 0, 42) --[span_463](start_span)[span_463](end_span)
                Container.BackgroundColor3 = Theme.ElementBg --[span_464](start_span)[span_464](end_span)
                Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6) --[span_465](start_span)[span_465](end_span)
                local ContainerStroke = Instance.new("UIStroke", Container) --[span_466](start_span)[span_466](end_span)
                ContainerStroke.Color = Color3.fromRGB(45, 45, 55) --[span_467](start_span)[span_467](end_span)

                local Label = Instance.new("TextLabel", Container) --[span_468](start_span)[span_468](end_span)
                Label.Size = UDim2.new(0.4, 0, 1, 0) --[span_469](start_span)[span_469](end_span)
                Label.Position = UDim2.new(0, 12, 0, 0) --[span_470](start_span)[span_470](end_span)
                Label.BackgroundTransparency = 1 --[span_471](start_span)[span_471](end_span)
                Label.Text = labelText --[span_472](start_span)[span_472](end_span)
                Label.TextColor3 = Theme.Text --[span_473](start_span)[span_473](end_span)
                Label.Font = Enum.Font.GothamBold --[span_474](start_span)[span_474](end_span)
                Label.TextSize = 13 --[span_475](start_span)[span_475](end_span)
                Label.TextXAlignment = Enum.TextXAlignment.Left --[span_476](start_span)[span_476](end_span)

                local Input = Instance.new("TextBox", Container) --[span_477](start_span)[span_477](end_span)
                Input.Size = UDim2.new(0.52, 0, 0, 28) --[span_478](start_span)[span_478](end_span)
                Input.Position = UDim2.new(0.45, 0, 0.5, -14) --[span_479](start_span)[span_479](end_span)
                Input.BackgroundColor3 = Color3.fromRGB(35, 35, 42) --[span_480](start_span)[span_480](end_span)
                Input.PlaceholderText = placeholder --[span_481](start_span)[span_481](end_span)
                Input.Text = "" --[span_482](start_span)[span_482](end_span)
                Input.TextColor3 = Theme.Accent --[span_483](start_span)[span_483](end_span)
                Input.Font = Enum.Font.GothamBold --[span_484](start_span)[span_484](end_span)
                Input.TextSize = 12 --[span_485](start_span)[span_485](end_span)
                Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 4) --[span_486](start_span)[span_486](end_span)
                Instance.new("UIStroke", Input).Color = Color3.fromRGB(55, 55, 65) --[span_487](start_span)[span_487](end_span)

                Input:GetPropertyChangedSignal("Text"):Connect(function() --[span_488](start_span)[span_488](end_span)
                    Input.TextTransparency = 0.5 --[span_489](start_span)[span_489](end_span)
                    Tween(Input, {TextTransparency = 0}, 0.2) --[span_490](start_span)[span_490](end_span)
                    if callback then pcall(callback, Input.Text) end --[span_491](start_span)[span_491](end_span)
                end)

                table.insert(AllElements, {Name = labelText, Obj = Container, ParentPage = TabPage}) --[span_492](start_span)[span_492](end_span)
            end

            return Elements --[span_493](start_span)[span_493](end_span)
        end
        return CatObj --[span_494](start_span)[span_494](end_span)
    end

    -- برمجة محرك البحث المتكامل والمصلح[span_495](start_span)[span_495](end_span)
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function() --[span_496](start_span)[span_496](end_span)
        local query = string.lower(SearchBox.Text) --[span_497](start_span)[span_497](end_span)
        if query == "" then --[span_498](start_span)[span_498](end_span)
            SearchOverlay.Visible = false --[span_499](start_span)[span_499](end_span)
            if ActiveTab then ActiveTab.Page.Visible = true end --[span_500](start_span)[span_500](end_span)
        else
            if ActiveTab then ActiveTab.Page.Visible = false end --[span_501](start_span)[span_501](end_span)
            SearchOverlay.Visible = true --[span_502](start_span)[span_502](end_span)
            
            -- تنظيف شاشة البحث وإعادة تخصيص العناصر المطابقة[span_503](start_span)[span_503](end_span)
            for _, item in pairs(AllElements) do --[span_504](start_span)[span_504](end_span)
                if string.find(string.lower(item.Name), query) then --[span_505](start_span)[span_505](end_span)
                    item.Obj.Parent = SearchOverlay --[span_506](start_span)[span_506](end_span)
                    item.Obj.Visible = true --[span_507](start_span)[span_507](end_span)
                else
                    item.Obj.Visible = false --[span_508](start_span)[span_508](end_span)
                end
            end
        end
    end)

    -- إعادة العناصر لوضعها الأصلي عند مسح البحث[span_509](start_span)[span_509](end_span)
    SearchBox.FocusLost:Connect(function() --[span_510](start_span)[span_510](end_span)
        if SearchBox.Text == "" then --[span_511](start_span)[span_511](end_span)
            SearchOverlay.Visible = false --[span_512](start_span)[span_512](end_span)
            for _, item in pairs(AllElements) do --[span_513](start_span)[span_513](end_span)
                item.Obj.Parent = item.ParentPage --[span_514](start_span)[span_514](end_span)
                item.Obj.Visible = true --[span_515](start_span)[span_515](end_span)
            end
            if ActiveTab then ActiveTab.Page.Visible = true end --[span_516](start_span)[span_516](end_span)
        end
    end)

    return WindowObj --[span_517](start_span)[span_517](end_span)
end

return VunixLib --[span_518](start_span)[span_518](end_span)