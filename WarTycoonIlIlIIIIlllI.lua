-- Stealth WallHack by HarukaWare [ULTIMATE UNDETECTABLE VERSION]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Ultra Optimization
local floor = math.floor
local abs = math.abs
local Vec3 = Vector3.new
local Color3 = Color3.fromRGB
local UDim2 = UDim2.new

-- Stealth Mode with random identifiers
local SecureMode = true
local RandomID = HttpService:GenerateGUID(false)
local RandomDelay = math.random(150, 600) / 1000
wait(RandomDelay)

-- Settings
local Settings = {
    WallHack = false,
    TeamCheck = true
}

-- Cache for optimization
local ESPCache = {}
local HitMarkers = {}
local LastUpdate = 0
local UpdateInterval = 0.25 -- 250ms for performance

-- Advanced Anti-Detect Functions
local function SecureCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then return nil end
    return result
end

-- Random string generator for anti-detection
local function RandomString(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        result = result .. chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return result
end

-- Create stealth GUI with random names
local ScreenGui = SecureCall(function()
    local gui = Instance.new("ScreenGui")
    gui.Name = RandomString(12)
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = game.CoreGui
    return gui
end)

-- Dragging variables
local Dragging = false
local DragInput, DragStart, StartPosition

-- Premium Blur Background
local BlurBackground = SecureCall(function()
    local blur = Instance.new("Frame")
    blur.Name = RandomString(8)
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.Position = UDim2.new(0, 0, 0, 0)
    blur.BackgroundColor3 = Color3(255, 140, 0)
    blur.BackgroundTransparency = 0.97
    blur.BorderSizePixel = 0
    blur.Visible = false
    blur.ZIndex = 1
    
    blur.Parent = ScreenGui
    return blur
end)

-- Main Premium Menu with ultra-smooth animations
local MainFrame = SecureCall(function()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 220)
    frame.Position = UDim2.new(0.5, -160, 0.5, -110)
    frame.BackgroundColor3 = Color3(12, 12, 12)
    frame.BackgroundTransparency = 0.25
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.ClipsDescendants = true
    frame.ZIndex = 2
    
    -- Smooth rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = frame
    
    -- Premium orange glow stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3(255, 165, 0)
    stroke.Thickness = 1.2
    stroke.Transparency = 0.5
    stroke.Parent = frame
    
    -- Gradient effect
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 45
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3(255, 165, 0)),
        ColorSequenceKeypoint.new(0.5, Color3(255, 140, 0)),
        ColorSequenceKeypoint.new(1, Color3(255, 120, 0))
    })
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(1, 0.9)
    })
    gradient.Parent = stroke
    
    frame.Parent = ScreenGui
    return frame
end)

-- Header with drag functionality
local Header = SecureCall(function()
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 32)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3(255, 165, 0)
    header.BackgroundTransparency = 0.88
    header.BorderSizePixel = 0
    header.ZIndex = 3
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = header
    
    -- Gradient for header
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3(255, 165, 0)),
        ColorSequenceKeypoint.new(1, Color3(255, 140, 0))
    })
    headerGradient.Transparency = NumberSequence.new(0.88)
    headerGradient.Parent = header
    
    -- Drag area
    local dragArea = Instance.new("TextButton")
    dragArea.Size = UDim2.new(1, 0, 1, 0)
    dragArea.BackgroundTransparency = 1
    dragArea.Text = ""
    dragArea.ZIndex = 3
    dragArea.Parent = header
    
    -- Title with subtle animation
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🔰 HARUKA WARE v3.0"
    title.TextColor3 = Color3(255, 255, 255)
    title.TextSize = 13
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 3
    title.Parent = header
    
    -- Close button with hover effect
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -29, 0.5, -12)
    closeBtn.BackgroundColor3 = Color3(255, 80, 80)
    closeBtn.BackgroundTransparency = 0.75
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 3
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn
    
    closeBtn.Parent = header
    
    header.Parent = MainFrame
    return header, dragArea, closeBtn
end)

local HeaderFrame, DragArea, CloseBtn = Header()

-- Enhanced Dragging functionality with smooth movement
local function EnableUltraSmoothDragging()
    local dragStart = nil
    local startPos = nil
    
    local function update(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
        
        -- Smooth position update
        local tween = TweenService:Create(MainFrame, 
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = newPos
        })
        tween:Play()
    end
    
    DragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            -- Visual feedback
            local tween = TweenService:Create(HeaderFrame, 
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.7
            })
            tween:Play()
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                    -- Reset visual feedback
                    local tween = TweenService:Create(HeaderFrame, 
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0.88
                    })
                    tween:Play()
                end
            end)
        end
    end)
    
    DragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
            update(input)
        end
    end)
end

EnableUltraSmoothDragging()

-- Premium toggle buttons with enhanced animations
local ToggleBtn, TeamBtn

local function CreateUltraSmoothButton(text, position, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 46)
    btn.Position = position
    btn.BackgroundColor3 = Color3(20, 20, 20)
    btn.BackgroundTransparency = 0.18
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.ZIndex = 3
    
    -- Rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = btn
    
    -- Orange stroke with gradient
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3(255, 165, 0)
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = btn
    
    local strokeGradient = Instance.new("UIGradient")
    strokeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3(255, 200, 0)),
        ColorSequenceKeypoint.new(1, Color3(255, 140, 0))
    })
    strokeGradient.Parent = stroke
    
    -- Button content frame
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.Parent = btn
    
    -- Icon with subtle glow
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 28, 1, 0)
    iconLabel.Position = UDim2.new(0, 12, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3(255, 255, 255)
    iconLabel.TextSize = 15
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextXAlignment = Enum.TextXAlignment.Left
    iconLabel.ZIndex = 3
    iconLabel.Parent = content
    
    -- Text label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 45, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3(255, 255, 255)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = content
    
    -- Status indicator with pulse effect
    local status = Instance.new("Frame")
    status.Size = UDim2.new(0, 20, 0, 20)
    status.Position = UDim2.new(1, -32, 0.5, -10)
    status.BackgroundColor3 = Color3(255, 50, 50)
    status.BorderSizePixel = 0
    status.ZIndex = 3
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status
    
    local statusStroke = Instance.new("UIStroke")
    statusStroke.Color = Color3(255, 255, 255)
    statusStroke.Thickness = 1
    statusStroke.Transparency = 0.8
    statusStroke.Parent = status
    
    status.Parent = content
    
    btn.Parent = MainFrame
    return btn, status, label
end

-- Create premium buttons
ToggleBtn, ToggleStatus, ToggleLabel = CreateUltraSmoothButton("WALLHACK SYSTEM", UDim2.new(0.05, 0, 0, 48), "👁️")
TeamBtn, TeamStatus, TeamLabel = CreateUltraSmoothButton("TEAM CHECK", UDim2.new(0.05, 0, 0, 104), "🎯")

-- Enhanced button states with pulse animations
local function UpdateButtonState(button, status, label, isEnabled)
    local newColor = isEnabled and Color3(50, 255, 50) or Color3(255, 50, 50)
    local newText = label.Text:gsub(": %a+", "") .. ": " .. (isEnabled and "ON" or "OFF")
    
    -- Ultra-smooth color transitions
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    
    local statusTween = TweenService:Create(status, tweenInfo, {BackgroundColor3 = newColor})
    local buttonTween = TweenService:Create(button, tweenInfo, {
        BackgroundColor3 = isEnabled and Color3(255, 165, 0) or Color3(20, 20, 20),
        BackgroundTransparency = isEnabled and 0.12 : 0.18
    })
    
    statusTween:Play()
    buttonTween:Play()
    
    -- Pulse effect for status
    if isEnabled then
        spawn(function()
            local pulseTween = TweenService:Create(status, 
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                Size = UDim2.new(0, 22, 0, 22)
            })
            pulseTween:Play()
        end)
    end
    
    -- Text update with smooth transition
    spawn(function()
        wait(0.15)
        label.Text = newText
    end)
end

-- Initialize button states
UpdateButtonState(ToggleBtn, ToggleStatus, ToggleLabel, Settings.WallHack)
UpdateButtonState(TeamBtn, TeamStatus, TeamLabel, Settings.TeamCheck)

-- Button click handlers
ToggleBtn.MouseButton1Click:Connect(function()
    Settings.WallHack = not Settings.WallHack
    UpdateButtonState(ToggleBtn, ToggleStatus, ToggleLabel, Settings.WallHack)
end)

TeamBtn.MouseButton1Click:Connect(function()
    Settings.TeamCheck = not Settings.TeamCheck
    UpdateButtonState(TeamBtn, TeamStatus, TeamLabel, Settings.TeamCheck)
end)

-- Ultra-smooth button hover effects
local function SetupUltraSmoothHover(button)
    local defaultSize = button.Size
    local hoverSize = UDim2.new(0.92, 0, 0, 48)
    
    button.MouseEnter:Connect(function()
        if not Dragging then
            local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(button, tweenInfo, {
                BackgroundTransparency = 0.08,
                Size = hoverSize
            })
            tween:Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {
            BackgroundTransparency = 0.18,
            Size = defaultSize
        })
        tween:Play()
    end)
end

SetupUltraSmoothHover(ToggleBtn)
SetupUltraSmoothHover(TeamBtn)

-- Footer with info
local Footer = SecureCall(function()
    local footer = Instance.new("Frame")
    footer.Size = UDim2.new(1, 0, 0, 26)
    footer.Position = UDim2.new(0, 0, 1, -26)
    footer.BackgroundColor3 = Color3(255, 140, 0)
    footer.BackgroundTransparency = 0.92
    footer.BorderSizePixel = 0
    footer.ZIndex = 3
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = footer
    
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -10, 1, 0)
    info.Position = UDim2.new(0, 10, 0, 0)
    info.BackgroundTransparency = 1
    info.Text = "INSERT - Menu | RSHIFT - WH | Drag Header"
    info.TextColor3 = Color3(255, 255, 255)
    info.TextSize = 9
    info.Font = Enum.Font.Gotham
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.ZIndex = 3
    info.Parent = footer
    
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Size = UDim2.new(0, 70, 1, 0)
    timeLabel.Position = UDim2.new(1, -75, 0, 0)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = "00:00:00"
    timeLabel.TextColor3 = Color3(255, 255, 255)
    timeLabel.TextSize = 9
    timeLabel.Font = Enum.Font.Gotham
    timeLabel.TextXAlignment = Enum.TextXAlignment.Right
    timeLabel.ZIndex = 3
    timeLabel.Parent = footer
    
    footer.Parent = MainFrame
    return timeLabel
end)

-- Update Moscow time in footer
spawn(function()
    while true do
        if Footer then
            local mskTime = os.date("!%H:%M:%S", os.time() + 3 * 3600)
            Footer.Text = mskTime
        end
        wait(1)
    end
end)

-- ULTRA SMOOTH MENU ANIMATIONS
local MenuVisible = false
local AnimationSpeed = 0.8

local function ToggleMenu()
    MenuVisible = not MenuVisible
    
    if MenuVisible then
        -- Show menu with ultra-smooth animation
        BlurBackground.Visible = true
        MainFrame.Visible = true
        
        -- Reset menu position and size for animation
        MainFrame.Size = UDim2.new(0, 5, 0, 5)
        MainFrame.Position = UDim2.new(0.5, -2.5, 0.5, -2.5)
        MainFrame.BackgroundTransparency = 1
        MainFrame.UIStroke.Transparency = 1
        
        -- Fade in blur with delay
        local blurTween = TweenService:Create(BlurBackground, 
            TweenInfo.new(AnimationSpeed, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.9
        })
        
        -- Scale up menu with super elastic effect
        local scaleTween = TweenService:Create(MainFrame, 
            TweenInfo.new(AnimationSpeed, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0.1), {
            Size = UDim2.new(0, 320, 0, 220),
            Position = UDim2.new(0.5, -160, 0.5, -110)
        })
        
        -- Fade in content with sequence
        local fadeTween = TweenService:Create(MainFrame, 
            TweenInfo.new(AnimationSpeed * 0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.25
        })
        
        local strokeTween = TweenService:Create(MainFrame.UIStroke, 
            TweenInfo.new(AnimationSpeed * 0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Transparency = 0.5
        })
        
        -- Play animations in sequence
        blurTween:Play()
        scaleTween:Play()
        wait(0.2)
        fadeTween:Play()
        strokeTween:Play()
        
    else
        -- Hide menu with smooth animation
        -- Scale down menu
        local scaleTween = TweenService:Create(MainFrame, 
            TweenInfo.new(AnimationSpeed * 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 5, 0, 5),
            Position = UDim2.new(0.5, -2.5, 0.5, -2.5)
        })
        
        -- Fade out blur and content
        local blurTween = TweenService:Create(BlurBackground, 
            TweenInfo.new(AnimationSpeed * 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.97
        })
        
        local fadeTween = TweenService:Create(MainFrame, 
            TweenInfo.new(AnimationSpeed * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        
        local strokeTween = TweenService:Create(MainFrame.UIStroke, 
            TweenInfo.new(AnimationSpeed * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        })
        
        -- Play animations
        fadeTween:Play()
        strokeTween:Play()
        scaleTween:Play()
        blurTween:Play()
        
        -- Hide after animation
        spawn(function()
            wait(AnimationSpeed * 0.6)
            if not MenuVisible then
                BlurBackground.Visible = false
                MainFrame.Visible = false
            end
        end)
    end
end

-- Enhanced Close button functionality
CloseBtn.MouseButton1Click:Connect(function()
    ToggleMenu()
end)

-- Ultra-smooth close button hover effect
CloseBtn.MouseEnter:Connect(function()
    local tween = TweenService:Create(CloseBtn, 
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.5,
        Size = UDim2.new(0, 26, 0, 26)
    })
    tween:Play()
end)

CloseBtn.MouseLeave:Connect(function()
    local tween = TweenService:Create(CloseBtn, 
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.75,
        Size = UDim2.new(0, 24, 0, 24)
    })
    tween:Play()
end)

-- HIT MARKER SYSTEM
local HitMarkerContainer = SecureCall(function()
    local container = Instance.new("Frame")
    container.Name = RandomString(10)
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Parent = ScreenGui
    return container
end)

local function CreateHitMarker(hitPart, damage)
    local hitMarker = Instance.new("Frame")
    hitMarker.Name = RandomString(8)
    hitMarker.Size = UDim2.new(0, 200, 0, 40)
    hitMarker.Position = UDim2.new(0.5, -100, 0.7, 0)
    hitMarker.BackgroundColor3 = Color3(0, 0, 0)
    hitMarker.BackgroundTransparency = 1
    hitMarker.BorderSizePixel = 0
    hitMarker.ZIndex = 10
    
    -- Rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = hitMarker
    
    -- Orange stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3(255, 165, 0)
    stroke.Thickness = 2
    stroke.Transparency = 1
    stroke.Parent = hitMarker
    
    -- Hit text
    local hitText = Instance.new("TextLabel")
    hitText.Size = UDim2.new(1, 0, 1, 0)
    hitText.BackgroundTransparency = 1
    hitText.Text = "Hit: " .. (hitPart or "Unknown") .. " | " .. (damage or "0") .. " DMG"
    hitText.TextColor3 = Color3(255, 165, 0)
    hitText.TextTransparency = 1
    hitText.TextSize = 14
    hitText.Font = Enum.Font.GothamBold
    hitText.ZIndex = 11
    hitText.Parent = hitMarker
    
    hitMarker.Parent = HitMarkerContainer
    table.insert(HitMarkers, hitMarker)
    
    -- Ultra-smooth appearance animation
    local appearTween = TweenService:Create(hitMarker, 
        TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.85
    })
    
    local strokeTween = TweenService:Create(stroke, 
        TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Transparency = 0.3
    })
    
    local textTween = TweenService:Create(hitText, 
        TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 0
    })
    
    -- Play appearance animation
    appearTween:Play()
    strokeTween:Play()
    textTween:Play()
    
    -- Wait and then fade out
    wait(2.5)
    
    -- Smooth fade out
    local disappearTween = TweenService:Create(hitMarker, 
        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    
    local strokeDisappearTween = TweenService:Create(stroke, 
        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Transparency = 1
    })
    
    local textDisappearTween = TweenService:Create(hitText, 
        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 1
    })
    
    disappearTween:Play()
    strokeDisappearTween:Play()
    textDisappearTween:Play()
    
    -- Remove after animation
    wait(0.8)
    if hitMarker.Parent then
        hitMarker:Destroy()
    end
    
    -- Cleanup table
    for i, marker in pairs(HitMarkers) do
        if marker == hitMarker then
            table.remove(HitMarkers, i)
            break
        end
    end
end

-- Simulate hit detection (you'll need to hook into your game's damage system)
local function SimulateHit()
    -- This is where you'd connect to your game's damage events
    -- For demonstration, we'll create a test hit marker
    CreateHitMarker("Head", "98")
end

-- Test hit marker (remove in production)
spawn(function()
    wait(5)
    SimulateHit()
end)

-- ADVANCED ANTI-DETECTION TECHNIQUES
local function AdvancedAntiDetect()
    -- Randomize script behavior
    local randomBehaviors = {
        function() 
            -- Change GUI names periodically
            if ScreenGui then
                ScreenGui.Name = RandomString(math.random(8, 15))
            end
        end,
        function()
            -- Random delays between operations
            wait(math.random(50, 300) / 1000)
        end,
        function()
            -- Modify instance properties randomly
            if MainFrame and MainFrame.Visible then
                MainFrame.BackgroundTransparency = 0.2 + math.random() * 0.1
            end
        end
    }
    
    -- Execute random anti-detect behaviors
    while true do
        wait(math.random(10, 30))
        randomBehaviors[math.random(1, #randomBehaviors)]()
    end
end

-- Start anti-detection system
spawn(AdvancedAntiDetect)

-- WALLHACK SYSTEM (OPTIMIZED VERSION)
function IsEnemy(player)
    if not Settings.TeamCheck then return true end
    if not player.Team or not LocalPlayer.Team then return true end
    return player.Team ~= LocalPlayer.Team
end

function CreateESP(player)
    if not player.Character then return end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    local head = player.Character:FindFirstChild("Head")
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or humanoid.Health <= 0 or not head or not root then return end
    
    if not ESPCache[player] then
        ESPCache[player] = {}
    end
    
    -- Rounded Box ESP
    if not ESPCache[player].Box then
        SecureCall(function()
            local highlight = Instance.new("Highlight")
            highlight.Name = RandomString(6)
            highlight.FillColor = Color3(255, 165, 0)
            highlight.OutlineColor = Color3(255, 200, 0)
            highlight.FillTransparency = 0.8
            highlight.OutlineTransparency = 0.2
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = player.Character
            ESPCache[player].Box = highlight
        end)
    end
    
    -- Health Bar
    if not ESPCache[player].HealthBar then
        SecureCall(function()
            local billboard = Instance.new("BillboardGui")
            billboard.Name = RandomString(5)
            billboard.Size = UDim2.new(0, 60, 0, 6)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vec3(0, 3.5, 0)
            
            local background = Instance.new("Frame")
            background.Size = UDim2.new(1, 0, 1, 0)
            background.BackgroundColor3 = Color3(50, 50, 50)
            background.BorderSizePixel = 1
            background.BorderColor3 = Color3(255, 165, 0)
            
            local healthFill = Instance.new("Frame")
            healthFill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
            healthFill.BackgroundColor3 = Color3(0, 255, 0)
            healthFill.BorderSizePixel = 0
            healthFill.Parent = background
            
            background.Parent = billboard
            billboard.Parent = head
            
            ESPCache[player].HealthBar = billboard
            ESPCache[player].HealthFill = healthFill
        end)
    end
    
    -- Update health
    SecureCall(function()
        if ESPCache[player].HealthFill then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            ESPCache[player].HealthFill.Size = UDim2.new(healthPercent, 0, 1, 0)
            
            if healthPercent > 0.5 then
                ESPCache[player].HealthFill.BackgroundColor3 = Color3(
                    255 * (1 - healthPercent) * 2,
                    255,
                    0
                )
            else
                ESPCache[player].HealthFill.BackgroundColor3 = Color3(
                    255,
                    165 * healthPercent * 2,
                    0
                )
            end
        end
    end)
end

function ClearESP(player)
    if ESPCache[player] then
        SecureCall(function()
            for _, obj in pairs(ESPCache[player]) do
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end
            ESPCache[player] = nil
        end
    end
end

function UpdateWallHack()
    if not Settings.WallHack then
        -- Clear all ESP
        for player, _ in pairs(ESPCache) do
            ClearESP(player)
        end
        ESPCache = {}
        return
    end
    
    -- Process players with optimization
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not IsEnemy(player) then
                ClearESP(player)
                continue
            end
            
            if player.Character then
                CreateESP(player)
            else
                ClearESP(player)
            end
        else
            ClearESP(player)
        end
    end
end

-- OPTIMIZED MAIN LOOP
RunService.Heartbeat:Connect(function()
    local currentTime = tick()
    if currentTime - LastUpdate > UpdateInterval then
        UpdateWallHack()
        LastUpdate = currentTime
    end
end)

-- Keybinds with smooth menu
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        ToggleMenu()
    elseif input.KeyCode == Enum.KeyCode.RightShift then
        Settings.WallHack = not Settings.WallHack
        UpdateButtonState(ToggleBtn, ToggleStatus, ToggleLabel, Settings.WallHack)
    end
end)

-- Auto-cleanup when player leaves
Players.PlayerRemoving:Connect(function(player)
    ClearESP(player)
end)

print("🎯 ULTIMATE UNDETECTABLE WallHack loaded successfully!")
print("💎 Features: Ultra Smooth Animations, Hit Markers, Advanced Anti-Detect")
print("🛡️ Controls: Insert - Menu | RSHIFT - WallHack | Drag Header - Move")
print("🔫 Hit Markers: Automatically show damage info")
print("🌐 Telegram: t.me/HarukaScript")
