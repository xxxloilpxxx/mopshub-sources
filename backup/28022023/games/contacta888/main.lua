--mopsHub South London 2 [RELEASE] | 2023
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
newcclosure = newcclosure
getnamecallmethod = getnamecallmethod

if writeclipboard then writeclipboard("discord.gg/g4EGAwjUAK") end
repeat task.wait() until game:IsLoaded()

--Modules
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))(); Notify = Notify.Notify

--Variables

local FileName = string.format("mopshub_%s", game.PlaceId)
local ExecutorName, ExecutorVersion = identifyexecutor()
local ScriptTitle = string.format("mopsHub - %s - %s", "Contact: A-888", ExecutorName)

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
    Settings = { _DEBUG = false },
    Weapon = { AlwaysHeadShot = false, NoRecoil = false, NoSpread = false, InfiniteAmmo = false, RapidFire = false, OneShot = false },

    Functions = {},

    Client = {
        GunGarbage = {}
    },

    Misc = {
        Demons = nil,
    },
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
    LoadingSubtitle = "by ShyFlooo",
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
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = ""
    }
})

UI.Functions.Weapon = {
    { Function = "CreateSection", Args = "━ Weapon ━" },
    { Function = "CreateToggle", Args = { Name = "Always Headshot", Flag = "_alwaysheadshot", CurrentValue = mopsHub.Weapon.AlwaysHeadShot, Callback = function(Value) mopsHub.Weapon.AlwaysHeadShot = Value end } },
    { Function = "CreateToggle", Args = { Name = "No Recoil", Flag = "_norecoil", CurrentValue = mopsHub.Weapon.NoRecoil, Callback = function(Value) mopsHub.Weapon.NoRecoil = Value end } },
    { Function = "CreateToggle", Args = { Name = "No Spread", Flag = "_nospread", CurrentValue = mopsHub.Weapon.NoSpread, Callback = function(Value) mopsHub.Weapon.NoSpread = Value end } },
    { Function = "CreateToggle", Args = { Name = "Infinite Ammo", Flag = "_infammo", CurrentValue = mopsHub.Weapon.InfiniteAmmo, Callback = function(Value) mopsHub.Weapon.InfiniteAmmo = Value end } },
    { Function = "CreateToggle", Args = { Name = "Rapidfire", Flag = "_rapidfire", CurrentValue = mopsHub.Weapon.RapidFire, Callback = function(Value) mopsHub.Weapon.RapidFire = Value end } },
    { Function = "CreateToggle", Args = { Name = "One Shot", Flag = "_oneshot", CurrentValue = mopsHub.Weapon.OneShot, Callback = function(Value) mopsHub.Weapon.OneShot = Value end } },
}

UI.Functions.Character = {
    { Function = "CreateSection", Args = "━ Character Modification ━" },
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

--Setup
mopsHub.Functions.spawnTask(function()
    for _,v in pairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v, "spread") then
            mopsHub.Client.GunGarbage = v
        end
    end
end)

--Hooks
mopsHub.Functions.spawnTask(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if getnamecallmethod() == 'FireServer' and self.Name == 'damage_handler' and mopsHub.Weapon.AlwaysHeadShot then
            args[1] = mopsHub.Misc.Demons()
            args[3]["part_that_hit"] = mopsHub.Misc.Demons().Head
        end
        return old(self, unpack(args))
    end)
    setreadonly(mt, true)
end)

--Update
mopsHub.Functions.renderStepped:Connect(function()
    --Gun Mods
    if mopsHub.Client.GunGarbage then
        if mopsHub.Weapon.NoRecoil then
            mopsHub.Client.GunGarbage.base_recoil = 0
        end
        if mopsHub.Weapon.NoSpread then
            mopsHub.Client.GunGarbage.spread = 0
        end
        if mopsHub.Weapon.InfiniteAmmo then
            mopsHub.Client.GunGarbage.magazine = math.huge
        end
        if mopsHub.Weapon.RapidFire then
            mopsHub.Client.GunGarbage.fire_rate = 0.1
        end
        if mopsHub.Weapon.OneShot then
            mopsHub.Client.GunGarbage.damage = 99999
        end
    end
end)

--Finish
getgenv().mopsHub = mopsHub
