local player = game.Players.LocalPlayer
local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

local function findClosestRealBall()
    local realBalls = workspace:WaitForChild("RealBalls"):GetChildren()
    local closestBall = nil
    local minDistance = math.huge

    for _, ball in pairs(realBalls) do
        local distance = (ball.Position - player.Character.HumanoidRootPart.Position).Magnitude
        if distance < minDistance then
            closestBall = ball
            minDistance = distance
        end
    end

    return closestBall
end

local function autoParry()
    local closestBall = findClosestRealBall()

    if closestBall and closestBall.Target == player then
        remotes:WaitForChild("ParryButtonPress"):FireServer()
    end
end

player.CharacterAdded:Connect(function()
    while wait(1) do
        autoParry()
    end
end)
