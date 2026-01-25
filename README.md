# ASTRAL Z

# MORE SOON

- **DESIGN** - The Design Will Improve Soon Yet!
- **ANIMATIONS** - Animations Are Very Important On A UI So We Added.

# INSTALLATION LOADSTRING
```lua
local AstralZ = loadstring(game:HttpGet("https://raw.githubusercontent.com/Legitxwx/AstralZ/refs/heads/main/Supra.lua"))()
```

# Key System Logic
```lua
local Config = {
    Title = "Astral Z Public",
    KeySystem = true,
    KeyLink = "https://discord.gg/astralz",
    Keys = loadstring(game:HttpGet("https://pastebin.com/raw/YOUR_KEY_DATA"))()
}
```

# IMPORTANT
Put this below the key logic
```lua
local Window = AstralZ.new(Config)
```

# Tab
```lua
local Main = Window:AddTab("Title")
```

# Toggle
```lua
Main:AddToggle("Kill Aura", function(val)
    print("Kill Aura is now: ", val)
end)
```

# Slider
```lua
Main:AddSlider("Walkspeed", 16, 200, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)
```

# Dropdown
```lua
Visuals:AddDropdown("ESP Mode", {"Box", "Tracer", "Skeleton"}, function(selected)
    Window:Notify("ESP", "Mode set to: " .. selected)
end)
```

#
```lua
Misc:AddInput("Teleport To Player", function(txt)
    print("txt")
end)
```

# Button
```lua
Credits:AddButton("Copy Owner Discord", function()
    print()
end)
```

# Notification
```lua
Window:Notify("title", "Desc")
```

# FULL USAGE
```lua
local AstralZ = loadstring(game:HttpGet("https://raw.githubusercontent.com/Legitxwx/AstralZ/refs/heads/main/Supra.lua"))()

--// Setup Configuration
local Config = {
    Title = "Astral Z Public",
    KeySystem = true,
    KeyLink = "https://discord.gg/astralz",
    Keys = loadstring(game:HttpGet("https://pastebin.com/raw/YOUR_KEY_DATA"))()
}

--// Initialize
local Window = AstralZ.new(Config)

--// Tabs
local Main = Window:AddTab("Combat")
local Visuals = Window:AddTab("Visuals")
local Misc = Window:AddTab("Settings")

Main:AddToggle("Kill Aura", function(val)
    print("Kill Aura is now: ", val)
end)

Main:AddSlider("Walkspeed", 16, 200, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

Visuals:AddDropdown("ESP Mode", {"Box", "Tracer", "Skeleton"}, function(selected)
    Window:Notify("ESP", "Mode set to: " .. selected)
end)

Misc:AddInput("Teleport To Player", function(txt)
    Window:Notify("TP", "Searching for " .. txt)
end)

local Credits = Window:AddTab("Credits")
Credits:AddButton("Copy Owner Discord", function()
    setclipboard("discord.gg/astralz")
end)
```

### CREDITS

- **WAZADERMOKA** - DESIGNER
- **LEGITXWX** - OWNER
- **VEDSPP** - ORGANIZER
- **VALVULIX** - ANIMATIONS

# THANK YOU ALL FOR SUPPORTING OUR ASTRAL Z UI. WE PROMISE YALL TO DEVELOP EVEN MORE AND MORE FEATURES COMING SOON!

**FULL DOCUMENTATION**
> [DOCUMENTATION](github.io)
