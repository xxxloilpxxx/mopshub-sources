local request = (syn and syn.request or request) or http_request
if request then
    local res = request({Url = "https://raw.githubusercontent.com/mopsfl/roblox-scripts/main/temp"})
    if not res.Success then return game.Players.LocalPlayer:Kick() end
else
    return game.Players.LocalPlayer:Kick()
end

--mopsHub SCRIPTNAME | 2023
--Written by DELU <- cant even script this faggot

getactors = getactors
getgenv = getgenv
getrenv = getrenv
syn = syn
setreadonly = setreadonly
hookmetamethod = hookmetamethod
checkcaller = checkcaller
writeclipboard = writeclipboard
identifyexecutor = identifyexecutor
rconsoleprint = rconsoleprint
rconsoleclear = rconsoleclear
rconsoleerr = rconsoleerr
rconsoleinfo = rconsoleinfo
rconsolename = rconsolename
rconsolewarn = rconsolewarn
hookfunction = hookfunction
printconsole = printconsole
getgc = getgc
Drawing = Drawing
mousemoverel = mousemoverel
getrawmetatable = getrawmetatable
islclosure = islclosure
getupvalues = getupvalues
setupvalue = setupvalue
getinfo = getinfo
is_synapse_function = is_synapse_function
iskrnlclosure = iskrnlclosure
isourclosure = isourclosure
queue_on_teleport = queue_on_teleport
fluxus = fluxus
isactor = isactor
isfile = isfile
writefile = writefile
readfile = readfile
LRM_LinkedDiscordID = LRM_LinkedDiscordID
LRM_TotalExecutions = LRM_TotalExecutions

if writeclipboard then writeclipboard("discord.gg/g4EGAwjUAK") end
repeat task.wait() until game:IsLoaded()

--Modules
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))(); Notify = Notify.Notify

--Variables

local ScriptVersion = "1.0.4"

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Camera = game:GetService("Workspace").CurrentCamera
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local FileName = string.format("mopshub_%s", game.PlaceId)
local ExecutorName, ExecutorVersion = identifyexecutor()
local ScriptTitle = string.format("mopsHub - %s - %s", "FRONTLINES", ExecutorName)
local ConfigFilePath = "/mopsHub/settings_frontlines_premium.mhs"
local ClientId = RbxAnalyticsService:GetClientId()

local closureCheck = (syn and is_synapse_function) or iskrnlclosure or isourclosure
local queueTeleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport

local mopsHub = {
    Settings = { _DEBUG = false },

    Aim_Assist = { Enabled = false, VisibleCheck = false, Target_Hitbox = "Head", Smoothness = 8, showFOV = false, fov = 180, fovColor = Color3.fromRGB(0,255,0) },
    Silent_Aim = { Enabled = false, VisibleCheck = false, Target_Hitbox = "Head", HitChance = 0.5, HeadChance = 0.5, Randomization = 0.5, showFOV = false, fov = 180, TriggerBot = false, fovColor = Color3.fromRGB(0,255,0) },
    ESP = { Enabled = false, Boxes = false, Tracers = false, TracerAttachShift = 1, tracersOrientation = "Bottom", Health = false, HealthBar = false, Names = false, Distance = false, Weapon = false, Chams = false, FontSize = 13, BoxColor = Color3.fromRGB(255,255,255), ChamsOutlineColor = Color3.fromRGB(255,255,255), ChamsFillColor = Color3.fromRGB(255,0,0), ChamsFillTransparency = 0.5, ChamsOutlineTransparency = 0.5, TextColor = Color3.fromRGB(255,255,255), TracerColor = Color3.fromRGB(255,255,255), TextSize = 8, Rainbow = false, SavedColors = {}, Highlight_Target = false, Chams_Visible_Check = false, },
    Character_Modifications = { WalkSpeedMultiplier = { Multiplier = 1 }, InfiniteJump = { Enabled = false, JumpHeight = 55 }, Bunny_Hop = { Enabled = false, Power = 4 }, No_Fall_Damage = { Enabled = false } },
    Gun_Mods = { NoRecoil = false, NoSpread = false, RapidFire = false, },
    Hitbox_Extender = { Enabled = false, Size = 3, Hitbox_Transparency = 0.5 },

    KillAll = false,

    Functions = {},
    Connections = {},
    uiElements = {},
    Client = {
        globals = nil,
        enums = nil,
        utils = nil,
        event_enum = nil,
        global_sol_state = nil,
        fpv_sol_recoil = nil,
        fpv_sol_spread = nil,
        fpv_sol_equipment = nil,
        fpv_sol_multipliers = nil,
        fpv_sol_instances = nil,
        soldier_models = nil,
        soldiers_alive = nil,
        sol_state_class = nil,
        sol_firearm_operation = nil,
        sol_time_sequence_value = nil,
        exe_set_t = nil,
        exe_set = nil,
    },
    Misc = {
        FOV_Circles = {},
        Silent_Aim_Target = nil,
        hitboxExtenderEnabledOnce = false,

        Hitbox_Parts = {
            ["Head"] = "TPVBodyVanillaHead",
            ["Torso"] = "HumanoidRootPart",
        },
        Aim_Assist_Active = false,
        fire_rates = {},
        killall_target = nil,
    },
}

getgenv()._WINDOW = { Tabs = {} }

local UI = {
    Tabs = {
        "Weapon",
		"Visual",
		"Character",
        "Settings",
		"Credits"
    },
    Functions = {
        ["Player"] = {},
        ["Weapon"] = {},
        ["Visual"] = {},
        ["Character"] = {},
        ["Misc"] = {},
        ["Settings"] = {},
    },
    Credits = {
        [1] = {
            Name = "Developers",
            Content = {
                { "ShyFlooo", "Lead Programmer" },
                { "Delu", "Programmer" },
            },
        }
    },
}

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = ScriptTitle,
    LoadingTitle = ScriptTitle,
    LoadingSubtitle = "ShyFlooo",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "/mopsHub/.config",
        FileName = FileName
    },
    KeySystem = false,
    KeySettings = {
        Title = ScriptTitle,
        Subtitle = "Key System",
        Note = "discord.gg/g4EGAwjUAK",
        FileName = ".mopshubkey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = ""
    }
})

UI.Functions.Weapon = {
    { Function = "CreateSection", Args = "━ Aim Assist ━" },
    { Function = "CreateToggle", Args = { Name = "Aim Assist", Flag = "_aimassist", CurrentValue = mopsHub.Aim_Assist.Enabled, Callback = function(Value) mopsHub.Aim_Assist.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Visible Check", Flag = "_aimassist_visiblecheck", CurrentValue = mopsHub.Aim_Assist.VisibleCheck, Callback = function(Value) mopsHub.Aim_Assist.VisibleCheck = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Target Hitbox", Flag = "_aimassist_targethitbox", Options = {"Head", "Torso"}, CurrentOption = mopsHub.Aim_Assist.Target_Hitbox, Callback = function(Value) mopsHub.Aim_Assist.Target_Hitbox = Value end } },
    { Function = "CreateToggle", Args = { Name = "Show FOV", Flag = "_aimassist_showfov", CurrentValue = mopsHub.Aim_Assist.showFOV, Callback = function(Value) mopsHub.Aim_Assist.showFOV = Value end } },
    { Function = "CreateSlider", Args = { Name = "FOV", Flag = "_aimassist_fov", Range = {0,360}, Increment = 1, CurrentValue = mopsHub.Aim_Assist.fov, Callback = function(Value) mopsHub.Aim_Assist.fov = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "FOV Color", Flag = "_aimassist_fov_color", Color = mopsHub.Aim_Assist.fovColor, Callback = function(Value) mopsHub.Aim_Assist.fovColor = Value end } },
    { Function = "CreateSlider", Args = { Name = "Smoothness", Flag = "_aimassist_smoothness", Range = {5,10}, Increment = 0.1, CurrentValue = mopsHub.Aim_Assist.Smoothness, Callback = function(Value) mopsHub.Aim_Assist.Smoothness = Value end } },

    { Function = "CreateSection", Args = "━ Silent Aimbot ━" },
    { Function = "CreateToggle", Args = { Name = "Silent Aim", Flag = "_silentaim", CurrentValue = mopsHub.Silent_Aim.Enabled, Callback = function(Value) mopsHub.Silent_Aim.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Visible Check", Flag = "_silentaim_visiblecheck", CurrentValue = mopsHub.Silent_Aim.VisibleCheck, Callback = function(Value) mopsHub.Silent_Aim.VisibleCheck = Value end } },
    --{ Function = "CreateSlider", Args = { Name = "Position Randomization", Flag = "_silentaim_posrandomization", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Silent_Aim.Randomization, Callback = function(Value) mopsHub.Silent_Aim.Randomization = Value end } },
    --{ Function = "CreateSlider", Args = { Name = "Hit Chance", Flag = "_silentaim_hitchance", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Silent_Aim.HitChance, Callback = function(Value) mopsHub.Silent_Aim.HitChance = Value end } },
    --{ Function = "CreateSlider", Args = { Name = "Head Hit Chance", Flag = "_silentaim_headhitchance", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Silent_Aim.HeadChance, Callback = function(Value) mopsHub.Silent_Aim.HeadChance = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Target Hitbox", Flag = "_silentaim_targethitbox", Options = {"Head", "Torso"}, CurrentOption = mopsHub.Silent_Aim.Target_Hitbox, Callback = function(Value) mopsHub.Silent_Aim.Target_Hitbox = Value end } },
    --{ Function = "CreateToggle", Args = { Name = "Triggerbot", Flag = "_silentaim_triggerbot", CurrentValue = mopsHub.Silent_Aim.TriggerBot, Callback = function(Value) mopsHub.Silent_Aim.TriggerBot = Value end } },
    { Function = "CreateToggle", Args = { Name = "Show FOV", Flag = "_silentaim_showfov", CurrentValue = mopsHub.Silent_Aim.showFOV, Callback = function(Value) mopsHub.Silent_Aim.showFOV = Value end } },
    { Function = "CreateSlider", Args = { Name = "FOV", Flag = "_silentaim_fov", Range = {0,360}, Increment = 1, CurrentValue = mopsHub.Silent_Aim.fov, Callback = function(Value) mopsHub.Silent_Aim.fov = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "FOV Color", Flag = "_silentaim_fov_color", Color = mopsHub.Silent_Aim.fovColor, Callback = function(Value) mopsHub.Silent_Aim.fovColor = Value end } },

    --{ Function = "CreateSection", Args = "━ Kill All ━" },
    --{ Function = "CreateToggle", Args = { Name = "Kill All", Flag = "_killall", CurrentValue = mopsHub.KillAll, Callback = function(Value) mopsHub.KillAll = Value end } },

    { Function = "CreateSection", Args = "━ Gun Mods ━" },
    { Function = "CreateToggle", Args = { Name = "No Recoil", Flag = "_norecoil", CurrentValue = mopsHub.Gun_Mods.NoRecoil, Callback = function(Value) mopsHub.Gun_Mods.NoRecoil = Value end } },
    { Function = "CreateToggle", Args = { Name = "No Spread", Flag = "_nospread", CurrentValue = mopsHub.Gun_Mods.NoSpread, Callback = function(Value) mopsHub.Gun_Mods.NoSpread = Value end } },
    { Function = "CreateToggle", Args = { Name = "Rapidfire", Flag = "_nospread", CurrentValue = mopsHub.Gun_Mods.RapidFire, Callback = function(Value) mopsHub.Gun_Mods.RapidFire = Value; for _,v in pairs(getgc(true)) do if typeof(v) == "table" and rawget(v, "fire_rate") then v.fire_rate = 5 end end end } },
    { Function = "CreateParagraph", Args = { Title = "Note:", Content = "Reset once to apply Rapidfire." } },

}

UI.Functions.Visual = {
    { Function = "CreateSection", Args = "━ ESP ━" },
    { Function = "CreateToggle", Args = { Name = "Enabled", Flag = "_esp", CurrentValue = mopsHub.ESP.Enabled, Callback = function(Value) mopsHub.ESP.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Boxes", Flag = "_esp_boxes", CurrentValue = mopsHub.ESP.Boxes, Callback = function(Value) mopsHub.ESP.Boxes = Value end } },
    { Function = "CreateToggle", Args = { Name = "Tracers", Flag = "_esp_tracers", CurrentValue = mopsHub.ESP.Tracers, Callback = function(Value) mopsHub.ESP.Tracers = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Tracers Orientation", Flag = "_esp_tracers_orientation", CurrentOption = mopsHub.ESP.tracersOrientation, Options = { "Bottom", "Middle", "Top" }, Callback = function(Value) mopsHub.ESP.tracersOrientation = Value if Value == "Bottom" then mopsHub.ESP.TracerAttachShift = 1 elseif Value == "Middle" then mopsHub.ESP.TracerAttachShift = 2 else mopsHub.ESP.TracerAttachShift = 999999 end end } },
    { Function = "CreateToggle", Args = { Name = "Chams", Flag = "_esp_chams", CurrentValue = mopsHub.ESP.Chams, Callback = function(Value) mopsHub.ESP.Chams = Value end } },
    { Function = "CreateToggle", Args = { Name = "Health Bar", Flag = "_esp_healthbar", CurrentValue = mopsHub.ESP.HealthBar, Callback = function(Value) mopsHub.ESP.HealthBar = Value end } },
    { Function = "CreateToggle", Args = { Name = "Health", Flag = "_esp_health", CurrentValue = mopsHub.ESP.Health, Callback = function(Value) mopsHub.ESP.Health = Value end } },
    { Function = "CreateToggle", Args = { Name = "Names", Flag = "_esp_names", CurrentValue = mopsHub.ESP.Names, Callback = function(Value) mopsHub.ESP.Names = Value end } },
    { Function = "CreateToggle", Args = { Name = "Distance", Flag = "_esp_distance", CurrentValue = mopsHub.ESP.Distance, Callback = function(Value) mopsHub.ESP.Distance = Value end } },
    { Function = "CreateSection", Args = "━ ESP Settings ━" },
    --{ Function = "CreateToggle", Args = { Name = "Highlight Visible Targets", Flag = "_esp_hightlight_target", CurrentValue = mopsHub.ESP.Highlight_Target, Callback = function(Value) mopsHub.ESP.Highlight_Target = Value end } },
    { Function = "CreateToggle", Args = { Name = "Chams Visible Check", Flag = "_esp_hightlight_target", CurrentValue = mopsHub.ESP.Chams_Visible_Check, Callback = function(Value) mopsHub.ESP.Chams_Visible_Check = Value end } },

    { Function = "CreateSection", Args = "━ ESP Customization ━" },
    { Function = "CreateColorPicker", Args = { Name = "Box Color", Flag = "_esp_boxes_color", Color = mopsHub.ESP.BoxColor, Callback = function(Value) mopsHub.ESP.BoxColor = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "Chams Fill Color", Flag = "_esp_chamsfill_color", Color = mopsHub.ESP.ChamsFillColor, Callback = function(Value) mopsHub.ESP.ChamsFillColor = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "Chams Outline Color", Flag = "_esp_chamsoutline_color", Color = mopsHub.ESP.ChamsOutlineColor, Callback = function(Value) mopsHub.ESP.ChamsOutlineColor = Value end } },
    { Function = "CreateSlider", Args = { Name = "Chams Fill Transparency", Flag = "_esp_chams_fill_transparency", Range = {0,1}, Increment = 1, CurrentValue = mopsHub.ESP.ChamsFillTransparency, Callback = function(Value) mopsHub.ESP.ChamsFillTransparency = Value end } },
    { Function = "CreateSlider", Args = { Name = "Chams Outline Transparency", Flag = "_esp_chams_outline_transparency", Range = {0,1}, Increment = 1, CurrentValue = mopsHub.ESP.ChamsOutlineTransparency, Callback = function(Value) mopsHub.ESP.ChamsOutlineTransparency = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "Tracer Color", Flag = "_esp_tracers_color", Color = mopsHub.ESP.TracerColor, Callback = function(Value) mopsHub.ESP.TracerColor = Value end } },
    { Function = "CreateSlider", Args = { Name = "Text Size", Flag = "_esp_text_size", Range = {0,30}, Increment = 1, CurrentValue = mopsHub.ESP.FontSize, Callback = function(Value) mopsHub.ESP.FontSize = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "Text Color", Flag = "_esp_text_color", Color = mopsHub.ESP.TextColor, Callback = function(Value) mopsHub.ESP.TextColor = Value end } },
    { Function = "CreateToggle", Args = { Name = "Rainbow Colors", Flag = "_esp_rainbow", CurrentValue = mopsHub.ESP.Rainbow, Callback = function(Value) mopsHub.ESP.Rainbow = Value end } },

    { Function = "CreateSection", Args = "━ Hitbox Extender ━" },
    { Function = "CreateToggle", Args = { Name = "Enabled", Flag = "_hitboxextender", CurrentValue = mopsHub.Hitbox_Extender.Enabled, Callback = function(Value) mopsHub.Hitbox_Extender.Enabled = Value end } },
    { Function = "CreateSlider", Args = { Name = "Hitbox Size", Flag = "_hitboxextender_size", Range = {1,10}, Increment = 0.1, CurrentValue = mopsHub.Hitbox_Extender.Size, Callback = function(Value) mopsHub.Hitbox_Extender.Size = Value end } },
    { Function = "CreateSlider", Args = { Name = "Hitbox Transparency", Flag = "_hitboxextender_size", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Hitbox_Extender.Hitbox_Transparency, Callback = function(Value) mopsHub.Hitbox_Extender.Hitbox_Transparency = Value end } },

}

UI.Functions.Character = {
    { Function = "CreateSection", Args = "━ Modifications ━" },
    { Function = "CreateSlider", Args = { Name = "Walkspeed Multiplier", Flag = "_character_modifications_walkspeed", Range = {1,10}, Increment = 1, CurrentValue = mopsHub.Character_Modifications.WalkSpeedMultiplier.Multiplier, Callback = function(Value) mopsHub.Character_Modifications.WalkSpeedMultiplier.Multiplier = Value end } },
    { Function = "CreateToggle", Args = { Name = "Infinite Jump", Flag = "_character_modifications_infinitejump", CurrentValue = mopsHub.Character_Modifications.InfiniteJump.Enabled, Callback = function(Value) mopsHub.Character_Modifications.InfiniteJump.Enabled = Value end } },
    { Function = "CreateSlider", Args = { Name = "Infinite Jump Height", Flag = "_character_modifications_infinitejump_height", Range = {0,100}, Increment = 1, CurrentValue = mopsHub.Character_Modifications.InfiniteJump.JumpHeight, Callback = function(Value) mopsHub.Character_Modifications.InfiniteJump.JumpHeight = Value end } },
    { Function = "CreateToggle", Args = { Name = "Bunny Hop", Flag = "_character_modifications_bunnyhop", CurrentValue = mopsHub.Character_Modifications.Bunny_Hop.Enabled, Callback = function(Value) mopsHub.Character_Modifications.Bunny_Hop.Enabled = Value end } },
}

UI.Functions.Settings = {
    { Function = "CreateSection", Args = " ━ Script ━ " },
    { Function = "CreateToggle", Args = { Name = "Auto Load Configs", Flag = "_autoLoadConfigs", CurrentValue = mopsHub.Settings.autoLoadConfigs, Callback = function(Value) mopsHub.Settings.autoLoadConfigs = Value; mopsHub.Functions.Other.saveLocalConfig(Value) end } },
    { Function = "CreateParagraph", Args = { Title = "Script Informations", Content = string.format("\nScript Version: %s", ScriptVersion or ""), } },
    { Function = "CreateParagraph", Args = { Title = "Client Informations", Content = string.format("\nExecutor: %s %s\n\nDiscord ID: %s\n\nTotal Executions: %s", ExecutorName or "unknown", ExecutorVersion or "unknown", LRM_LinkedDiscordID or "unknown", LRM_TotalExecutions or "unknown"), } },
}

--UI Init (my ass automatic rayfield ui loader lol xd)
do
    local success, err = pcall(function()
        for _, n in pairs(UI.Tabs) do
            local w = Window:CreateTab(n)
            getgenv()._WINDOW.Tabs[n] = w
        end
        for _, c in pairs(UI.Credits) do
            local _c = ""
            for _,v in pairs(c.Content) do
                if #v[2] > 0 then
                    _c = _c.."\n"..v[1].." - ".. v[2]
                else
                    _c = _c.."\n"..v[1]
                end
            end
            getgenv()._WINDOW.Tabs["Credits"]:CreateSection(string.format("━ %s ━", c.Name))
            getgenv()._WINDOW.Tabs["Credits"]:CreateParagraph({Title = c.Name, Content = _c})
        end

        for index, funcs in pairs(UI.Functions) do
            if mopsHub.Settings._DEBUG then
                rconsolewarn("[mopsHub UI Init]: Creating "..#funcs.." function(s) for ".. index.. "")
            end
            for i, func in pairs(funcs) do
                if func.Function and func.Args then
                    local Tab = getgenv()._WINDOW.Tabs[index]
                    if Tab then
                        pcall(function()
                            local f,_s = func.Function, true
                            if f == "CreateSection" then
                                Tab:CreateSection(func.Args)
                            elseif f == "CreateButton" then
                                Tab:CreateButton(func.Args)
                            elseif f == "CreateToggle" then
                                Tab:CreateToggle(func.Args)
                            elseif f == "CreateDropdown" then
                                Tab:CreateDropdown(func.Args)
                            elseif f == "CreateInput" then
                                Tab:CreateInput(func.Args)
                            elseif f == "CreateSlider" then
                                Tab:CreateSlider(func.Args)
                            elseif f == "CreateParagraph" then
                                Tab:CreateParagraph(func.Args)
                            elseif f == "CreateLabel" then
                                Tab:CreateLabel(func.Args)
                            elseif f == "CreateKeybind" then
                                Tab:CreateKeybind(func.Args)
                            elseif f == "CreateColorPicker" then
                                Tab:CreateColorPicker(func.Args)
                            else
                                _s = false
                            end;
                            if mopsHub.Settings._DEBUG then
                                if _s then
                                    mopsHub.uiElements[tostring((func.Args.Flag) or func.Args:gsub('━','')) or "unknownElement"] = Element
                                    rconsoleinfo("[mopsHub UI Init]: Created "..tostring((func.Args.Flag and "function element".. func.Args.Flag) or "section element ["..func.Args:gsub('━','').."]").. " for ".. index.. " ["..string.gsub(func.Function, "Create", "").. "]")
                                else
                                    rconsoleerr("[mopsHub UI Init]: Invalid function [ "..tostring(func.Function).. " ] for [".. index .. "] index: ("..i..")")
                                end
                            end
                        end)
                    end
                end
            end
        end
    end)
    if not success and err then
        rconsoleerr(string.format("[mopsHub UI Init - Error]: Unexpected error occurred while initalizin the UI."))
        rconsoleerr(string.format("Support: discord.gg/g4EGAwjUAK"))
        rconsoleerr("Error: ".. err)
        Window:Destroy()
    end
end

mopsHub.Functions = {
    spawnTask = function(f) return task.spawn(f) end,
    renderStepped = RunService.RenderStepped,

    createFOVCircle = function() local circle = Drawing.new("Circle"); circle.Thickness = 2; circle.NumSides = 999; circle.Filled = false; circle.Transparency = 0.6; circle.Radius = mopsHub.Silent_Aim.fov; return circle end,
    getSolidierId = function(_Player) for i, v in pairs(mopsHub.Client.globals.cli_names) do if _Player and _Player.Name == v then return i end end end,
    getHealth = function(_Player) local id = mopsHub.Functions.getSolidierId(_Player) if not id then return 0 end local health = mopsHub.Client.globals.gbl_sol_healths[id] if not health then return 0 end return health end,
    getTeam = function(_Player) local id = mopsHub.Functions.getSolidierId(_Player) if not id then return end return mopsHub.Client.globals.cli_teams[id] end,
    isAlive = function(_Player) local id = mopsHub.Functions.getSolidierId(_Player) if not id then return false end if mopsHub.Client.globals.soldiers_alive[id] == true and mopsHub.Functions.getHealth(_Player) ~= 0 then return true end return false end,
    getPlayerFromCharacter = function(_Character) for id, model in pairs(mopsHub.Client.globals.soldier_models) do if model == _Character then local name = mopsHub.Client.globals.cli_names[id] if name then return Players:FindFirstChild(name) end end end end,
    getCharacter = function(_Player) local id = mopsHub.Functions.getSolidierId(_Player) if not id then return end return mopsHub.Client.globals.soldier_models[id] end,
    getHumanoid = function() return mopsHub.Client.fpv_sol_instances.humanoid end,
    getRootPart = function() return mopsHub.Client.fpv_sol_instances.root end,
    isInCircle = function(point, center, radius) return (point.x - center.x*point.x - center.x) + (point.y - center.y*point.y - center.y) <= radius*radius end,
    isVisible = function(Position, Ignore) local soldiers = {} for i,v in pairs(workspace:GetChildren()) do if v.Name == "soldier_model" then table.insert(soldiers, v) end end Ignore = Ignore or { Camera, workspace.Terrain, mopsHub.Functions.getCharacter(Player), workspace:FindFirstChild("workspace") and workspace.workspace:FindFirstChild("glass"), workspace.workspace:FindFirstChild("boundary"), unpack(soldiers) } return #Camera:GetPartsObscuringTarget({ Position }, Ignore) == 0 end,
    getHitboxes = function() local hitboxes = {} for _,v in pairs(workspace:GetChildren()) do if v:IsA("BasePart") and v.Color == Color3.new(1,0,0) then table.insert(hitboxes, v) end end return hitboxes end,

    Aim_Assist = {
        getTarget = function()
            local _target = nil
            local _position = nil
            local _min = math.huge

            local mouseLocation = UserInputService:GetMouseLocation()
            local _players = Players:GetPlayers()

            for _, plr in pairs(_players) do
                if plr == Player then continue end
                local _plr_team = mopsHub.Functions.getTeam(plr)
                local _client_team = mopsHub.Functions.getTeam(Player)
                if _plr_team == _client_team then continue end
                local _plr_character = mopsHub.Functions.getCharacter(plr)
                if not _plr_character then continue end
                local _hitbox = _plr_character["HumanoidRootPart"]
                if not _hitbox then continue end
                local _health = mopsHub.Functions.getHealth(plr)
                if not (_health ~= 0) then continue end
                local screenPosition, visible = Camera:WorldToViewportPoint(_hitbox.Position)
                if not visible then continue end
                if (mopsHub.Aim_Assist.VisibleCheck and not mopsHub.Functions.isVisible(_hitbox.Position)) then continue end
                local delta = (Vector2.new(screenPosition.X, screenPosition.Y) - mouseLocation).Magnitude
                if delta < _min and delta <= mopsHub.Aim_Assist.fov then
                    _min = delta;
                    _target = plr;
                    _position = screenPosition;
                end
            end
            return _target, _position
        end
    },
    applyProxyMetatable = function(tbl, events)
        if getmetatable(tbl) then return end

        local cache = {}
        for key in next, events do
            cache[key] = tbl[key]
        end

        setmetatable(tbl, {
            __index = function(self, key)
                local fn = events[key]
                if fn and cache[key] then
                    local result = fn(cache[key])
                    if result then
                        return result
                    end
                    return cache[key]
                end
                return rawget(self, key)
            end,
            __newindex = function(self, key, value)
                if events[key] then
                    cache[key] = value
                    return
                end
                rawset(self, key, value)
            end
        })

        for key in next, events do
            rawset(tbl, key, nil)
        end
    end,
    Other = {
        saveLocalConfig = function(Value)
            mopsHub.Settings.autoLoadConfigs = Value
            local enc
            local s,e = pcall(function()
                enc = HttpService:JSONEncode(mopsHub.Settings)
            end)
            if s then
                writefile(ConfigFilePath, tostring(enc))
                if mopsHub.Settings._DEBUG then rconsoleinfo("[mopsHub Debug]: Updated settings json. > autoLoadConfigs: ".. tostring(Value)) end
            else
                writefile(ConfigFilePath, HttpService:JSONEncode(mopsHub.Settings))
                if mopsHub.Settings._DEBUG then rconsoleerr("[mopsHub Debug - Error]: Unable to encode settings json.\nError:\n\n> ".. e) end
            end
        end
    },
}

-- Setup
mopsHub.Functions.spawnTask(function()
    pcall(function()
        if getgenv().mopsHub then
            for _,v in pairs(getgenv().mopsHub.Connections) do
                v:Disconnect()
            end
            for _,v in pairs(getgenv().mopsHub.Misc.FOV_Circles) do
                v:Remove()
            end
        end
    end)

    mopsHub.Client.globals = getrenv()._G.globals
    mopsHub.Client.enums = getrenv()._G.enums
    mopsHub.Client.utils = getrenv()._G.utils
    --mopsHub.Client.event_enum = mopsHub.Client.utils.gbus.EVENT_ENUM
    mopsHub.Client.global_sol_state = mopsHub.Client.globals.gbl_sol_state
    mopsHub.Client.fpv_sol_recoil = mopsHub.Client.globals.fpv_sol_recoil
    mopsHub.Client.fpv_sol_spread = mopsHub.Client.globals.fpv_sol_spread
    mopsHub.Client.fpv_sol_equipment = mopsHub.Client.globals.fpv_sol_equipment
    mopsHub.Client.fpv_sol_multipliers = mopsHub.Client.globals.fpv_sol_multipliers
    mopsHub.Client.soldier_models = mopsHub.Client.globals.soldier_models
    mopsHub.Client.soldiers_alive = mopsHub.Client.globals.soldiers_alive
    mopsHub.Client.sol_state_class = mopsHub.Client.enums.sol_state_class
    mopsHub.Client.sol_firearm_operation = getrenv()._G.sol_firearm_operation
    mopsHub.Client.fpv_sol_instances = mopsHub.Client.globals.fpv_sol_instances
    mopsHub.Client.fpv_sol_instances = mopsHub.Client.globals.fpv_sol_instances
    mopsHub.Client.exe_set = getrenv()._G.exe_set
    mopsHub.Client.exe_set_t = getrenv()._G.exe_set_t
    --mopsHub.Client.trig_event =  mopsHub.Client.utils.gbus.trig_event

    --Get EVENT_ENUM with gc since i have no clue where it is. maybe im retarded
    for _,v in pairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v, "FPV_SOL_EQUIP") then
            mopsHub.Client.event_enum = v
        end
    end

    mopsHub.Misc.FOV_Circles["SilentAim"] = mopsHub.Functions.createFOVCircle()
    mopsHub.Misc.FOV_Circles["AimAssist"] = mopsHub.Functions.createFOVCircle()

    --Auto Load Config
    if isfile(ConfigFilePath) then
        local s,e = pcall(function()
            local file_settings = readfile(ConfigFilePath)
            local parsedSettings = {}
            local s,e = pcall(function()
                parsedSettings = HttpService:JSONDecode(file_settings)
            end)
            if s then
                for i,v in pairs(parsedSettings) do
                    mopsHub.Settings[i] = v
                end
            else
                writefile(ConfigFilePath, HttpService:JSONEncode(mopsHub.Settings))
                if mopsHub.Settings._DEBUG then rconsoleerr("[mopsHub Debug - Error]: Unable to parse local settings json.\nError:\n\n> ".. e) end
            end
        end)
        if not s and e then
            print(e)
        end
    else
        mopsHub.Settings.autoLoadConfigs = false
        writefile(ConfigFilePath, tostring(HttpService:JSONEncode(mopsHub.Settings)))
        if mopsHub.Settings._DEBUG then print("[mopsHub - Debug]: created local config file.") end
    end
end)

--Silent Aim Target Update
mopsHub.Connections["_silentAim_targetUpdate"] = mopsHub.Functions.renderStepped:Connect(function()
    local center = workspace.CurrentCamera.ViewportSize / 2

    local clientCharacter = mopsHub.Functions.getCharacter(Player)
    local clientHealth = mopsHub.Functions.getHealth(Player)
    local clientTeam = mopsHub.Functions.getTeam(Player)

    if not clientCharacter then return end
    if clientHealth <= 0 then return end

    local Choices = {}
    for _, plr in next, Players:GetPlayers() do
        if plr == Player then continue end

        local character = mopsHub.Functions.getCharacter(plr)
        local health = mopsHub.Functions.getHealth(plr)
        local team = mopsHub.Functions.getTeam(plr)
        local bone = character and character:FindFirstChild(mopsHub.Misc.Hitbox_Parts[mopsHub.Silent_Aim.Target_Hitbox])
        if health > 0 and character and team ~= clientTeam and bone then
            local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(bone.Position)
            if not vis then continue end
            local screenPos = Vector2.new(pos.X, pos.Y)
            if not mopsHub.Functions.isInCircle(screenPos, center, mopsHub.Silent_Aim.fov) then continue end
            if (mopsHub.Silent_Aim.VisibleCheck and not mopsHub.Functions.isVisible(bone.Position)) then continue end

            local distance = math.floor((screenPos - center).Magnitude)
            table.insert(Choices, {
                Player = plr,
                Distance = distance,
                Character = character,
            })
        end
    end

    table.sort(Choices, function(a, b)
        return a.Distance < b.Distance
    end)

    local choice = Choices[1]
    if choice then
        local plr = choice.Player;
        mopsHub.Misc.Silent_Aim_Target = plr
    else
        mopsHub.Misc.Silent_Aim_Target = nil
    end
end)

--Silent Aim
mopsHub.Functions.spawnTask(function()
    local old_exe_set = nil

	local function exe_set_proxy(event, ...)
		local args = { ... }
		if event == mopsHub.Client.exe_set_t.FPV_SOL_BULLET_SPAWN then
			local stack = debug.getstack(3)

			local discharge_params = nil
	        for idx, obj in next, stack do
	            if type(obj) == 'table' and type(rawget(obj, 'fire_params')) == 'table' then
	                discharge_params = obj;
	                break
	            end
	        end
			if mopsHub.Silent_Aim.Enabled and mopsHub.Misc.Silent_Aim_Target and discharge_params then
                local character = mopsHub.Functions.getCharacter(mopsHub.Misc.Silent_Aim_Target)
				local bone = character and character:FindFirstChild('HumanoidRootPart')

				if bone then
					local fire_params = discharge_params.fire_params
                	local fire_multipliers = discharge_params.fire_multipliers
                	local velocity = fire_params.muzzle_velocity * fire_multipliers.muzzle_velocity;

                	args[4] = CFrame.lookAt(args[3], bone.CFrame.p).LookVector * (velocity * 1)
				end
			end
		end

		return old_exe_set(event, unpack(args))
	end

    old_exe_set = hookfunction(mopsHub.Client.exe_set, function(...)
		return exe_set_proxy(...)
	end)
end)

--Aim Assist
mopsHub.Connections["_aimAssist_inputBegan"] = UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and mopsHub.Aim_Assist.Enabled then
        mopsHub.Misc.Aim_Assist_Active = true
    end
end)

mopsHub.Connections["_aimAssist_inputended"] = UserInputService.InputEnded:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and mopsHub.Aim_Assist.Enabled then
        mopsHub.Misc.Aim_Assist_Active = false
    end
end)

mopsHub.Connections["_aimAssist_update"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Aim_Assist.Enabled and mopsHub.Misc.Aim_Assist_Active then
        local target, screenPos = mopsHub.Functions.Aim_Assist.getTarget()
        if not target then return end
        local mouseLocation = UserInputService:GetMouseLocation()
        mousemoverel( (screenPos.X - mouseLocation.X) / mopsHub.Aim_Assist.Smoothness, (screenPos.Y - mouseLocation.Y) / mopsHub.Aim_Assist.Smoothness )
    end
end)

--ESP
mopsHub.Functions.spawnTask(function()
    if getgenv().esp then getgenv().esp:unload() end
    local esp = {cache = {} };

    function esp:unload()
        for i,v in next, esp.cache do
            getgenv().esp.remove_plr(i)
        end
        getgenv().esp_loop = nil
    end
    function esp.rotatev2(V2, r)
        local c = math.math.cos(r);
        local s = math.math.sin(r);
        return Vector2.new(c * V2.X - s * V2.Y, s * V2.X + c * V2.Y);
    end;

    function esp.getmagnitude(p1,p2)
        return (p1 - p2).Magnitude
    end;

    function esp.getprimarypart(model)
        local found_part = model ~= nil and model:FindFirstChild('HumanoidRootPart')
        return found_part
    end;

    function esp.inst(instance,prop)
        local INEW = Instance.new(instance)
        local s, e  = pcall(function()
            for i,v in next, prop do
                INEW[i] = v
            end
        end)
        return INEW
    end;

    function esp.draw(drawing,prop)
        local NEWDRAWING = Drawing.new(drawing)
        local s, e = pcall(function()
            for i,v in next, prop do
                NEWDRAWING[i] = v
            end
        end)
        return NEWDRAWING
    end;

    function esp.setall(array,prop,value)
        for i,v in next, array do
            if tostring(v) ~= 'Highlight' and tostring(i) ~= 'arrow' and tostring(i) ~= 'arrow_outline' then
                v[prop] = value
            end
        end
    end;

    function esp.remove_plr(character)
        if rawget(esp.cache,character) then
            for _,v in pairs(esp.cache[character]) do
                v:Remove()
            end;
            esp.cache[character] = nil;
        end;
    end;

    function esp.check(character)
        local can_pass = true
        if character:FindFirstChild("friendly_marker") then can_pass = false end
        if not character.Parent == workspace then can_pass = false end
        local plr = mopsHub.Functions.getPlayerFromCharacter(character)
        local plr_team = mopsHub.Functions.getTeam(plr)
        local client_team = mopsHub.Functions.getTeam(Player)
        if plr_team == client_team then can_pass = false end
        if plr then if not mopsHub.Functions.isAlive(plr) then can_pass = false end end
        if not (mopsHub.Functions.getHealth(plr) ~= 0) then can_pass = false end
        return can_pass
    end;

    function esp.add_plr(character)
        local plr_tab = {}
        plr_tab.inner_box = esp.draw('Square',{
            Filled = true,
        });
        plr_tab.tracer = esp.draw('Line',{
            Thickness = 1,
        });
        plr_tab.box_outline = esp.draw('Square',{
            Filled = false,
            Transparency = 1,
            Thickness = 3,
        });
        plr_tab.box = esp.draw('Square',{
            Filled = false,
            Transparency = 1,
            Thickness = 1,
        });
        plr_tab.name_bold = esp.draw('Text',{
            Center = true,
            Outline = false,
            Transparency = 1,
        });
        plr_tab.distance = esp.draw('Text',{
            Center = true,
        });
        plr_tab.highlight = esp.inst('Highlight',{
        });
        plr_tab.health = esp.draw('Text',{
            Center = false,
        });
        plr_tab.healthbar_outline = esp.draw('Line',{
            Thickness = 3,
        });
        plr_tab.healthbar = esp.draw('Line',{
            Thickness = 1,
        });
        plr_tab.name = esp.draw('Text',{
            Center = true,
        });
        plr_tab.highlight = esp.inst('Highlight',{
        });
        esp.cache[character] = plr_tab;
    end

    function esp.update_esp(character,array)
        local rootpart = character:FindFirstChild('HumanoidRootPart')
        local player = mopsHub.Functions.getPlayerFromCharacter(character)
        local screenpos, onscreen = Camera.WorldToViewportPoint(Camera, rootpart.Position)
        local health
        if player then
            health = mopsHub.Functions.getHealth(player)
        end
        local scale_factor = 1 / (screenpos.Z * math.tan(math.rad(Camera.FieldOfView * 0.5)) * 2) * 100
        local width, height = math.floor(45 * scale_factor), math.floor(65 * scale_factor)
        local size = Vector2.new(width,height)
        if size.X < 3 or size.Y < 6 then
            size = Vector2.new(5,10)
        end
        local position = Vector2.new(screenpos.X - size.X / 2,screenpos.Y - size.Y / 2)
        position = Vector2.new(math.floor(position.X),math.floor(position.Y))
        local bottom_bounds = 0
        local top_bounds = 0
        local bottom_offset = Vector2.new(math.floor(size.X / 2 + position.X), math.floor(size.Y + position.Y + 1))
        local top_offset = Vector2.new(math.floor(size.X / 2 + position.X), math.floor(position.Y - 16))
        local distance = esp.getmagnitude(rootpart.Position,Camera.CFrame.Position)
        local check = esp.check(character)
        local s, e = pcall(function()
            if onscreen and check then
                if mopsHub.ESP.Tracers then
                    array.tracer.Visible = true
                    array.tracer.From = Vector2.new(screenpos.X, screenpos.Y) + Vector2.new(0, size.Y / 2)
                    array.tracer.To = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/mopsHub.ESP.TracerAttachShift or 1)
                    array.tracer.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TracerColor
                else
                    array.tracer.Visible = false
                end
                if mopsHub.ESP.Chams and health > 0 then
                    array.highlight.Parent = CoreGui
                    array.highlight.Adornee = character
                    array.highlight.Enabled = true
                    array.highlight.DepthMode = mopsHub.ESP.Chams_Visible_Check and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
                    array.highlight.FillTransparency = mopsHub.ESP.ChamsFillTransparency
                    array.highlight.OutlineTransparency = mopsHub.ESP.ChamsOutlineTransparency
                    if mopsHub.ESP.Highlight_Target and mopsHub.Functions.isVisible(rootpart.Position) then
                        array.highlight.FillColor = Color3.fromRGB(0,255,0)
                        array.highlight.OutlineColor = Color3.fromRGB(0,255,0)
                    else
                        array.highlight.FillColor = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.ChamsFillColor
                        array.highlight.OutlineColor = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.ChamsOutlineColor
                    end
                else
                    array.highlight.Enabled = false
                end
                if mopsHub.ESP.Boxes then
                    array.box.Visible = true
                    array.box.Size = size
                    array.box.Position = position
                    array.box.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.BoxColor
                    array.box_outline.Size = size
                    array.box_outline.Position = position
                    array.box_outline.Visible = false
                    array.box_outline.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.BoxColor
                    array.inner_box.Size = Vector2.new(array.box.Size.X-3,array.box.Size.Y-3)
                    array.inner_box.Position = Vector2.new(position.X+1.5,position.Y+1.5)
                    array.inner_box.Transparency = 0.5
                    array.inner_box.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.BoxColor
                    array.inner_box.Visible = false
                else
                    array.box.Visible = false
                end
                if mopsHub.ESP.HealthBar then
                    array.healthbar.Transparency = 1
                    array.healthbar_outline.Transparency = 1
                    array.healthbar.Visible = true
                    array.healthbar.Color = Color3.fromRGB(255,0,0):Lerp(Color3.fromRGB(0,255,0),health / 100);
                    array.healthbar.From = Vector2.new((position.X - 5), position.Y + size.Y)
                    array.healthbar.To = Vector2.new(array.healthbar.From.X, array.healthbar.From.Y - (health / 100) * size.Y)
                    array.healthbar_outline.Visible = false
                    array.healthbar_outline.Color = Color3.fromRGB(255,255,255)
                    array.healthbar_outline.From = Vector2.new(array.healthbar.From.X, position.Y + size.Y + 1 )
                    array.healthbar_outline.To = Vector2.new(array.healthbar.From.X, (array.healthbar.From.Y -1 * size.Y) - 1)
                else
                    array.healthbar.Visible = false
                    array.healthbar_outline.Visible = false
                end
                if mopsHub.ESP.Names then
                    array.name.Transparency = 1
                    array.name_bold.Transparency = 0.5
                    array.name.Visible = true
                    array.name.Text = tostring(player)
                    array.name.Size = mopsHub.ESP.FontSize
                    array.name.Font = 2
                    --if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
                    --    array.name.Color = esp.highlight_target.color
                    --else
                        array.name.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
                    --end
                    array.name.Outline = false
                    array.name.OutlineColor = Color3.fromRGB(255,255,255)
                    array.name.Position = Vector2.new(top_offset.X,top_offset.Y - (top_bounds))
                else
                    array.name.Visible = false
                    array.name_bold.Visible = false
                end
                if mopsHub.ESP.Health then
                    local From = Vector2.new((position.X - 5), position.Y + size.Y)
                    local To = Vector2.new(From.X, From.Y - 1 * size.Y)
                    array.health.Transparency = 1
                    array.health.Visible = true
                    array.health.Text = tostring(math.floor(health))
                    array.health.Size = mopsHub.ESP.FontSize
                    array.health.Font = 2
                    array.health.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
                    array.health.Outline = false
                    array.health.OutlineColor = Color3.fromRGB(255,255,255)
                    array.health.Position = Vector2.new(position.X - 30, To.Y)
                else
                    array.health.Visible = false
                end
                if mopsHub.ESP.Distance then
                    array.distance.Transparency = 1
                    array.distance.Visible = true
                    array.distance.Text = tostring(math.floor(distance))..'s'
                    array.distance.Size = mopsHub.ESP.FontSize
                    array.distance.Font = 2
                    array.distance.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
                    array.distance.Outline = false
                    array.distance.OutlineColor = Color3.fromRGB(255,255,255)
                    array.distance.Position = Vector2.new(bottom_offset.X, bottom_offset.Y + bottom_bounds)
                    bottom_bounds += 14
                else
                    array.distance.Visible = false
                end
            else
                esp.setall(array, 'Visible', false)
            end
        end)
        if not s and e then
            printconsole(e, 255, 0, 0)
            esp.setall(array, 'Visible', false)
            array.highlight.Enabled = false
        end
    end

    for i,v in next, workspace:GetChildren() do
        if v.Name == "soldier_model" and mopsHub.Functions.getPlayerFromCharacter(v) ~= Player then
            esp.add_plr(v)
        end
    end
    workspace.ChildAdded:Connect(function(v)
        if v.Name == "soldier_model" then
            esp.add_plr(v)
        end
    end)
    workspace.ChildRemoved:Connect(function(v)
        if v.Name == "soldier_model" then
            esp.remove_plr(v)
        end
    end)
    mopsHub.Connections["_espUpdate"] = RunService.RenderStepped:Connect(function()
        for player, drawings in next, esp.cache do
            if drawings and player then
                esp.update_esp(player, drawings);
            end
        end
    end)
    getgenv().esp = esp
end)

--Infinite Jump
mopsHub.Functions.spawnTask(function()
    local function Action(Object, Function) if Object ~= nil then Function(Object); end end
    game:GetService('UserInputService').InputBegan:Connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
            local Humanoid = mopsHub.Functions.getHumanoid()
            local RootPart = mopsHub.Functions.getRootPart()
            if not mopsHub.Character_Modifications.InfiniteJump.Enabled then return end
            if not Humanoid or not RootPart then return end
            Action(Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(RootPart, function(Root)
                        Root.Velocity = Vector3.new(0, mopsHub.Character_Modifications.InfiniteJump.JumpHeight or 50, 0);
                    end)
                end
            end)
        end
    end)
end)

--Character Modifications
mopsHub.Connections["_charmods"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Client.fpv_sol_multipliers then
        mopsHub.Client.fpv_sol_multipliers.movement = mopsHub.Character_Modifications.WalkSpeedMultiplier.Multiplier
    end
end)

--Gun Mods
mopsHub.Functions.spawnTask(function()
    local spread = mopsHub.Client.fpv_sol_spread.spread
    local attitude_delta = mopsHub.Client.fpv_sol_recoil.attitude_delta

    setmetatable(mopsHub.Client.fpv_sol_spread, {
        __index = function(self, key)
            if key == 'spread' then
                if mopsHub.Gun_Mods.NoSpread then return 0 end
                return spread
            end
            return rawget(self, key)
        end,
        __newindex = function(self, key, value)
            if key == 'spread' then spread = value; return end
            rawset(self, key, value)
        end
    })
    setmetatable(mopsHub.Client.fpv_sol_recoil, {
        __index = function(self, key)
            if key == 'attitude_delta' then
                if mopsHub.Gun_Mods.NoRecoil then return Vector3.new() end
                return attitude_delta
            end
            return rawget(self, key)
        end,
        __newindex = function(self, key, value)
            if key == 'attitude_delta' then attitude_delta = value; return end
            rawset(self, key, value)
        end
    })

    rawset(mopsHub.Client.fpv_sol_spread, 'spread', nil)
    rawset(mopsHub.Client.fpv_sol_recoil, 'attitude_delta', nil)

    if closureCheck and not iskrnlclosure then
        local OldEvalUdho = mopsHub.Client.utils.math_util.eval_udho
        local function eval_udho(...)
            if mopsHub.Gun_Mods.NoRecoil and debug.info(2, 's'):find('recoil_anim') then
                return 0, 0
            end
            return OldEvalUdho(...)
        end
        mopsHub.Client.utils.math_util.eval_udho = eval_udho

        for _, fn in next, getgc() do
            if type(fn) == 'function' then
                if islclosure(fn) and (not closureCheck(fn)) then
                    local upvalues = getupvalues(fn)
                    for _, upv in next, upvalues do
                        if upv == OldEvalUdho then
                            setupvalue(fn, _, eval_udho)
                        end
                    end
                end
            end
        end
    end
end)

--FOV Update
mopsHub.Connections["_fovUpdate"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Misc.FOV_Circles.SilentAim then
        mopsHub.Misc.FOV_Circles.SilentAim.Position = UserInputService:GetMouseLocation()
        mopsHub.Misc.FOV_Circles.SilentAim.Radius = mopsHub.Silent_Aim.fov
        mopsHub.Misc.FOV_Circles.SilentAim.Visible = mopsHub.Silent_Aim.showFOV and mopsHub.Silent_Aim.Enabled
        mopsHub.Misc.FOV_Circles.SilentAim.Color = mopsHub.Silent_Aim.fovColor
    end
    if mopsHub.Misc.FOV_Circles.AimAssist then
        mopsHub.Misc.FOV_Circles.AimAssist.Position = UserInputService:GetMouseLocation()
        mopsHub.Misc.FOV_Circles.AimAssist.Radius = mopsHub.Aim_Assist.fov
        mopsHub.Misc.FOV_Circles.AimAssist.Visible = mopsHub.Aim_Assist.showFOV and mopsHub.Aim_Assist.Enabled
        mopsHub.Misc.FOV_Circles.AimAssist.Color = mopsHub.Aim_Assist.fovColor
    end
end)

--Hitbox Extender
mopsHub.Connections["_hitboxExtender"] = mopsHub.Functions.renderStepped:Connect(function()
    local hitboxes = mopsHub.Functions.getHitboxes()
    for _,v in pairs(hitboxes) do
        if mopsHub.Hitbox_Extender.Enabled then
            if not mopsHub.Misc.hitboxExtenderEnabledOnce then mopsHub.Misc.hitboxExtenderEnabledOnce = true end
            v.Size = Vector3.new(mopsHub.Hitbox_Extender.Size,mopsHub.Hitbox_Extender.Size,mopsHub.Hitbox_Extender.Size)
            v.Transparency = mopsHub.Hitbox_Extender.Hitbox_Transparency
        else
            if mopsHub.Misc.hitboxExtenderEnabledOnce then
                mopsHub.Misc.hitboxExtenderEnabledOnce = false
                v.Size = Vector3.new(1,1,1)
                v.Transparency = 1
            end
        end
    end
end)

--Bunny Hop
mopsHub.Connections["_bunnyHop"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Character_Modifications.Bunny_Hop.Enabled and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        local humanoid = mopsHub.Functions.getHumanoid()
        if humanoid then
            local power = 4
            power = power and (2 * game.Workspace.Gravity * power) ^ 0.5 or 40
            humanoid.Jump = true
            humanoid.JumpPower = power
        end
    end
end)

--Finish
if mopsHub.Settings.autoLoadConfigs then
    Rayfield:LoadConfiguration()
    if mopsHub.uiElements["_autoLoadConfigs"] then
        mopsHub.uiElements["_autoLoadConfigs"]:Set(mopsHub.Settings.autoLoadConfigs)
    end
    if mopsHub.Settings._DEBUG then
        rconsoleinfo("[mopsHub - Debug]: loaded config from previous session")
    end
end

getgenv().mopsHub = mopsHub
