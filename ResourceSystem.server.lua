
local Players = game:GetService("Players")

local resources = {
    Wood = 0,
    Stone = 0,
    Food = 0,
    Water = 0
}

local function setupResource(player)
    for resource, amount in pairs(resources) do
        player:SetAttribute(resource, amount)
    end
end

Players.PlayerAdded:Connect(setupResource)

for _, player in ipairs(Players:GetPlayers()) do
    setupResource(player)
end

local function giveResource(player, resource, amount)
    if not player or not player:IsA("Player") then
        return false
    end

    if resources[resource] == nil then
        return false
    end

    if typeof(amount) ~= "number" or amount <= 0 then
        return false
    end

    local current = player:GetAttribute(resource) or 0
    player:SetAttribute(resource, current + math.floor(amount))

    return true
end

_G.GiveResource = giveResource
