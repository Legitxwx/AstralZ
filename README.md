**** # ASTRAL HUB SOURCE

**** # INITIALIZATION
```
local Astral = loadstring(game:HttpGet("https://raw.githubusercontent.com/Legitxwx/AstralZ/refs/heads/main/Supra.lua"))()
```
**** # WINDOW CONFIGURATION
```
local Window = Astral:CreateWindow({
    Title = "ASTRAL HUB",
    Subtitle = "UNIVERSAL",
    Author = "Gemini",
    Version = "5.0",
    loading = true
})
```
**** # TAB SELECTION
```
local Tab = Window:CreateTab({
    Title = "Combat Scripts"
})
```
**** # SCRIPT CARDS
```
local Card = Tab:CreateCard({
    Title = "KillAura V2",
    thumbnail = "rbxassetid://13511116127",
    loadstring = "print('Executed Combat Script!')"
})
```

**** # NOTIFICATIONS
```
Astral:Notify("System", "Welcome to Astral. Use the search bar to find scripts.", 5)
```
