local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local aiActive = false
local leftArmDistance = 2  -- Desired close distance to the enemy's left arm
local rightArmDistance = 5  -- Desired avoidance distance from the enemy's right arm
local attackRange = 10  -- Distance within which the AI will attempt to use the sword
local shakeIntensity = math.rad(0.5)  -- Intensity for realistic shaking
local shakeFrequency = 0.5  -- Frequency of shaking in seconds
local turnRatio = 0.5  -- Smoothness of turning

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

-- Toggle AI activation with the "Y" key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Y then
        aiActive = not aiActive
        print("AI Toggled:", aiActive and "ON" or "OFF")  -- Optional: Visual feedback in the output
    end
end)

-- Main combat AI routine
local function handleCombatAI(character)
    local Humanoid = character:WaitForChild("Humanoid")
    local RootPart = character:WaitForChild("HumanoidRootPart")
    local pathfinder = PathfindingService:CreatePath({AgentRadius = 2, AgentHeight = 5, AgentCanJump = true})
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

    local function MoveToPosition(targetPosition)
        pathfinder:ComputeAsync(RootPart.Position, targetPosition)
        local waypoints = pathfinder:GetWaypoints()

        for _, waypoint in ipairs(waypoints) do
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            Humanoid:MoveTo(waypoint.Position)
            Humanoid.MoveToFinished:Wait()
        end
    end

    local function CombatRoutine()
        while aiActive do
            local enemy = GetClosestEnemy()
            if enemy and enemy.Character then
                local enemyHumanoid = enemy.Character:FindFirstChildOfClass("Humanoid")
                if enemyHumanoid then
                    if enemy ~= currentTarget then
                        currentTarget = enemy
                    end

                    if currentTarget.Character.Humanoid.Health > 0 then
                        local leftArm = currentTarget.Character:FindFirstChild("Left Arm")
                        local rightArm = currentTarget.Character:FindFirstChild("Right Arm")

                        if leftArm and rightArm then
                            local leftArmTarget = leftArm.Position - (leftArm.Position - RootPart.Position).unit * leftArmDistance
                            local rightArmAvoid = rightArm.Position + (RootPart.Position - rightArm.Position).unit * rightArmDistance
                            local moveToPosition = (leftArmTarget + rightArmAvoid) / 2

                            -- Shaking effect
                            if tick() - lastShakeTime > shakeFrequency then
                                lastShakeTime = tick()
                                RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.random() < 0.5 and -shakeIntensity or shakeIntensity, 0)
                            end

                            MoveToPosition(moveToPosition)

                            local distanceToTarget = (RootPart.Position - moveToPosition).magnitude
                            if distanceToTarget <= attackRange then
                                local tool = character:FindFirstChildOfClass("Tool")
                                if tool then tool:Activate() end
                            end
                        end
                    end
                end
            end
            wait(0.1)  # Check every 0.1 seconds to minimize performance impact
        end
    end

    RunService.RenderStepped:Connect(CombatRoutine)
end

Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    handleCombatAI(character)
end)

createGUI()
