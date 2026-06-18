-- [[ VunixUI | Ultra Modern Edition 2026 - No More 1900s ]]
-- [[ Rounded, Animated, Premium Elements & PopUps ]]

local VunixLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local StartTime = tick()

-- [ ثيم جديد كلياً: ألوان عصرية وفخمة (وداعاً للأبيض والأسود) ]
local Theme = {
    Background = Color3.fromRGB(15, 15, 20),    -- كحلي ليلي عميق
    Sidebar = Color3.fromRGB(22, 22, 30),       -- كحلي أفتح للجانب
    ElementBg = Color3.fromRGB(30, 30, 42),     -- لون العناصر الأساسي
    ElementHover = Color3.fromRGB(45, 45, 60),  -- لون عند التأشير
    ActiveTabBg = Color3.fromRGB(55, 55, 75),   -- لون التاب النشط
    Text = Color3.fromRGB(245, 245, 255),       -- أبيض ناصع
    Accent = Color3.fromRGB(0, 235, 255),       -- سماوي نيون
    GradientStart = Color3.fromRGB(180, 0, 255),-- بنفسجي نيون
    SubText = Color3.fromRGB(160, 160, 180),    -- سكني فاتح
    Danger = Color3.fromRGB(255, 55, 75)        -- أحمر احترافي للحذف
}

local function GetSafeUIFolder()
    if gethui then 
        local success, result = pcall(gethui)
        if success and result then return result end
    end
    return pcall(function() return CoreGui end) and CoreGui or Player:WaitForChild("PlayerGui")
end

local function Tween(obj, props, time)
    return TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

local function ApplyPremiumGradient(parent)
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.GradientStart),
        ColorSequenceKeypoint.new(1, Theme.Accent)
    })
    Gradient.Rotation = 45
    Gradient.Parent = parent
    return Gradient
end

function VunixLib:CreateWindow(Config)
    local hubName = Config.Title or "Vunix Prime"
    local logoId = Config.LogoId or "17829927053"
    
    local ScreenGuiParent = GetSafeUIFolder()
    if ScreenGuiParent:FindFirstChild("VunixPremiumHub") then 
        ScreenGuiParent.VunixPremiumHub:Destroy() 
    end

    local ScreenGui = Instance.new("ScreenGui", ScreenGuiParent)
    ScreenGui.Name = "VunixPremiumHub"
    ScreenGui.ResetOnSpawn = false

    local BlurInstance = Lighting:FindFirstChild("VunixPremiumBlur")
    if BlurInstance then BlurInstance:Destroy() end
    
    local function ToggleBlur(state)
        if state then
            BlurInstance = Instance.new("BlurEffect", Lighting)
            BlurInstance.Name = "VunixPremiumBlur"
            BlurInstance.Size = 0
            TweenService:Create(BlurInstance, TweenInfo.new(0.5), {Size = 10}):Play()
        else
            if BlurInstance then
                local t = TweenService:Create(BlurInstance, TweenInfo.new(0.4), {Size = 0})
                t:Play()
                t.Completed:Connect(function() if BlurInstance then BlurInstance:Destroy() end end)
            end
        end
    end

    local Main = Instance.new("CanvasGroup", ScreenGui)
    Main.Size = UDim2.fromOffset(680, 480)
    Main.Position = UDim2.new(0.5, -340, -0.6, 0)
    Main.BackgroundColor3 = Theme.Background
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16) -- زوايا أنعم جداً
    
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Thickness = 2
    ApplyPremiumGradient(MainStroke)

    ToggleBlur(true)
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -340, 0.5, -240),
        GroupTransparency = 0
    }):Play()

    -- [ نظام البوب أب (Pop-Up System) المطور ]
    local PopupOverlay = Instance.new("Frame", ScreenGui)
    PopupOverlay.Size = UDim2.new(1, 0, 1, 0)
    PopupOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    PopupOverlay.BackgroundTransparency = 1
    PopupOverlay.Visible = false
    PopupOverlay.ZIndex = 100

    local PopupFrame = Instance.new("Frame", PopupOverlay)
    PopupFrame.Size = UDim2.fromOffset(320, 200)
    PopupFrame.Position = UDim2.new(0.5, -160, 0.5, 50) -- يبدأ من تحت شوي للأنميشن
    PopupFrame.BackgroundColor3 = Theme.Sidebar
    PopupFrame.GroupTransparency = 1
    Instance.new("UICorner", PopupFrame).CornerRadius = UDim.new(0, 14)
    local PopStroke = Instance.new("UIStroke", PopupFrame)
    PopStroke.Color = Theme.Accent
    PopStroke.Thickness = 1.5

    local PopTitle = Instance.new("TextLabel", PopupFrame)
    PopTitle.Size = UDim2.new(1, 0, 0, 40)
    PopTitle.BackgroundTransparency = 1
    PopTitle.Text = "Title"
    PopTitle.TextColor3 = Theme.Accent
    PopTitle.Font = Enum.Font.GothamBold
    PopTitle.TextSize = 18

    local PopDesc = Instance.new("TextLabel", PopupFrame)
    PopDesc.Size = UDim2.new(1, -40, 0, 40)
    PopDesc.Position = UDim2.new(0, 20, 0, 40)
    PopDesc.BackgroundTransparency = 1
    PopDesc.Text = "Description"
    PopDesc.TextColor3 = Theme.SubText
    PopDesc.Font = Enum.Font.GothamMedium
    PopDesc.TextSize = 13
    PopDesc.TextWrapped = true

    local PopBtnContainer = Instance.new("Frame", PopupFrame)
    PopBtnContainer.Size = UDim2.new(1, -40, 0, 90)
    PopBtnContainer.Position = UDim2.new(0, 20, 0, 95)
    PopBtnContainer.BackgroundTransparency = 1
    
    local PopLayout = Instance.new("UIListLayout", PopBtnContainer)
    PopLayout.FillDirection = Enum.FillDirection.Vertical -- الأزرار فوق بعض
    PopLayout.Padding = UDim.new(0, 8)
    PopLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function CreatePopBtn(text, color)
        local btn = Instance.new("TextButton", PopBtnContainer)
        btn.Size = UDim2.new(1, 0, 0, 38)
        btn.BackgroundColor3 = color
        btn.Text = text
        btn.TextColor3 = Theme.Text
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        return btn
    end

    local BtnTop = CreatePopBtn("Button 1", Theme.ElementBg)
    local BtnBottom = CreatePopBtn("Button 2", Theme.Danger)

    local function ShowPopup(title, desc, topText, topCb, bottomText, bottomCb)
        PopTitle.Text = title
        PopDesc.Text = desc
        BtnTop.Text = topText
        BtnBottom.Text = bottomText

        -- تنظيف الأوامر السابقة
        for _, conn in pairs(getconnections(BtnTop.MouseButton1Click) or {}) do conn:Disable() end
        for _, conn in pairs(getconnections(BtnBottom.MouseButton1Click) or {}) do conn:Disable() end

        BtnTop.MouseButton1Click:Connect(function()
            Tween(PopupFrame, {Position = UDim2.new(0.5, -160, 0.5, 50)}, 0.3)
            Tween(PopupOverlay, {BackgroundTransparency = 1}, 0.3)
            task.wait(0.3)
            PopupOverlay.Visible = false
            if topCb then topCb() end
        end)

        BtnBottom.MouseButton1Click:Connect(function()
            Tween(PopupFrame, {Position = UDim2.new(0.5, -160, 0.5, 50)}, 0.3)
            Tween(PopupOverlay, {BackgroundTransparency = 1}, 0.3)
            task.wait(0.3)
            PopupOverlay.Visible = false
            if bottomCb then bottomCb() end
        end)

        PopupOverlay.Visible = true
        Tween(PopupOverlay, {BackgroundTransparency = 0.5}, 0.3)
        Tween(PopupFrame, {Position = UDim2.new(0.5, -160, 0.5, -100)}, 0.4)
    end

    -- TopBar
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundTransparency = 1

    local HubTitle = Instance.new("TextLabel", TopBar)
    HubTitle.Size = UDim2.new(0, 300, 1, 0)
    HubTitle.Position = UDim2.new(0, 20, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = hubName
    HubTitle.TextColor3 = Theme.Text
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextSize = 18
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left
    ApplyPremiumGradient(HubTitle)

    -- زر الإغلاق مع البوب أب
    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.fromOffset(30, 30)
    CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Theme.Danger
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18

    CloseBtn.MouseButton1Click:Connect(function()
        ShowPopup(
            "Close Interface?",
            "Are you sure you want to completely remove this UI?",
            "Cancel", function() end,
            "Remove", function()
                ToggleBlur(false)
                -- أنميشن الحذف الاحترافي (تصغير وتلاشي)
                local destructTween = TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.fromOffset(0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    GroupTransparency = 1
                })
                destructTween:Play()
                destructTween.Completed:Connect(function() ScreenGui:Destroy() end)
            end
        )
    end)

    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
        end
    end)
    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 200, 1, -60)
    Sidebar.Position = UDim2.new(0, 10, 0, 50)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

    local TabsScroll = Instance.new("ScrollingFrame", Sidebar)
    TabsScroll.Size = UDim2.new(1, 0, 1, -10)
    TabsScroll.Position = UDim2.new(0, 0, 0, 10)
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.ScrollBarThickness = 0
    local TabsLayout = Instance.new("UIListLayout", TabsScroll)
    TabsLayout.Padding = UDim.new(0, 8)
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local ContentContainer = Instance.new("Frame", Main)
    ContentContainer.Size = UDim2.new(1, -230, 1, -60)
    ContentContainer.Position = UDim2.new(0, 220, 0, 50)
    ContentContainer.BackgroundTransparency = 1

    local WindowObj = {}
    local ActiveTab = nil
    local AllElements = {}

    function WindowObj:CreateCategory(catName)
        local CatFrame = Instance.new("Frame", TabsScroll)
        CatFrame.Size = UDim2.new(1, -20, 0, 40)
        CatFrame.BackgroundColor3 = Theme.ElementBg
        CatFrame.ClipsDescendants = true
        Instance.new("UICorner", CatFrame).CornerRadius = UDim.new(0, 8)

        local CatBtn = Instance.new("TextButton", CatFrame)
        CatBtn.Size = UDim2.new(1, 0, 0, 40)
        CatBtn.BackgroundTransparency = 1
        CatBtn.Text = "   " .. catName
        CatBtn.TextColor3 = Theme.Text
        CatBtn.Font = Enum.Font.GothamBold
        CatBtn.TextSize = 13
        CatBtn.TextXAlignment = Enum.TextXAlignment.Left

        local SubTabsLayout = Instance.new("UIListLayout", CatFrame)
        SubTabsLayout.Padding = UDim.new(0, 4)
        SubTabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        local Expanded = false
        CatBtn.MouseButton1Click:Connect(function()
            Expanded = not Expanded
            local targetHeight = Expanded and (SubTabsLayout.AbsoluteContentSize.Y + 10) or 40
            Tween(CatFrame, {Size = UDim2.new(1, -20, 0, targetHeight)})
            Tween(CatBtn, {TextColor3 = Expanded and Theme.Accent or Theme.Text})
        end)

        local CatObj = {}

        function CatObj:CreateTab(tabName)
            local TabBtn = Instance.new("TextButton", CatFrame)
            TabBtn.Size = UDim2.new(1, -10, 0, 36)
            TabBtn.BackgroundColor3 = Theme.Sidebar
            TabBtn.Text = tabName
            TabBtn.TextColor3 = Theme.SubText
            TabBtn.Font = Enum.Font.GothamMedium
            TabBtn.TextSize = 12
            Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

            local TabPage = Instance.new("ScrollingFrame", ContentContainer)
            TabPage.Size = UDim2.new(1, 0, 1, 0)
            TabPage.BackgroundTransparency = 1
            TabPage.ScrollBarThickness = 2
            TabPage.Visible = false
            
            local PageLayout = Instance.new("UIListLayout", TabPage)
            PageLayout.Padding = UDim.new(0, 10)
            PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15)
            end)

            TabBtn.MouseButton1Click:Connect(function()
                if ActiveTab then
                    ActiveTab.Page.Visible = false
                    Tween(ActiveTab.Btn, {BackgroundColor3 = Theme.Sidebar, TextColor3 = Theme.SubText})
                end
                ActiveTab = {Page = TabPage, Btn = TabBtn}
                TabPage.Visible = true
                Tween(TabBtn, {BackgroundColor3 = Theme.ActiveTabBg, TextColor3 = Theme.Accent})
            end)

            local Elements = {}

            -- تحسين الأزرار
            function Elements:CreateButton(btnName, callback)
                local BtnBg = Instance.new("TextButton", TabPage)
                BtnBg.Size = UDim2.new(1, -10, 0, 45)
                BtnBg.BackgroundColor3 = Theme.ElementBg
                BtnBg.Text = btnName
                BtnBg.TextColor3 = Theme.Text
                BtnBg.Font = Enum.Font.GothamBold
                BtnBg.TextSize = 13
                Instance.new("UICorner", BtnBg).CornerRadius = UDim.new(0, 8) -- دائري وجميل

                BtnBg.MouseEnter:Connect(function() Tween(BtnBg, {BackgroundColor3 = Theme.ElementHover}) end)
                BtnBg.MouseLeave:Connect(function() Tween(BtnBg, {BackgroundColor3 = Theme.ElementBg}) end)
                
                BtnBg.MouseButton1Click:Connect(function()
                    Tween(BtnBg, {Size = UDim2.new(1, -16, 0, 40)}, 0.1)
                    task.wait(0.1)
                    Tween(BtnBg, {Size = UDim2.new(1, -10, 0, 45)}, 0.1)
                    if callback then pcall(callback) end
                end)
            end

            -- تحسين السلايدر (شكل انسيابي)
            function Elements:CreateSlider(name, min, max, default, callback)
                local SlBg = Instance.new("Frame", TabPage)
                SlBg.Size = UDim2.new(1, -10, 0, 65)
                SlBg.BackgroundColor3 = Theme.ElementBg
                Instance.new("UICorner", SlBg).CornerRadius = UDim.new(0, 10)

                local Title = Instance.new("TextLabel", SlBg)
                Title.Size = UDim2.new(1, -20, 0, 25)
                Title.Position = UDim2.new(0, 15, 0, 5)
                Title.BackgroundTransparency = 1
                Title.Text = name
                Title.TextColor3 = Theme.Text
                Title.Font = Enum.Font.GothamBold
                Title.TextSize = 13
                Title.TextXAlignment = Enum.TextXAlignment.Left

                local ValLabel = Instance.new("TextLabel", SlBg)
                ValLabel.Size = UDim2.new(0, 50, 0, 25)
                ValLabel.Position = UDim2.new(1, -65, 0, 5)
                ValLabel.BackgroundTransparency = 1
                ValLabel.Text = tostring(default)
                ValLabel.TextColor3 = Theme.Accent
                ValLabel.Font = Enum.Font.GothamBold
                ValLabel.TextSize = 13

                local Track = Instance.new("Frame", SlBg)
                Track.Size = UDim2.new(1, -30, 0, 8)
                Track.Position = UDim2.new(0, 15, 0, 40)
                Track.BackgroundColor3 = Theme.Sidebar
                Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

                local Fill = Instance.new("Frame", Track)
                Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                Fill.BackgroundColor3 = Theme.Accent
                Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

                local dragging = false
                local function move(input)
                    local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                    local val = math.floor(min + ((max - min) * pos))
                    ValLabel.Text = tostring(val)
                    Tween(Fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1)
                    if callback then pcall(callback, val) end
                end

                Track.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; move(inp) end end)
                UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
                UserInputService.InputChanged:Connect(function(inp) if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then move(inp) end end)
            end

            -- تحسين الدروب داون (Dropdown)
            function Elements:CreateDropdown(name, options, callback)
                local DropBg = Instance.new("Frame", TabPage)
                DropBg.Size = UDim2.new(1, -10, 0, 45)
                DropBg.BackgroundColor3 = Theme.ElementBg
                DropBg.ClipsDescendants = true
                Instance.new("UICorner", DropBg).CornerRadius = UDim.new(0, 8)

                local DropBtn = Instance.new("TextButton", DropBg)
                DropBtn.Size = UDim2.new(1, 0, 0, 45)
                DropBtn.BackgroundTransparency = 1
                DropBtn.Text = "   " .. name .. " : Select"
                DropBtn.TextColor3 = Theme.Text
                DropBtn.Font = Enum.Font.GothamBold
                DropBtn.TextSize = 13
                DropBtn.TextXAlignment = Enum.TextXAlignment.Left

                local DropList = Instance.new("UIListLayout", DropBg)
                DropList.Padding = UDim.new(0, 5)
                DropList.HorizontalAlignment = Enum.HorizontalAlignment.Center

                local isOpen = false
                DropBtn.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    Tween(DropBg, {Size = UDim2.new(1, -10, 0, isOpen and (DropList.AbsoluteContentSize.Y + 10) or 45)})
                end)

                for _, opt in ipairs(options) do
                    local OptBtn = Instance.new("TextButton", DropBg)
                    OptBtn.Size = UDim2.new(1, -20, 0, 35)
                    OptBtn.BackgroundColor3 = Theme.Sidebar
                    OptBtn.Text = opt
                    OptBtn.TextColor3 = Theme.SubText
                    OptBtn.Font = Enum.Font.GothamMedium
                    OptBtn.TextSize = 12
                    Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)

                    OptBtn.MouseButton1Click:Connect(function()
                        DropBtn.Text = "   " .. name .. " : " .. opt
                        isOpen = false
                        Tween(DropBg, {Size = UDim2.new(1, -10, 0, 45)})
                        if callback then pcall(callback, opt) end
                    end)
                end
            end

            return Elements
        end
        return CatObj
    end

    return WindowObj
end

return VunixLib