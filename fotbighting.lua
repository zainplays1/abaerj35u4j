local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local aiActive = true  -- AI is always on by default
local currentTarget = nil
local followPlayer = nil
local attackTarget = nil

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

-- Function to handle chat commands
local function onPlayerChatted(sender, message)
    if sender == Player then
        local args = message:split(" ")
        local command = args[1]:lower()

        if command == "/follow" and #args > 1 then
            local targetName = table.concat(args, " ", 2)
            followPlayer = findPlayerByName(targetName)
            attackTarget = nil
            print("Command to follow: " .. (followPlayer and followPlayer.Name or "player not found"))
        elseif command == "/attack" and #args > 1 then
            local targetName = table.concat(args, " ", 2)
            attackTarget = findPlayerByName(targetName)
            followPlayer = nil
            print("Command to attack: " .. (attackTarget and attackTarget.Name or "player not found"))
        elseif command == "/stop" then
            followPlayer = nil
            attackTarget = nil
            print("AI actions stopped.")
        end
    end
end

-- Connect the chat handler
Player.Chatted:Connect(onPlayerChatted)

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

-- Main combat AI routine
local function trackAndInteract()
    while true do
        wait(0.1)
        if not aiActive or not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end

        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
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
                }
            end
        end
    end
end

RunService.RenderStepped:Connect(trackAndInteract)

createGUI()
