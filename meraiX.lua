-- MeraiX Executor Script (Rewritten & Enhanced for Stability)
-- Developed by EDEN 11 for C00lshine / zaxv3101
-- This script is released under an open-source license, encouraging community contributions and modifications.

-- // Core Variables and Services //
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- // Configuration //
local CONFIG = {
    GUI_COLOR = Color3.fromRGB(40, 40, 40),
    ACCENT_COLOR = Color3.fromRGB(80, 80, 255),
    TEXT_COLOR = Color3.fromRGB(255, 255, 255),
    TEXT_COLOR_SECONDARY = Color3.fromRGB(180, 180, 180),
    BORDER_COLOR = Color3.fromRGB(25, 25, 25),
    FONT = Enum.Font.SourceSansBold,
    SCRIPTBLOX_API_URL = "https://scriptblox.com/api/script/get?id=", -- Base URL for fetching scripts by ID
    SCRIPTBLOX_SEARCH_URL = "https://scriptblox.com/api/script/search?query=", -- Base URL for searching scripts
}

-- // MeraiX GUI Setup (Unchanged from previous deobfuscated version) //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MeraiX_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = CONFIG.GUI_COLOR
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = CONFIG.BORDER_COLOR
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.AspectRatio = 1.618 -- Golden ratio for aesthetic appeal
UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
UIAspectRatioConstraint.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0.1, 0)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = CONFIG.ACCENT_COLOR
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0.8, 0, 1, 0)
TitleLabel.Position = UDim2.new(0.1, 0, 0, 0)
TitleLabel.BackgroundColor3 = CONFIG.ACCENT_COLOR
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "MeraiX Executor"
TitleLabel.Font = CONFIG.FONT
TitleLabel.TextSize = 24
TitleLabel.TextColor3 = CONFIG.TEXT_COLOR
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0.08, 0, 0.7, 0)
MinimizeButton.Position = UDim2.new(0.82, 0, 0.15, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "—"
MinimizeButton.Font = CONFIG.FONT
MinimizeButton.TextSize = 20
MinimizeButton.TextColor3 = CONFIG.TEXT_COLOR
MinimizeButton.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.08, 0, 0.7, 0)
CloseButton.Position = UDim2.new(0.91, 0, 0.15, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.Font = CONFIG.FONT
CloseButton.TextSize = 20
CloseButton.TextColor3 = CONFIG.TEXT_COLOR
CloseButton.Parent = TitleBar

local ScriptEditor = Instance.new("TextBox")
ScriptEditor.Name = "ScriptEditor"
ScriptEditor.Size = UDim2.new(0.9, 0, 0.6, 0)
ScriptEditor.Position = UDim2.new(0.05, 0, 0.15, 0)
ScriptEditor.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ScriptEditor.BorderSizePixel = 1
ScriptEditor.BorderColor3 = CONFIG.BORDER_COLOR
ScriptEditor.Text = "-- Write your Lua script here"
ScriptEditor.Font = Enum.Font.Code
ScriptEditor.TextSize = 14
ScriptEditor.TextColor3 = CONFIG.TEXT_COLOR
ScriptEditor.TextWrapped = true
ScriptEditor.MultiLine = true
ScriptEditor.ClearTextOnFocus = true
ScriptEditor.Parent = MainFrame

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Size = UDim2.new(0.4, 0, 0.08, 0)
ExecuteButton.Position = UDim2.new(0.05, 0, 0.78, 0)
ExecuteButton.BackgroundColor3 = CONFIG.ACCENT_COLOR
ExecuteButton.BorderSizePixel = 0
ExecuteButton.Text = "Execute"
ExecuteButton.Font = CONFIG.FONT
ExecuteButton.TextSize = 18
ExecuteButton.TextColor3 = CONFIG.TEXT_COLOR
ExecuteButton.Parent = MainFrame

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "ClearButton"
ClearButton.Size = UDim2.new(0.2, 0, 0.08, 0)
ClearButton.Position = UDim2.new(0.5, 0, 0.78, 0)
ClearButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ClearButton.BorderSizePixel = 0
ClearButton.Text = "Clear"
ClearButton.Font = CONFIG.FONT
ClearButton.TextSize = 18
ClearButton.TextColor3 = CONFIG.TEXT_COLOR
ClearButton.Parent = MainFrame

local LibraryButton = Instance.new("TextButton")
LibraryButton.Name = "LibraryButton"
LibraryButton.Size = UDim2.new(0.25, 0, 0.08, 0)
LibraryButton.Position = UDim2.new(0.7, 0, 0.78, 0)
LibraryButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
LibraryButton.BorderSizePixel = 0
LibraryButton.Text = "Library"
LibraryButton.Font = CONFIG.FONT
LibraryButton.TextSize = 18
LibraryButton.TextColor3 = CONFIG.TEXT_COLOR
LibraryButton.Parent = MainFrame

local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Size = UDim2.new(0.1, 0, 0.08, 0)
SettingsButton.Position = UDim2.new(0.05, 0, 0.88, 0)
SettingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SettingsButton.BorderSizePixel = 0
SettingsButton.Text = "⚙️" -- Cog icon
SettingsButton.Font = CONFIG.FONT
SettingsButton.TextSize = 20
SettingsButton.TextColor3 = CONFIG.TEXT_COLOR
SettingsButton.Parent = MainFrame

local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Name = "CreditsLabel"
CreditsLabel.Size = UDim2.new(0.8, 0, 0.06, 0)
CreditsLabel.Position = UDim2.new(0.1, 0, 0.93, 0)
CreditsLabel.BackgroundColor3 = CONFIG.GUI_COLOR
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = "Credits: C00lshine (Discord: zaxv3101)"
CreditsLabel.Font = CONFIG.FONT
CreditsLabel.TextSize = 12
CreditsLabel.TextColor3 = CONFIG.TEXT_COLOR_SECONDARY
CreditsLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditsLabel.Parent = MainFrame

-- // Minimized Icon //
local MinimizedIcon = Instance.new("Frame")
MinimizedIcon.Name = "MeraiX_MinimizedIcon"
MinimizedIcon.Size = UDim2.new(0.05, 0, 0.05, 0)
MinimizedIcon.Position = UDim2.new(0.01, 0, 0.01, 0)
MinimizedIcon.BackgroundColor3 = CONFIG.ACCENT_COLOR
MinimizedIcon.BorderSizePixel = 1
MinimizedIcon.BorderColor3 = CONFIG.BORDER_COLOR
MinimizedIcon.Visible = false
MinimizedIcon.Parent = ScreenGui

local MinimizedIconLabel = Instance.new("TextButton")
MinimizedIconLabel.Name = "IconLabel"
MinimizedIconLabel.Size = UDim2.new(1, 0, 1, 0)
MinimizedIconLabel.Position = UDim2.new(0, 0, 0, 0)
MinimizedIconLabel.BackgroundColor3 = CONFIG.ACCENT_COLOR
MinimizedIconLabel.BackgroundTransparency = 1
MinimizedIconLabel.Text = "M"
MinimizedIconLabel.Font = CONFIG.FONT
MinimizedIconLabel.TextSize = 24
MinimizedIconLabel.TextColor3 = CONFIG.TEXT_COLOR
MinimizedIconLabel.Parent = MinimizedIcon

local MinimizedUICorner = Instance.new("UICorner")
MinimizedUICorner.CornerRadius = UDim.new(0, 8)
MinimizedUICorner.Parent = MinimizedIcon

-- // Library Frame (for ScriptBlox Integration) //
local LibraryFrame = Instance.new("Frame")
LibraryFrame.Name = "LibraryFrame"
LibraryFrame.Size = UDim2.new(0.4, 0, 0.7, 0)
LibraryFrame.Position = UDim2.new(0.55, 0, 0.15, 0)
LibraryFrame.BackgroundColor3 = CONFIG.GUI_COLOR
LibraryFrame.BorderSizePixel = 1
LibraryFrame.BorderColor3 = CONFIG.BORDER_COLOR
LibraryFrame.Visible = false
LibraryFrame.Parent = ScreenGui

local LibraryUICorner = Instance.new("UICorner")
LibraryUICorner.CornerRadius = UDim.new(0, 8)
LibraryUICorner.Parent = LibraryFrame

local LibraryTitle = Instance.new("TextLabel")
LibraryTitle.Name = "LibraryTitle"
LibraryTitle.Size = UDim2.new(1, 0, 0.08, 0)
LibraryTitle.Position = UDim2.new(0, 0, 0, 0)
LibraryTitle.BackgroundColor3 = CONFIG.ACCENT_COLOR
LibraryTitle.BorderSizePixel = 0
LibraryTitle.Text = "MeraiX ScriptBlox Library"
LibraryTitle.Font = CONFIG.FONT
LibraryTitle.TextSize = 20
LibraryTitle.TextColor3 = CONFIG.TEXT_COLOR
LibraryTitle.Parent = LibraryFrame

local LibraryCloseButton = Instance.new("TextButton")
LibraryCloseButton.Name = "CloseButton"
LibraryCloseButton.Size = UDim2.new(0.12, 0, 0.7, 0)
LibraryCloseButton.Position = UDim2.new(0.85, 0, 0.15, 0)
LibraryCloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
LibraryCloseButton.BorderSizePixel = 0
LibraryCloseButton.Text = "X"
LibraryCloseButton.Font = CONFIG.FONT
LibraryCloseButton.TextSize = 18
LibraryCloseButton.TextColor3 = CONFIG.TEXT_COLOR
LibraryCloseButton.Parent = LibraryTitle

local SearchTextBox = Instance.new("TextBox")
SearchTextBox.Name = "SearchTextBox"
SearchTextBox.Size = UDim2.new(0.7, 0, 0.07, 0)
SearchTextBox.Position = UDim2.new(0.05, 0, 0.1, 0)
SearchTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SearchTextBox.BorderSizePixel = 1
SearchTextBox.BorderColor3 = CONFIG.BORDER_COLOR
SearchTextBox.PlaceholderText = "Search ScriptBlox..."
SearchTextBox.Font = CONFIG.FONT
SearchTextBox.TextSize = 14
SearchTextBox.TextColor3 = CONFIG.TEXT_COLOR
SearchTextBox.ClearTextOnFocus = false
SearchTextBox.Parent = LibraryFrame

local SearchButton = Instance.new("TextButton")
SearchButton.Name = "SearchButton"
SearchButton.Size = UDim2.new(0.2, 0, 0.07, 0)
SearchButton.Position = UDim2.new(0.78, 0, 0.1, 0)
SearchButton.BackgroundColor3 = CONFIG.ACCENT_COLOR
SearchButton.BorderSizePixel = 0
SearchButton.Text = "Search"
SearchButton.Font = CONFIG.FONT
SearchButton.TextSize = 16
SearchButton.TextColor3 = CONFIG.TEXT_COLOR
SearchButton.Parent = LibraryFrame

local LibraryScrollingFrame = Instance.new("ScrollingFrame")
LibraryScrollingFrame.Name = "LibraryScrollingFrame"
LibraryScrollingFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
LibraryScrollingFrame.Position = UDim2.new(0.05, 0, 0.18 + 0.07, 0) -- Adjusted position
LibraryScrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LibraryScrollingFrame.BorderSizePixel = 1
LibraryScrollingFrame.BorderColor3 = CONFIG.BORDER_COLOR
LibraryScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated dynamically
LibraryScrollingFrame.ScrollBarImageColor3 = CONFIG.ACCENT_COLOR
LibraryScrollingFrame.ScrollBarThickness = 6
LibraryScrollingFrame.Parent = LibraryFrame

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.Name = "ScriptLayout"
UIGridLayout.CellSize = UDim2.new(1, 0, 0, 70) -- Slightly larger for title and description
UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
UIGridLayout.FillDirectionMaxCells = 1
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIGridLayout.Parent = LibraryScrollingFrame

-- // Settings Frame //
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
SettingsFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
SettingsFrame.BackgroundColor3 = CONFIG.GUI_COLOR
SettingsFrame.BorderSizePixel = 1
SettingsFrame.BorderColor3 = CONFIG.BORDER_COLOR
SettingsFrame.Visible = false
SettingsFrame.Parent = ScreenGui

local SettingsUICorner = Instance.new("UICorner")
SettingsUICorner.CornerRadius = UDim.new(0, 8)
SettingsUICorner.Parent = SettingsFrame

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Name = "SettingsTitle"
SettingsTitle.Size = UDim2.new(1, 0, 0.12, 0)
SettingsTitle.Position = UDim2.new(0, 0, 0, 0)
SettingsTitle.BackgroundColor3 = CONFIG.ACCENT_COLOR
SettingsTitle.BorderSizePixel = 0
SettingsTitle.Text = "MeraiX Settings"
SettingsTitle.Font = CONFIG.FONT
SettingsTitle.TextSize = 20
SettingsTitle.TextColor3 = CONFIG.TEXT_COLOR
SettingsTitle.Parent = SettingsFrame

local SettingsCloseButton = Instance.new("TextButton")
SettingsCloseButton.Name = "CloseButton"
SettingsCloseButton.Size = UDim2.new(0.15, 0, 0.7, 0)
SettingsCloseButton.Position = UDim2.new(0.82, 0, 0.15, 0)
SettingsCloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
SettingsCloseButton.BorderSizePixel = 0
SettingsCloseButton.Text = "X"
SettingsCloseButton.Font = CONFIG.FONT
SettingsCloseButton.TextSize = 18
SettingsCloseButton.TextColor3 = CONFIG.TEXT_COLOR
SettingsCloseButton.Parent = SettingsTitle

-- Example Setting: Toggle for a visual effect
local ExampleSettingLabel = Instance.new("TextLabel")
ExampleSettingLabel.Name = "ExampleSettingLabel"
ExampleSettingLabel.Size = UDim2.new(0.8, 0, 0.15, 0)
ExampleSettingLabel.Position = UDim2.new(0.1, 0, 0.2, 0)
ExampleSettingLabel.BackgroundColor3 = CONFIG.GUI_COLOR
ExampleSettingLabel.BackgroundTransparency = 1
ExampleSettingLabel.Text = "Enable Cool Animations:"
ExampleSettingLabel.Font = CONFIG.FONT
ExampleSettingLabel.TextSize = 16
ExampleSettingLabel.TextColor3 = CONFIG.TEXT_COLOR
ExampleSettingLabel.TextXAlignment = Enum.TextXAlignment.Left
ExampleSettingLabel.Parent = SettingsFrame

local ExampleSettingToggle = Instance.new("TextButton")
ExampleSettingToggle.Name = "ExampleSettingToggle"
ExampleSettingToggle.Size = UDim2.new(0.1, 0, 0.1, 0)
ExampleSettingToggle.Position = UDim2.new(0.8, 0, 0.22, 0)
ExampleSettingToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
ExampleSettingToggle.BorderSizePixel = 1
ExampleSettingToggle.BorderColor3 = CONFIG.BORDER_COLOR
ExampleSettingToggle.Text = "ON"
ExampleSettingToggle.Font = CONFIG.FONT
ExampleSettingToggle.TextSize = 14
ExampleSettingToggle.TextColor3 = CONFIG.TEXT_COLOR
ExampleSettingToggle.Parent = SettingsFrame

local animationsEnabled = true
ExampleSettingToggle.MouseButton1Click:Connect(function()
    animationsEnabled = not animationsEnabled
    if animationsEnabled then
        ExampleSettingToggle.Text = "ON"
        ExampleSettingToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ExampleSettingToggle.Text = "OFF"
        ExampleSettingToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- // Animation Function //
local function animateTween(object, propertyTable, duration, easingStyle, easingDirection)
    if not animationsEnabled then return end
    local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
    local tween = TweenService:Create(object, tweenInfo, propertyTable)
    tween:Play()
    return tween
end

-- // Core Executor Functions //

-- Function to execute a script string
local function executeScript(scriptText)
    -- Attempt to load the script as a function
    local success, funcOrError = pcall(function()
        return loadstring(scriptText)
    end)

    if success then
        -- loadstring successfully compiled the script
        if typeof(funcOrError) == "function" then
            -- Execute the compiled function
            local execSuccess, execErr = pcall(funcOrError)
            if not execSuccess then
                warn("MeraiX Execution Error: " .. tostring(execErr))
                ScriptEditor.Text = "-- Script execution failed:\n" .. tostring(execErr)
            else
                print("MeraiX: Script executed successfully.")
            end
        elseif funcOrError == nil then
            -- loadstring returned nil because the scriptText was empty or malformed syntax-wise
            warn("MeraiX Loadstring Warning: Script input was empty or had invalid syntax.")
            ScriptEditor.Text = "-- Cannot execute: Script is empty or has a syntax error. Check output."
        else
            -- This case should ideally not happen with loadstring, but it's a safeguard
            warn("MeraiX Internal Error: loadstring returned unexpected type: " .. typeof(funcOrError))
            ScriptEditor.Text = "-- Internal Error: Could not prepare script for execution. Type: " .. typeof(funcOrError)
        end
    else
        -- pcall around loadstring failed, meaning loadstring itself threw an error (e.g., security context issues)
        warn("MeraiX Loadstring Failed: " .. tostring(funcOrError))
        ScriptEditor.Text = "-- Failed to load script into execution context:\n" .. tostring(funcOrError) .. "\n(Possible syntax error or executor limitation)"
    end
end

-- Function to fetch script from ScriptBlox by ID
local function fetchScriptFromScriptBlox(scriptId)
    local url = CONFIG.SCRIPTBLOX_API_URL .. scriptId
    local content = ""
    local success, response = pcall(function()
        content = HttpService:GetAsync(url)
    end)

    if success then
        local data = HttpService:JSONDecode(content)
        if data and data.script and data.success then
            ScriptEditor.Text = data.script.script
            animateTween(ScriptEditor, {BackgroundTransparency = 0.2}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            task.wait(0.2)
            animateTween(ScriptEditor, {BackgroundTransparency = 0}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        else
            warn("MeraiX ScriptBlox API Error: " .. (data and data.message or "Unknown error"))
            ScriptEditor.Text = "-- Error: Could not load script from ScriptBlox (ID: " .. scriptId .. "). " .. (data and data.message or "Script not found/API error.")
        end
    else
        warn("MeraiX ScriptBlox Connection Failed: " .. tostring(response))
        ScriptEditor.Text = "-- Error: Failed to connect to ScriptBlox API for ID: " .. scriptId .. ". Check your internet connection or API status."
    end
end

-- Function to search ScriptBlox
local function searchScriptBlox(query)
    -- Clear previous search results
    for _, child in ipairs(LibraryScrollingFrame:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then
            child:Destroy()
        end
    end
    -- Reset CanvasSize
    LibraryScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

    local url = CONFIG.SCRIPTBLOX_SEARCH_URL .. HttpService:UrlEncode(query)
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        if data and data.scripts and data.success then
            local scriptCount = 0
            for i, scriptData in ipairs(data.scripts) do
                scriptCount = scriptCount + 1
                local scriptFrame = Instance.new("Frame")
                scriptFrame.Name = "ScriptEntry_" .. scriptData._id
                scriptFrame.Size = UDim2.new(1, 0, 0, 70)
                scriptFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                scriptFrame.BorderSizePixel = 1
                scriptFrame.BorderColor3 = CONFIG.BORDER_COLOR
                scriptFrame.Parent = LibraryScrollingFrame

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 5)
                corner.Parent = scriptFrame

                local titleLabel = Instance.new("TextLabel")
                titleLabel.Name = "Title"
                titleLabel.Size = UDim2.new(0.95, 0, 0.4, 0)
                titleLabel.Position = UDim2.new(0.025, 0, 0.05, 0)
                titleLabel.BackgroundColor3 = scriptFrame.BackgroundColor3
                titleLabel.BackgroundTransparency = 1
                titleLabel.Text = scriptData.title
                titleLabel.Font = CONFIG.FONT
                titleLabel.TextSize = 16
                titleLabel.TextColor3 = CONFIG.TEXT_COLOR
                titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                titleLabel.TextWrapped = true
                titleLabel.Parent = scriptFrame

                local descriptionLabel = Instance.new("TextLabel")
                descriptionLabel.Name = "Description"
                descriptionLabel.Size = UDim2.new(0.95, 0, 0.35, 0)
                descriptionLabel.Position = UDim2.new(0.025, 0, 0.45, 0)
                descriptionLabel.BackgroundColor3 = scriptFrame.BackgroundColor3
                descriptionLabel.BackgroundTransparency = 1
                descriptionLabel.Text = (scriptData.description and scriptData.description:sub(1, math.min(#scriptData.description, 70)) .. "..." or "No description.")
                descriptionLabel.Font = Enum.Font.SourceSans
                descriptionLabel.TextSize = 12
                descriptionLabel.TextColor3 = CONFIG.TEXT_COLOR_SECONDARY
                descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
                descriptionLabel.TextWrapped = true
                descriptionLabel.Parent = scriptFrame

                local loadButton = Instance.new("TextButton")
                loadButton.Name = "LoadButton"
                loadButton.Size = UDim2.new(0.25, 0, 0.25, 0)
                loadButton.Position = UDim2.new(0.7, 0, 0.7, 0)
                loadButton.BackgroundColor3 = CONFIG.ACCENT_COLOR
                loadButton.BorderSizePixel = 0
                loadButton.Text = "Load"
                loadButton.Font = CONFIG.FONT
                loadButton.TextSize = 14
                loadButton.TextColor3 = CONFIG.TEXT_COLOR
                loadButton.Parent = scriptFrame

                loadButton.MouseButton1Click:Connect(function()
                    fetchScriptFromScriptBlox(scriptData._id)
                    -- Close library after loading
                    animateTween(LibraryFrame, {Position = UDim2.new(1, 0, 0.15, 0), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    task.wait(0.3)
                    LibraryFrame.Visible = false
                    LibraryFrame.BackgroundTransparency = 0
                    LibraryFrame.Position = UDim2.new(0.55, 0, 0.15, 0)
                end)

                scriptFrame.MouseEnter:Connect(function()
                    animateTween(scriptFrame, {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                end)
                scriptFrame.MouseLeave:Connect(function()
                    animateTween(scriptFrame, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                end)
            end
            LibraryScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, scriptCount * (UIGridLayout.CellSize.Offset.Y + UIGridLayout.CellPadding.Offset.Y))
        else
            warn("MeraiX ScriptBlox Search Error: " .. (data and data.message or "Unknown error or no scripts found."))
            local noResultsLabel = Instance.new("TextLabel")
            noResultsLabel.Name = "NoResults"
            noResultsLabel.Size = UDim2.new(1, 0, 0, 30)
            noResultsLabel.BackgroundColor3 = LibraryScrollingFrame.BackgroundColor3
            noResultsLabel.BackgroundTransparency = 1
            noResultsLabel.Text = "No scripts found for your search."
            noResultsLabel.Font = CONFIG.FONT
            noResultsLabel.TextSize = 14
            noResultsLabel.TextColor3 = CONFIG.TEXT_COLOR_SECONDARY
            noResultsLabel.Parent = LibraryScrollingFrame
            LibraryScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 30)
        end
    else
        warn("MeraiX ScriptBlox Search Connection Failed: " .. tostring(response))
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Name = "Error"
        errorLabel.Size = UDim2.new(1, 0, 0, 30)
        errorLabel.BackgroundColor3 = LibraryScrollingFrame.BackgroundColor3
        errorLabel.BackgroundTransparency = 1
        errorLabel.Text = "Error connecting to ScriptBlox for search."
        errorLabel.Font = CONFIG.FONT
        errorLabel.TextSize = 14
        errorLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        errorLabel.Parent = LibraryScrollingFrame
        LibraryScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 30)
    end
end

-- // Event Connections //
ExecuteButton.MouseButton1Click:Connect(function()
    executeScript(ScriptEditor.Text)
    animateTween(ExecuteButton, {BackgroundTransparency = 0.5}, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    task.wait(0.1)
    animateTween(ExecuteButton, {BackgroundTransparency = 0}, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end)

ClearButton.MouseButton1Click:Connect(function()
    ScriptEditor.Text = "-- Write your Lua script here"
    animateTween(ClearButton, {BackgroundTransparency = 0.5}, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    task.wait(0.1)
    animateTween(ClearButton, {BackgroundTransparency = 0}, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end)

CloseButton.MouseButton1Click:Connect(function()
    animateTween(MainFrame, {Position = UDim2.new(0.5, -MainFrame.AbsoluteSize.X/2, 1.1, 0), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    task.wait(0.3)
    MainFrame.Visible = false
    MainFrame.BackgroundTransparency = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0) -- Reset position for next open
end)

MinimizeButton.MouseButton1Click:Connect(function()
    animateTween(MainFrame, {Size = UDim2.new(0.01, 0, 0.01, 0), Position = MinimizedIcon.Position, BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    task.wait(0.3)
    MainFrame.Visible = false
    MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0) -- Reset size for next open
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0) -- Reset position
    MainFrame.BackgroundTransparency = 0
    MinimizedIcon.Visible = true
    animateTween(MinimizedIcon, {BackgroundTransparency = 0}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end)

MinimizedIconLabel.MouseButton1Click:Connect(function()
    animateTween(MinimizedIcon, {BackgroundTransparency = 1}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    task.wait(0.2)
    MinimizedIcon.Visible = false
    MainFrame.Visible = true
    animateTween(MainFrame, {Position = UDim2.new(0.3, 0, 0.2, 0), BackgroundTransparency = 0}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end)

LibraryButton.MouseButton1Click:Connect(function()
    LibraryFrame.Visible = true
    animateTween(LibraryFrame, {Position = UDim2.new(0.55, 0, 0.15, 0), BackgroundTransparency = 0}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    searchScriptBlox("") -- Perform an initial empty search on opening
end)

LibraryCloseButton.MouseButton1Click:Connect(function()
    animateTween(LibraryFrame, {Position = UDim2.new(1, 0, 0.15, 0), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    task.wait(0.3)
    LibraryFrame.Visible = false
    LibraryFrame.BackgroundTransparency = 0
    LibraryFrame.Position = UDim2.new(0.55, 0, 0.15, 0) -- Reset position
end)

SearchButton.MouseButton1Click:Connect(function()
    searchScriptBlox(SearchTextBox.Text)
end)

SearchTextBox.TextLabel.ReturnPressed:Connect(function()
    searchScriptBlox(SearchTextBox.Text)
end)

SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = true
    animateTween(SettingsFrame, {Position = UDim2.new(0.2, 0, 0.3, 0), BackgroundTransparency = 0}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end)

SettingsCloseButton.MouseButton1Click:Connect(function()
    animateTween(SettingsFrame, {Position = UDim2.new(-0.3, 0, 0.3, 0), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    task.wait(0.3)
    SettingsFrame.Visible = false
    SettingsFrame.BackgroundTransparency = 0
    SettingsFrame.Position = UDim2.new(0.2, 0, 0.3, 0) -- Reset position
end)

-- // Draggable Functionality for MainFrame (Unchanged) //
local dragging
local dragInput
local dragStart
local startPosition

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.Ended then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X,
                                             startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
        end
    end
end)

-- Initial GUI animation on load
animateTween(MainFrame, {Position = UDim2.new(0.3, 0, 0.2, 0), BackgroundTransparency = 0}, 0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
