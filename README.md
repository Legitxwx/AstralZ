# Installation
```lua
local Astral = loadstring(game:HttpGet("https://raw.githubusercontent.com/Legitxwx/AstralZ/refs/heads/main/Supra.lua"))()

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
