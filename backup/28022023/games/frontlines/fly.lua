local globals = getrenv()._G.globals

local getHumanoid = function() return globals.fpv_sol_instances.humanoid end
local getRootPart = function() return globals.fpv_sol_instances.root end

local humanoid = getHumanoid()
local root = getRootPart()
local flying,bv,bav,h,c,cam,nc,Clip,rstr
local p = game.Players.LocalPlayer
local buttons = {W = false, S = false, A = false, D = false, Moving = false}

game:GetService("UserInputService").InputBegan:Connect(function (input, GPE)
    if GPE then return end
    for i, e in pairs(buttons) do
        if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
            buttons[i] = true
            buttons.Moving = true
        end
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function (input, GPE)
    if GPE then return end
    local a = false
    for i, e in pairs(buttons) do
        if i ~= "Moving" then
            if input.KeyCode == Enum.KeyCode[i] then
                buttons[i] = false
            end
            if buttons[i] then a = true end
        end
    end
    buttons.Moving = a
end)

local setVec = function (vec)
    return vec * (10 / vec.Magnitude)
end

game:GetService("RunService").Heartbeat:Connect(function(step)
    if flying and c then
        local _p = c.Position
        local cf = cam.CFrame
        local ax, ay, az = cf:toEulerAnglesXYZ()
        c.CFrame = (CFrame.new(_p.X, _p.Y, _p.Z) * CFrame.Angles(ax, ay, az))
        if buttons.Moving then
            local t = Vector3.new()
            if buttons.W then t = t + (setVec(cf.lookVector)) end
            if buttons.S then t = t - (setVec(cf.lookVector)) end
            if buttons.A then t = t - (setVec(cf.rightVector)) end
            if buttons.D then t = t + (setVec(cf.rightVector)) end
            c:TranslateBy(t * step)
        end
    end
end)

if not root or flying then return end
c = root
h = humanoid
h.PlatformStand = true
cam = workspace:WaitForChild('Camera')
bv = Instance.new("BodyVelocity")
bav = Instance.new("BodyAngularVelocity")
bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
bv.Parent = c:FindFirstChild("TPVBodyVanillaHead")
bav.Parent = c:FindFirstChild("TPVBodyVanillaHead")
flying = true
h.Died:Connect(function() flying = false end)