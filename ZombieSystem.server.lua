
local Players = game:GetService("Players")

local function createZombie(position)
    local zombie = Instance.new("Model")
    zombie.Name = "Zombie"

    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = 150
    humanoid.Health = 150
    humanoid.WalkSpeed = 10
    humanoid.Parent = zombie

    local root = Instance.new("Part")
    root.Name = "HumanoidRootPart"
    root.Size = Vector3.new(2, 2, 1)
    root.Position = position
    root.Anchored = false
    root.Parent = zombie

    local body = Instance.new("Part")
    body.Name = "Torso"
    body.Size = Vector3.new(2, 2, 1)
    body.Position = position + Vector3.new(0, 2, 0)
    body.Parent = zombie

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 1, 1)
    head.Position = position + Vector3.new(0, 3.5, 0)
    head.Parent = zombie

    local weld1 = Instance.new("WeldConstraint")
    weld1.Part0 = root
    weld1.Part1 = body
    weld1.Parent = root

    local weld2 = Instance.new("WeldConstraint")
    weld2.Part0 = body
    weld2.Part1 = head
    weld2.Parent = body

    zombie.PrimaryPart = root
    zombie.Parent = workspace

    local attacking = false

    task.spawn(function()
        while zombie.Parent and humanoid.Health > 0 do
            local nearestPlayer = nil
            local shortestDistance = 100

            for _, player in ipairs(Players:GetPlayers()) do
                local character = player.Character
                local targetRoot = character and character:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = character and character:FindFirstChildOfClass("Humanoid")

                if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                    local distance = (targetRoot.Position - root.Position).Magnitude

                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestPlayer = player
                    end
                end
            end

            if nearestPlayer and nearestPlayer.Character then
                local targetRoot = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")

                if targetRoot then
                    humanoid:MoveTo(targetRoot.Position)

                    if shortestDistance < 4 and not attacking then
                        attacking = true
                        local targetHumanoid = nearestPlayer.Character:FindFirstChildOfClass("Humanoid")

                        if targetHumanoid then
                            targetHumanoid:TakeDamage(10)
                        end

                        task.wait(1)
                        attacking = false
                    end
                end
            end

            task.wait(0.2)
        end

        zombie:Destroy()
    end)

    return zombie
end

_G.CreateZombie = createZombie

return createZombie
