local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local aiActive = true  -- AI is always on by default
local followPlayer = nil
local attackTarget = nil
local currentTarget = nil
local closeProximity = 5  -- Distance at which strategic turning is activated
local attackRange = 10  -- Range within which the AI will attempt to attack
local shakeIntensity = math.rad(0.5)  -- Intensity of shaking effect
local shakeFrequency = 0.5  -- Frequency of shaking in seconds
local turnRatio = 0.5  -- Smoothness of turning adjustments

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
        print("AI Status: " .. (aiActive and "Enabled" or "Disabled"))
    end)
end

-- Helper function to find player by partial name match
local function findPlayerByName(partialName)
    partialName = partialName:lower()
    for _, p in pairs(Players:GetPlayers()) do
        local username = p.Name:lower()
        local displayName = (p.DisplayName or ""):lower()
        if username:find(partialName) or displayName:find(partialName) then
            return p
        end
    end
    return nil
end

-- Function to handle chat commands
local function onPlayerChatted(player, message)
    if player == Player then
        local command, args = message:match("^/(%w+)%s*(.*)")
        if command then
            if command == "come" then
                followPlayer = Player
                attackTarget = nil
            elseif command == "attack" and args ~= "" then
                attackTarget = findPlayerByName(args)
                followPlayer = nil
            elseif command == "stop" then
                followPlayer = nil
                attackTarget = nil
            end
        end
    end
end

-- Connect the chat handler
Players.LocalPlayer.Chatted:Connect(onPlayerChatted)

-- Main combat AI routine
local function CombatRoutine()
    local lastShakeTime = tick()
    while aiActive do
        local enemy = attackTarget or followPlayer
        if enemy and enemy.Character then
            local enemyHumanoid = enemy.Character:FindFirstChildOfClass("Humanoid")
            if enemyHumanoid and currentTarget ~= enemy then
                -- Sync jump with the enemy
                enemyHumanoid.StateChanged:Connect(function(_, newState)
                    if newState == Enum.HumanoidStateType.Freefall and Player.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then
                        Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
                currentTarget = enemy
            end

            if currentTarget.Character.Humanoid.Health > 0 then
                local targetPosition = currentTarget.Character.HumanoidRootPart.Position
                local distanceToTarget = (Player.Character.HumanoidRootPart.Position - targetPosition).magnitude

                if distanceToTarget <= closeProximity then
                    -- Strategic turning: slightly turn left when close
                    targetPosition = targetPosition - Player.Character.HumanoidRootPart.CFrame.RightVector * 2
                end

                -- Maintain horizontal orientation and move towards the target
                local horizontalDirection = Vector3.new(targetPosition.X, Player.Character.HumanoidRootPart.Position.Y, targetPosition.Z)
                Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame:Lerp(CFrame.new(Player.Character.HumanoidRootPart.Position, horizontalDirection), turnRatio)

                Player.Character.Humanoid:MoveTo(targetPosition)

                -- Shaking effect
                if tick() - lastShakeTime > shakeFrequency then
                    lastShakeTime = tick()
                    Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.random() < 0.5 and -shakeIntensity or shakeIntensity, 0)
                end

                if distanceToTarget <= attackRange then
                    local tool = Player.Character:FindFirstChildOfClass("Tool")
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

createGUI()
