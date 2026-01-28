-- [[ ASTRAL UI LIBRARY: ABSOLUTE EDITION ]]
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Astral = {Tabs = {}, Elements = {}}

local function Ani(obj, time, goal)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quint), goal):Play()
end

function Astral:Notify(title, text, duration)
    local Holder = CoreGui:FindFirstChild("Astral_NotifHolder") or Instance.new("Frame", CoreGui)
    if Holder.Name ~= "Astral_NotifHolder" then
        Holder.Name = "Astral_NotifHolder"; Holder.Size = UDim2.new(0, 300, 1, -20); Holder.Position = UDim2.new(1, -310, 0, 10); Holder.BackgroundTransparency = 1
        Instance.new("UIListLayout", Holder).VerticalAlignment = Enum.VerticalAlignment.Bottom
        Holder.UIListLayout.Padding = UDim.new(0, 10)
    end

    local N = Instance.new("Frame", Holder)
    N.Size = UDim2.new(1, 0, 0, 0); N.BackgroundColor3 = Color3.fromRGB(15, 15, 25); N.ClipsDescendants = true
    Instance.new("UICorner", N).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", N).Color = Color3.fromRGB(138, 43, 226)

    local T = Instance.new("TextLabel", N)
    T.Text = title:upper(); T.Size = UDim2.new(1, -10, 0, 25); T.Position = UDim2.new(0, 12, 0, 5); T.TextColor3 = Color3.fromRGB(138, 43, 226); T.Font = "GothamBold"; T.BackgroundTransparency = 1; T.TextXAlignment = "Left"

    local D = Instance.new("TextLabel", N)
    D.Text = text; D.Size = UDim2.new(1, -24, 0, 30); D.Position = UDim2.new(0, 12, 0, 28); D.TextColor3 = Color3.fromRGB(200, 200, 200); D.Font = "Gotham"; D.TextWrapped = true; D.BackgroundTransparency = 1; D.TextXAlignment = "Left"; D.TextSize = 12

    Ani(N, 0.5, {Size = UDim2.new(1, 0, 0, 70)})
    task.delay(duration or 5, function()
        Ani(N, 0.5, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1})
        task.wait(0.5); N:Destroy()
    end)
end

function Astral:CreateWindow(cfg)
    local MainGui = Instance.new("ScreenGui", CoreGui)
    MainGui.Name = "Astral_UI"

    if cfg.loading then
        local Intro = Instance.new("Frame", MainGui)
        Intro.Size = UDim2.new(1, 0, 1, 0); Intro.BackgroundColor3 = Color3.fromRGB(5, 5, 10); Intro.ZIndex = 999
        local Lbl = Instance.new("TextLabel", Intro)
        Lbl.Text = cfg.Title:upper(); Lbl.Font = "GothamBold"; Lbl.TextSize = 60; Lbl.TextColor3 = Color3.fromRGB(138, 43, 226); Lbl.Size = UDim2.new(1, 0, 1, 0); Lbl.BackgroundTransparency = 1
        task.spawn(function()
            task.wait(1.5); Ani(Lbl, 1, {TextTransparency = 1}); Ani(Intro, 1, {BackgroundTransparency = 1}); task.wait(1); Intro:Destroy()
        end)
    end

    local ToggleBtn = Instance.new("ImageButton", MainGui)
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50); ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25); ToggleBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 18); ToggleBtn.Image = "rbxassetid://6031094678"; ToggleBtn.ImageColor3 = Color3.fromRGB(138, 43, 226)
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(138, 43, 226)

    local Frame = Instance.new("Frame", MainGui)
    Frame.Size = UDim2.new(0, 620, 0, 420); Frame.Position = UDim2.new(0.5, -310, 0.5, -210); Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", Frame).Color = Color3.fromRGB(138, 43, 226)

    local TopBar = Instance.new("Frame", Frame)
    TopBar.Size = UDim2.new(1, 0, 0, 50); TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 26); Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)
    
    local TitleLbl = Instance.new("TextLabel", TopBar)
    TitleLbl.Text = "  " .. cfg.Title .. " <font color='#8A2BE2'>" .. cfg.Subtitle .. "</font>"; TitleLbl.RichText = true; TitleLbl.Size = UDim2.new(0.5, 0, 1, 0); TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255); TitleLbl.Font = "GothamBold"; TitleLbl.TextXAlignment = "Left"; TitleLbl.BackgroundTransparency = 1

    local Close = Instance.new("TextButton", TopBar)
    Close.Text = "✕"; Close.Size = UDim2.new(0, 50, 1, 0); Close.Position = UDim2.new(1, -50, 0, 0); Close.TextColor3 = Color3.fromRGB(220, 60, 60); Close.BackgroundTransparency = 1; Close.TextSize = 20

    local Min = Instance.new("TextButton", TopBar)
    Min.Text = "—"; Min.Size = UDim2.new(0, 50, 1, 0); Min.Position = UDim2.new(1, -100, 0, 0); Min.TextColor3 = Color3.fromRGB(200, 200, 200); Min.BackgroundTransparency = 1; Min.TextSize = 20

    local SearchCont = Instance.new("Frame", Frame)
    SearchCont.Size = UDim2.new(1, -190, 0, 35); SearchCont.Position = UDim2.new(0, 175, 0, 65); SearchCont.BackgroundColor3 = Color3.fromRGB(20, 20, 30); Instance.new("UICorner", SearchCont).CornerRadius = UDim.new(0, 8)
    
    local SearchBox = Instance.new("TextBox", SearchCont)
    SearchBox.Size = UDim2.new(1, -20, 1, 0); SearchBox.Position = UDim2.new(0, 10, 0, 0); SearchBox.BackgroundTransparency = 1; SearchBox.PlaceholderText = "Search scripts..."; SearchBox.Text = ""; SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255); SearchBox.Font = "Gotham"; SearchBox.TextXAlignment = "Left"

    local Sidebar = Instance.new("ScrollingFrame", Frame)
    Sidebar.Size = UDim2.new(0, 150, 1, -70); Sidebar.Position = UDim2.new(0, 15, 0, 65); Sidebar.BackgroundTransparency = 1; Sidebar.ScrollBarThickness = 0
    Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 8)

    local ContentArea = Instance.new("Frame", Frame)
    ContentArea.Size = UDim2.new(1, -185, 1, -120); ContentArea.Position = UDim2.new(0, 170, 0, 110); ContentArea.BackgroundTransparency = 1

    local function drag(obj, target)
        local d, iS, sP; obj.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true iS = i.Position sP = target.Position end end)
        UserInputService.InputChanged:Connect(function(i) if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local delta = i.Position - iS target.Position = UDim2.new(sP.X.Scale, sP.X.Offset + delta.X, sP.Y.Scale, sP.Y.Offset + delta.Y) end end)
        UserInputService.InputEnded:Connect(function() d = false end)
    end
    drag(TopBar, Frame); drag(ToggleBtn, ToggleBtn)

    Close.MouseButton1Click:Connect(function() MainGui:Destroy() end)
    Min.MouseButton1Click:Connect(function() Frame.Visible = false end)
    ToggleBtn.MouseButton1Click:Connect(function() Frame.Visible = not Frame.Visible end)

    local Window = {}
    function Window:CreateTab(tcfg)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(1, 0, 0, 40); TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35); TabBtn.Text = tcfg.Title; TabBtn.TextColor3 = Color3.fromRGB(150, 150, 160); TabBtn.Font = "GothamMedium"; Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        
        local Page = Instance.new("ScrollingFrame", ContentArea)
        Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 2; Page.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226); Page.AutomaticCanvasSize = "Y"
        Instance.new("UIGridLayout", Page).CellSize = UDim2.new(0, 205, 0, 155)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentArea:GetChildren()) do v.Visible = false end
            Page.Visible = true; Page.Position = UDim2.new(0, 20, 0, 0); Ani(Page, 0.5, {Position = UDim2.new(0, 0, 0, 0)})
        end)

        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            local input = SearchBox.Text:lower()
            for _, card in pairs(Page:GetChildren()) do if card:IsA("Frame") then card.Visible = card.Name:lower():find(input) ~= nil end end
        end)

        local Tab = {}
        function Tab:CreateCard(ccfg)
            local Card = Instance.new("Frame", Page)
            Card.Name = ccfg.Title; Card.BackgroundColor3 = Color3.fromRGB(20, 20, 30); Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)
            
            local Thumb = Instance.new("ImageLabel", Card)
            Thumb.Size = UDim2.new(1, 0, 0, 90); Thumb.Image = ccfg.thumbnail; Instance.new("UICorner", Thumb).CornerRadius = UDim.new(0, 10)

            local CTitle = Instance.new("TextLabel", Card)
            CTitle.Text = ccfg.Title; CTitle.Size = UDim2.new(1, -15, 0, 25); CTitle.Position = UDim2.new(0, 10, 0, 95); CTitle.TextColor3 = Color3.fromRGB(255, 255, 255); CTitle.Font = "GothamBold"; CTitle.BackgroundTransparency = 1; CTitle.TextXAlignment = "Left"

            local ExecBtn = Instance.new("TextButton", Card)
            ExecBtn.Size = UDim2.new(0, 85, 0, 30); ExecBtn.Position = UDim2.new(1, -95, 1, -38); ExecBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226); ExecBtn.Text = "Execute"; ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ExecBtn.Font = "GothamBold"; Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 6)

            ExecBtn.MouseButton1Click:Connect(function()
                if not ccfg.loadstring or ccfg.loadstring == "" then
                    Astral:Notify("Error", "Script Outdated!", 3)
                else
                    Astral:Notify("Success", "Executing " .. ccfg.Title, 2)
                    loadstring(ccfg.loadstring)()
                end
            end)
            return Card
        end
        return Tab
    end
    return Window
end

return Astral
