--mopsHub Phantom Forces Framework [RELEASE] | 2023
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
printconsole = printconsole

repeat task.wait() until game:IsLoaded()
local _t = tick()

--Variables
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local Camera = game:GetService("Workspace").CurrentCamera

local Framework = {
    Functions = {},
    Connections = {},
    Modules = {
        require = nil,
        network = nil,
        WeaponControllerInterface = nil,
        MainCameraObject = nil,
        ReplicationObject = nil,
        ReplicationInterface = nil,
        ThirdPersonObject = nil,
        FirearmObject = nil,
        MeleeObject = nil,
        CharacterInterface = nil,
        PlayerDataStoreClient = nil,
        ContentDatabase = nil,
        GameGlock = nil,
        ActiveLoadoutUtils = nil,
        HudStatusInterface = nil,
        PublicSettings = nil,
        WeaponControllerEvents = nil,
        CharacterEvents = nil,
        PlayerStatusEvents = nil,
        physics = nil,
        particle = nil,
    },
    Events = {
        onCharacterSpawned = nil,
        onCharacterDespawned = nil,
        onControllerFlag = nil,
        onPlayerDied = nil,
        onPlayerSpawned = nil,
    },
    Client = {
        Controller = nil,
        CharacterObject = nil,
        entryTable = nil,
        CurrentGunIndex = nil,
        BarrelPosition = nil,
        ActiveWeapon = nil,
        GarbageWeaponData = nil,
        isAlive = false,
        WeaponRegistries = {},
    },
    Misc = {
        firepos = nil,
        camerapos = nil
    }
}

--Modules
do
    local s, error = pcall(function()
        Framework.Modules.require = getrenv().shared.require
        Framework.Modules.network = Framework.Modules.require("network")
        Framework.Modules.WeaponControllerInterface = Framework.Modules.require("WeaponControllerInterface")
        Framework.Modules.MainCameraObject = Framework.Modules.require("MainCameraObject")
        Framework.Modules.ReplicationObject = Framework.Modules.require("ReplicationObject")
        Framework.Modules.ReplicationInterface = Framework.Modules.require("ReplicationInterface")
        Framework.Modules.ThirdPersonObject = Framework.Modules.require("ThirdPersonObject")
        Framework.Modules.FirearmObject = Framework.Modules.require("FirearmObject")
        Framework.Modules.MeleeObject = Framework.Modules.require("MeleeObject")
        Framework.Modules.CharacterInterface = Framework.Modules.require("CharacterInterface")
        Framework.Modules.PlayerDataStoreClient = Framework.Modules.require("PlayerDataStoreClient")
        Framework.Modules.ContentDatabase = Framework.Modules.require("ContentDatabase")
        Framework.Modules.GameGlock = Framework.Modules.require("GameClock")
        Framework.Modules.ActiveLoadoutUtils = Framework.Modules.require("ActiveLoadoutUtils")
        Framework.Modules.HudStatusInterface = Framework.Modules.require("HudStatusInterface")
        Framework.Modules.PublicSettings = Framework.Modules.require("PublicSettings")
        Framework.Modules.CharacterEvents = Framework.Modules.require("CharacterEvents")
        Framework.Modules.WeaponControllerEvents = Framework.Modules.require("WeaponControllerEvents")
        Framework.Modules.PlayerStatusEvents = Framework.Modules.require("PlayerStatusEvents")
        Framework.Modules.physics = Framework.Modules.require("physics")
        Framework.Modules.particle = Framework.Modules.require("particle")
    end); if not s then
        writeclipboard("discord.gg/g4EGAwjUAK")
        return printconsole("[PF Framework Error]: Unable to get required modules.\nJoin our discord server for help: discord.gg/g4EGAwjUAK (copied)",200,0,0)
    end
end

Framework.Functions = {
    spawnTask = function(f) return task.spawn(f) end,
    renderStepped = RunService.RenderStepped,
    isVisible = function(Position, Ignore) Ignore = Ignore or { workspace.Terrain, workspace.Ignore, workspace.CurrentCamera, workspace.Players } return #Camera:GetPartsObscuringTarget({ Position }, Ignore) == 0 end,
    getEntry = function(_Player) return Framework.Modules.ReplicationInterface.getEntry(_Player) end,
    getCharacter = function(_Player) local Entry = Framework.Functions.getEntry(_Player) if Entry then return (Entry._thirdPersonObject and Entry._thirdPersonObject._character) end end,
    getHealth = function(_Player) local Entry = Framework.Functions.getEntry(_Player) return Entry._healthstate.health0, Entry._healthstate.maxhealth end,
    getWeaponName = function(_Player) local Entry = Framework.Functions.getEntry(_Player) if Entry._thirdPersonObject then return Entry._thirdPersonObject._weaponname or "" end end,
    isAlive = function(_Player) local Entry = Framework.Functions.getEntry(_Player) return Entry._alive end,
    isEnemy = function(Character) if Character.Parent.Name == tostring(Player.TeamColor) then return false else return true end end,
    getActiveWeapon = function() if Framework.Client.Controller then return Framework.Client.Controller._activeWeaponRegistry[Framework.Client.CurrentGunIndex] end end,
    createFOVCircle = function() local circle = Drawing.new("Circle"); circle.Thickness = 2; circle.NumSides = 999; circle.Filled = false; circle.Transparency = 0.6; circle.Radius = Framework.Silent_Aim.fov; return circle end,
    raycast = function(origin, direction, filterlist, whitelist) local Params = RaycastParams.new() Params.FilterDescendantsInstances = filterlist Params.FilterType = Enum.RaycastFilterType[whitelist and "Whitelist" or "Blacklist"] local result = workspace:Raycast(origin, direction, Params) return result and result.Instance, result and result.Position, result and result.Normal end,
    GetWeaponRegistry = function() if Framework.Client.Controller then return Framework.Client.Controller._activeWeaponRegistry end end,
    GetRegistryWeaponData = function(Registry) if Registry then return Registry._weaponData end end,
    getClosest = function(fov, hitbox, visibleCheck)
        local _position, _entry, _part;
        fov = fov or 180
        hitbox = hitbox or "Random"
        visibleCheck = visibleCheck or false
        for player, entry in next, Framework.Client.entryTable do
            local character = Framework.Functions.getCharacter(player)
            if character and player.Team ~= Player.Team then
                local part
                part = character[hitbox == "Random" and
                        (math.random() < (0.5) and "Head" or "Torso") or
                        (hitbox or "Head")];
                local position = part.Position + (part.Size * 0.5 * (math.random() * 2 - 1)) * (0.5);
                local screenPosition, visible = Camera.WorldToScreenPoint(Camera, position)
                if not (visibleCheck and not Framework.Functions.isVisible(position, Framework.Misc.PhsyicIgnore)) and not (visibleCheck and not visible) then
                    local p1, p2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(screenPosition.X, screenPosition.Y)
                    local magnitude = (p2-p1).Magnitude
                    if magnitude < fov then
                        _position = position;
                        _entry = entry;
                        _part = part;
                    end
                end
            end
        end
        return _position, _entry, _part;
    end,
    reloadWeapon = function()
        local magSize = Framework.Client.ActiveWeapon:getWeaponStat("magsize")
        local newCount = (magSize + (Framework.Client.ActiveWeapon:getWeaponStat("chamber") and 1 or 0)) - Framework.Client.ActiveWeapon._magCount
        if Framework.Client.ActiveWeapon._spareCount > newCount then
            Framework.Client.ActiveWeapon._magCount += newCount
            Framework.Client.ActiveWeapon._spareCount -= newCount
        else
            Framework.Client.ActiveWeapon._magCount += Framework.Client.ActiveWeapon._spareCount
            Framework.Client.ActiveWeapon._spareCount = 0
        end

        Framework.Modules.network:send("reload")
        Framework.Modules.HudStatusInterface.updateAmmo(Framework.Client.ActiveWeapon)
    end,
    getGarbageWeaponData = function() for _, a in pairs(getgc(true)) do if type(a) == 'table' and rawget(a, "aimrotkickmin") then return a end end end,
}


--Setup
Framework.Functions.spawnTask(function()
    if getgenv().Framework then
        for _,v in pairs(getgenv().Framework.Connections) do pcall(function() v:Disconnect() end) end
        Framework.Functions.solveQuartic = getgenv().Framework.Functions.solveQuartic
        Framework.Client.entryTable = getgenv().Framework.Client.entryTable
    else
        Framework.Functions.solveQuartic = debug.getupvalue(Framework.Modules.physics.timehit, 2);
        Framework.Client.entryTable = debug.getupvalue(Framework.Modules.ReplicationInterface.getEntry, 1)
        Framework.Events.onPlayerDied = Framework.Modules.PlayerStatusEvents.onPlayerDied
        Framework.Events.onPlayerSpawned = Framework.Modules.PlayerStatusEvents.onPlayerSpawned
        Framework.Events.onControllerFlag = Framework.Modules.WeaponControllerEvents.onControllerFlag
        Framework.Events.onCharacterSpawned = Framework.Modules.CharacterEvents.onSpawned
        Framework.Events.onCharacterDespawned = Framework.Modules.CharacterEvents.onDespawned
    end
end)

--Update
Framework.Connections["_update"] = Framework.Functions.renderStepped:Connect(function()
    Framework.Client.Controller = Framework.Modules.WeaponControllerInterface.getController()
    Framework.Client.WeaponRegistries = Framework.Functions.GetWeaponRegistry()
    Framework.Client.ActiveWeapon = Framework.Functions.getActiveWeapon()
    Framework.Client.CharacterObject = Framework.Modules.CharacterInterface.getCharacterObject()
    Framework.Client.isAlive = Framework.Modules.CharacterInterface.isAlive() or false

    if Framework.Modules.CharacterInterface.isAlive() and Framework.Client.Controller then
        Framework.Client.CurrentGunIndex = Framework.Client.Controller._activeWeaponIndex

        if Framework.Client.ActiveWeapon and Framework.Client.ActiveWeapon._barrelPart ~= nil then
            Framework.Client.BarrelPosition = Framework.Client.ActiveWeapon._barrelPart.Position
        end

        Framework.Misc.firepos = Framework.Client.BarrelPosition
        Framework.Misc.camerapos = Framework.Modules.CharacterInterface.getCharacterObject()._rootPart.Parent.Head.Position
    end
end)

--Finish

printconsole(string.format("[PF Framwork]: Framework loaded. took %s second(s)", (tick()-_t)), 0, 200, 0)
getgenv().Framework = Framework

return Framework