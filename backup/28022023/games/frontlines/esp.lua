_G.ESP = {
    Boxes = true,
    Tracers = true,
    Rainbow = true,
}

--ESPfrom my phantom forces script. (ass messy but works)

if getgenv().esp_loop then getgenv().esp_loop:Disconnect() end

--Variables
local RunService = game:GetService("RunService")
local Camera = game:GetService("Workspace").CurrentCamera

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

--ESP
task.spawn(function()
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

    function esp.remove_plr(player)
        if rawget(esp.cache,player) then 
            for i,v in pairs(esp.cache[player]) do
                v:Remove()
            end;
            esp.cache[player] = nil;
        end;
    end;

    function esp.check(player)
        local can_pass = true
        if player:FindFirstChild("friendly_marker") then can_pass = false end
        if not player.Parent == workspace then can_pass = false end

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
        plr_tab.highlight = esp.inst('Highlight',{
        });
        esp.cache[player] = plr_tab;
    end

    function esp.update_esp(player,array)
        local rootpart = player:FindFirstChild('HumanoidRootPart')
        local screenpos, onscreen = Camera.WorldToViewportPoint(Camera, rootpart.Position)
        local scale_factor = 1 / (screenpos.Z * math.tan(math.rad(Camera.FieldOfView * 0.5)) * 2) * 100
        local width, height = math.floor(45 * scale_factor), math.floor(65 * scale_factor)
        local size = Vector2.new(width,height)
        if size.X < 3 or size.Y < 6 then
            size = Vector2.new(5,10)
        end
        local position = Vector2.new(screenpos.X - size.X / 2,screenpos.Y - size.Y / 2)
        position = Vector2.new(math.floor(position.X),math.floor(position.Y))
        local check = esp.check(player)
        local s, e = pcall(function()
            if onscreen and check then
                if _G.ESP and _G.ESP.Tracers or true then
                    array.tracer.Visible = true
                    array.tracer.From = Vector2.new(screenpos.X, screenpos.Y) + Vector2.new(0, size.Y / 2)
                    array.tracer.To = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/1 or 1)
                    array.tracer.Color = (_G.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or Color3.new(1,1,1)
                else
                    array.tracer.Visible = false
                end
                if _G.ESP and _G.ESP.Boxes or true then
                    array.box.Visible = true
                    array.box.Size = size
                    array.box.Position = position
                    array.box.Color = (_G.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or Color3.new(1,1,1)
                    array.box_outline.Size = size
                    array.box_outline.Position = position
                    array.box_outline.Visible = false
                    array.box_outline.Color = (_G.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or Color3.new(1,1,1)
                    array.inner_box.Size = Vector2.new(array.box.Size.X-3,array.box.Size.Y-3)
                    array.inner_box.Position = Vector2.new(position.X+1.5,position.Y+1.5)
                    array.inner_box.Transparency = 0.5
                    array.inner_box.Color = (_G.ESP.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)) or Color3.new(1,1,1)
                    array.inner_box.Visible = false
                else
                    array.box.Visible = false
                end
            else
                esp.setall(array, 'Visible', false)
            end
        end)
        if not s and e then
            printconsole(e,255,0,0)
            esp.setall(array,'Visible', false)
            array.highlight.Enabled = false
        end
    end

    for i,v in next, workspace:GetChildren() do
        if v.Name == "soldier_model" then
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
    getgenv().esp_loop = RunService.RenderStepped:Connect(function()
        for player, drawings in next, esp.cache do
            if drawings and player then
                esp.update_esp(player, drawings);
            end
        end
    end)
    getgenv().esp = esp
end)