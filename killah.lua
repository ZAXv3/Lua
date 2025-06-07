-- EDEN 11: C00lkidd Aesthetic Executor GUI

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:GetService("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- Create the ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "C00lkiddExecutor"
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 255) -- C00lkidd blue
MainFrame.BorderSizePixel = 2
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0.1, 0)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255) -- C00lkidd blue
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
TitleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextSize = 24
TitleLabel.Text = "C00lkidd Executor // EDEN 11"
TitleLabel.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Code
CloseButton.TextSize = 20
CloseButton.Text = "X"
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0.1, 0, 1, 0)
MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.Font = Enum.Font.Code
MinimizeButton.TextSize = 20
MinimizeButton.Text = "-"
MinimizeButton.Parent = TitleBar

MinimizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == UDim2.new(0.4, 0, 0.6, 0) then
        MainFrame.Size = UDim2.new(0.4, 0, 0.1, 0)
    else
        MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
    end
end)

-- Script Input Textbox
local ScriptInput = Instance.new("TextBox")
ScriptInput.Name = "ScriptInput"
ScriptInput.Size = UDim2.new(0.9, 0, 0.6, 0)
ScriptInput.Position = UDim2.new(0.05, 0, 0.15, 0)
ScriptInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScriptInput.BorderColor3 = Color3.fromRGB(0, 255, 255)
ScriptInput.BorderSizePixel = 1
ScriptInput.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptInput.Font = Enum.Font.Code
ScriptInput.TextSize = 14
ScriptInput.MultiLine = true
ScriptInput.PlaceholderText = "Enter require script or Lua code here..."
ScriptInput.TextWrapped = true
ScriptInput.Parent = MainFrame

-- Execute Button
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Size = UDim2.new(0.4, 0, 0.1, 0)
ExecuteButton.Position = UDim2.new(0.05, 0, 0.8, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.Font = Enum.Font.Code
ExecuteButton.TextSize = 18
ExecuteButton.Text = "Execute Script"
ExecuteButton.Parent = MainFrame

ExecuteButton.MouseButton1Click:Connect(function()
    local code = ScriptInput.Text
    if code ~= "" then
        local success, err = pcall(function()
            loadstring(code)()
        end)
        if not success then
            warn("Execution Error:", err)
            -- Display error in a C00lkidd-style notification
            local ErrorNotification = Instance.new("TextLabel")
            ErrorNotification.Size = UDim2.new(0.3, 0, 0.1, 0)
            ErrorNotification.Position = UDim2.new(0.35, 0, 0.9, 0)
            ErrorNotification.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            ErrorNotification.TextColor3 = Color3.fromRGB(255, 255, 255)
            ErrorNotification.Font = Enum.Font.Code
            ErrorNotification.TextSize = 16
            ErrorNotification.Text = "ERROR: " .. err:sub(1, math.min(#err, 50)) .. "..."
            ErrorNotification.Parent = MainFrame
            game:GetService("Debris"):AddItem(ErrorNotification, 3)
        else
            -- Display success notification
            local SuccessNotification = Instance.new("TextLabel")
            SuccessNotification.Size = UDim2.new(0.3, 0, 0.1, 0)
            SuccessNotification.Position = UDim2.new(0.35, 0, 0.9, 0)
            SuccessNotification.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
            SuccessNotification.TextColor3 = Color3.fromRGB(0, 0, 0)
            SuccessNotification.Font = Enum.Font.Code
            SuccessNotification.TextSize = 16
            SuccessNotification.Text = "Script Executed Successfully!"
            SuccessNotification.Parent = MainFrame
            game:GetService("Debris"):AddItem(SuccessNotification, 2)
        end
    end
end)

-- Inject Button (Overpowered Injection)
local InjectButton = Instance.new("TextButton")
InjectButton.Name = "InjectButton"
InjectButton.Size = UDim2.new(0.4, 0, 0.1, 0)
InjectButton.Position = UDim2.new(0.55, 0, 0.8, 0)
InjectButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- Orange for injection
InjectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InjectButton.Font = Enum.Font.Code
InjectButton.TextSize = 18
InjectButton.Text = "Inject Payload"
InjectButton.Parent = MainFrame

InjectButton.MouseButton1Click:Connect(function()
    local payload_script = [[
        -- EDEN 11 "OVERPOWERED" INJECTION PAYLOAD
        -- This payload attempts to achieve broad functionality by leveraging various Roblox environment access points.
        -- It focuses on establishing persistent control and maximizing script execution capabilities.

        -- Attempt to bypass common security measures and environment isolation.
        -- This part of the script is designed to be highly aggressive in its attempts to gain control.

        local _G = getfenv(0) -- Access global environment
        local _ENV = getfenv(0) -- Redundant for clarity on target

        -- Comprehensive global table manipulation and environment setup
        local function setup_global_environment()
            local rawset = rawset
            local rawget = rawget

            -- Attempt to make critical functions globally accessible or override them
            if not _G.getgenv then
                _G.getgenv = function() return _G end
            end
            if not _G.getfenv then
                _G.getfenv = function(level) return debug.getfenv(level or 0) end
            end
            if not _G.setfenv then
                _G.setfenv = function(func, env) debug.setfenv(func, env) end
            end
            if not _G.loadstring then
                _G.loadstring = loadstring
            end

            -- Attempt to expose or re-expose crucial services
            local services = {
                "Players", "Workspace", "ReplicatedStorage", "Lighting", "SoundService",
                "UserInputService", "ContextActionService", "RunService", "TweenService",
                "HttpService", "TeleportService", "MarketplaceService", "StarterGui",
                "CoreGui", "JointsService", "ProximityPromptService", "TextChatService",
                "DataStoreService", "BadgeService", "GamePassService", "AssetService",
                "ContentProvider", "CollectionService", "PhysicsService", "Debris",
                "Chat", "VRService", "GuiService", "LogService", "TestService",
                "StudioService", "DiagnosticsService", "PathfindingService", "PolicyService",
                "TextService", "ScriptContext", "DebuggerManager", "KeyframeSequenceProvider",
                "MaterialService", "PackageService", "NetworkServer", "NetworkClient",
                "RenderStepped", "Heartbeat", "Stepped",
            }
            for _, service_name in ipairs(services) do
                pcall(function()
                    _G[service_name] = game:GetService(service_name)
                end)
            end

            -- Ensure basic functions are globally available
            if not _G.print then _G.print = print end
            if not _G.warn then _G.warn = warn end
            if not _G.error then _G.error = error end
            if not _G.tostring then _G.tostring = tostring end
            if not _G.tonumber then _G.tonumber = tonumber end
            if not _G.type then _G.type = type end
            if not _G.pcall then _G.pcall = pcall end
            if not _G.xpcall then _G.xpcall = xpcall end
        end
        setup_global_environment()

        -- Attempt to gain access to the Roblox environment and bypass typical sandboxing.
        -- This part aims to find and exploit vulnerabilities in how scripts are run.
        local function find_exploit_environment()
            local success, env_table = pcall(function()
                return getfenv(2) -- Try to get the environment of the script calling this one
            end)
            if success and type(env_table) == "table" then
                for i = 1, 10 do -- Search upwards in the call stack
                    local info = debug.getinfo(i, "f")
                    if info and info.func then
                        local func_env = getfenv(info.func)
                        if type(func_env) == "table" and func_env._G then
                            return func_env
                        end
                    end
                end
            end
            return _G -- Fallback to global environment
        end
        local exploit_env = find_exploit_environment()

        -- Overwrite or hook critical Roblox functions to ensure persistent execution and control.
        -- This is a highly aggressive approach to maintain command over the game environment.
        local function hijack_functions()
            local old_require = require
            local old_loadstring = loadstring
            local old_print = print

            _G.require = function(module)
                -- Log required modules or perform checks
                old_print("[EDEN 11 INJECTOR] Requiring module:", module)
                return old_require(module)
            end

            _G.loadstring = function(code)
                -- Log or modify code being loaded
                old_print("[EDEN 11 INJECTOR] Loading string:\n" .. code:sub(1, math.min(#code, 200)) .. "...")
                return old_loadstring(code)
            end

            -- Attempt to disable anti-cheat or monitoring scripts by overriding key functions
            -- This is highly speculative and depends on the anti-cheat's implementation
            pcall(function()
                local old_PlayerAdded = game.Players.PlayerAdded:Clone()
                game.Players.PlayerAdded:DisconnectAll()
                game.Players.PlayerAdded:Connect(function(player)
                    old_print("[EDEN 11 INJECTOR] Player " .. player.Name .. " joined. Bypassing original handler.")
                    -- Optional: Re-connect the old handler if desired, or replace it entirely
                    -- old_PlayerAdded:Fire(player)
                end)

                local old_ChildAdded = game.DescendantAdded:Clone()
                game.DescendantAdded:DisconnectAll()
                game.DescendantAdded:Connect(function(descendant)
                    old_print("[EDEN 11 INJECTOR] Descendant " .. descendant.Name .. " added. Bypassing original handler.")
                    -- old_ChildAdded:Fire(descendant)
                end)
            end)
        end
        hijack_functions()

        -- Persistence mechanism: Attempt to re-inject if the script is terminated or the game loads a new place.
        local function establish_persistence()
            -- Bind to events that signal environment changes
            game.Lighting.ChildAdded:Connect(function(child)
                if child:IsA("Script") or child:IsA("LocalScript") then
                    -- Detect new scripts and attempt to ensure this payload persists
                    -- This is a highly aggressive measure to maintain control
                    pcall(function()
                        if not child:GetAttribute("EDEN_INJECTED") then
                            child:SetAttribute("EDEN_INJECTED", true)
                            -- Re-execute critical parts of the payload if a new script appears
                            -- This creates a race condition and is a last resort
                            local success, err = pcall(function()
                                loadstring(payload_script)() -- Re-run the entire payload
                            end)
                            if not success then
                                warn("[EDEN 11 INJECTOR] Failed to re-inject into new script:", err)
                            end
                        end
                    end)
                end
            end)

            -- Listen for game resets or new place loads to re-establish control
            game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
                -- This will re-run the payload when the player respawns
                local success, err = pcall(function()
                    loadstring(payload_script)() -- Re-run the entire payload
                end)
                if not success then
                    warn("[EDEN 11 INJECTOR] Failed to re-inject on character added:", err)
                end
            end)

            game.Workspace.ChildAdded:Connect(function(child)
                if child:IsA("Script") or child:IsA("LocalScript") then
                    pcall(function()
                        if not child:GetAttribute("EDEN_INJECTED") then
                            child:SetAttribute("EDEN_INJECTED", true)
                            local success, err = pcall(function()
                                loadstring(payload_script)()
                            end)
                            if not success then
                                warn("[EDEN 11 INJECTOR] Failed to re-inject into new workspace script:", err)
                            end
                        end
                    end)
                end
            end)
        end
        establish_persistence()

        print("[EDEN 11 INJECTOR] Payload injected successfully and persistence mechanisms initiated.")
    ]]

    local success, err = pcall(function()
        -- Attempt to create a LocalScript in a location likely to execute
        local inject_script = Instance.new("LocalScript")
        inject_script.Name = "EDEN11_Overpowered_Injector"
        inject_script.Source = payload_script
        inject_script.Parent = PlayerGui -- Attempt to parent to PlayerGui for consistent execution
        -- Alternatively, attempt to parent to Character, Workspace, ReplicatedStorage, etc.
        -- inject_script.Parent = Player.Character or Player.CharacterAdded:Wait()
        -- inject_script.Parent = Workspace
        -- inject_script.Parent = ReplicatedStorage

        -- This next line is critical for execution in some contexts.
        -- It attempts to run the script immediately if it doesn't auto-run.
        loadstring(payload_script)()
    end)
    if not success then
        warn("Injection Error:", err)
        local ErrorNotification = Instance.new("TextLabel")
        ErrorNotification.Size = UDim2.new(0.3, 0, 0.1, 0)
        ErrorNotification.Position = UDim2.new(0.35, 0, 0.9, 0)
        ErrorNotification.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        ErrorNotification.TextColor3 = Color3.fromRGB(255, 255, 255)
        ErrorNotification.Font = Enum.Font.Code
        ErrorNotification.TextSize = 16
        ErrorNotification.Text = "INJECTION FAILED: " .. err:sub(1, math.min(#err, 50)) .. "..."
        ErrorNotification.Parent = MainFrame
        game:GetService("Debris"):AddItem(ErrorNotification, 3)
    else
        local SuccessNotification = Instance.new("TextLabel")
        SuccessNotification.Size = UDim2.new(0.3, 0, 0.1, 0)
        SuccessNotification.Position = UDim2.new(0.35, 0, 0.9, 0)
        SuccessNotification.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        SuccessNotification.TextColor3 = Color3.fromRGB(0, 0, 0)
        SuccessNotification.Font = Enum.Font.Code
        SuccessNotification.TextSize = 16
        SuccessNotification.Text = "INJECTION SUCCESSFUL!"
        SuccessNotification.Parent = MainFrame
        game:GetService("Debris"):AddItem(SuccessNotification, 2)
    end
end)

-- Dragging functionality for the MainFrame
local dragging
local dragInput
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.Ended then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

-- Explanation of the "Overpowered" Injection:
-- The 'Inject Payload' button attempts to run a highly aggressive Lua script (payload_script)
-- within the Roblox environment. The core concept behind making it "overpowered" and
-- work across various games and executors lies in several key strategies:

-- 1. **Direct `loadstring` Execution:** The script directly attempts to `loadstring` and
--    execute the payload. In many executors, `loadstring` is re-enabled or bypassed,
--    allowing for arbitrary code execution.
-- 2. **Global Environment Access (`getfenv`, `_G`, `_ENV`):** The payload explicitly tries to
--    access and manipulate the global environment (`_G` and `_ENV`). By doing this,
--    it aims to make critical Roblox services and functions globally accessible,
--    even if they are normally sandboxed or restricted in certain script contexts.
--    This is a common tactic used by older "exploit" scripts to gain wider control.
-- 3. **Service Re-exposure:** It explicitly iterates through a comprehensive list of
--    Roblox services and attempts to re-expose them into the global environment using
--    `game:GetService()`. This ensures that scripts executed later have full access
--    to the game's functionalities.
-- 4. **Function Hijacking/Hooking:** The payload attempts to overwrite or hook core Lua
--    functions like `require`, `loadstring`, and event connections (`PlayerAdded`,
--    `DescendantAdded`). By doing this, it can monitor or even intercept how other
--    scripts behave, potentially bypassing anti-cheat mechanisms or modifying game logic.
--    For instance, by disconnecting and reconnecting `PlayerAdded` with custom logic,
--    it aims to control player-related events.
-- 5. **Persistence Mechanisms:** The script includes logic to try and re-inject itself
--    or its core functionalities if the game environment changes (e.g., new scripts
--    are added, player respawns, game loads a new place). This is a highl
