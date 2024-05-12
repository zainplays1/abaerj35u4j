local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local aiActive = true  -- AI is always on by default
local followPlayer = nil
local attackTarget = nil
local currentTarget = nil

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

-- Listen to chat commands directly from the player
local function onPlayerChatted(player, message)
    print("Received message from " .. player.Name .. ": " .. message)  -- Debugging output
    if player == Player then
        local command, args = message:match("^/(%w+)%s*(.*)")
        if command then
            if command == "come" then
                followPlayer = player
                attackTarget = nil
                print("AI is coming to " .. player.Name)
            elseif command == "attack" and args ~= "" then
                attackTarget = findPlayerByName(args)
                followPlayer = nil
                if attackTarget then
                    print("AI is attacking " .. attackTarget.Name)
                else
                    print("Player not found for attack.")
                end
            elseif command == "stop" then
                followPlayer = nil
                attackTarget = nil
                print("AI actions stopped.")
            end
        end
    end
end

-- Connect the chat handler
Player.Chatted:Connect(onPlayerChatted)

-- Combat and movement routine
local function CombatRoutine()
    while true do
        wait(0.1)
        if not aiActive then continue end
        if not Player.Character or not Player.Character:FindFirstChild("Humanoid") then continue end

        local humanoid = Player.Character.Humanoid
        local rootPart = Player.Character.HumanoidRootPart

        if followPlayer and followPlayer.Character and followPlayer.Character:FindFirstChild("HumanoidRootPart") then
            humanoid:MoveTo(followPlayer.Character.HumanoidRootPart.Position)
            print("Moving to " .. followPlayer.Name)  -- Debugging output
        elseif attackTarget and attackTarget.Character and attackTarget.Character:FindFirstChild("HumanoidRootPart") then
            humanoid:MoveTo(attackTarget.Character.HumanoidRootPart.Position)
            if (rootPart.Position - attackTarget.Character.HumanoidRootPart.Position).magnitude <= 10 then
                local tool = Player.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                    print("Attacking " .. attackTarget.Name)  -- Debugging output
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(CombatRoutine)

createGUI()
