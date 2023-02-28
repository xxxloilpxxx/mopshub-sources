--mopsHub Bad Business 3.20 | 2023
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
getupvalue = getupvalue

if writeclipboard then writeclipboard("discord.gg/g4EGAwjUAK") end
repeat task.wait() until game:IsLoaded()
getgenv().SecureMode = true

--Modules
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))(); Notify = Notify.Notify

--Variables
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Camera = game:GetService("Workspace").CurrentCamera
local Debris = game:GetService("Debris")
local TeleportService = game:GetService("TeleportService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local MarketplaceService = game:GetService("MarketplaceService")

local FileName = string.format("mopshub_%s", game.PlaceId)
local ExecutorName, ExecutorVersion = identifyexecutor()
local ScriptTitle = string.format("mopsHub - %s - %s", "Bad Business", ExecutorName)
local ConfigFilePath = "/mopsHub/settings_badbusiness_v2.mhs"
local ClientId = RbxAnalyticsService:GetClientId()
local ScriptVersion = "1.0.2"

local mopsHub = {
    Settings = { _DEBUG = true },

    Silent_Aim = { Enabled = true },
    ESP = { Enabled = false, Boxes = false, Tracers = false, TracerAttachShift = 1, tracersOrientation = "Bottom", Health = false, HealthBar = false, Names = false, Distance = false, Weapon = false, Chams = false, FontSize = 13, BoxColor = Color3.fromRGB(255,255,255), ChamsOutlineColor = Color3.fromRGB(255,255,255), ChamsFillColor = Color3.fromRGB(255,0,0), ChamsFillTransparency = 0.5, ChamsOutlineTransparency = 0.5, TextColor = Color3.fromRGB(255,255,255), TracerColor = Color3.fromRGB(255,255,255), TextSize = 8, Rainbow = false, },
    Gun_Mods = { InfiniteAmmo = false, Wallbang = false, NoRecoil = false, NoSpread = false },
    Character_Modifications = { InfiniteJump = { Enabled = false, JumpHeight = 55 } },

    Client = {
        Characters = {},
        PlayerTable = {}
    },
    Modules = {
        TS = nil,
        Timer = nil,
        Camera = nil
    },
    Functions = {},
    Connections = {},

    Misc = {},
}

getgenv()._WINDOW = { Tabs = {} }

local UI = {
    Tabs = {
        "Player",
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
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = ""
    }
})

UI.Functions.Player = {
    { Function = "CreateSection", Args = "━ Values ━" },
}

UI.Functions.Visual = {
    { Function = "CreateSection", Args = "━ ESP ━" },
    { Function = "CreateToggle", Args = { Name = "ESP", Flag = "_esp", CurrentValue = mopsHub.ESP.Enabled, Callback = function(Value) mopsHub.ESP.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Boxes", Flag = "_esp_boxes", CurrentValue = mopsHub.ESP.Boxes, Callback = function(Value) mopsHub.ESP.Boxes = Value end } },
    { Function = "CreateToggle", Args = { Name = "Tracers", Flag = "_esp_tracers", CurrentValue = mopsHub.ESP.Tracers, Callback = function(Value) mopsHub.ESP.Tracers = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Tracers Orientation", Flag = "_esp_tracers_orientation", CurrentOption = mopsHub.ESP.tracersOrientation, Options = { "Bottom", "Middle", "Top" }, Callback = function(Value) mopsHub.ESP.tracersOrientation = Value if Value == "Bottom" then mopsHub.ESP.TracerAttachShift = 1 elseif Value == "Middle" then mopsHub.ESP.TracerAttachShift = 2 else mopsHub.ESP.TracerAttachShift = 999999 end end } },
    { Function = "CreateToggle", Args = { Name = "Chams", Flag = "_esp_chams", CurrentValue = mopsHub.ESP.Chams, Callback = function(Value) mopsHub.ESP.Chams = Value end } },
    { Function = "CreateToggle", Args = { Name = "Health Bar", Flag = "_esp_healthbar", CurrentValue = mopsHub.ESP.HealthBar, Callback = function(Value) mopsHub.ESP.HealthBar = Value end } },
    { Function = "CreateToggle", Args = { Name = "Health", Flag = "_esp_health", CurrentValue = mopsHub.ESP.Health, Callback = function(Value) mopsHub.ESP.Health = Value end } },
    { Function = "CreateToggle", Args = { Name = "Names", Flag = "_esp_names", CurrentValue = mopsHub.ESP.Names, Callback = function(Value) mopsHub.ESP.Names = Value end } },
    { Function = "CreateToggle", Args = { Name = "Weapon", Flag = "_esp_weapon", CurrentValue = mopsHub.ESP.Weapon, Callback = function(Value) mopsHub.ESP.Weapon = Value end } },
    { Function = "CreateToggle", Args = { Name = "Distance", Flag = "_esp_distance", CurrentValue = mopsHub.ESP.Distance, Callback = function(Value) mopsHub.ESP.Distance = Value end } },

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
    getCharacter = function(_Player)
        _Player = _Player or Player
        return mopsHub.Modules.TS.Characters:GetCharacter(_Player)
    end,
    isAlive = function(_Player)
        _Player = _Player or Player
        if mopsHub.Client.PlayerTable[_Player] then
			if mopsHub.Client.PlayerTable[_Player].Parent == game.Workspace.Characters then
				if mopsHub.Client.PlayerTable[_Player]:FindFirstChild("Root")then
					return true
				end
			end
		end
    end,
    getHealth = function(_Player)
        _Player = _Player or Player
        if mopsHub.Client.PlayerTable[_Player] then
			if mopsHub.Client.PlayerTable[_Player].Parent == game.Workspace.Characters then
				if mopsHub.Client.PlayerTable[_Player]:FindFirstChild("Health") then
					return mopsHub.Client.PlayerTable[_Player]:FindFirstChild("Health").Value, 100
				end
			end
		end
    end
}

--Setup
mopsHub.Functions.spawnTask(function()
    mopsHub.Client.Characters = workspace:WaitForChild("Characters")
    mopsHub.Modules.TS = require(ReplicatedStorage:WaitForChild("TS"))
    if mopsHub.Modules.TS then
        mopsHub.Client.PlayerTable = getupvalue(mopsHub.Modules.TS.Characters.GetCharacter, 1)
        mopsHub.Modules.Camera = mopsHub.Modules.TS.Camera
        mopsHub.Modules.Timer = mopsHub.Modules.TS.Timer
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

    function esp.get_char(player)
        local CHARACTER = mopsHub.Functions.getCharacter(player)
        return CHARACTER
    end;

    function esp.getprimarypart(model)
        local found_part = model ~= nil and model:FindFirstChild('Root')
        return found_part
    end;

    function esp.validate(player)
        local plr_character = esp.get_char(player)
        if plr_character and plr_character:FindFirstChild('Root') then
            return true
        end
    end;

    function esp.inst(instance,prop)
        local INEW = Instance.new(instance)
        local s, e  = pcall(function()
            for i,v in next, prop do
                INEW[i] = v
            end
        end)
        if not s and e and mopsHub.Settings._DEBUG then rconsoleerr('pie.solutions ER: '..tostring(e)) end
        return INEW
    end;

    function esp.draw(drawing,prop)
        local NEWDRAWING = Drawing.new(drawing)
        local s, e = pcall(function()
            for i,v in next, prop do
                NEWDRAWING[i] = v
            end
        end)
        if not s and e and mopsHub.Settings._DEBUG then rconsoleerr('pie.solutions ER: '..tostring(e)) end
        return NEWDRAWING
    end;

    function esp.setall(array,prop,value)
        for i,v in next, array do
            if tostring(v) ~= 'Highlight' and tostring(i) ~= 'arrow' and tostring(i) ~= 'arrow_outline' then
                v[prop] = value
            end
        end
    end;

    function esp.remove_plr(player)
        if rawget(esp.cache,player) then 
            for i,v in pairs(esp.cache[player]) do
                v:Remove()
            end;
            esp.cache[player] = nil;
        end;
    end;

    function esp.check(player)
        local alive_status = mopsHub.Functions.isAlive(player)
        local character = mopsHub.Functions.getCharacter(player)
        local team = player.Team
        local can_pass = false
        local status_pass = false
        local team_pass = false
        if character then
            if alive_status then
                status_pass = true
            end
            if team ~= Player.Team then
                team_pass = true
            end
        end
        if status_pass and team_pass then can_pass = true end
        return can_pass;
    end;

    function esp.add_plr(player)
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
        plr_tab.healthbar_outline = esp.draw('Line',{
            Thickness = 3,
        });
        plr_tab.healthbar = esp.draw('Line',{
            Thickness = 1,
        });
        plr_tab.name = esp.draw('Text',{
            Center = true,
        });
        plr_tab.name_bold = esp.draw('Text',{
            Center = true,
            Outline = false,
            Transparency = 1,
        });
        plr_tab.distance = esp.draw('Text',{
            Center = true,
        });
        plr_tab.distance_bold = esp.draw('Text',{
            Center = true,
            Outline = false,
        });
        plr_tab.tool = esp.draw('Text',{
            Center = true,
        });
        plr_tab.tool_bold = esp.draw('Text',{
            Center = true,
            Outline = false,
        });
        plr_tab.health = esp.draw('Text',{
            Center = false,
        });
        plr_tab.health_bold = esp.draw('Text',{
            Center = false,
            Outline = false,
        });
        plr_tab.highlight = esp.inst('Highlight',{
        });
        esp.cache[player] = plr_tab;
    end

    function esp.update_esp(player,array)
        if esp.validate(player) then
            local character = esp.get_char(player)
            local rootpart = character:FindFirstChild('Root')
            local health, max_health = mopsHub.Functions.getHealth(player)
            local screenpos, onscreen = Camera.WorldToViewportPoint(Camera, rootpart.Position)
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
            local distance = esp.getmagnitude(rootpart.Position,Camera.CFrame.p)
            local check = esp.check(player)
            local s, e = pcall(function()
                if onscreen and check and mopsHub.ESP.Enabled then
                    if mopsHub.ESP.Tracers then
                        array.tracer.Visible = true
                        array.tracer.From = Vector2.new(screenpos.X, screenpos.Y)
                        array.tracer.To = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/mopsHub.ESP.TracerAttachShift or 1)
                        array.tracer.Color = mopsHub.ESP.TracerColor
                    else
                        array.tracer.Visible = false
                    end
                    if mopsHub.ESP.Chams then
                        array.highlight.Parent = CoreGui
                        array.highlight.Adornee = character
                        array.highlight.Enabled = true
                        array.highlight.FillColor = mopsHub.ESP.ChamsFillColor
                        array.highlight.DepthMode = 'AlwaysOnTop'
                        array.highlight.OutlineColor = mopsHub.ESP.ChamsOutlineColor
                        array.highlight.FillTransparency = mopsHub.ESP.ChamsFillTransparency
                        array.highlight.OutlineTransparency = mopsHub.ESP.ChamsOutlineTransparency
                    else
                        array.highlight.Enabled = false
                    end
                    if mopsHub.ESP.Boxes then
                        array.box.Visible = true
                        array.box.Size = size
                        array.box.Position = position
                        --if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
                        --    array.box.Color = mopsHub.ESP.BoxColor
                        --else
                            array.box.Color = mopsHub.ESP.BoxColor
                        --end
                        array.box_outline.Size = size
                        array.box_outline.Position = position
                        array.box_outline.Visible = false
                        array.box_outline.Color = mopsHub.ESP.BoxColor
                        array.inner_box.Size = Vector2.new(array.box.Size.X-3,array.box.Size.Y-3)
                        array.inner_box.Position = Vector2.new(position.X+1.5,position.Y+1.5)
                        array.inner_box.Transparency = 0.5
                        array.inner_box.Color = Color3.fromRGB(255,255,255)
                        array.inner_box.Visible = false
                    else
                        array.inner_box.Visible = false
                        array.box_outline.Visible = false
                        array.box.Visible = false
                    end
                    if mopsHub.ESP.HealthBar then
                        array.healthbar.Transparency = 1
                        array.healthbar_outline.Transparency = 1
                        array.healthbar.Visible = true
                        array.healthbar.Color = Color3.fromRGB(255,0,0):Lerp(Color3.fromRGB(0,255,0),health / max_health);
                        array.healthbar.From = Vector2.new((position.X - 5), position.Y + size.Y)
                        array.healthbar.To = Vector2.new(array.healthbar.From.X, array.healthbar.From.Y - (health / max_health) * size.Y)
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
                            array.name.Color = mopsHub.ESP.TextColor
                        --end
                        array.name.Outline = false
                        array.name.OutlineColor = Color3.fromRGB(255,255,255)
                        array.name.Position = Vector2.new(top_offset.X,top_offset.Y - (top_bounds))
                    else
                        array.name.Visible = false
                        array.name_bold.Visible = false
                    end
                    if mopsHub.ESP.Distance then
                        array.distance.Transparency = 1
                        array.distance_bold.Transparency = 0.5
                        array.distance.Visible = true
                        array.distance.Text = tostring(math.floor(distance))..'s'
                        array.distance.Size = mopsHub.ESP.FontSize
                        array.distance.Font = 2
                        --if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
                        --    array.distance.Color = esp.highlight_target.color
                        --else
                            array.distance.Color = mopsHub.ESP.TextColor
                        --end
                        array.distance.Outline = false
                        array.distance.OutlineColor = Color3.fromRGB(255,255,255)
                        array.distance.Position = Vector2.new(bottom_offset.X, bottom_offset.Y + bottom_bounds)
                        bottom_bounds += 14
                        if esp.boldtext then
                            array.distance_bold.Visible = true
                            array.distance_bold.Size = mopsHub.ESP.FontSize
                            array.distance_bold.Font = 2
                            --if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
                            --    array.distance_bold.Color = esp.highlight_target.color
                            --else
                                array.distance_bold.Color = mopsHub.ESP.TextColor
                            --end
                            array.distance_bold.Text = array.distance.Text
                            array.distance_bold.Position = Vector2.new(array.distance.Position.X + 1, array.distance.Position.Y)
                        else
                            array.distance_bold.Visible = false
                        end
                    else
                        array.distance.Visible = false
                        array.distance_bold.Visible = false
                    end
                    if mopsHub.ESP.Health then
                        local From = Vector2.new((position.X - 5), position.Y + size.Y)
                        local To = Vector2.new(From.X, From.Y - 1 * size.Y)
                        array.health.Transparency = 1
                        array.health_bold.Transparency = 0.5
                        array.health.Visible = true
                        array.health.Text = tostring(math.floor(health))
                        array.health.Size = mopsHub.ESP.FontSize
                        array.health.Font = 2
                        array.health.Color = mopsHub.ESP.TextColor
                        array.health.Outline = false
                        array.health.OutlineColor = Color3.fromRGB(255,255,255)
                        array.health.Position = Vector2.new(position.X - 30, To.Y)
                        if esp.boldtext then
                            array.health_bold.Visible = true
                            array.health_bold.Size = mopsHub.ESP.FontSize
                            array.health_bold.Font = 2
                            array.health_bold.Color = array.health.Color
                            array.health_bold.Text = array.health.Text
                            array.health_bold.Position = Vector2.new(array.health.Position.X + 1, array.health.Position.Y)
                        else
                            array.health_bold.Visible = false
                        end
                    else
                        array.health.Visible = false
                        array.health_bold.Visible = false
                    end
                    if mopsHub.ESP.Weapon then
                        array.tool.Transparency = 1
                        array.tool_bold.Transparency = 0.5
                        array.tool.Visible = true
                        array.tool.Text = mopsHub.Functions.getWeaponName(player)
                        array.tool.Size = mopsHub.ESP.FontSize
                        array.tool.Font = 2
                        --if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
                        --    array.tool.Color = esp.highlight_target.color
                        --else
                            array.tool.Color = mopsHub.ESP.TextColor
                        --end
                        array.tool.Color = mopsHub.ESP.TextColor
                        array.tool.Outline = false
                        array.tool.OutlineColor = Color3.fromRGB(255,255,255)
                        array.tool.Position = Vector2.new(bottom_offset.X, bottom_offset.Y + bottom_bounds)
                        bottom_bounds += 14
                        if esp.boldtext then
                            array.tool_bold.Visible = true
                            array.tool_bold.Size = mopsHub.ESP.FontSize
                            array.tool_bold.Font = 2
                            --if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
                            --    array.tool_bold.Color = esp.highlight_target.color
                            --else
                                array.tool_bold.Color = mopsHub.ESP.TextColor
                            --end
                            array.tool_bold.Text = array.tool.Text
                            array.tool_bold.Position = Vector2.new(array.tool.Position.X + 1, array.tool.Position.Y)
                        else
                            array.tool_bold.Visible = false
                        end
                    else
                        array.tool.Visible = false
                        array.tool_bold.Visible = false
                    end
                else
                    array.highlight.Enabled = false
                    esp.setall(array,'Visible',false)
                end
            end)
            if not s and e then
                rconsoleerr('ESP ERROR: '..tostring(e))
                esp.setall(array,'Visible',false)
                array.highlight.Enabled = false
            end
            else
                esp.setall(array,'Visible',false)
                array.highlight.Enabled = false
        end
    end


    for i,player in next, Players:GetPlayers() do
        if player ~= Player then
            esp.add_plr(player)
        end
    end
    Players.PlayerAdded:Connect(function(player)
        esp.add_plr(player)
    end)
    Players.PlayerRemoving:Connect(function(player)
        esp.remove_plr(player)
    end)
    getgenv().esp_loop = mopsHub.Functions.renderStepped:Connect(function()
        for player, drawings in next, esp.cache do
            if drawings and player then
                if mopsHub.ESP.Enabled then
                    esp.update_esp(player, drawings);
                end
            end
        end
    end)
    getgenv().esp = esp
end)