local Players = game:GetService("Players")

local inventories = {}

local function createInventory(player)
    inventories[player.UserId] = {
        Wood = 0,
        Stone = 0,
        Food = 0,
        Water = 0
    }
end

Players.PlayerAdded:Connect(createInventory)

Players.PlayerRemoving:Connect(function(player)
    inventories[player.UserId] = nil
end)

_G.GetInventory = function(player)
    return inventories[player.UserId]
end

_G.AddItem = function(player, item, amount)
    local inventory = inventories[player.UserId]

    if not inventory or inventory[item] == nil then
        return false
    end

    if amount <= 0 then
        return false
    end

    inventory[item] += amount
    return true
end
