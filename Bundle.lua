-- [[ Kernel Hub | Unified Core - Solid Design Edition 2026 ]]
-- [[ Developed by Kernel - No external bundles required ]]

local VunixLib = {}

-- [[ 1. الإعدادات والخدمات الأساسية ]]
local TweenService = game:GetService("TweenService") --[span_1](start_span)[span_1](end_span)
local UserInputService = game:GetService("UserInputService") --[span_2](start_span)[span_2](end_span)
local CoreGui = game:GetService("CoreGui") --[span_3](start_span)[span_3](end_span)
local Players = game:GetService("Players") --[span_4](start_span)[span_4](end_span)

local Theme = {
    Background = Color3.fromRGB(12, 12, 14),
    ElementBg = Color3.fromRGB(24, 24, 28),
    Accent = Color3.fromRGB(0, 255, 255),
    Text = Color3.fromRGB(255, 255, 255)
}

-- [[ 2. دوال الأنميشن والتصميم الصلب ]]
local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play() --[span_5](start_span)[span_5](end_span)
end

-- [[ 3. وظائف النظام الأساسية (بدون الحاجة لـ Bundle) ]]
function VunixLib:Init(Config)
    local ScreenGui = Instance.new("ScreenGui", CoreGui) --[span_6](start_span)[span_6](end_span)
    ScreenGui.Name = "KernelHub_Core" --[span_7](start_span)[span_7](end_span)
    
    local Main = Instance.new("Frame", ScreenGui) --[span_8](start_span)[span_8](end_span)
    Main.Size = UDim2.fromOffset(600, 400) --[span_9](start_span)[span_9](end_span)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200) --[span_10](start_span)[span_10](end_span)
    Main.BackgroundColor3 = Theme.Background --[span_11](start_span)[span_11](end_span)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10) --[span_12](start_span)[span_12](end_span)
    
    -- إضافة زر الإغلاق المباشر
    local CloseBtn = Instance.new("TextButton", Main) --[span_13](start_span)[span_13](end_span)
    CloseBtn.Size = UDim2.fromOffset(30, 30) --[span_14](start_span)[span_14](end_span)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5) --[span_15](start_span)[span_15](end_span)
    CloseBtn.Text = "X" --[span_16](start_span)[span_16](end_span)
    CloseBtn.TextColor3 = Color3.fromRGB(255, 65, 65) --[span_17](start_span)[span_17](end_span)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end) --[span_18](start_span)[span_18](end_span)
    
    print("Kernel Hub Initialized Successfully [No Bundle Needed]") --[span_19](start_span)[span_19](end_span)
end

-- [[ 4. تنفيذ النظام مباشرة ]]
VunixLib:Init({Title = "Kernel Hub"}) --[span_20](start_span)[span_20](end_span)

return VunixLib

