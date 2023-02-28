--mopsHub Phantom Forces [RELEASE] | 2023
--Written by mopsfl

getactors = getactors
getgenv = getgenv
getrenv = getrenv
syn = syn
setreadonly = setreadonly
hookmetamethod = hookmetamethod
checkcaller = checkcaller
setclipboard = setclipboard
writeclipboard = writeclipboard or setclipboard
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
request = request
http_request = http_request
isfile = isfile
writefile = writefile
readfile = readfile
queue_on_teleport = queue_on_teleport
fluxus = fluxus
isactor = isactor
printconsole = printconsole or print
getcustomasset = getcustomasset
getsynasset = getsynasset

local _startTick = tick()
printconsole("[mopsHub]: Framework loading...")

if writeclipboard then writeclipboard("discord.gg/g4EGAwjUAK") end
repeat task.wait() until game:IsLoaded() task.wait(2)

local bypassScript = 'shared.mopsHubLoading=true;local a=game:GetService("RunService")local b=game:GetService("ReplicatedFirst")local c=game:GetService("InsertService")c.DescendantAdded:Connect(function(d)if d:IsA("Actor")then d:Destroy()end end)b.ChildAdded:Connect(function(d)if d:IsA("Actor")then b.ChildAdded:Wait()for e,f in next,d:GetChildren()do f.Parent=b end end end)local g;g=hookmetamethod(a.Stepped,"__index",function(self,h)local i=g(self,h)if h=="ConnectParallel"and not checkcaller()then hookfunction(i,newcclosure(function(j,k)return g(self,"Connect")(j,function()return self:Wait()and k()end)end))end;return i end)task.spawn(function()local shared=getrenv().shared;repeat task.wait()until shared.close;getgenv().shared.RequireTable=shared.require end)'

--Variables
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Camera = game:GetService("Workspace").CurrentCamera
local Debris = game:GetService("Debris")
local TeleportService = game:GetService("TeleportService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

--Actor Bypass for non-synapse users
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
if shared.mopsHubLoading then repeat task.wait() until shared.RequireTable end
if (syn and isactor and not isactor()) or not syn then
    if shared.RequireTable == nil then
        if queueteleport then
            queueteleport(bypassScript)
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
            task.wait(9e9)
        else
            Player:Kick("[mopsHub - Error]: Executor not supported, sorry!")
            task.wait(9e9)
        end
    else
        if printconsole then
            printconsole("[mopsHub - PF]: running via bypass",0,255,0)
        else
            print("[mopsHub - PF]: running via bypass")
        end
    end
else
    if printconsole then
        printconsole("[mopsHub - PF]: running via actor",0,255,0)
    else
        print("[mopsHub - PF]: running via actor")
    end
end

--Modules
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))(); Notify = Notify.Notify

local FileName = string.format("mopshub_%s", game.PlaceId)
local ExecutorName, ExecutorVersion = identifyexecutor()
local ScriptTitle = string.format("mopsHub - %s - %s", "Phantom Forces", ExecutorName)
local ConfigFilePath = "/mopsHub/settings_phantomforces_v2.mhs"
local ClientId = RbxAnalyticsService:GetClientId()

local ScriptVersion = "v1.0.3"

local mopsHub = {
    Settings = { autoLoadConfigs = false, _DEBUG = getgenv().mopsHub_DEBUG or false },

    Aim_Assist = { Enabled = false, VisibleCheck = false, Target_Hitbox = "Head", Smoothness = 1.5, showFOV = false, fov = 180, fovColor = Color3.fromRGB(0,255,0) },
    Silent_Aim = { Enabled = false, VisibleCheck = false, Target_Hitbox = "Head", HitChance = 0.5, HeadChance = 0.5, Randomization = 0.5, showFOV = false, fov = 180, TriggerBot = false, fovColor = Color3.fromRGB(0,255,0) },
    Ragebot = { Enabled = false, Target_Hitbox = "Head", },
    Gun_Mods = { InstantReload = false, InstantEquip = false, FullAuto = false, NoRecoil = false, NoSpread = false,NoSway = false, InstantReloadCancel = false },
    ESP = { Enabled = false, Boxes = false, Tracers = false, TracerAttachShift = 1, tracersOrientation = "Bottom", Health = false, HealthBar = false, Names = false, Distance = false, Weapon = false, Chams = false, FontSize = 13, BoxColor = Color3.fromRGB(255,255,255), ChamsOutlineColor = Color3.fromRGB(255,255,255), ChamsFillColor = Color3.fromRGB(255,0,0), ChamsFillTransparency = 0.5, ChamsOutlineTransparency = 0.5, TextColor = Color3.fromRGB(255,255,255), TracerColor = Color3.fromRGB(255,255,255), TextSize = 8, Rainbow = false, SavedColors = {} },
    Hitbox_Extender = { Enabled = false, Hitbox = "Head", Size = 7, Transparency = 0.5, Color = Color3.fromRGB(255,0,0), HitBoxes = {} },
    Character_Modifications = { WalkSpeed = { Enabled = false,  Speed = 16 }, InfiniteJump = { Enabled = false, JumpHeight = 55 }, Bunny_Hop = { Enabled = false, Power = 4 }, No_Fall_Damage = { Enabled = false } },
    Third_Person = { Enabled = false, HideViewportModel = false, Offsets = { x = 0, y = 2, z = 9 } },
    Automatic_Actions = { AutoRespawn = false, JoinNewServerOnVoteKick = false, },
    Gun_Customization = { Enabled = false, GunColor = Color3.fromRGB(0,255,0), Transparency = 0, Material = Enum.Material.ForceField, Image = nil, Rainbow = false },
    Arm_Customization = { Enabled = false, Rainbow = false },
    Unlock = { Guns = false, Attachments = false, Knifes = false, Grenades = false },

    Functions = { BulletCheck = nil },
    Connections = {},
    Drawings = {},
    uiElements = {},

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
    Client = {
        Controller = nil,
        CharacterObject = nil,
        FakeRepObject = nil,
        entryTable = nil,
        CurrentGunIndex = nil,
        BarrelPosition = nil,
        ActiveWeapon = nil,
        GarbageWeaponData = nil,
        isAlive = false,
        replicatedPosition = nil,
        weaponModel = nil,
        WeaponRegistries = {},

        Events = {
            lastSpawnPosition = nil,
        }
    },
    Misc = {
        IgnoredWeaponParts = { IgnoredInstances = {"Flame", "SightMark", "SightMark2A", "Tip", "Trigger"} },
        OldWeaponPartData = { Material = {}, Color = {} },
        Third_Person = { ViewportModelIgnore = nil },
        Rage_Bot = {
            TableInfo = {
                firepos = nil,
                bullets = {},
                camerapos = nil,
            },
            Target = nil,
            LastFire = 0,
            bulletCountIndex = 10,
        },
        Gun_Mods = { NoRecoil_Stats = {"aimcamkickspeed", "modelkickspeed", "modelrecoverspeed"} },
        Silent_Aim = { fovCircle = nil },
        Aim_Assist = { fovCircle = nil, Active = false, Target = { part = nil, position = nil, entry = nil } },
        old = {
            network = { send = nil },
            particle = {},
            setSway = nil,
            walkSway = nil,
            gunSway = nil,
            meleeSway = nil,
            meelWalkSway = nil,
            shake = nil,
            getWeaponStat = nil,
            WeaponDatabases = {},
            AttachmentDatabase = {},
        },
        PhsyicIgnore = { Camera, workspace.Players, workspace.Terrain, workspace.Ignore },
        WeaponTypes = {
            Guns = { "ASSAULT", "SHOTGUN", "SNIPER", "PISTOL", "DMR", "REVOLVER" },
            Knifes = { "KNIFE" },
            Grenades = { "Grenade" }
        },
        Beams = {},
        tempmodifiedguns = {},
        MenuScreenGui = nil,
        DisplayVoteKick = nil,
        WeaponDatabases = {},
        AttachmentDatabase = {},
        MaterialNames = { "ForceField", "Neon", "Plastic", "Wood", "Slate", "Concrete", "CorrodedMetal", "DiamondPlate", "Foil", "Grass", "Ice", "Marble", "Granite", "Brick", "Pebble", "Sand", "Fabric", "SmoothPlastic", "Metal", "WoodPlanks", "Cobblestone", "Water", "Rock", "Glacier", "Snow", "Sandstone", "Mud", "Basalt", "Ground", "CrackedLava", "Glass", "Asphalt", "LeafyGrass", "Salt", "Limestone", "Pavement" },
        RainbowESP = false,
    },
    _loaded = false,
    votekick_logstate = 0,
}

getgenv()._WINDOW = { Tabs = {} }

if getgenv().mopsHub ~= nil and getgenv().mopsHub._loaded then
    if mopsHub.Settings._DEBUG then
        rconsolewarn("[mopsHub Debug]: mopsHub framework already loaded.")
    end
    if getgenv()._rayfield then
        getgenv()._rayfield:Notify({
            Title = "mopsHub Notification",
            Content = "mopsHub framework already loaded and cannot be loaded twice.",
            Duration = 6,
            Image = 4483362458,
        })
    end
    return
end

--Modules
do
    local s, error = pcall(function()
        mopsHub.Modules.require = getrenv().shared.require or shared.RequireTable
        mopsHub.Modules.network = mopsHub.Modules.require("network")
        mopsHub.Modules.WeaponControllerInterface = mopsHub.Modules.require("WeaponControllerInterface")
        mopsHub.Modules.MainCameraObject = mopsHub.Modules.require("MainCameraObject")
        mopsHub.Modules.ReplicationObject = mopsHub.Modules.require("ReplicationObject")
        mopsHub.Modules.ReplicationInterface = mopsHub.Modules.require("ReplicationInterface")
        mopsHub.Modules.ThirdPersonObject = mopsHub.Modules.require("ThirdPersonObject")
        mopsHub.Modules.FirearmObject = mopsHub.Modules.require("FirearmObject")
        mopsHub.Modules.MeleeObject = mopsHub.Modules.require("MeleeObject")
        mopsHub.Modules.CharacterInterface = mopsHub.Modules.require("CharacterInterface")
        mopsHub.Modules.PlayerDataStoreClient = mopsHub.Modules.require("PlayerDataStoreClient")
        mopsHub.Modules.ContentDatabase = mopsHub.Modules.require("ContentDatabase")
        mopsHub.Modules.GameGlock = mopsHub.Modules.require("GameClock")
        mopsHub.Modules.ActiveLoadoutUtils = mopsHub.Modules.require("ActiveLoadoutUtils")
        mopsHub.Modules.HudStatusInterface = mopsHub.Modules.require("HudStatusInterface")
        mopsHub.Modules.PublicSettings = mopsHub.Modules.require("PublicSettings")
        mopsHub.Modules.CharacterEvents = mopsHub.Modules.require("CharacterEvents")
        mopsHub.Modules.WeaponControllerEvents = mopsHub.Modules.require("WeaponControllerEvents")
        mopsHub.Modules.PlayerStatusEvents = mopsHub.Modules.require("PlayerStatusEvents")
        mopsHub.Modules.physics = mopsHub.Modules.require("physics")
        mopsHub.Modules.particle = mopsHub.Modules.require("particle")
    end); if not s then
        if mopsHub.Settings._DEBUG then rconsoleerr("[mopsHub Debug - Error]: Unable to load game modules.\nError:".. error) end
        writeclipboard("discord.gg/g4EGAwjUAK")
        return Notify({
            Title = "<font color='#ff0000'>Error</font>",
            Description = "Unable to get required modules.<br /><br />Join our discord server for help: <font color='#7289da'>discord.gg/g4EGAwjUAK</font> (copied)",
            Duration = 10,
        })
    end
end

--UI Init
if mopsHub.Settings._DEBUG then
    if rconsoleclear then rconsoleclear() end
    if rconsolename then rconsolename("mopsHub - Debug") end
end

local UI = {
    Tabs = {
        "Weapon",
        "Visual",
        "Character",
        "Misc",
        "Settings",
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
        },
        [2] = {
            Name = "Special Thanks",
            Content = {
                {"@yukihooked",""},
                {"@mickeydev",""},
                {"@LURKLURKLURKLURKLURKLURKLURKLURK",""}
            },
        },
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
        Title = "mopsHub - Phantom Forces",
        Subtitle = "Key System",
        Note = "",
        FileName = ".mopshubkey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = ""
    }
}); getgenv()._rayfield = Rayfield

--UI Functions
UI.Functions.Weapon = {
    { Function = "CreateSection", Args = "━ Aim Assist ━" },
    { Function = "CreateToggle", Args = { Name = "Aim Assist", Flag = "_aimassist", CurrentValue = mopsHub.Aim_Assist.Enabled, Callback = function(Value) mopsHub.Aim_Assist.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Visible Check", Flag = "_aimassist_visiblecheck", CurrentValue = mopsHub.Aim_Assist.VisibleCheck, Callback = function(Value) mopsHub.Aim_Assist.VisibleCheck = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Target Hitbox", Flag = "_aimassist_targethitbox", Options = {"Head", "Torso"}, CurrentOption = mopsHub.Aim_Assist.Target_Hitbox, Callback = function(Value) mopsHub.Aim_Assist.Target_Hitbox = Value end } },
    { Function = "CreateToggle", Args = { Name = "Show FOV", Flag = "_aimassist_showfov", CurrentValue = mopsHub.Aim_Assist.showFOV, Callback = function(Value) mopsHub.Aim_Assist.showFOV = Value end } },
    { Function = "CreateSlider", Args = { Name = "FOV", Flag = "_aimassist_fov", Range = {0,360}, Increment = 1, CurrentValue = mopsHub.Aim_Assist.fov, Callback = function(Value) mopsHub.Aim_Assist.fov = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "FOV Color", Flag = "_aimassist_fov_color", Color = mopsHub.Aim_Assist.fovColor, Callback = function(Value) mopsHub.Aim_Assist.fovColor = Value end } },
    { Function = "CreateSlider", Args = { Name = "Smoothness", Flag = "_aimassist_smoothness", Range = {0.5,5}, Increment = 0.1, CurrentValue = mopsHub.Aim_Assist.Smoothness, Callback = function(Value) mopsHub.Aim_Assist.Smoothness = Value*10 end } },

    { Function = "CreateSection", Args = "━ Silent Aimbot ━" },
    { Function = "CreateToggle", Args = { Name = "Silent Aim", Flag = "_silentaim", CurrentValue = mopsHub.Silent_Aim.Enabled, Callback = function(Value) mopsHub.Silent_Aim.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Visible Check", Flag = "_silentaim_visiblecheck", CurrentValue = mopsHub.Silent_Aim.VisibleCheck, Callback = function(Value) mopsHub.Silent_Aim.VisibleCheck = Value end } },
    { Function = "CreateSlider", Args = { Name = "Position Randomization", Flag = "_silentaim_posrandomization", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Silent_Aim.Randomization, Callback = function(Value) mopsHub.Silent_Aim.Randomization = Value end } },
    { Function = "CreateSlider", Args = { Name = "Hit Chance", Flag = "_silentaim_hitchance", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Silent_Aim.HitChance, Callback = function(Value) mopsHub.Silent_Aim.HitChance = Value end } },
    { Function = "CreateSlider", Args = { Name = "Head Hit Chance", Flag = "_silentaim_headhitchance", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Silent_Aim.HeadChance, Callback = function(Value) mopsHub.Silent_Aim.HeadChance = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Target Hitbox", Flag = "_silentaim_targethitbox", Options = {"Random", "Head", "Torso"}, CurrentOption = mopsHub.Silent_Aim.Target_Hitbox, Callback = function(Value) mopsHub.Silent_Aim.Target_Hitbox = Value end } },
    --{ Function = "CreateToggle", Args = { Name = "Triggerbot", Flag = "_silentaim_triggerbot", CurrentValue = mopsHub.Silent_Aim.TriggerBot, Callback = function(Value) mopsHub.Silent_Aim.TriggerBot = Value end } },
    { Function = "CreateToggle", Args = { Name = "Show FOV", Flag = "_silentaim_showfov", CurrentValue = mopsHub.Silent_Aim.showFOV, Callback = function(Value) mopsHub.Silent_Aim.showFOV = Value end } },
    { Function = "CreateSlider", Args = { Name = "FOV", Flag = "_silentaim_fov", Range = {0,360}, Increment = 1, CurrentValue = mopsHub.Silent_Aim.fov, Callback = function(Value) mopsHub.Silent_Aim.fov = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "FOV Color", Flag = "_silentaim_fov_color", Color = mopsHub.Silent_Aim.fovColor, Callback = function(Value) mopsHub.Silent_Aim.fovColor = Value end } },

    { Function = "CreateSection", Args = "━ Ragebot ━" },
    { Function = "CreateToggle", Args = { Name = "Rage Bot", Flag = "_ragebot", CurrentValue = mopsHub.Ragebot.Enabled, Callback = function(Value) mopsHub.Ragebot.Enabled = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Target Hitbox", Flag = "_ragebot_targethitbox", Options = {"Head", "Torso"}, CurrentOption = mopsHub.Ragebot.Target_Hitbox, Callback = function(Value) mopsHub.Ragebot.Target_Hitbox = Value end } },

    { Function = "CreateSection", Args = "━ Modifications ━" },
    { Function = "CreateToggle", Args = { Name = "No Recoil", Flag = "_norecoil", CurrentValue = mopsHub.Gun_Mods.NoRecoil, Callback = function(Value) mopsHub.Gun_Mods.NoRecoil = Value end } },
    { Function = "CreateToggle", Args = { Name = "No Spread", Flag = "_nospread", CurrentValue = mopsHub.Gun_Mods.NoSpread, Callback = function(Value) mopsHub.Gun_Mods.NoSpread = Value end } },
    { Function = "CreateToggle", Args = { Name = "No Sway", Flag = "_nosway", CurrentValue = mopsHub.Gun_Mods.NoSway, Callback = function(Value) mopsHub.Gun_Mods.NoSway = Value end } },
    { Function = "CreateToggle", Args = { Name = "Instant Reload Cancel", Flag = "_instantreloadcancel", CurrentValue = mopsHub.Gun_Mods.InstantReloadCancel, Callback = function(Value) mopsHub.Gun_Mods.InstantReloadCancel = Value end } },
    { Function = "CreateToggle", Args = { Name = "Instant Reload", Flag = "_instantreload", CurrentValue = mopsHub.Gun_Mods.InstantReload, Callback = function(Value) mopsHub.Gun_Mods.InstantReload = Value end } },
    { Function = "CreateToggle", Args = { Name = "Instant Equip", Flag = "_instantequip", CurrentValue = mopsHub.Gun_Mods.InstantEquip, Callback = function(Value) mopsHub.Gun_Mods.InstantEquip = Value end } },
    { Function = "CreateToggle", Args = { Name = "Full Automatic", Flag = "_fullauto", CurrentValue = mopsHub.Gun_Mods.FullAuto, Callback = function(Value) mopsHub.Gun_Mods.FullAuto = Value end } },
    { Function = "CreateParagraph", Args = { Title = "Note:", Content = "Some changes will only apply after a respawn." } },

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
    { Function = "CreateToggle", Args = { Name = "Weapon", Flag = "_esp_weapon", CurrentValue = mopsHub.ESP.Weapon, Callback = function(Value) mopsHub.ESP.Weapon = Value end } },
    { Function = "CreateToggle", Args = { Name = "Distance", Flag = "_esp_distance", CurrentValue = mopsHub.ESP.Distance, Callback = function(Value) mopsHub.ESP.Distance = Value end } },

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
    --{ Function = "CreateToggle", Args = { Name = "Hitbox Extender", Flag = "_hitbox_extender", CurrentValue = mopsHub.Hitbox_Extender.Enabled, Callback = function(Value) mopsHub.Hitbox_Extender.Enabled = Value end } },
    --{ Function = "CreateDropdown", Args = { Name = "Target Hitbox", Flag = "_hitbox_target", CurrentOption = mopsHub.Hitbox_Extender.Hitbox, Options = { "Head" }, Callback = function(Value) mopsHub.Hitbox_Extender.Hitbox = Value end } },
    --{ Function = "CreateSlider", Args = { Name = "Hitbox Size", Flag = "_hitbox_extender_size", Range = {0,15}, Increment = 1, CurrentValue = mopsHub.Hitbox_Extender.Size, Callback = function(Value) mopsHub.Hitbox_Extender.Size = Value end } },
    --{ Function = "CreateSlider", Args = { Name = "Hitbox Transparency", Flag = "_hitbox_extender_transparency", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Hitbox_Extender.Transparency, Callback = function(Value) mopsHub.Hitbox_Extender.Transparency = Value end } },
    --{ Function = "CreateColorPicker", Args = { Name = "Hitbox Color", Flag = "_hitbox_extender_color", Color = mopsHub.Hitbox_Extender.Color, Callback = function(Value) mopsHub.Hitbox_Extender.Color = Value end } },
    { Function = "CreateParagraph", Args = { Title = "Note:", Content = "Soon" } },

    { Function = "CreateSection", Args = "━ Third Person ━" },
    { Function = "CreateToggle", Args = { Name = "Third Person", Flag = "_thirdperson", CurrentValue = mopsHub.Third_Person.Enabled, Callback = function(Value) mopsHub.Third_Person.Enabled = Value end } },
    --{ Function = "CreateToggle", Args = { Name = "Hide Viewport Model", Flag = "_thirdperson_hideviewportmodel", CurrentValue = mopsHub.Third_Person.HideViewportModel, Callback = function(Value) mopsHub.Third_Person.HideViewportModel = Value end } },
    { Function = "CreateSlider", Args = { Name = "Camera X Offset", Flag = "_thirdperson_offset_x", Range = {-20,20}, Increment = 1, CurrentValue = mopsHub.Third_Person.Offsets.x, Callback = function(Value) mopsHub.Third_Person.Offsets.x = Value end } },
    { Function = "CreateSlider", Args = { Name = "Camera Y Offset", Flag = "_thirdperson_offset_y", Range = {-20,20}, Increment = 1, CurrentValue = mopsHub.Third_Person.Offsets.y, Callback = function(Value) mopsHub.Third_Person.Offsets.y = Value end } },
    { Function = "CreateSlider", Args = { Name = "Camera Z Offset", Flag = "_thirdperson_offset_z", Range = {-20,20}, Increment = 1, CurrentValue = mopsHub.Third_Person.Offsets.z, Callback = function(Value) mopsHub.Third_Person.Offsets.z = Value end } },

    { Function = "CreateSection", Args = "━ Visual Customization ━" },
    { Function = "CreateToggle", Args = { Name = "Gun Customization", Flag = "_customgun_enabled", CurrentValue = mopsHub.Gun_Customization.Enabled, Callback = function(Value) mopsHub.Gun_Customization.Enabled = Value end } },
    { Function = "CreateColorPicker", Args = { Name = "Gun Color", Flag = "_customgun_color", Color = mopsHub.Gun_Customization.GunColor, Callback = function(Value) mopsHub.Gun_Customization.GunColor = Value end } },
    { Function = "CreateSlider", Args = { Name = "Gun Transparency", Flag = "_customgun_transparency", Range = {0,1}, Increment = 0.1, CurrentValue = mopsHub.Gun_Customization.Transparency, Callback = function(Value) mopsHub.Gun_Customization.Transparency = Value end } },
    { Function = "CreateDropdown", Args = { Name = "Gun Material", Flag = "_customgun_material", CurrentOption = mopsHub.Gun_Customization.Material.Name, Options = mopsHub.Misc.MaterialNames, Callback = function(Value) mopsHub.Gun_Customization.Material = Enum.Material[Value] end } },
    { Function = "CreateToggle", Args = { Name = "Rainbow Gun", Flag = "_customgun_rainbow", CurrentValue = mopsHub.Gun_Customization.Rainbow, Callback = function(Value) mopsHub.Gun_Customization.Rainbow = Value end } },
    { Function = "CreateToggle", Args = { Name = "Arm Customization", Flag = "_customarm_enabled", CurrentValue = mopsHub.Arm_Customization.Enabled, Callback = function(Value) mopsHub.Arm_Customization.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Rainbow Arms", Flag = "_customarm_rainbow", CurrentValue = mopsHub.Arm_Customization.Rainbow, Callback = function(Value) mopsHub.Arm_Customization.Rainbow = Value end } },
    --{ Function = "CreateInput", Args = { Name = "Gun Image", Flag = "_customgun_image", PlaceholderText = "Image Id", CurrentOption = mopsHub.Gun_Customization.Image, RemoveTextAfterFocusLost = false, Callback = function(Value) mopsHub.Gun_Customization.Image = Value end } },


}

UI.Functions.Character = {
    { Function = "CreateSection", Args = "━ Modifications ━" },
    { Function = "CreateToggle", Args = { Name = "Walkspeed Modification", Flag = "_character_modifications_walkspeedenabled", CurrentValue = mopsHub.Character_Modifications.WalkSpeed.Enabled, Callback = function(Value) mopsHub.Character_Modifications.WalkSpeed.Enabled = Value end } },
    { Function = "CreateSlider", Args = { Name = "Walkspeed", Flag = "_character_modifications_walkspeed", Range = {5,50}, Increment = 1, CurrentValue = mopsHub.Character_Modifications.WalkSpeed.Speed, Callback = function(Value) mopsHub.Character_Modifications.WalkSpeed.Speed = Value end } },
    { Function = "CreateToggle", Args = { Name = "Infinite Jump", Flag = "_character_modifications_infinitejump", CurrentValue = mopsHub.Character_Modifications.InfiniteJump.Enabled, Callback = function(Value) mopsHub.Character_Modifications.InfiniteJump.Enabled = Value end } },
    { Function = "CreateSlider", Args = { Name = "Infinite Jump Height", Flag = "_character_modifications_infinitejump_height", Range = {0,100}, Increment = 1, CurrentValue = mopsHub.Character_Modifications.InfiniteJump.JumpHeight, Callback = function(Value) mopsHub.Character_Modifications.InfiniteJump.JumpHeight = Value end } },
    { Function = "CreateToggle", Args = { Name = "No Fall Damage", Flag = "_character_modifications_nofalldamage", CurrentValue = mopsHub.Character_Modifications.No_Fall_Damage.Enabled, Callback = function(Value) mopsHub.Character_Modifications.No_Fall_Damage.Enabled = Value end } },
    { Function = "CreateToggle", Args = { Name = "Bunny Hop", Flag = "_character_modifications_bunnyhop", CurrentValue = mopsHub.Character_Modifications.Bunny_Hop.Enabled, Callback = function(Value) mopsHub.Character_Modifications.Bunny_Hop.Enabled = Value end } },

    { Function = "CreateSection", Args = "━ Anti Aim ━" },
    { Function = "CreateParagraph", Args = { Title = "Note:", Content = "Soon" } },

}

UI.Functions.Misc = {
    { Function = "CreateSection", Args = "━ Automatic Actions ━" },
    { Function = "CreateToggle", Args = { Name = "Auto Respawn", Flag = "_autorespawn", CurrentValue = mopsHub.Automatic_Actions.AutoRespawn, Callback = function(Value) mopsHub.Automatic_Actions.AutoRespawn = Value end } },
    { Function = "CreateToggle", Args = { Name = "Server Hop on votekick", Flag = "_serverhoponvotekick", CurrentValue = mopsHub.Automatic_Actions.JoinNewServerOnVoteKick, Callback = function(Value) mopsHub.Automatic_Actions.JoinNewServerOnVoteKick = Value end } },
    { Function = "CreateSection", Args = "━ Unlocks ━" },
    { Function = "CreateToggle", Args = { Name = "Unlock all Weapons", Flag = "_unlockallweapons", CurrentValue = mopsHub.Unlock.Guns, Callback = function(Value) mopsHub.Unlock.Guns = Value end } },
    { Function = "CreateToggle", Args = { Name = "Unlock all Attachments", Flag = "_unlockallattachments", CurrentValue = mopsHub.Unlock.Attachments, Callback = function(Value) mopsHub.Unlock.Attachments = Value end } },
    { Function = "CreateToggle", Args = { Name = "Unlock all Knifes", Flag = "_unlockallknifes", CurrentValue = mopsHub.Unlock.Knifes, Callback = function(Value) mopsHub.Unlock.Knifes = Value end } },
    { Function = "CreateToggle", Args = { Name = "Unlock all Grenades", Flag = "_unlockallgrenades", CurrentValue = mopsHub.Unlock.Grenades, Callback = function(Value) mopsHub.Unlock.Grenades = Value end } },
    { Function = "CreateParagraph", Args = { Title = "Note:", Content = "! Everything is client-sided and only visual. You don't actually have the items !" } },

}

UI.Functions.Settings = {
    { Function = "CreateSection", Args = " ━ Script ━ " },
    { Function = "CreateToggle", Args = { Name = "Auto Load Configs", Flag = "_autoLoadConfigs", CurrentValue = mopsHub.Settings.autoLoadConfigs, Callback = function(Value) mopsHub.Settings.autoLoadConfigs = Value; mopsHub.Functions.Other.saveLocalConfig(Value) end } },
    { Function = "CreateParagraph", Args = { Title = "Script Informations", Content = string.format("\nScript Version: %s", ScriptVersion or ""), } },
    { Function = "CreateParagraph", Args = { Title = "Client Informations", Content = string.format("\nExecutor: %s %s\n\nClient Id: %s", ExecutorName or "unknown", ExecutorVersion or "unknown", ClientId or "unknown"), } },
}

--UI Init (my ass automatic rayfield ui loader)
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
                    local Element = nil
                    if Tab then
                        pcall(function()
                            local f,_s = func.Function, true
                            if f == "CreateSection" then
                                Element = Tab:CreateSection(func.Args)
                            elseif f == "CreateButton" then
                                Element = Tab:CreateButton(func.Args)
                            elseif f == "CreateToggle" then
                                Element = Tab:CreateToggle(func.Args)
                            elseif f == "CreateDropdown" then
                                Element = Tab:CreateDropdown(func.Args)
                            elseif f == "CreateInput" then
                                Element = Tab:CreateInput(func.Args)
                            elseif f == "CreateSlider" then
                                Element = Tab:CreateSlider(func.Args)
                            elseif f == "CreateParagraph" then
                                Element = Tab:CreateParagraph(func.Args)
                            elseif f == "CreateLabel" then
                                Element = Tab:CreateLabel(func.Args)
                            elseif f == "CreateKeybind" then
                                Element = Tab:CreateKeybind(func.Args)
                            elseif f == "CreateColorPicker" then
                                Element = Tab:CreateColorPicker(func.Args)
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

--Functions
mopsHub.Functions = {
    spawnTask = function(f) return task.spawn(f) end,
    renderStepped = RunService.RenderStepped,
    isVisible = function(Position, Ignore) Ignore = Ignore or { workspace.Terrain, workspace.Ignore, workspace.CurrentCamera, workspace.Players } return #Camera:GetPartsObscuringTarget({ Position }, Ignore) == 0 end,
    getEntry = function(_Player) return mopsHub.Modules.ReplicationInterface.getEntry(_Player) end,
    getCharacter = function(_Player) local Entry = mopsHub.Functions.getEntry(_Player) if Entry then return (Entry._thirdPersonObject and Entry._thirdPersonObject._character) end end,
    getHealth = function(_Player) local Entry = mopsHub.Functions.getEntry(_Player) return Entry._healthstate.health0, Entry._healthstate.maxhealth end,
    getWeaponName = function(_Player) local Entry = mopsHub.Functions.getEntry(_Player) if Entry._thirdPersonObject then return Entry._thirdPersonObject._weaponname or "" end end,
    isAlive = function(_Player) if _Player == Player then return mopsHub.Client.isAlive or false end local Entry = mopsHub.Functions.getEntry(_Player) return Entry._alive end,
    isEnemy = function(Character) if Character.Parent.Name == tostring(Player.TeamColor) then return false else return true end end,
    getActiveWeapon = function() if mopsHub.Client.Controller then return mopsHub.Client.Controller._activeWeaponRegistry[mopsHub.Client.CurrentGunIndex] end end,
    createFOVCircle = function() local circle = Drawing.new("Circle"); circle.Thickness = 2; circle.NumSides = 999; circle.Filled = false; circle.Transparency = 0.6; circle.Radius = mopsHub.Silent_Aim.fov; return circle end,
    raycast = function(origin, direction, filterlist, whitelist) local Params = RaycastParams.new() Params.FilterDescendantsInstances = filterlist Params.FilterType = Enum.RaycastFilterType[whitelist and "Whitelist" or "Blacklist"] local result = workspace:Raycast(origin, direction, Params) return result and result.Instance, result and result.Position, result and result.Normal end,
    GetWeaponRegistry = function() if mopsHub.Client.Controller then return mopsHub.Client.Controller._activeWeaponRegistry end end,
    GetRegistryWeaponData = function(Registry) if Registry then return Registry._weaponData end end,
    checkDecal = function(imageid)
        if not imageid then return false end local info = MarketplaceService:GetProductInfo(imageid, Enum.InfoType.Asset) if info and info.AssetTypeId == 13 then return true else return false end
    end,
    createDecal = function(imageid)
        if not imageid then return end
        if not mopsHub.Functions.checkDecal(imageid) then return Rayfield:Notify({
            Title = "mopsHub - Error",
            Content = string.format("ImageId '%s' not found.", tostring(imageid)),
            Duration = 4,
        }) end

        local Decal = Instance.new("Decal")
        Decal.Texture = string.format("rbxassetid://%s", tostring(imageid))
        return Decal
    end,
    createBeam = function(origin, ending, texture)
        local beam = Instance.new("Beam")
        beam.Texture = "http://www.roblox.com/asset/?id=12451896890"
        beam.TextureMode = Enum.TextureMode.Stretch
        beam.TextureSpeed = 8
        beam.LightEmission = 1
        beam.LightInfluence = 1
        beam.TextureLength = 12
        beam.FaceCamera = true
        beam.Enabled = true
        beam.ZOffset = -1
        beam.Transparency = NumberSequence.new((1 - 150 / 255),(1 - 150 / 255))
        beam.Color = ColorSequence.new(Color3.fromRGB(255,134,93),Color3.fromRGB(121, 61, 41))
        beam.Attachment0 = origin
        beam.Attachment1 = ending
        Debris:AddItem(beam, 3)
        Debris:AddItem(origin, 3)
        Debris:AddItem(ending, 3)

        local speedtween = TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(beam, speedtween, { TextureSpeed = 2 }):Play()
        beam.Parent = workspace
        table.insert(mopsHub.Misc.Beams, { beam = beam, time = tick() })
        return beam
    end,
    getClosest = function(aim_assist)
        local _position, _entry, _part;
        for player, entry in next, mopsHub.Client.entryTable do
            local character = mopsHub.Functions.getCharacter(player)
            if character and player.Team ~= Player.Team then
                local part = character[mopsHub.Silent_Aim.Target_Hitbox == "Random" and
                    (math.random() < (mopsHub.Silent_Aim.HeadChance or 0.5) and "Head" or "Torso") or
                    (mopsHub.Silent_Aim.Target_Hitbox or "Head")];
                local position = part.Position + (part.Size * 0.5 * (math.random() * 2 - 1)) * (mopsHub.Silent_Aim.Randomization or 0.5);
                local screenPosition, visible = Camera.WorldToScreenPoint(Camera, position)
                local VisibleCheck = mopsHub.Silent_Aim.VisibleCheck
                if not (VisibleCheck and not mopsHub.Functions.isVisible(position, mopsHub.Misc.PhsyicIgnore)) and not (VisibleCheck and not visible) then
                    local p1, p2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(screenPosition.X, screenPosition.Y)
                    local magnitude = (p2 - p1).Magnitude
                    if magnitude < mopsHub.Silent_Aim.fov and (math.random() < (mopsHub.Silent_Aim.HitChance or 0.5)) then
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
        local magSize = mopsHub.Client.ActiveWeapon:getWeaponStat("magsize")
        local newCount = (magSize + (mopsHub.Client.ActiveWeapon:getWeaponStat("chamber") and 1 or 0)) - mopsHub.Client.ActiveWeapon._magCount
        if mopsHub.Client.ActiveWeapon._spareCount > newCount then
            mopsHub.Client.ActiveWeapon._magCount += newCount
            mopsHub.Client.ActiveWeapon._spareCount -= newCount
        else
            mopsHub.Client.ActiveWeapon._magCount += mopsHub.Client.ActiveWeapon._spareCount
            mopsHub.Client.ActiveWeapon._spareCount = 0
        end

        mopsHub.Modules.network:send("reload")
        mopsHub.Modules.HudStatusInterface.updateAmmo(mopsHub.Client.ActiveWeapon)
    end,
    getGarbageWeaponData = function()
        for _, a in pairs(getgc(true)) do
            if type(a) == 'table' and rawget(a, "aimrotkickmin") then
                return a
            end
        end
    end,
    Silent_Aim = {
        getTrajectory = function(dir, velocity, accel, speed)
            local r1, r2, r3, r4 = mopsHub.Functions.solveQuartic(
                accel:Dot(accel) * 0.25,
                accel:Dot(velocity),
                accel:Dot(dir) + velocity:Dot(velocity) - speed^2,
                dir:Dot(velocity) * 2,
                dir:Dot(dir));

            local time = (r1>0 and r1) or (r2>0 and r2) or (r3>0 and r3) or r4;
            local bullet = dir / time + velocity + 0.5 * accel * time;
            return bullet, time;
        end,
        updateFOV = function()
            if not mopsHub.Misc.Silent_Aim.fovCircle then mopsHub.Misc.Silent_Aim.fovCircle = mopsHub.Functions.createFOVCircle() end
            mopsHub.Misc.Silent_Aim.fovCircle.Visible = mopsHub.Silent_Aim.showFOV and mopsHub.Silent_Aim.Enabled
            mopsHub.Misc.Silent_Aim.fovCircle.Color = mopsHub.Silent_Aim.fovColor
            mopsHub.Misc.Silent_Aim.fovCircle.Radius = mopsHub.Silent_Aim.fov
            mopsHub.Misc.Silent_Aim.fovCircle.Position = UserInputService:GetMouseLocation()
        end,
    },
    Aim_Assist = {
        updateFOV = function()
            if not mopsHub.Misc.Aim_Assist.fovCircle then mopsHub.Misc.Aim_Assist.fovCircle = mopsHub.Functions.createFOVCircle() end
            mopsHub.Misc.Aim_Assist.fovCircle.Visible = mopsHub.Aim_Assist.showFOV and mopsHub.Aim_Assist.Enabled
            mopsHub.Misc.Aim_Assist.fovCircle.Color = mopsHub.Aim_Assist.fovColor
            mopsHub.Misc.Aim_Assist.fovCircle.Radius = mopsHub.Aim_Assist.fov
            mopsHub.Misc.Aim_Assist.fovCircle.Position = UserInputService:GetMouseLocation()
        end,
        getClosest = function()
            local _position, _entry, _part;
            for player, entry in next, mopsHub.Client.entryTable do
                if player == Player then return end
                local plrstemp = {}
                local Character = mopsHub.Functions.getCharacter(player)
                local isAlive = mopsHub.Functions.isAlive(player)
                if not Character or not isAlive then continue end
                if player.Team == Player.Team then continue end
                local Part = Character[mopsHub.Aim_Assist.Target_Hitbox]
                local Position = Part.Position
                local screenPosition, visible = Camera.WorldToScreenPoint(Camera, Position)

                if mopsHub.Aim_Assist.VisibleCheck then
                    if visible then if mopsHub.Functions.isVisible(Position, mopsHub.Misc.PhsyicIgnore) then table.insert(plrstemp, player) end
                    else
                        if visible then table.insert(plrstemp, player)
                        else if table.find(plrstemp, player) then table.remove(plrstemp, player) end
                        end
                    end
                else
                    if visible then
                        table.insert(plrstemp, player)
                    else if table.find(plrstemp, player) then table.remove(plrstemp, player) end
                    end
                end

                local p1, p2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(screenPosition.X, screenPosition.Y)
                local magnitude = (p2 - p1).Magnitude

                for _,v in pairs(plrstemp) do
                    if mopsHub.Functions.isAlive(v) and visible and magnitude < mopsHub.Aim_Assist.fov then
                        _position = Position;
                        _entry = entry;
                        _part = Part;
                    end
                end
            end
            return _position, _entry, _part
        end
    },
    Rage_Bot = {
        checkFireRate = function(firerate)
            firerate = type(firerate) == "table" and firerate[1] or firerate
            return (tick() - mopsHub.Misc.Rage_Bot.LastFire) > (60 / firerate)
        end,
        checkBullet_old = function(o,t,penetrationdepth)
            if not penetrationdepth or penetrationdepth <= 0 then return false end
            local ve = t - o
            local n = ve.Unit
            local h, po = mopsHub.Functions.raycast(o, ve, mopsHub.Misc.PhsyicIgnore)
            if h then
                if h.CanCollide or h.Transparency == 0 then
                    local e = h.Size.Magnitude * n
                    local nh, dp = mopsHub.Functions.raycast(po + e, -e, {h}, true)
                    if not dp or not po then return false end
                    local m = (dp - po).Magnitude
                    if m >= penetrationdepth then
                        return false
                    else
                        penetrationdepth = penetrationdepth - m
                    end
                end
                return mopsHub.Functions.Rage_Bot.checkBullet(po + n / 100, t, penetrationdepth)
            end
            return true
        end,
        checkBullet = function(_origin, target, radius, pen, bulletSpeed)
            local origins = { CFrame.new(_origin, target) };

            for _, id in next, Enum.NormalId:GetEnumItems() do
                table.insert(origins, origins[1] + Vector3.fromNormalId(id) * radius);
            end
            
            for _, origin in next, origins do
                local p = origin.Position;
                local velocity = mopsHub.Modules.physics.trajectory(p, mopsHub.Modules.PublicSettings.bulletAcceleration, target, bulletSpeed);
                local bulletcheck = mopsHub.Functions.BulletCheck(p, target, velocity, mopsHub.Modules.PublicSettings.bulletAcceleration, pen);

                if bulletcheck then
                    return p, velocity;
                end
            end
        end
    },
    Gun_Mods = {
        noRecoil = function()
            mopsHub.Functions.spawnTask(function()
                if mopsHub.Gun_Mods.NoRecoil then
                    for _, a in pairs(getgc(true)) do
                        if type(a) == 'table' and rawget(a, "aimrotkickmin") then
                            setreadonly(a, false)
                            a.aimrotkickmin = Vector3.new(0,0,0)
                            a.aimrotkickmax = Vector3.new(0,0,0)
                            a.aimtranskickmin = Vector3.new(0,0,0)
                            a.aimtranskickmax = Vector3.new(0,0,0)
                            a.aimcamkickmin = Vector3.new(0,0,0)
                            a.aimcamkickmax = Vector3.new(0,0,0)
                            a.rotkickmin = Vector3.new(0,0,0)
                            a.rotkickmax = Vector3.new(0,0,0)
                            a.transkickmin = Vector3.new(0,0,0)
                            a.transkickmax = Vector3.new(0,0,0)
                            a.camkickmin = Vector3.new(0,0,0)
                            a.camkickmax = Vector3.new(0,0,0)
                            a.aimcamkickspeed = 99999
                            a.modelkickspeed = 9999
                            a.modelrecoverspeed = 9999
                            setreadonly(a, true)
                        end
                    end
                end
            end)
        end
    },
    Automatic_Actions = {
        getServers = function()
            if not mopsHub.Functions.Request then if mopsHub.Settings._DEBUG then rconsolewarn("[mopsHub - Debug]: Request function not defined") end return end
            if mopsHub.votekick_logstate == 3 then return end
            local url = "https://games.roblox.com/v1/games/292439477/servers/0?sortOrder=Desc&limit=100&excludeFullGames=true"
            local res = mopsHub.Functions.Request({
                ["Url"] = url,
                ["Method"] = "GET",
                ["Headers"] = {
                    ["Content-Type"] = "application/json"
                },
            })
            if res.StatusCode ~= 200 or not res.Success then
                if mopsHub.Settings._DEBUG then
                    return rconsoleerr("[mopsHub Debug - Error]: Unable to fetch servers (serverhop).")
                end
            end
            return HttpService:JSONDecode(res.Body)
        end
    },
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
    Unlocks = {
        unlockType = function(weaponType, enabled)
            if not enabled then return end
            if typeof(tostring(weaponType)) == "string" then
                for i,types in pairs(mopsHub.Misc.WeaponTypes) do
                    if i == weaponType then
                        for _,v in pairs(mopsHub.Misc.WeaponDatabases) do
                            setreadonly(v, false)
                            if weaponType ~= "Attachments" and table.find(types, v["type"]) then
                                v.unlockrank = 0
                                v.exclusiveunlock = false
                                v.hideunlessowned = false
                                v.notinmysterybox = nil
                                v.supertest = nil
                            elseif weaponType == "Attachments" then
                                v.unlockkills = 0
                            end
                            setreadonly(v, true)
                        end
                    else
                        for _,v in pairs(mopsHub.Misc.AttachmentDatabase) do
                            setreadonly(v, false)
                            v.unlockkills = 0
                            setreadonly(v, true)
                        end
                    end
                end
            end
        end
    }
}

--Setup
mopsHub.Functions.spawnTask(function()
    if getgenv().mopsHub then
        for _,v in pairs(getgenv().mopsHub.Connections) do pcall(function() v:Disconnect() end) end
        if getgenv().mopsHub.Misc.Silent_Aim.fovCircle then getgenv().mopsHub.Misc.Silent_Aim.fovCircle:Remove() end
        if getgenv().mopsHub.Misc.Aim_Assist.fovCircle then getgenv().mopsHub.Misc.Aim_Assist.fovCircle:Remove() end
        mopsHub.Functions = getgenv().mopsHub.Functions
        mopsHub.Misc.old = getgenv().mopsHub.Misc.old or mopsHub.Misc.old
        mopsHub.Functions.Request = (syn and syn.request or request) or http_request
        mopsHub.Client.entryTable = getgenv().mopsHub.Client.entryTable
    else
        mopsHub.Functions.solveQuartic = debug.getupvalue(mopsHub.Modules.physics.timehit, 2);
        mopsHub.Client.entryTable = debug.getupvalue(mopsHub.Modules.ReplicationInterface.getEntry, 1)
        mopsHub.Misc.old.setSway = mopsHub.Modules.MainCameraObject.setSway
        mopsHub.Misc.old.shake = mopsHub.Modules.MainCameraObject.shake
        mopsHub.Misc.old.walkSway = mopsHub.Modules.FirearmObject.walkSway
        mopsHub.Misc.old.gunSway = mopsHub.Modules.FirearmObject.gunSway
        mopsHub.Misc.old.meleeSway = mopsHub.Modules.MeleeObject.meleeSway
        mopsHub.Misc.old.meelWalkSway = mopsHub.Modules.MeleeObject.walkSway
        mopsHub.Misc.old.network.send = mopsHub.Modules.network.send
        mopsHub.Misc.old.getWeaponStat = mopsHub.Modules.FirearmObject.getWeaponStat
        mopsHub.Misc.MenuScreenGui = Player.PlayerGui:WaitForChild("MenuScreenGui")
        mopsHub.Misc.DisplayVoteKick = Player.PlayerGui:WaitForChild("ChatScreenGui").Main.DisplayVoteKick
        mopsHub.Functions.BulletCheck = getrenv().shared.require("BulletCheck")
        for _,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "unlockrank") then
                table.insert(mopsHub.Misc.WeaponDatabases, v)
            elseif typeof(v) == "table" and rawget(v, "unlockkills") then
                table.insert(mopsHub.Misc.AttachmentDatabase, v)
            end
        end
    end

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

--Update
mopsHub.Connections["_update"] = mopsHub.Functions.renderStepped:Connect(function()
    mopsHub.Client.Controller = mopsHub.Modules.WeaponControllerInterface.getController()
    mopsHub.Client.WeaponRegistries = mopsHub.Functions.GetWeaponRegistry()
    mopsHub.Client.ActiveWeapon = mopsHub.Functions.getActiveWeapon()
    mopsHub.Client.CharacterObject = mopsHub.Modules.CharacterInterface.getCharacterObject()
    mopsHub.Client.isAlive = mopsHub.Modules.CharacterInterface.isAlive()
    mopsHub.Functions.Request = (syn and syn.request or request) or http_request

    if mopsHub.Client.isAlive and mopsHub.Client.Controller then
        mopsHub.Client.CurrentGunIndex = mopsHub.Client.Controller._activeWeaponIndex
        if mopsHub.Ragebot.Enabled then
            mopsHub.Misc.Rage_Bot.TableInfo.firepos = mopsHub.Client.BarrelPosition
            mopsHub.Misc.Rage_Bot.TableInfo.camerapos = mopsHub.Modules.CharacterInterface.getCharacterObject()._rootPart.Parent.Head.Position
            if mopsHub.Client.ActiveWeapon and mopsHub.Client.ActiveWeapon._barrelPart ~= nil then
                mopsHub.Client.BarrelPosition = mopsHub.Client.ActiveWeapon._barrelPart.Position
            end
        end
    end
    if mopsHub.Aim_Assist.Enabled then
        local position, entry, part = mopsHub.Functions.Aim_Assist.getClosest()
        if position and entry and part then
            mopsHub.Misc.Aim_Assist.Target.part = part
            mopsHub.Misc.Aim_Assist.Target.position = position
            mopsHub.Misc.Aim_Assist.Target.entry = entry
        else
            mopsHub.Misc.Aim_Assist.Target = { }
        end
    else
        mopsHub.Misc.Aim_Assist.Target = { }
    end
end)

--Events
mopsHub.Functions.spawnTask(function()
    --Character Events
    mopsHub.Connections["_onSpawned"] = mopsHub.Modules.CharacterEvents.onSpawned:Connect(function(spawnPosition)
        mopsHub.Client.Events.lastSpawnPosition = spawnPosition
        if mopsHub.Settings._DEBUG then
            rconsoleinfo("[mopsHub - Debug]: entry spawned > ".. tostring(spawnPosition))
        end
    end)
    mopsHub.Connections["_onDespawned"] = mopsHub.Modules.CharacterEvents.onDespawned:Connect(function(s)
        if mopsHub.Settings._DEBUG then
            rconsoleinfo("[mopsHub - Debug]: character despawned > ".. tostring(s))
        end
        table.clear(mopsHub.Misc.tempmodifiedguns)
    end)
    --Weapon Controller Events
    mopsHub.Connections["_onControllerFlag"] = mopsHub.Modules.WeaponControllerEvents.onControllerFlag:Connect(function(weponData, flag, tick)
        if mopsHub.Settings._DEBUG then
            rconsoleinfo(string.format("[mopsHub - Debug]: controller flag > %s, %s, %s", tostring(flag), tostring(tick), tostring(weponData)))
        end
    end)
    --Player Status Events
    mopsHub.Connections["_onPlayerDied"] = mopsHub.Modules.PlayerStatusEvents.onPlayerDied:Connect(function(player, position)
        if mopsHub.Settings._DEBUG then
            rconsoleinfo(string.format("[mopsHub - Debug]: player died > %s, %s", tostring(player), tostring(position)))
        end
    end)
    mopsHub.Connections["_onPlayerSpawned"] = mopsHub.Modules.PlayerStatusEvents.onPlayerSpawned:Connect(function(player, bodyPart, s, pos, t)
        if mopsHub.Settings._DEBUG then
            rconsoleinfo(string.format("[mopsHub - Debug]: player spawned > %s, %s, %s, %s", tostring(player), tostring(bodyPart), tostring(s), tostring(pos), tostring(t)))
        end
    end)
end)

--Hooks
mopsHub.Functions.spawnTask(function()
    --Network Hooks
    mopsHub.Modules.network.send = function(self, name, ...)
        local args = {...}
        --No Fall Damage
        if name == "falldamage" and mopsHub.Character_Modifications.No_Fall_Damage.Enabled then
            if mopsHub.Settings._DEBUG then rconsoleinfo("[mopsHub Debug]: hooking falldamage") end return
        elseif name == "repupdate" then
            mopsHub.Client.replicatedPosition = args[1]
        end

        --Third Person
        if mopsHub.Client.FakeRepObject then
            if name == "stance" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    local stance = args[1]
                    third_person_object:setStance(stance)
                end
            elseif name == "aim" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    local aim = args[1]
                    third_person_object:setAim(aim)
                end
            elseif name == "equip" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    local weapon_index = args[1]
                    if weapon_index < 3 then
                        third_person_object:equip(weapon_index)
                    elseif weapon_index == 3 then
                        third_person_object:equipMelee(weapon_index)
                    end
                end
            elseif name == "sprint" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    local sprinting = args[1]
                    third_person_object:setSprint(sprinting)
                end
            elseif name == "stab" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    third_person_object:stab()
                end
            elseif name == "spawn" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    local character_model = third_person_object:popCharacterModel()
                    character_model:Destroy()
                    mopsHub.Client.FakeRepObject:despawn()
                end
                local current_loadout = mopsHub.Modules.ActiveLoadoutUtils.getActiveLoadoutData(mopsHub.Modules.PlayerDataStoreClient.getPlayerData())
                mopsHub.Client.FakeRepObject:spawn(nil, current_loadout)
            elseif name == "forcereset" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    local character_model = third_person_object._character
                    character_model:Destroy()
                    mopsHub.Client.FakeRepObject:despawn()
                end
            elseif name == "newbullets" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    third_person_object:kickWeapon()
                end
            elseif name == "swapweapon" then
                local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                if third_person_object then
                    local weapon_index = args[2]
                    local weapon_dropped = args[1]
                    if weapon_index < 3 then
                        mopsHub.Client.FakeRepObject._activeWeaponRegistry[weapon_index] = {
                            weaponName = weapon_dropped.Gun.Value,
                            weaponData = mopsHub.Modules.ContentDatabase.getWeaponData(weapon_dropped.Gun.Value),
                        }
                    else
                        mopsHub.Client.FakeRepObject._activeWeaponRegistry[weapon_index] = {
                            weaponName = weapon_dropped.Knife.Value,
                            weaponData = mopsHub.Modules.ContentDatabase.getWeaponData(weapon_dropped.Knife.Value),
                        }
                    end
                end
            elseif name == "repupdate" then
                if mopsHub.Third_Person.Enabled and mopsHub.Modules.CharacterInterface.isAlive() then
                    local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                    if not third_person_object then
                        mopsHub.Client.FakeRepObject._activeWeaponRegistry[1] = {
                            weaponName = mopsHub.Client.Controller._activeWeaponRegistry[1]._weaponName,
                            weaponData = mopsHub.Client.Controller._activeWeaponRegistry[1]._weaponData,
                            attachmentData = mopsHub.Client.Controller._activeWeaponRegistry[1]._weaponAttachments,
                            camoData = mopsHub.Client.Controller._activeWeaponRegistry[1]._camoList
                        }
                        mopsHub.Client.FakeRepObject._activeWeaponRegistry[2] = {
                            weaponName = mopsHub.Client.Controller._activeWeaponRegistry[2]._weaponName,
                            weaponData = mopsHub.Client.Controller._activeWeaponRegistry[2]._weaponData,
                            attachmentData = mopsHub.Client.Controller._activeWeaponRegistry[2]._weaponAttachments,
                            camoData = mopsHub.Client.Controller._activeWeaponRegistry[2]._camoList
                        }
                        mopsHub.Client.FakeRepObject._activeWeaponRegistry[3] = {
                            weaponName = mopsHub.Client.Controller._activeWeaponRegistry[3]._weaponName,
                            weaponData = mopsHub.Client.Controller._activeWeaponRegistry[3]._weaponData,
                            camoData = mopsHub.Client.Controller._activeWeaponRegistry[3]._camoData
                        }
                        mopsHub.Client.FakeRepObject._activeWeaponRegistry[4] = {
                            weaponName = mopsHub.Client.Controller._activeWeaponRegistry[4]._weaponName,
                            weaponData = mopsHub.Client.Controller._activeWeaponRegistry[4]._weaponData
                        }
                        mopsHub.Client.FakeRepObject._thirdPersonObject = mopsHub.Modules.ThirdPersonObject.new(mopsHub.Client.FakeRepObject._player, nil, mopsHub.Client.FakeRepObject)
                        mopsHub.Client.FakeRepObject._thirdPersonObject:equip(mopsHub.Client.Controller._activeWeaponIndex, true)
                        mopsHub.Client.FakeRepObject._alive = true
                    end
                    local clock_time = mopsHub.Modules.GameGlock.getTime()
                    local tick = tick()
                    local velocity = Vector3.zero
                    if mopsHub.Client.FakeRepObject._receivedPosition and mopsHub.Client.FakeRepObject._receivedFrameTime then
                        velocity = (args[1] - mopsHub.Client.FakeRepObject._receivedPosition) / (tick - mopsHub.Client.FakeRepObject._receivedFrameTime);
                    end
                    local broken = false
                    if mopsHub.Client.FakeRepObject._lastPacketTime and clock_time - mopsHub.Client.FakeRepObject._lastPacketTime > 0.5 then
                        broken = true
                        mopsHub.Client.FakeRepObject._breakcount = mopsHub.Client.FakeRepObject._breakcount + 1
                    end
                    mopsHub.Client.FakeRepObject._smoothReplication:receive(clock_time, tick, {
                        t = tick,
                        position = args[1],
                        velocity = velocity,
                        angles = args[2],
                        breakcount = mopsHub.Client.FakeRepObject._breakcount
                    }, broken);
                    mopsHub.Client.FakeRepObject._updaterecieved = true
                    mopsHub.Client.FakeRepObject._receivedPosition = args[1]
                    mopsHub.Client.FakeRepObject._receivedFrameTime = tick
                    mopsHub.Client.FakeRepObject._lastPacketTime = clock_time
                    mopsHub.Client.FakeRepObject:step(3, true)
                else
                    if mopsHub.Client.FakeRepObject then
                        local third_person_object = mopsHub.Client.FakeRepObject:getThirdPersonObject()
                        if third_person_object then
                            local character_model = third_person_object:popCharacterModel()
                            character_model:Destroy()
                            mopsHub.Client.FakeRepObject:despawn()
                        end
                    end
                end
            end
        end
        return mopsHub.Misc.old.network.send(self, name, ...)
    end

    --Silent Aim
    mopsHub.Misc.old.particle["new"] = hookfunction(mopsHub.Modules.particle.new, function(args)
        if debug.info(2, "n") == "fireRound" and mopsHub.Silent_Aim.Enabled then
            local position, entry = mopsHub.Functions.getClosest();
            if position and entry then
                local index = table.find(debug.getstack(2), args.velocity);
                args.velocity = mopsHub.Functions.Silent_Aim.getTrajectory(position - args.visualorigin,entry._velspring._p0, -args.acceleration, args.velocity.Magnitude);
                debug.setstack(2, index, args.velocity);
            end
        end
        if args.physicsignore then mopsHub.Misc.PhsyicIgnore = args.physicsignore end
        return mopsHub.Misc.old.particle["new"](args)
    end)

    --Third Person
    mopsHub.Misc.old.oldNewIndex = hookmetamethod(game, "__newindex", function(self, index, value)
        if checkcaller() then
            return mopsHub.Misc.old.oldNewIndex(self, index, value)
        end
        if mopsHub.Modules.CharacterInterface:isAlive() then
            if self == Camera and index == "CFrame" and mopsHub.Third_Person.Enabled then
                value *= CFrame.new(mopsHub.Third_Person.Offsets.x, mopsHub.Third_Person.Offsets.y, mopsHub.Third_Person.Offsets.z)

                if not mopsHub.Misc.Third_Person.ViewportModelIgnore then
                    mopsHub.Misc.Third_Person.ViewportModelIgnore = {}
                    for _,v in pairs(Camera:GetDescendants()) do
                        if v:IsA("BasePart") and v.Transparency == 1 then
                            table.insert(mopsHub.Misc.Third_Person.ViewportModelIgnore, v)
                        end
                    end
                end
                if mopsHub.Third_Person.HideViewportModel then
                    for _,v in pairs(Camera:GetDescendants()) do
                        if v:IsA("BasePart") and not table.find(mopsHub.Misc.Third_Person.ViewportModelIgnore,v) then
                            v.Transparency = 1
                        end
                    end
                end
            end
        end
        return mopsHub.Misc.old.oldNewIndex(self, index, value)
    end)

    --Gun Mods
    mopsHub.Modules.FirearmObject.getWeaponStat = function(...)
        local args = {...}
        if mopsHub.Gun_Mods.NoRecoil then
            local data = args[2]
            if table.find(mopsHub.Misc.Gun_Mods.NoRecoil_Stats, args[2]) then
                args[1]._weaponData[data] = 999
            end
        end
        return mopsHub.Misc.old.getWeaponStat(...)
    end
end)

--Aim Assist
mopsHub.Functions.spawnTask(function()
    mopsHub.Connections["_aimassist_inputbegan"] = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 and mopsHub.Aim_Assist.Enabled then
            mopsHub.Misc.Aim_Assist.Active = true
            while mopsHub.Misc.Aim_Assist.Active and mopsHub.Aim_Assist.Enabled do task.wait()
                if mopsHub.Misc.Aim_Assist.Target.part ~= nil then
                    local mousePosition = Camera:WorldToScreenPoint(Mouse.Hit.Position)
                    local targetPosition = Camera:WorldToScreenPoint(mopsHub.Misc.Aim_Assist.Target.part.Position)
                    mousemoverel((targetPosition.X - mousePosition.X) / math.clamp(mopsHub.Aim_Assist.Smoothness, 10, 50) or 5, (targetPosition.Y - mousePosition.Y) / math.clamp(mopsHub.Aim_Assist.Smoothness, 10, 50) or 5)
                end
            end
        end
    end)
    mopsHub.Connections["_aimassist_inputended"] = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 and mopsHub.Aim_Assist.Enabled then
            mopsHub.Misc.Aim_Assist.Active = false
        end
    end)
end)

--Rage Bot
mopsHub.Connections["_rageBot"] = mopsHub.Functions.renderStepped:Connect(function()
    for _,v in pairs(Players:GetPlayers()) do
        if mopsHub.Ragebot.Enabled and mopsHub.Functions.getCharacter(v) and mopsHub.Functions.isAlive(v) and v.Team ~= Player.Team and v ~= Player and mopsHub.Client.isAlive and mopsHub.Client.ActiveWeapon and mopsHub.Client.CurrentGunIndex < 3 and mopsHub.Client.replicatedPosition then
            local weaponData = mopsHub.Functions.GetRegistryWeaponData(mopsHub.Client.ActiveWeapon)
            local hitboxPosition = mopsHub.Functions.getCharacter(v)[mopsHub.Ragebot.Target_Hitbox].Position
            local bulletspeed = weaponData.bulletspeed
            local firerate = type(mopsHub.Client.ActiveWeapon._weaponData.firerate) == "table" and mopsHub.Client.ActiveWeapon._weaponData.firerate[1] or mopsHub.Client.ActiveWeapon._weaponData.firerate
            local penetrationdepth = weaponData.penetrationdepth
            if mopsHub.Client.ActiveWeapon._magCount == 0 then
                mopsHub.Functions.reloadWeapon()
            end
            if mopsHub.Functions.Rage_Bot.checkFireRate(firerate) and mopsHub.Client.ActiveWeapon._magCount ~= 0 then
                local firePos, velocity = mopsHub.Functions.Rage_Bot.checkBullet(
                    mopsHub.Client.replicatedPosition,
                    hitboxPosition,
                    9.9,
                    penetrationdepth,
                    bulletspeed
                )
                if firePos then
                    print(firePos)
                    local ctime = mopsHub.Modules.GameGlock.getTime()
                    local bulletcount = debug.getupvalue(mopsHub.Modules.FirearmObject.fireRound, mopsHub.Misc.Rage_Bot.bulletCountIndex)
                    mopsHub.Misc.Rage_Bot.TableInfo = {
                        firepos = firePos,
                        camerapos = mopsHub.Client.replicatedPosition,
                        bullets = { { velocity, bulletcount } }
                    }
                    mopsHub.Modules.network:send("newbullets", mopsHub.Misc.Rage_Bot.TableInfo, ctime)
                    mopsHub.Modules.network:send("bullethit", v, hitboxPosition, mopsHub.Ragebot.Target_Hitbox, bulletcount, ctime)
                    mopsHub.Client.ActiveWeapon._magCount -= 1
                    mopsHub.Misc.Rage_Bot.Target = v
                    mopsHub.Misc.Rage_Bot.LastFire = tick()
                    bulletcount += 1
                    debug.setupvalue(mopsHub.Modules.FirearmObject.fireRound, mopsHub.Misc.Rage_Bot.bulletCountIndex, bulletcount)
                    break;
                end
            end
        end
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
        local found_part = model ~= nil and model:FindFirstChild('Torso')
        return found_part
    end;

    function esp.validate(player)
        local plr_character = esp.get_char(player)
        if plr_character and plr_character:FindFirstChild('Torso') then
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
            local rootpart = character:FindFirstChild('Torso')
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
                        array.tracer.From = Vector2.new(screenpos.X, screenpos.Y) + Vector2.new(0, size.Y / 2)
                        array.tracer.To = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/mopsHub.ESP.TracerAttachShift or 1)
                        array.tracer.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TracerColor
                    else
                        array.tracer.Visible = false
                    end
                    if mopsHub.ESP.Chams then
                        array.highlight.Parent = CoreGui
                        array.highlight.Adornee = character
                        array.highlight.Enabled = true
                        array.highlight.FillColor = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.ChamsFillColor
                        array.highlight.DepthMode = 'AlwaysOnTop'
                        array.highlight.OutlineColor = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.ChamsOutlineColor
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
                            array.box.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.BoxColor
                        --end
                        array.box_outline.Size = size
                        array.box_outline.Position = position
                        array.box_outline.Visible = false
                        array.box_outline.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.BoxColor
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
                            array.name.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
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
                            array.distance.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
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
                                array.distance_bold.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
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
                        array.health.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
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
                            array.tool.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
                        --end
                        array.tool.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
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
                                array.tool_bold.Color = (mopsHub.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or mopsHub.ESP.TextColor
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
                if mopsHub.Settings._DEBUG then rconsoleerr('[mopsHub Debug - Error]: '..tostring(e)) end
                esp.setall(array,'Visible', false)
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
    getgenv().esp_loop = RunService.RenderStepped:Connect(function()
        for player, drawings in next, esp.cache do
            if drawings and player then
                esp.update_esp(player, drawings);
            end
        end
    end)
    getgenv().esp = esp
end)

--Walkspeed Modification
mopsHub.Connections["_walkSpeedModification"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Modules.CharacterInterface.isAlive() and mopsHub.Character_Modifications.WalkSpeed.Enabled then
        local travel = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            travel += Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
        end; if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            travel -= Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
        end; if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            travel += Vector3.new(-Camera.CFrame.LookVector.Z, 0, Camera.CFrame.LookVector.X)
        end; if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            travel += Vector3.new(Camera.CFrame.LookVector.Z, 0, -Camera.CFrame.LookVector.X)
        end

        travel = travel.Unit
        local newDir = Vector3.new(travel.X * mopsHub.Character_Modifications.WalkSpeed.Speed, Player.Character:FindFirstChild("HumanoidRootPart").Velocity.y, travel.Z * mopsHub.Character_Modifications.WalkSpeed.Speed)
        if travel.Unit.X == travel.Unit.X then
            Player.Character:FindFirstChild("HumanoidRootPart").Velocity = newDir
        end
    end
end)

--Infinite Jump
mopsHub.Functions.spawnTask(function()
    local function Action(Object, Function) if Object ~= nil then Function(Object); end end
    game:GetService('UserInputService').InputBegan:Connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
            if not mopsHub.Character_Modifications.InfiniteJump.Enabled then return end
            if not Player.Character or not Player.Character:FindFirstChildOfClass("Humanoid") then return end
            Action(Player.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(Root)
                        Root.Velocity = Vector3.new(0, mopsHub.Character_Modifications.InfiniteJump.JumpHeight or 50, 0);
                    end)
                end
            end)
        end
    end)
end)

--Gun Mods
mopsHub.Connections["_gunMods"] = mopsHub.Functions.renderStepped:Connect(function()
    if not mopsHub.Client.WeaponRegistries then return end
    for _,registry in pairs(mopsHub.Client.WeaponRegistries) do
        local weaponData = mopsHub.Functions.GetRegistryWeaponData(registry)
        if not weaponData then return end

        setreadonly(weaponData, false)

        --Instant Equip
        if mopsHub.Gun_Mods.InstantEquip and weaponData.equipspeed then weaponData.equipspeed = tick() end

        --Instant Reload [1]
        --if mopsHub.Gun_Mods.InstantReload and weaponData.animations then
        --    for _,anim in pairs(weaponData.animations) do
        --        if typeof(anim) == "table" then
        --            if string.find(string.lower(_), "reload") then
        --                anim.timescale = 0.01
        --            end
        --        end
        --    end
        --end

        --Instant Reload [2]
        if mopsHub.Gun_Mods.InstantReload and mopsHub.Client.ActiveWeapon and typeof(tonumber(mopsHub.Client.ActiveWeapon._magCount)) == "number" then
            if tonumber(mopsHub.Client.ActiveWeapon._magCount) <= 1 then
                mopsHub.Functions.reloadWeapon()
            end
        end

        --Instant Reload Cancel
        if mopsHub.Gun_Mods.InstantReloadCancel and registry._reloadCancelTime then registry._reloadCancelTime = 0 end

        --Automatic Weapon
        if mopsHub.Gun_Mods.FullAuto and weaponData.firemodes then weaponData.firemodes = { true } end

        --No Recoil
        if mopsHub.Gun_Mods.NoRecoil and weaponData.camkickmax then
            local newWeaponData = {
                aimrotkickmin = Vector3.new(0,0,0),
                aimrotkickmax = Vector3.new(0,0,0),
                aimtranskickmin = Vector3.new(0,0,0),
                aimtranskickmax = Vector3.new(0,0,0),
                aimcamkickmin = Vector3.new(0,0,0),
                aimcamkickmax = Vector3.new(0,0,0),
                rotkickmin = Vector3.new(0,0,0),
                rotkickmax = Vector3.new(0,0,0),
                transkickmin = Vector3.new(0,0,0),
                transkickmax = Vector3.new(0,0,0),
                camkickmin = Vector3.new(0,0,0),
                camkickmax = Vector3.new(0,0,0),
            }

            for d,v in pairs(newWeaponData) do
                if weaponData[d] then weaponData[d] = v end
            end

            mopsHub.Modules.MainCameraObject.setSway = function(self, a)
                return mopsHub.Misc.old.setSway(self, 0)
            end
            mopsHub.Modules.MainCameraObject.shake = function(self, a)
                return mopsHub.Misc.old.shake(self, Vector3.zero)
            end
        end

        --No Spread
        if mopsHub.Gun_Mods.NoSpread and weaponData.hipfirespreadrecover then
            weaponData.hipfirespreadrecover = 100
            weaponData.hipfirespread = 0
            weaponData.hipfirestability = 0
        end
        setreadonly(weaponData, true)
    end

    mopsHub.Modules.FirearmObject.walkSway = function(...)
        if mopsHub.Gun_Mods.NoSway then
            return CFrame.new()
        end
        return mopsHub.Misc.old.walkSway(...)
    end
    mopsHub.Modules.FirearmObject.gunSway = function(...)
        if mopsHub.Gun_Mods.NoSway then
            return CFrame.new()
        end
        return mopsHub.Misc.old.gunSway(...)
    end
    mopsHub.Modules.MeleeObject.walkSway = function(...)
        if mopsHub.Gun_Mods.NoSway then
            return CFrame.new()
        end
        return mopsHub.Misc.old.meleeSway(...)
    end
    mopsHub.Modules.MeleeObject.meleeSway = function(...)
        if mopsHub.Gun_Mods.NoSway then
            return CFrame.new()
        end
        return mopsHub.Misc.old.meelWalkSway(...)
    end
end)

--Third Person
mopsHub.Functions.spawnTask(function()
    local player = Instance.new("Player")
    mopsHub.Client.FakeRepObject = mopsHub.Modules.ReplicationObject.new(player)
    mopsHub.Client.FakeRepObject._player = Player
    player:Destroy()
    player = nil

    if mopsHub.Modules.CharacterInterface:isAlive() and mopsHub.Client.Controller and mopsHub.Client.FakeRepObject then
        mopsHub.Client.FakeRepObject._activeWeaponRegistry[1] = {
            weaponName = mopsHub.Functions.getActiveWeapon[1]._weaponName,
            weaponData = mopsHub.Functions.getActiveWeapon[1]._weaponData,
            attachmentData = mopsHub.Functions.getActiveWeapon[1]._weaponAttachments,
            camoData = mopsHub.Functions.getActiveWeapon[1]._camoList
        }
        mopsHub.Client.FakeRepObject._activeWeaponRegistry[2] = {
            weaponName = mopsHub.Functions.getActiveWeapon[2]._weaponName,
            weaponData = mopsHub.Functions.getActiveWeapon[2]._weaponData,
            attachmentData = mopsHub.Functions.getActiveWeapon[2]._weaponAttachments,
            camoData = mopsHub.Functions.getActiveWeapon[2]._camoList
        }
        mopsHub.Client.FakeRepObject._activeWeaponRegistry[3] = {
            weaponName = mopsHub.Functions.getActiveWeapon[3]._weaponName,
            weaponData = mopsHub.Functions.getActiveWeapon[3]._weaponData,
            camoData = mopsHub.Functions.getActiveWeapon[3]._camoData
        }
        mopsHub.Client.FakeRepObject._activeWeaponRegistry[4] = {
            weaponName = mopsHub.Functions.getActiveWeapon[4]._weaponName,
            weaponData = mopsHub.Functions.getActiveWeapon[4]._weaponData
        }
        mopsHub.Client.FakeRepObject._thirdPersonObject = mopsHub.Modules.ThirdPersonObjectnew(mopsHub.Client.FakeRepObjec._player, nil, mopsHub.Client.FakeRepObjec)
        mopsHub.Client.FakeRepObject._thirdPersonObject:equip(1, true)
        mopsHub.Client.FakeRepObject._alive = true
    end
end)

--Bunny Hop
mopsHub.Connections["_bunnyHop"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Character_Modifications.Bunny_Hop.Enabled and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        if mopsHub.Client.CharacterObject and mopsHub.Client.Controller then
            if mopsHub.Client.CharacterObject._floorMaterial == Enum.Material.Air then return end
            local power = 4
            if mopsHub.Client.ActiveWeapon:getWeaponType() == "Melee" then
                power = power * 1.15
            end
            local velocity_y = mopsHub.Client.CharacterObject._rootPart.Velocity.y
            power = power and (2 * game.Workspace.Gravity * power) ^ 0.5 or 40
            local jump_power = power if velocity_y < 0 then jump_power = power end
            if mopsHub.Client.CharacterObject._movementMode == "prone" or mopsHub.Client.CharacterObject._movementMode == "crouch" then
                mopsHub.Client.CharacterObject:setMovementMode("stand")
                return
            end
            if mopsHub.Client.ActiveWeapon:getWeaponType() == "Firearm" and mopsHub.Client.ActiveWeapon:isAiming() then
                mopsHub.Client.CharacterObject._humanoid.JumpPower = jump_power
                mopsHub.Client.CharacterObject._humanoid.Jump = true
                return true
            end
            mopsHub.Client.CharacterObject._humanoid.JumpPower = jump_power
            mopsHub.Client.CharacterObject._humanoid.Jump = true
        end
    end
end)

--FOV Circles
mopsHub.Connections["_fovCircles"] = mopsHub.Functions.renderStepped:Connect(function()
    mopsHub.Functions.Silent_Aim.updateFOV()
    mopsHub.Functions.Aim_Assist.updateFOV()
end)

--Automatic Actions
mopsHub.Connections["_automaticActions"] = mopsHub.Functions.renderStepped:Connect(function()
    --Auto Respawn
    if mopsHub.Automatic_Actions.AutoRespawn then
        if mopsHub.Misc.MenuScreenGui.Enabled == true and not mopsHub.Client.isAlive then
            mopsHub.Functions.spawnTask(function()
                task.wait(1)
                if mopsHub.Misc.MenuScreenGui.Enabled == true and not mopsHub.Client.isAlive then
                    mopsHub.Modules.CharacterInterface.spawn()
                end
            end)
        end
    end

    --Server Hop on votekick
    if mopsHub.Automatic_Actions.JoinNewServerOnVoteKick then
        local s,e = pcall(function()
            mopsHub.Functions.spawnTask(function()
                if mopsHub.Misc.DisplayVoteKick.Visible == true then
                    if mopsHub.Settings._DEBUG and mopsHub.votekick_logstate == 0 then mopsHub.votekick_logstate = 1 rconsoleprint("[mopsHub - Debug]: votekick prompt visible") end
                    local str = mopsHub.Misc.DisplayVoteKick.TextTitle.Text
                    if string.find(str, Player.Name) then
                        if mopsHub.Settings._DEBUG and mopsHub.votekick_logstate == 1 then mopsHub.votekick_logstate = 2 rconsolewarn("[mopsHub - Debug]: votekick initiated on localplayer") end
                        if mopsHub.votekick_logstate == 2 then
                            local servers = mopsHub.Functions.Automatic_Actions.getServers()
                            if servers then
                                mopsHub.votekick_logstate = 3
                                local _server = math.random(1,#servers.data)
                                local _serverid = servers.data[_server].id
                                if mopsHub.Settings._DEBUG then rconsolewarn("[mopsHub - Debug]: new server found > instanceId: ".. _serverid) end
                                task.wait(2)
                                TeleportService:TeleportToPlaceInstance(game.PlaceId, _serverid)
                            end
                        end
                    end
                else mopsHub.votekick_logstate = 0
                end
            end)
        end)
        if not s and mopsHub.Settings._DEBUG then return rconsoleerr("[mopsHub Debug - Error]: ".. e) end
    else mopsHub.votekick_logstate = 0
    end
end)

--Client Unlocks
mopsHub.Connections["_clientunlocks"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Client.isAlive ~= true then
        mopsHub.Functions.Unlocks.unlockType("Guns", mopsHub.Unlock.Guns)
        mopsHub.Functions.Unlocks.unlockType("Knifes", mopsHub.Unlock.Knifes)
        mopsHub.Functions.Unlocks.unlockType("Grenades", mopsHub.Unlock.Grenades)
        mopsHub.Functions.Unlocks.unlockType("Attachments", mopsHub.Unlock.Attachments)
    end
end)

--Gun Customization
mopsHub.Connections["_gunCustomization"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Gun_Customization.Enabled then
        if mopsHub.Client.isAlive and mopsHub.Client.ActiveWeapon then
            local OldWDataColor = mopsHub.Misc.OldWeaponPartData.Color
            if not OldWDataColor then OldWDataColor = {} end
            if not OldWDataColor[mopsHub.Client.ActiveWeapon._weaponName] then
                OldWDataColor[mopsHub.Client.ActiveWeapon._weaponName] = {}
                for _,v in pairs(mopsHub.Client.ActiveWeapon._weaponModel:GetChildren()) do
                    if v:IsA("BasePart") then
                        table.insert(OldWDataColor[mopsHub.Client.ActiveWeapon._weaponName], {})
                        OldWDataColor[mopsHub.Client.ActiveWeapon._weaponName][v.Name] = v.Color
                    end
                end
            end;
            local OldWDataMaterial = mopsHub.Misc.OldWeaponPartData.Material
            if not OldWDataMaterial[mopsHub.Client.ActiveWeapon._weaponName] then
                OldWDataMaterial[mopsHub.Client.ActiveWeapon._weaponName] = {}
                for _,v in pairs(mopsHub.Client.ActiveWeapon._weaponModel:GetChildren()) do
                    if v:IsA("BasePart") then
                        table.insert(OldWDataMaterial[mopsHub.Client.ActiveWeapon._weaponName], {})
                        OldWDataMaterial[mopsHub.Client.ActiveWeapon._weaponName][v.Name] = v.Material
                    end
                end
            end
            for _,v in pairs(mopsHub.Client.ActiveWeapon._weaponModel:GetChildren()) do
                if v:IsA("BasePart") then
                    if not table.find(mopsHub.Misc.IgnoredWeaponParts.IgnoredInstances, v.Name) then
                        v.Transparency = mopsHub.Gun_Customization.Transparency
                    end
                    if not mopsHub.Gun_Customization.Rainbow then
                        v.Color = mopsHub.Gun_Customization.GunColor
                    end
                    v.Material = mopsHub.Gun_Customization.Material
                    --if mopsHub.Gun_Customization.Image ~= nil and typeof(tonumber(mopsHub.Gun_Customization.Image)) == "number" then
                    --    if v:FindFirstChildOfClass("Decal") then return end
                    --    local Decal = Instance.new("Decal")
                    --    Decal.Texture = string.format("rbxassetid://%s", mopsHub.Gun_Customization.Image)
                    --    Decal.Parent = v
                    --end
                end
            end
        else
            --mopsHub.Misc.OldWeaponPartData.Color = {}
            --mopsHub.Misc.OldWeaponPartData.Material = {}
        end
    --else
    --    if mopsHub.Client.isAlive and mopsHub.Client.ActiveWeapon then
    --        for _,v in pairs(mopsHub.Client.ActiveWeapon._weaponModel:GetChildren()) do
    --            if v:IsA("BasePart") then
    --                if not table.find(mopsHub.Misc.IgnoredWeaponParts.IgnoredInstances, v.Name) then
    --                    v.Transparency = 0
    --                end
    --                if mopsHub.Misc.OldWeaponPartData.Color[mopsHub.Client.ActiveWeapon._weaponName] then
    --                    v.Color = mopsHub.Misc.OldWeaponPartData.Color[mopsHub.Client.ActiveWeapon._weaponName][v.Name]
    --                    v.Material = mopsHub.Misc.OldWeaponPartData.Material[mopsHub.Client.ActiveWeapon._weaponName][v.Name]
    --                end
    --                if v:FindFirstChildOfClass("Decal") then v:FindFirstChildOfClass("Decal"):Destroy() end
    --            end
    --        end
    --    else
    --        mopsHub.Misc.OldWeaponPartData.Color = {}
    --        mopsHub.Misc.OldWeaponPartData.Material = {}
    --    end
    end
end)

--Rainbow Gun
mopsHub.Connections["_rainbowGun"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Gun_Customization.Enabled and mopsHub.Gun_Customization.Rainbow and mopsHub.Client.isAlive then
        for _, v in pairs(Camera:FindFirstChild("Main"):GetDescendants()) do
            if not table.find(mopsHub.Misc.IgnoredWeaponParts.IgnoredInstances, v.Name) then
                mopsHub.Functions.spawnTask(function()
                    if v:IsA("BasePart") then
                        v.Color = Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)
                    end
                end)
            end
        end
    end
end)

--Rainbow Arms
mopsHub.Connections["_rainbowArms"] = mopsHub.Functions.renderStepped:Connect(function()
    if mopsHub.Arm_Customization.Enabled and mopsHub.Arm_Customization.Rainbow and mopsHub.Client.isAlive then
        for _, v in pairs(Camera:GetDescendants()) do
            if not v:IsDescendantOf(Camera:FindFirstChild("Main")) then
                if not table.find(mopsHub.Misc.IgnoredWeaponParts.IgnoredInstances, v.Name) then
                    mopsHub.Functions.spawnTask(function()
                        if v:IsA("BasePart") then
                            v.Color = Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)
                            v.Material = Enum.Material.ForceField
                            v.Transparency = 0.8
                        end
                    end)
                end
            end
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

mopsHub._loaded = true
getgenv().mopsHub = mopsHub

printconsole(string.format("[mopsHub]: Framwork loaded in %s second(s).", tick()-_startTick))