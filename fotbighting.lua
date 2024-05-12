local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local aiActive = true  -- AI is always on by default
local followPlayer = nil
local attackTarget = nil
local currentTarget = nil
local leftArmDistance = 2
local rightArmAvoidance = 5

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

-- Main combat AI routine
local function CombatRoutine()
    while aiActive do
        wait(0.1)  -- Reduce frequency to minimize performance impact
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end

        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        local rootPart = Player.Character.HumanoidRootPart

        if followPlayer and followPlayer.Character and followPlayer.Character:FindFirstChild("HumanoidRootPart") then
            humanoid:MoveTo(followPlayer.Character.HumanoidRootPart.Position)
        elseif attackTarget and attackTarget.Character then
            local targetHumanoid = attackTarget.Character:FindFirstChildOfClass("Humanoid")
            local targetRootPart = attackTarget.Character:FindFirstChild("HumanoidRootPart")

            if targetHumanoid and targetHumanoid.Health > 0 and targetRootPart then
                local moveToPosition = targetRootPart.Position
                humanoid:MoveTo(moveToPosition)
                local distance = (rootPart.Position - moveToPosition).magnitude

                if distance <= 10 then  -- Attack range
                    local tool = Player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        print("Attacking " .. attackTarget.Name)
                    end
                end
            else
                attackTarget = nil  -- Reset if target is defeated or not found
            end
        end
    end
end

-- Connect the chat handler to process commands
Player.Chatted:Connect(function(message)
    local args = message:split(" ")
    local command = args[1]:lower()

    if command == "/follow" and #args > 1 then
        local targetName = table.concat(args, " ", 2)
        followPlayer = findPlayerByName(targetName)
        attackTarget = nil
        if followPlayer then
            print("Following " .. followPlayer.Name)
        else
            print("Player not found: " .. targetName)
        end
    elseif command == "/attack" and #args > 1 then
        local targetName = table.concat(args, " ", 2)
        attackTarget = findPlayerByName(targetName)
        followPlayer = nil
        if attackTarget then
            print("Attacking " .. attackTarget.Name)
        else
            print("Player not found: " .. targetName)
        end
    elseif command == "/stop" then
        followPlayer = nil
        attackTarget = nil
        print("Stopping actions.")
    end
end)

-- Helper function to find a player by name, handling partial matches
local function findPlayerByName(name)
    local lowerName = name:lower()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name:lower():find(lowerName) or (player.DisplayName and player.DisplayName:lower():find(lowerName)) then
            return player
        end
    end
    return nil
end

createGUI()
RunService.RenderStepped:Connect(CombatRoutine)
