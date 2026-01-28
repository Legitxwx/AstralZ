# Installation
```lua
local Astral = loadstring(game:HttpGet("https://raw.githubusercontent.com/Legitxwx/AstralZ/refs/heads/main/Supra.lua"))()
```
# Window
local Window = Astral:CreateWindow({
    Title = "ASTRAL HUB",
    Subtitle = "PREMIUM",
    Author = "Astral",
    Version = "6.0",
    loading = true
})
```
# Tab
```lua
local Tab = Window:CreateTab({
    Title = "Tab",
    locked = false
})
```

# Game Card
```lua
local Card = Tab:CreateCard({
    Title = "Game Title",
    Description = "Game Description",
    thumbnail = "rbxassetid://13511116127",
    loadstring = "loadstring(game:HttpGet(""))()
})
```
# Executor Support
```lua
local ExecutorSupport = {
    ["Delta"] = true,
    ["Codex"] = true,
    ["Arceus X"] = true
}
```

# Notification
```lua
Astral:Notify("Welcome", "Astral UI v6.0 is ready for use!", 5)
```

# Full Lua
```lua
local Astral = loadstring(game:HttpGet("https://raw.githubusercontent.com/Legitxwx/AstralZ/refs/heads/main/Supra.lua"))()
local Window = Astral:CreateWindow({
    Title = "ASTRAL HUB",
    Subtitle = "PREMIUM",
    Author = "Gemini",
    Version = "6.0",
    loading = true
})

local Tab1 = Window:CreateTab({
    Title = "Combat",
    locked = false
})

local Tab2 = Window:CreateTab({
    Title = "Utilities"
})

local GameCards = Tab1:CreateCard({
    Title = "Infinite Yield",
    Description = "Admin Commands",
    thumbnail = "rbxassetid://13511116127",
    loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()"
})

local FarmCard = Tab1:CreateCard({
    Title = "Auto Farm",
    Description = "Level 1-Max",
    thumbnail = "rbxassetid://13511116127",
    loadstring = "print('Farm Started')"
})

local ExecutorSupport = {
    ["Delta"] = true,
    ["Codex"] = true,
    ["Arceus X"] = true
}

Astral:Notify("Welcome", "Astral UI v6.0 is ready for use!", 5)
```
