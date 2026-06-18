-- ملف الزر يستقبل كل المتغيرات التي مررناها من Tab.lua
return function(ParentPage, btnName, callback, Theme, Utils, AllElements)
    local BtnBg = Instance.new("TextButton", ParentPage)
    BtnBg.Size = UDim2.new(1, -10, 0, 42)
    BtnBg.BackgroundColor3 = Theme.ElementBg
    BtnBg.Text = btnName
    BtnBg.TextColor3 = Theme.Text
    
    -- استخدام دالة Tween من ملف Utilities
    BtnBg.MouseEnter:Connect(function() 
        Utils.Tween(BtnBg, {BackgroundColor3 = Theme.ElementHover}) 
    end)
    
    BtnBg.MouseLeave:Connect(function() 
        Utils.Tween(BtnBg, {BackgroundColor3 = Theme.ElementBg}) 
    end)
    
    BtnBg.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)

    table.insert(AllElements, {Name = btnName, Obj = BtnBg, ParentPage = ParentPage})
    
    return BtnBg
end
