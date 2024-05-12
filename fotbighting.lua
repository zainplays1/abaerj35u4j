local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ChatService = game:GetService("Chat")

local Player = Players.LocalPlayer
local aiActive = false
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
    end)
end

local function findPlayerByName(partialName)
    partialName = partialName:lower()
    local closestMatch = nil
    local shortestDistance = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        local username = p.Name:lower()
        local displayName = (p.DisplayName or ""):lower()
        if username:find(partialName) or displayName:find(partialName) then
            if closestMatch == nil or username:sub(1, #partialName) == partialName or displayName:sub(1, #partialName) == partialName then
                closestMatch = p
            end
        end
    end
    return closestMatch
end

local function handleCommands(message, player)
    local command, args = message:match("^/ (%w+)%s*(.*)")
    if command then
        if command == "come" and player == Player then
            followPlayer = player
            attackTarget = nil
        elseif command == "attack" and args ~= "" and player == Player then
            attackTarget = findPlayerByName(args)
            followPlayer = nil
        elseif command == "stop" and player == Player then
            followPlayer = nil
            attackTarget = nil
        end
    end
end

ChatService.Chatted:Connect(handleCommands)

local function trackAndInteract()
    while aiActive do
        local character = Player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoid or not rootPart then repeat wait() until Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") end

        if followPlayer then
            humanoid:MoveTo(followPlayer.Character.HumanoidRootPart.Position)
        elseif attackTarget then
            humanoid:MoveTo(attackTarget.Character.HumanoidRootPart.Position)
            if (rootPart.Position - attackTarget.Character.HumanoidRootPart.Position).magnitude < 10 then
                local tool = character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
        wait(0.1)
    end
end

RunService.RenderStepped:Connect(trackAndInteract)

Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    trackAndInteract()
end)

createGUI()
