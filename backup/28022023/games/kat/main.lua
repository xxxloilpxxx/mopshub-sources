--mopsHub SCRIPTNAME | 2023
--Written by mopsfl

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
getgc = getgc
Drawing = Drawing
mousemoverel = mousemoverel
getrawmetatable = getrawmetatable

if writeclipboard then writeclipboard("discord.gg/g4EGAwjUAK") end
repeat task.wait() until game:IsLoaded()

--Modules
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))(); Notify = Notify.Notify
local ESPFramework = loadstring(game:HttpGet("https://raw.githubusercontent.com/NougatBitz/Femware-Leak/main/ESP.lua", true))()

--Variables
local FileName = string.format("mopshub_%s", game.PlaceId)
local ExecutorName, ExecutorVersion = identifyexecutor()
local ScriptTitle = string.format("mopsHub - %s - %s", "KAT", ExecutorName)

local ScriptVersion = "1.0.0"

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Camera = game:GetService("Workspace").CurrentCamera
local Debris = game:GetService("Debris")

local mopsHub = {
    Settings = { _DEBUG = true },

    Silent_Aim = {},
    Gun_Mods = {},
    ESP = { Enabled = false, Boxes = false, Tracers = false, Names = false, Distance = false, Tool = false, Attach = 1, TeamCheck = false, Health = false },

    Functions = {},
    Client = {},
    Misc = {},
    Connections = {},
}

getgenv()._WINDOW = { Tabs = {} }

local UI = {
    Tabs = {
        "Weapon",
		"Visual",
		"Character",
		"Misc",
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
            },
        }
    },
}

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = ScriptTitle,
    LoadingTitle = ScriptTitle,
    LoadingSubtitle = "by ShyFlooo & FraudGoat",
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
}

UI.Functions.Visual = {
    { Function = "CreateSection", Args = "━ ESP ━" },
    { Function = "CreateToggle", Args = { Name = "Enabled", Flag = "_esp", CurrentValue = mopsHub.ESP.Enabled, Callback = function(Value) mopsHub.ESP.Enabled = Value getgenv().updateespvalues() end } },
    { Function = "CreateToggle", Args = { Name = "Boxes", Flag = "_esp_boxes", CurrentValue = mopsHub.ESP.Boxes, Callback = function(Value) mopsHub.ESP.Boxes = Value getgenv().updateespvalues() end } },
    { Function = "CreateToggle", Args = { Name = "Tracers", Flag = "_esp_tracers", CurrentValue = mopsHub.ESP.Tracers, Callback = function(Value) mopsHub.ESP.Tracers = Value getgenv().updateespvalues() end } },
    { Function = "CreateDropdown", Args = { Name = "Tracers Orientation", Flag = "_esp_tracers_orientation", CurrentOption = "Bottom", Options = { "Bottom", "Middle", "Top" }, Callback = function(Value) mopsHub.ESP.tracersOrientation = Value if Value == "Bottom" then mopsHub.ESP.Attach = 1 elseif Value == "Middle" then mopsHub.ESP.Attach = 2 else mopsHub.ESP.Attach = 999999 end end getgenv().updateespvalues() } },
    { Function = "CreateToggle", Args = { Name = "Health Bar", Flag = "_esp_healthbar", CurrentValue = mopsHub.ESP.Health, Callback = function(Value) mopsHub.ESP.Health = Value getgenv().updateespvalues() end } },
    { Function = "CreateToggle", Args = { Name = "Names", Flag = "_esp_names", CurrentValue = mopsHub.ESP.Names, Callback = function(Value) mopsHub.ESP.Names = Value getgenv().updateespvalues() end } },
    { Function = "CreateToggle", Args = { Name = "Weapon", Flag = "_esp_weapon", CurrentValue = mopsHub.ESP.Tool, Callback = function(Value) mopsHub.ESP.Tool = Value getgenv().updateespvalues() end } },
    { Function = "CreateToggle", Args = { Name = "Distance", Flag = "_esp_distance", CurrentValue = mopsHub.ESP.Distance, Callback = function(Value) mopsHub.ESP.Distance = Value getgenv().updateespvalues() end } },
    { Function = "CreateToggle", Args = { Name = "Distance", Flag = "_esp_distance", CurrentValue = mopsHub.ESP.TeamCheck, Callback = function(Value) mopsHub.ESP.TeamCheck = Value getgenv().updateespvalues() end } },
}

--UI Init
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
}

--Silent Aim
mopsHub.Functions.spawnTask(function()
    
end)


--Finish
getgenv().mopsHub = mopsHub