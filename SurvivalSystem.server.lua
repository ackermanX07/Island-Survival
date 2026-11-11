local Players = game:GetService("Players")

local function setupPlayer(player)
    player:SetAttribute("Hunger", 100)
    player:SetAttribute("Thirst", 100)
    player:SetAttribute("Energy", 100)

    task.spawn(function()
        local hungerTimer = 0
        local thirstTimer = 0
        local damageTimer = 0

        while player.Parent do
            task.wait(1)
            hungerTimer += 1
            thirstTimer += 1

            if hungerTimer >= 12 then
                hungerTimer = 0
                player:SetAttribute("Hunger", math.max(0, player:GetAttribute("Hunger") - 1))
            end

            if thirstTimer >= 8 then
                thirstTimer = 0
                player:SetAttribute("Thirst", math.max(0, player:GetAttribute("Thirst") - 1))
            end

            local hunger = player:GetAttribute("Hunger")
            local thirst = player:GetAttribute("Thirst")

            if hunger <= 0 or thirst <= 0 then
                damageTimer += 1
                if damageTimer >= 5 then
                    damageTimer = 0
                    local character = player.Character
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:TakeDamage(2) end
                end
            else
                damageTimer = 0
            end
        end
    end)
end

Players.PlayerAdded:Connect(setupPlayer)
for _, player in ipairs(Players:GetPlayers()) do setupPlayer(player) end
