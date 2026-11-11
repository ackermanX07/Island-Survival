local Players = game:GetService("Players")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "SurvivalHUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local container = Instance.new("Frame")
container.Size = UDim2.new(0, 210, 0, 150)
container.Position = UDim2.new(0, 15, 0, 15)
container.BackgroundColor3 = Color3.fromRGB(25, 30, 35)
container.BackgroundTransparency = 0.15
container.Parent = gui

local function createBar(name, color, y)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 22)
    label.Position = UDim2.new(0, 5, 0, y)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = name .. ": 100"
    label.Parent = container

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -10, 0, 10)
    bar.Position = UDim2.new(0, 5, 0, y + 23)
    bar.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    bar.Parent = container

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(1, 0, 1, 0)
    fill.BackgroundColor3 = color
    fill.Parent = bar

    return function(value)
        value = math.clamp(value, 0, 100)
        fill.Size = UDim2.new(value / 100, 0, 1, 0)
        label.Text = name .. ": " .. math.floor(value)
    end
end

local updateHunger = createBar("Hambre", Color3.fromRGB(230, 160, 50), 5)
local updateThirst = createBar("Sed", Color3.fromRGB(50, 150, 255), 40)
local updateEnergy = createBar("Energia", Color3.fromRGB(60, 210, 100), 75)
local updateHealth = createBar("Vida", Color3.fromRGB(230, 60, 60), 110)

local function updateStats()
    updateHunger(player:GetAttribute("Hunger") or 100)
    updateThirst(player:GetAttribute("Thirst") or 100)
    updateEnergy(player:GetAttribute("Energy") or 100)

    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        updateHealth(humanoid.Health / humanoid.MaxHealth * 100)
    end
end

for _, attribute in ipairs({"Hunger", "Thirst", "Energy"}) do
    player:GetAttributeChangedSignal(attribute):Connect(updateStats)
end

player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").HealthChanged:Connect(updateStats)
    updateStats()
end)

updateStats()
