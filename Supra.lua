local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local AstralZ = {}
AstralZ.__index = AstralZ

--// Animation Core
local function Ani(obj, goal, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quart), goal):Play()
end

--// Draggable Logic
local function MakeDraggable(frame, parent)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = parent.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            parent.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

function AstralZ.new(cfg)
    local self = setmetatable({}, AstralZ)
    self.Gui = Instance.new("ScreenGui", CoreGui)
    
    if cfg.KeySystem then
        self:BuildKeySystem(cfg)
    else
        self:BuildMain(cfg.Title)
    end
    return self
end

function AstralZ:Notify(title, msg)
    local n = Instance.new("Frame", self.Gui)
    n.Size = UDim2.new(0, 250, 0, 60); n.Position = UDim2.new(1, 10, 1, -70)
    n.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Instance.new("UICorner", n)
    local t = Instance.new("TextLabel", n); t.Size = UDim2.new(1,0,0.4,0); t.Text = " "..title; t.TextColor3 = Color3.fromRGB(0, 255, 150); t.BackgroundTransparency = 1; t.Font = "GothamBold"
    local d = Instance.new("TextLabel", n); d.Size = UDim2.new(1,0,0.6,0); d.Position = UDim2.new(0,0,0.4,0); d.Text = " "..msg; d.TextColor3 = Color3.fromRGB(200,200,200); d.BackgroundTransparency = 1; d.Font = "Gotham"
    Ani(n, {Position = UDim2.new(1, -260, 1, -70)})
    task.delay(3, function() Ani(n, {Position = UDim2.new(1, 10, 1, -70)}); task.wait(0.4); n:Destroy() end)
end

function AstralZ:BuildKeySystem(cfg)
    local f = Instance.new("Frame", self.Gui); f.Size = UDim2.new(0,300,0,200); f.Position = UDim2.new(0.5,-150,0.5,-100); f.BackgroundColor3 = Color3.fromRGB(15,15,18); Instance.new("UICorner", f)
    local i = Instance.new("TextBox", f); i.Size = UDim2.new(0.8,0,0,35); i.Position = UDim2.new(0.1,0,0.4,0); i.PlaceholderText = "Key..."; i.BackgroundColor3 = Color3.fromRGB(30,30,35); i.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", i)
    local b = Instance.new("TextButton", f); b.Size = UDim2.new(0.8,0,0,35); b.Position = UDim2.new(0.1,0,0.65,0); b.Text = "Verify"; b.BackgroundColor3 = Color3.fromRGB(0,150,255); b.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        if cfg.Keys[i.Text] then f:Destroy(); self:BuildMain(cfg.Title.." | "..cfg.Keys[i.Text]); self:Notify("Access", "Verified!") end
    end)
end

function AstralZ:BuildMain(title)
    self.Main = Instance.new("Frame", self.Gui); self.Main.Size = UDim2.new(0,500,0,350); self.Main.Position = UDim2.new(0.5,-250,0.5,-175); self.Main.BackgroundColor3 = Color3.fromRGB(18,18,22); Instance.new("UICorner", self.Main)
    local s = Instance.new("Frame", self.Main); s.Size = UDim2.new(0,130,1,0); s.BackgroundColor3 = Color3.fromRGB(25,25,30); Instance.new("UICorner", s)
    MakeDraggable(s, self.Main)
    self.TabHold = Instance.new("ScrollingFrame", s); self.TabHold.Size = UDim2.new(1,0,1,-50); self.TabHold.Position = UDim2.new(0,0,0,40); self.TabHold.BackgroundTransparency = 1; Instance.new("UIListLayout", self.TabHold)
    self.PageHold = Instance.new("Frame", self.Main); self.PageHold.Size = UDim2.new(1,-140,1,-20); self.PageHold.Position = UDim2.new(0,135,0,10); self.PageHold.BackgroundTransparency = 1
end

function AstralZ:AddTab(title)
    local b = Instance.new("TextButton", self.TabHold); b.Size = UDim2.new(1,0,0,35); b.BackgroundTransparency = 1; b.Text = title; b.TextColor3 = Color3.fromRGB(150,150,150); b.Font = "GothamBold"
    local p = Instance.new("ScrollingFrame", self.PageHold); p.Size = UDim2.new(1,0,1,0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 0; Instance.new("UIListLayout", p).Padding = UDim.new(0,8)
    b.MouseButton1Click:Connect(function()
        for _,v in pairs(self.PageHold:GetChildren()) do v.Visible = false end
        for _,v in pairs(self.TabHold:GetChildren()) do if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(150,150,150) end end
        p.Visible = true; b.TextColor3 = Color3.fromRGB(0,255,150)
    end)
    if #self.TabHold:GetChildren() == 1 then p.Visible = true; b.TextColor3 = Color3.fromRGB(0,255,150) end
    
    local tm = {}
    function tm:AddToggle(text, callback)
        local state = false
        local t = Instance.new("TextButton", p); t.Size = UDim2.new(1,-5,0,35); t.BackgroundColor3 = Color3.fromRGB(30,30,35); t.Text = "  "..text; t.TextColor3 = Color3.fromRGB(200,200,200); t.TextXAlignment = "Left"; Instance.new("UICorner", t)
        local box = Instance.new("Frame", t); box.Size = UDim2.new(0,30,0,15); box.Position = UDim2.new(1,-40,0.5,-7); box.BackgroundColor3 = Color3.fromRGB(50,50,50); Instance.new("UICorner", box, {CornerRadius = UDim.new(1,0)})
        t.MouseButton1Click:Connect(function() state = not state; callback(state); Ani(box, {BackgroundColor3 = state and Color3.fromRGB(0,255,150) or Color3.fromRGB(50,50,50)}) end)
    end
    function tm:AddSlider(text, min, max, callback)
        local s = Instance.new("Frame", p); s.Size = UDim2.new(1,-5,0,45); s.BackgroundColor3 = Color3.fromRGB(30,30,35); Instance.new("UICorner", s)
        local l = Instance.new("TextLabel", s); l.Size = UDim2.new(1,0,0,20); l.Text = "  "..text; l.BackgroundTransparency = 1; l.TextColor3 = Color3.fromRGB(180,180,180); l.TextXAlignment = "Left"
        local b = Instance.new("TextButton", s); b.Size = UDim2.new(1,-20,0,4); b.Position = UDim2.new(0,10,0,30); b.BackgroundColor3 = Color3.fromRGB(50,50,55); b.Text = ""
        local f = Instance.new("Frame", b); f.Size = UDim2.new(0,0,1,0); f.BackgroundColor3 = Color3.fromRGB(0,150,255)
        b.MouseButton1Down:Connect(function()
            local move = UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    local per = math.clamp((UserInputService:GetMouseLocation().X - b.AbsolutePosition.X)/b.AbsoluteSize.X, 0, 1)
                    f.Size = UDim2.new(per,0,1,0); callback(math.floor(min + (max-min)*per))
                end
            end)
            UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then move:Disconnect() end end)
        end)
    end
    function tm:AddInput(text, callback)
        local i = Instance.new("Frame", p); i.Size = UDim2.new(1,-5,0,40); i.BackgroundColor3 = Color3.fromRGB(30,30,35); Instance.new("UICorner", i)
        local box = Instance.new("TextBox", i); box.Size = UDim2.new(1,-20,0,30); box.Position = UDim2.new(0,10,0,5); box.PlaceholderText = text; box.BackgroundTransparency = 1; box.TextColor3 = Color3.fromRGB(255,255,255)
        box.FocusLost:Connect(function() callback(box.Text) end)
    end
    function tm:AddDropdown(text, list, callback)
        local d = Instance.new("TextButton", p); d.Size = UDim2.new(1,-5,0,35); d.BackgroundColor3 = Color3.fromRGB(30,30,35); d.Text = "  "..text; d.TextColor3 = Color3.fromRGB(200,200,200); d.TextXAlignment = "Left"; Instance.new("UICorner", d)
        local opened = false; local hold = Instance.new("Frame", p); hold.Size = UDim2.new(1,-5,0,0); hold.Visible = false; hold.BackgroundColor3 = Color3.fromRGB(25,25,30); Instance.new("UIListLayout", hold)
        d.MouseButton1Click:Connect(function() opened = not opened; hold.Visible = opened; hold.Size = opened and UDim2.new(1,-5,0,#list*30) or UDim2.new(1,-5,0,0) end)
        for _,v in pairs(list) do
            local opt = Instance.new("TextButton", hold); opt.Size = UDim2.new(1,0,0,30); opt.Text = v; opt.BackgroundColor3 = Color3.fromRGB(35,35,40); opt.TextColor3 = Color3.fromRGB(150,150,150)
            opt.MouseButton1Click:Connect(function() callback(v); d.Text = "  "..text..": "..v; opened = false; hold.Visible = false end)
        end
    end
    return tm
end

return AstralZ
