-- [[ PandaUI Element | Interactive Button ]]
return function(Parent, btnName, callback, Theme, Utils, AllElements)
    local BtnBg = Instance.new("TextButton", Parent)
    BtnBg.Size = UDim2.new(1, -10, 0, 42)
    BtnBg.BackgroundColor3 = Theme.ElementBg
    BtnBg.Text = ""
    BtnBg.AutoButtonColor = false
    Instance.new("UICorner", BtnBg).CornerRadius = UDim.new(0, 6)
    
    local BtnStroke = Instance.new("UIStroke", BtnBg)
    BtnStroke.Color = Color3.fromRGB(45, 45, 55)

    local BtnText = Instance.new("TextLabel", BtnBg)
    BtnText.Size = UDim2.new(1, 0, 1, 0)
    BtnText.BackgroundTransparency = 1
    BtnText.Text = btnName
    BtnText.TextColor3 = Theme.Text
    BtnText.Font = Enum.Font.GothamBold
    BtnText.TextSize = 13

    BtnBg.MouseEnter:Connect(function() Utils.Tween(BtnBg, {BackgroundColor3 = Theme.ElementHover}) end)
    BtnBg.MouseLeave:Connect(function() Utils.Tween(BtnBg, {BackgroundColor3 = Theme.ElementBg}) end)
    
    BtnBg.MouseButton1Click:Connect(function()
        Utils.Tween(BtnText, {TextSize = 11}, 0.1)
        task.wait(0.08)
        Utils.Tween(BtnText, {TextSize = 13}, 0.1)
        if callback then pcall(callback) end
    end)
    
    table.insert(AllElements, {Name = btnName, Obj = BtnBg, ParentPage = Parent})
    return BtnBg
end
