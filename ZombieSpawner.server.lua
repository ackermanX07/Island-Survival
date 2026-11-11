
local ServerStorage = game:GetService("ServerStorage")

local zombieTemplate = ServerStorage:WaitForChild("Zombie")

local SPAWN_INTERVAL = 15
local MAX_ZOMBIES = 10
local SPAWN_RADIUS = 100

local function countZombies()
    local count = 0

    for _, object in ipairs(workspace:GetChildren()) do
        if object.Name == "Zombie" then
            count += 1
        end
    end

    return count
end

while true do
    task.wait(SPAWN_INTERVAL)

    if countZombies() < MAX_ZOMBIES then
        local zombie = zombieTemplate:Clone()

        local x = math.random(-SPAWN_RADIUS, SPAWN_RADIUS)
        local z = math.random(-SPAWN_RADIUS, SPAWN_RADIUS)

        zombie:PivotTo(CFrame.new(x, 5, z))
        zombie.Parent = workspace
    end
end
