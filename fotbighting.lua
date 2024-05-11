local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local aiActive = false
local leftArmDistance = 2  -- Desired close distance to the enemy's left arm
local rightArmDistance = 5  -- Desired avoidance distance from the enemy's right arm
local attackRange = 10  -- Distance within which the AI will attempt to use the sword
local shakeIntensity = math.rad(0.5)  -- Intensity for realistic shaking
local shakeFrequency = 0.5  -- Frequency of shaking in seconds
local turnRatio = 0.5  -- Smoothness of turning
local closeProximity = 5  -- Distance at which strategic turning is activated

-- Setup GUI for toggling AI
local function createGUI()
    local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 150, 0, 50)
    frame.Position = UDim2.new(0.1, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Active = true
    frame.Draggable = true

    local button = Instance.new("TextButton", frame)
    button.Text = "Toggle AI"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    button.MouseButton1Click:Connect(function()
        aiActive = not aiActive
        button.Text = aiActive and "AI ON" or "Toggle AI"
        button.BackgroundColor3 = aiActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)
end

-- Main combat AI routine
local function handleCombatAI(character)
    local Humanoid = character:WaitForChild("Humanoid")
    local RootPart = character:WaitForChild("HumanoidRootPart")
    local currentTarget = nil
    local lastShakeTime = tick()

    local function GetClosestEnemy()
        local closestEnemy = nil
        local shortestDistance = math.huge
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= Player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") and otherPlayer.Character.Humanoid.Health > 0 then
                local distance = (otherPlayer.Character.HumanoidRootPart.Position - RootPart.Position).magnitude
                if distance < shortestDistance then
                    closestEnemy = otherPlayer
                    shortestDistance = distance
                end
            end
        end
        return closestEnemy
    end

    local function CombatRoutine()
        while aiActive do
            local enemy = GetClosestEnemy()
            if enemy and enemy.Character then
                local enemyHumanoid = enemy.Character:FindFirstChildOfClass("Humanoid")
                if enemyHumanoid then
                    -- Sync jump with the enemy
                    enemyHumanoid.StateChanged:Connect(function(_, newState)
                        if newState == Enum.HumanoidStateType.Freefall and Humanoid.FloorMaterial ~= Enum.Material.Air then
                            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end)
                end

                if enemy ~= currentTarget then
                    currentTarget = enemy
                end

                if currentTarget.Character.Humanoid.Health > 0 then
                    local targetPosition = currentTarget.Character.HumanoidRootPart.Position
                    local distanceToTarget = (RootPart.Position - targetPosition).magnitude

                    if distanceToTarget <= closeProximity then
                        -- Strategic turning: slightly turn left when close
                        targetPosition = targetPosition - RootPart.CFrame.RightVector * 2
                    end

                    -- Maintain horizontal orientation and move towards the target
                    local horizontalDirection = Vector3.new(targetPosition.X, RootPart.Position.Y, targetPosition.Z)
                    RootPart.CFrame = RootPart.CFrame:Lerp(CFrame.new(RootPart.Position, horizontalDirection), turnRatio)

                    Humanoid:MoveTo(targetPosition)

                    -- Shaking effect
                    if tick() - lastShakeTime > shakeFrequency then
                        lastShakeTime = tick()
                        RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.random() < 0.5 and -shakeIntensity or shakeIntensity, 0)
                    end

                    if distanceToTarget <= attackRange then
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                    end
                end
            elseif currentTarget and currentTarget.Character.Humanoid.Health <= 0 then
                currentTarget = nil  -- Clear target if it is defeated
            end
            wait(0.1)  -- Check every 0.1 seconds to minimize performance impact
        end
    end

    RunService.RenderStepped:Connect(CombatRoutine)
end

Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    handleCombatAI(character)
end)

createGUI()
