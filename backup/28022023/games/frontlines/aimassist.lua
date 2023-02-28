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

repeat task.wait() until game:IsLoaded() task.wait()
if getgenv()._circle then getgenv()._circle:Remove() end
if getgenv()._Connections then
    for _,v in pairs(getgenv()._Connections) do
        v:Disconnect()
    end
end

local globals, utils, enums do
	local ctr = 0;
	while true do
		local gc = getgc(true)
		for i = 1, #gc do
			local o = gc[i]
			if type(o) == 'table' then
				if rawget(o, 'gbl_sol_state') and rawget(o, 'fpv_sol_recoil') then
					globals = o;
				elseif rawget(o, 'sol_state_class') and rawget(o, 'sol_firearm_operation') then
					enums = o;
				elseif rawget(o, 'gbus') and rawget(o.gbus, 'EVENT_ENUM') then
					utils = o;
				end
			end
		end
		if enums and globals and utils then break end
	end
end

local event_enum = utils.gbus.EVENT_ENUM

local global_sol_state = globals.gbl_sol_state
local fpv_sol_recoil = globals.fpv_sol_recoil
local fpv_sol_spread = globals.fpv_sol_spread
local fpv_sol_equipment = globals.fpv_sol_equipment
local fpv_sol_multipliers = globals.fpv_sol_multipliers
local soldier_models = globals.soldier_models

local sol_root_parts = globals.sol_root_parts
local sol_state_class = enums.sol_state_class;
local sol_firearm_operation = enums.sol_firearm_operation;
local sol_time_sequence_value = enums.sol_time_sequence_value;

--Variables
local HttpService = game:GetService("HttpService")
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

local map = workspace:FindFirstChild("workspace")

_G.Aim_Assist = {
    Enabled = true,

    FOV = 180,
    FOV_Color = Color3.fromRGB(0,255,0),
    VisibleCheck = true,
    Smoothness = 1.5,
    TargetHitbox = "Head",

    --Dont Edit
    Active = false,
    _target = { part = nil, position = nil },
}
local Connections = {}
local Parts = {
    ["Head"] = "TPVBodyVanillaHead",
    ["Torso"] = "TPVBodyVanillaTorsoFront",
}

--Functions
local function check(sol)
    local can_pass = true
    if not (sol.Name == "soldier_model") then can_pass = false end
    if not sol.Parent == workspace then can_pass = false end
    if sol:FindFirstChild("friendly_marker") then can_pass = false end

    return can_pass;
end;

local function isVisible(Position, Ignore)
    Ignore = Ignore or { workspace.Terrain, workspace.CurrentCamera }
    return #Camera:GetPartsObscuringTarget({ Position }, Ignore) == 0
end

local function getClosest()
    local _position, _part;
    for _, sol in pairs(workspace:GetChildren()) do
        if check(sol) then
            local part = sol[Parts[_G.Aim_Assist.TargetHitbox]] or sol[Parts.Head]
            local position = part.Position
            local screenPosition, visible = Camera:WorldToScreenPoint(position)
            local p1, p2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(screenPosition.X, screenPosition.Y)
            local magnitude = (p2 - p1).Magnitude

             if visible and isVisible(position) and magnitude < _G.Aim_Assist.FOV then
                _position = screenPosition;
                _part = part;
            end
        end
    end
    return _position, _part;
end

--Main

local circle = Drawing.new("Circle"); circle.Thickness = 2; circle.NumSides = 999; circle.Filled = false; circle.Transparency = 0.6

Connections["_aimassist_update"] = RunService.RenderStepped:Connect(function()
    if _G.Aim_Assist.Enabled then
        circle.Radius = _G.Aim_Assist.FOV
        circle.Color = _G.Aim_Assist.FOV_Color
        circle.Position = UserInputService:GetMouseLocation()

        local position, part = getClosest()
        if position and part then
            _G.Aim_Assist._target.part = part
            _G.Aim_Assist._target.position = position
        end
    end
    circle.Visible = _G.Aim_Assist.Enabled
end)

Connections["_aimassist_inputbegan"] = UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and _G.Aim_Assist.Enabled then
        _G.Aim_Assist.Active = true
        while _G.Aim_Assist.Active and _G.Aim_Assist.Enabled do task.wait()
            if _G.Aim_Assist._target.position ~= nil then
                local mousePosition = Camera:WorldToScreenPoint(Mouse.Hit.Position)
                local targetPosition = _G.Aim_Assist._target.position
                mousemoverel((targetPosition.X - mousePosition.X) / 5, (targetPosition.Y - mousePosition.Y) / 5)
            end
        end
    end
end)
Connections["_aimassist_inputended"] = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and _G.Aim_Assist.Enabled then
        _G.Aim_Assist.Active = false
    end
end)

getgenv()._Connections = Connections
getgenv()._circle = circle