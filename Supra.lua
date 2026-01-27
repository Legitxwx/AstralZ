local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Astral = { Tabs = {} }

-- [[ CLEAN UTILS ]]
local function Ani(obj, time, goal)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quint), goal):Play()
end

-- [[ NOTIFICATION SYSTEM ]]
function Astral:Notify(title, text, duration)
    local Holder = game:GetService("CoreGui"):FindFirstChild("Astral_Notifs") or Instance.new("Frame", game:GetService("CoreGui"))
    if Holder.Name ~= "Astral_Notifs" then
        Holder.Name = "Astral_Notifs"; Holder.Size = UDim2.new(0, 300, 1, 0); Holder.Position = UDim2.new(1, -310, 0, 20); Holder.BackgroundTransparency = 1
        local L = Instance.new("UIListLayout", Holder); L.VerticalAlignment = "Bottom"; L.Padding = UDim.new(0, 8)
    end

    local N = Instance.new("Frame", Holder)
    N.Size = UDim2.new(1, 0, 0, 65); N.BackgroundColor3 = Color3.fromRGB(15, 15, 22); N.ClipsDescendants = true
    Instance.new("UICorner", N).CornerRadius = UDim.new(0, 8)
    local S = Instance.new("UIStroke", N); S.Color = Color3.fromRGB(138, 43, 226); S.Thickness = 1.5

    local T = Instance.new("TextLabel", N)
    T.Text = title; T.Size = UDim2.new(1, -10, 0, 25); T.Position = UDim2.new(0, 12, 0, 5); T.TextColor3 = Color3.fromRGB(138, 43, 226); T.Font = "GothamBold"; T.BackgroundTransparency = 1; T.TextXAlignment = "Left"
    
    local D = Instance.new("TextLabel", N)
    D.Text = text; D.Size = UDim2.new(1, -24, 0, 30); D.Position = UDim2.new(0, 12, 0, 28); D.TextColor3 = Color3.fromRGB(200, 200, 200); D.Font = "Gotham"; D.TextWrapped = true; D.BackgroundTransparency = 1; D.TextXAlignment = "Left"; D.TextSize = 12

    task.delay(duration or 4, function()
        Ani(N, 0.5, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1})
        task.wait(0.5); N:Destroy()
    end)
end

function Astral:CreateWindow(cfg)
    local Main = Instance.new("ScreenGui", game:GetService("CoreGui"))
    
    -- TOGGLE BUTTON
    local Toggle = Instance.new("ImageButton", Main)
    Toggle.Size = UDim2.new(0, 45, 0, 45); Toggle.Position = UDim2.new(0, 20, 0.5, 0); Toggle.BackgroundColor3 = Color3.fromRGB(12, 12, 18); Toggle.Image = "rbxassetid://6031094678"; Toggle.ImageColor3 = Color3.fromRGB(138, 43, 226)
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", Toggle).Color = Color3.fromRGB(138, 43, 226)

    -- MAIN FRAME
    local Frame = Instance.new("Frame", Main)
    Frame.Size = UDim2.new(0, 600, 0, 400); Frame.Position = UDim2.new(0.5, -300, 0.5, -200); Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Frame.ClipsDescendants = true
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", Frame).Color = Color3.fromRGB(138, 43, 226)

    -- TOPBAR
    local TopBar = Instance.new("Frame", Frame)
    TopBar.Size = UDim2.new(1, 0, 0, 45); TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.Text = "  " .. cfg.Title .. " <font color='#8A2BE2'>" .. cfg.Subtitle .. "</font>"; Title.RichText = true; Title.Size = UDim2.new(0.5, 0, 1, 0); Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.Font = "GothamBold"; Title.TextXAlignment = "Left"; Title.BackgroundTransparency = 1

    local Close = Instance.new("TextButton", TopBar)
    Close.Text = "✕"; Close.Size = UDim2.new(0, 45, 1, 0); Close.Position = UDim2.new(1, -45, 0, 0); Close.TextColor3 = Color3.fromRGB(220, 60, 60); Close.BackgroundTransparency = 1; Close.TextSize = 18

    local Min = Instance.new("TextButton", TopBar)
    Min.Text = "—"; Min.Size = UDim2.new(0, 45, 1, 0); Min.Position = UDim2.new(1, -90, 0, 0); Min.TextColor3 = Color3.fromRGB(200, 200, 200); Min.BackgroundTransparency = 1; Min.TextSize = 18

    -- SEARCH BAR
    local SearchBox = Instance.new("TextBox", Frame)
    SearchBox.Size = UDim2.new(1, -180, 0, 30); SearchBox.Position = UDim2.new(0, 170, 0, 55); SearchBox.BackgroundColor3 = Color3.fromRGB(18, 18, 26); SearchBox.PlaceholderText = "Search scripts..."; SearchBox.Text = ""; SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255); SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100); SearchBox.Font = "Gotham"
    Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 6)

    -- LOGIC: DRAG & TOGGLE
    local function makeDrag(o, target)
        local d, s, sp; o.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true s = i.Position sp = target.Position end end)
        UserInputService.InputChanged:Connect(function(i) if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local delta = i.Position - s target.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y) end end)
        UserInputService.InputEnded:Connect(function(i) d = false end)
    end
    makeDrag(TopBar, Frame); makeDrag(Toggle, Toggle)
    
    Close.MouseButton1Click:Connect(function() Main:Destroy() end)
    Min.MouseButton1Click:Connect(function() Frame.Visible = false end)
    Toggle.MouseButton1Click:Connect(function() Frame.Visible = not Frame.Visible end)

    local TabScroll = Instance.new("ScrollingFrame", Frame)
    TabScroll.Size = UDim2.new(0, 150, 1, -60); TabScroll.Position = UDim2.new(0, 10, 0, 55); TabScroll.BackgroundTransparency = 1; TabScroll.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabScroll).Padding = UDim.new(0, 5)

    local Content = Instance.new("Frame", Frame)
    Content.Size = UDim2.new(1, -170, 1, -100); Content.Position = UDim2.new(0, 160, 0, 95); Content.BackgroundTransparency = 1

    local Window = {}
    function Window:CreateTab(tcfg)
        local TabBtn = Instance.new("TextButton", TabScroll)
        TabBtn.Size = UDim2.new(1, 0, 0, 35); TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28); TabBtn.Text = tcfg.Title; TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150); TabBtn.Font = "GothamMedium"
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local Page = Instance.new("ScrollingFrame", Content)
        Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = "Y"
        Instance.new("UIGridLayout", Page).CellSize = UDim2.new(0, 205, 0, 140)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Content:GetChildren()) do v.Visible = false end
            Page.Visible = true; Page.Position = UDim2.new(0, 15, 0, 0); Ani(Page, 0.4, {Position = UDim2.new(0, 0, 0, 0)})
        end)

        -- SEARCH LOGIC
        SearchBox.GetPropertyChangedSignal(SearchBox, "Text"):Connect(function()
            local input = SearchBox.Text:lower()
            for _, card in pairs(Page:GetChildren()) do
                if card:IsA("Frame") then
                    card.Visible = card.Name:lower():find(input) and true or false
                end
            end
        end)

        local Tab = {}
        function Tab:CreateCard(ccfg)
            local Card = Instance.new("Frame", Page)
            Card.Name = ccfg.Title; Card.BackgroundColor3 = Color3.fromRGB(18, 18, 26); Card.BorderSizePixel = 0
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
            
            local Thumb = Instance.new("ImageLabel", Card)
            Thumb.Size = UDim2.new(1, 0, 0, 80); Thumb.Image = ccfg.thumbnail; Instance.new("UICorner", Thumb).CornerRadius = UDim.new(0, 8)

            local T = Instance.new("TextLabel", Card)
            T.Text = ccfg.Title; T.Size = UDim2.new(1, -10, 0, 20); T.Position = UDim2.new(0, 8, 0, 85); T.TextColor3 = Color3.fromRGB(255, 255, 255); T.Font = "GothamBold"; T.BackgroundTransparency = 1; T.TextXAlignment = "Left"

            local Exec = Instance.new("TextButton", Card)
            Exec.Size = UDim2.new(0, 75, 0, 26); Exec.Position = UDim2.new(1, -80, 1, -32); Exec.BackgroundColor3 = Color3.fromRGB(138, 43, 226); Exec.Text = "Execute"; Exec.TextColor3 = Color3.fromRGB(255, 255, 255); Exec.Font = "GothamBold"
            Instance.new("UICorner", Exec).CornerRadius = UDim.new(0, 5)

            Exec.MouseButton1Click:Connect(function()
                if not ccfg.loadstring or ccfg.loadstring == "" then
                    Astral:Notify("Error", "Script is empty or outdated.", 3)
                else
                    Astral:Notify("Executing", "Loading " .. ccfg.Title, 2)
                    task.wait(0.5); loadstring(ccfg.loadstring)()
                end
            end)
            return Card
        end
        return Tab
    end
    
    if cfg.loading then
        local L = Instance.new("Frame", Main); L.Size = UDim2.new(1,0,1,0); L.BackgroundColor3 = Color3.fromRGB(5,5,10); L.ZIndex = 100
        local LT = Instance.new("TextLabel", L); LT.Text = "ASTRAL"; LT.TextColor3 = Color3.fromRGB(138, 43, 226); LT.Font = "GothamBold"; LT.TextSize = 40; LT.Size = UDim2.new(1,0,1,0); LT.BackgroundTransparency = 1
        task.wait(1); Ani(L, 0.8, {BackgroundTransparency = 1}); Ani(LT, 0.8, {TextTransparency = 1}); task.wait(0.8); L:Destroy()
    end

    return Window
end

return Astral
