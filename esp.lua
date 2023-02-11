if getgenv().esp then getgenv().esp:unload() end 
local game_client = loadstring(game:HttpGet('https://raw.githubusercontent.com/LURKLURKLURKLURKLURKLURKLURKLURK/pf/main/game_client.lua'))()

local players,runservice,replicatedstorage = game.GetService(game,'Players'),game.GetService(game,'RunService'),game.GetService(game,'ReplicatedStorage')
local camera,plr = workspace.CurrentCamera,players.LocalPlayer
local findfirstchild,findfirstchildofclass,findfirstancestor = game.FindFirstChild,game.FindFirstChildOfClass,game.FindFirstAncestor;
local wtvp, wtsp = camera.WorldToViewportPoint,camera.WorldToScreenPoint; 
local mfloor,mabs,mround,mclamp,cos,atan2,sin,rad = math.floor,math.abs,math.round,math.clamp,math.cos,math.atan2,math.sin,math.rad;
local v2,v3,cf,c3rgb,c3new,gbb = Vector2.new,Vector3.new,CFrame.new,Color3.fromRGB,Color3.new,workspace.GetBoundingBox;

local esp = {
    highlight_target = {enabled = false, color = c3rgb(255,0,0),target = ''},
    teamcheck        = false,
    enabled          = false, 
    boldtext         = false, 
    limitdistance    = false,
    renderdistance   = 50,
    outlines         = {enabled = false, color = c3rgb(0,0,0)},
    fontsize         = 13,
    font             = 2,
    text             = {enabled = false, color = c3rgb(255,255,255)},
    misc_layout      = {
        ['arrows']    = {transparency = 1, enabled = false, size = 15, color = c3rgb(255,255,255),radius = 500},
        ['box']       = {inner = false, inner_trans = 0.5, inner_color = c3rgb(0,0,0), enabled = false, color = c3rgb(255,255,255)},
        ['health']    = {enabled = false, lower = c3rgb(255,0,0),higher = c3rgb(0,255,0)},
        ['highlight'] = {enabled = false, outline = c3rgb(255,255,255),fill = c3rgb(255,255,255),outlinetrans = 0,filltrans = 1},
    },
    text_layout      = {
        ['health']   = {enabled = false},
        ['name']     = {enabled = false},
        ['distance'] = {enabled = false},
        ['tool']     = {enabled = false},
    },
    cache = {},
};

function esp:unload()
    for i,v in next, esp.cache do 
        getgenv().esp.remove_plr(i)
    end
    getgenv().esp_loop = nil 
end

function game_client:get_character(plr)
    local player  = game_client.replication_interface.getEntry(plr) 
    
    if player then 
        local tp_object = player._thirdPersonObject 
        if tp_object then 
            return tp_object._character
        end
    end
end

function game_client:get_health(plr)
    local player = game_client.replication_interface.getEntry(plr)
    if player then 
        return player._healthstate.health0, player._healthstate.maxhealth 
    end
end

function game_client:check_status(plr)
    local player = game_client.replication_interface.getEntry(plr)
    
    if player then 
        return player._alive 
    end
end

function game_client:get_tool(plr)
    local player = game_client.replication_interface.getEntry(plr)
    if player then 
        local tp_object = player._thirdPersonObject 
        if tp_object then 
            return tp_object._weaponname or ''
        end
    end
end
function esp.rotatev2(V2, r)
    local c = math.cos(r);
    local s = math.sin(r);
    return v2(c * V2.X - s * V2.Y, s * V2.X + c * V2.Y);
end;
function esp.getmagnitude(p1,p2)
    return (p1 - p2).Magnitude
end;

function esp.get_char(player)
    local CHARACTER = game_client:get_character(player)
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
    if not s and e then printconsole('pie.solutions ER: '..tostring(e)) end 
    return INEW
end;

function esp.draw(drawing,prop)
    local NEWDRAWING = Drawing.new(drawing)
    
    local s, e = pcall(function()
        for i,v in next, prop do 
            NEWDRAWING[i] = v 
        end
    end)
    if not s and e then printconsole('pie.solutions ER: '..tostring(e)) end
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
        esp.cache[player] = nil ;
    end;
end;

function esp.check(player)
    local alive_status = game_client:check_status(player)
    local character = game_client:get_character(player)
    local team = player.Team 
    
    local can_pass = false 
    local status_pass = false 
    local team_pass = false 
    
    if character then 
        if alive_status then 
            status_pass = true
        end
        if team ~= plr.Team then 
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
    plr_tab.arrow_outline = esp.draw('Triangle',{
        Thickness = 3,
        Filled = false,
    });
    plr_tab.arrow = esp.draw('Triangle',{
        Thickness = 1,
        Filled = true,
    });
    esp.cache[player] = plr_tab;
end

function esp.update_esp(player,array)
    if esp.validate(player) then
        local character = esp.get_char(player)
        local rootpart = character:FindFirstChild('Torso') 
        local health, max_health = game_client:get_health(player)
        
        local screenpos, onscreen = wtvp(camera, rootpart.Position)
        local scale_factor = 1 / (screenpos.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 100
        local width, height = math.floor(45 * scale_factor), math.floor(65 * scale_factor)
        local size = Vector2.new(width,height)
        if size.X < 3 or size.Y < 6 then 
		    size = v2(5,10) -- makes it look proper at distance 
		end
        local position = Vector2.new(screenpos.X - size.X / 2,screenpos.Y - size.Y / 2)

		position = v2(mfloor(position.X),mfloor(position.Y))
		local bottom_bounds = 0
        local top_bounds = 0 
        local bottom_offset = v2(mfloor(size.X / 2 + position.X), mfloor(size.Y + position.Y + 1))
        local top_offset = v2(mfloor(size.X / 2 + position.X), mfloor(position.Y - 16))
        
		local distance = esp.getmagnitude(rootpart.Position,camera.CFrame.p)
		local check = esp.check(player)
		local s, e = pcall(function()
		    if not onscreen and check and esp.enabled then
		        if esp.misc_layout['arrows'].enabled then 
    		        local proj = camera.CFrame:PointToObjectSpace(rootpart.CFrame.p);
                    local ang  = atan2(proj.Z, proj.X);
                    local dir  = v2(cos(ang), sin(ang));
                    local a    = (dir * esp.misc_layout['arrows'].radius * .5) + camera.ViewportSize / 2;
                    local b, c = a - esp.rotatev2(dir, rad(35)) * esp.misc_layout['arrows'].size, a - esp.rotatev2(dir, -rad(35)) * esp.misc_layout['arrows'].size
                    array.arrow_outline.PointA = a;
                    array.arrow_outline.PointB = b;
                    array.arrow_outline.PointC = c;
                    
                    array.arrow.PointA = a;
                    array.arrow.PointB = b;
                    array.arrow.PointC = c;
                    array.arrow.Color = esp.misc_layout['arrows'].color 
                    array.arrow.Transparency = esp.misc_layout['arrows'].transparency 
                    
                    array.arrow.Visible = true 
                    array.arrow_outline.Visible = esp.outlines.enabled
                    array.arrow_outline.Color = esp.misc_layout['arrows'].color 
                    else 
                        array.arrow_outline.Visible = false 
                        array.arrow.Visible = false
		        end
                else 
                    array.arrow_outline.Visible = false 
                    array.arrow.Visible = false 
		    end
		    if onscreen and check and esp.enabled then
		        if esp.misc_layout['highlight'].enabled then 
		            array.highlight.Parent = game.GetService(game,'CoreGui')
		            array.highlight.Adornee = character 
		            array.highlight.Enabled = true 
		            array.highlight.FillColor = esp.misc_layout['highlight'].fill
		            array.highlight.DepthMode = 'AlwaysOnTop'
		            array.highlight.OutlineColor = esp.misc_layout['highlight'].outline
		            array.highlight.FillTransparency = esp.misc_layout['highlight'].filltrans 
		            array.highlight.OutlineTransparency = esp.misc_layout['highlight'].outlinetrans
		            else 
		                array.highlight.Enabled = false
		        end
	
		        if esp.misc_layout['box'].enabled then
		            
		            array.box.Visible = true 
		            array.box.Size = size
		            array.box.Position = position
		            if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
    		           array.box.Color = esp.highlight_target.color 
    		        else 
    		           array.box.Color = esp.misc_layout['box'].color 
		            end
		            
		            array.box_outline.Size = size 
		            array.box_outline.Position = position
		            array.box_outline.Visible = esp.outlines.enabled
		            array.box_outline.Color = esp.outlines.color
		            
		            array.inner_box.Size = v2(array.box.Size.X-3,array.box.Size.Y-3)
                    array.inner_box.Position = v2(position.X+1.5,position.Y+1.5)
                    array.inner_box.Transparency = esp.misc_layout['box'].inner_trans 
                    array.inner_box.Color = esp.misc_layout['box'].inner_color 
                    array.inner_box.Visible = esp.misc_layout['box'].inner
		            else
		                array.inner_box.Visible = false
		                array.box_outline.Visible = false 
		                array.box.Visible = false 
		        end
		        
		        
		        if esp.misc_layout['health'].enabled then
		            array.healthbar.Transparency = 1 
		            array.healthbar_outline.Transparency = 1
                    array.healthbar.Visible = true 
                    array.healthbar.Color = esp.misc_layout['health'].lower:lerp(esp.misc_layout['health'].higher,health  / max_health);
                    array.healthbar.From = v2((position.X - 5), position.Y + size.Y)
                    array.healthbar.To = v2(array.healthbar.From.X, array.healthbar.From.Y - (health  / max_health) * size.Y)
                    array.healthbar_outline.Visible = esp.outlines.enabled 
                    array.healthbar_outline.Color = esp.outlines.color
                    array.healthbar_outline.From = v2(array.healthbar.From.X, position.Y + size.Y + 1 )
                    array.healthbar_outline.To = v2(array.healthbar.From.X, (array.healthbar.From.Y -1 * size.Y) - 1)
                    else 
                        array.healthbar.Visible = false 
                        array.healthbar_outline.Visible = false
		        end
            
		        if esp.text.enabled then 
		            if esp.text_layout['name'].enabled then
		                array.name.Transparency = 1 
		                array.name_bold.Transparency = 0.5
		                array.name.Visible = true 
		                array.name.Text = tostring(player)
		                array.name.Size = esp.fontsize 
		                array.name.Font = esp.font 
		                if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
    		               array.name.Color = esp.highlight_target.color 
    		            else 
    		               array.name.Color = esp.text.color 
		                end
		                array.name.Outline = esp.outlines.enabled 
		                array.name.OutlineColor = esp.outlines.color 
		                array.name.Position = v2(top_offset.X,top_offset.Y - (top_bounds))
		                if esp.boldtext then 
		                    array.name_bold.Visible = true 
		                    array.name_bold.Size = esp.fontsize 
		                    array.name_bold.Font = esp.font 
		                    if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
    		                    array.name_bold.Color = esp.highlight_target.color 
    		                    else 
    		                       array.name_bold.Color = esp.text.color 
		                    end
		                    array.name_bold.Text = array.name.Text
		                    array.name_bold.Position = v2(array.name.Position.X + 1, array.name.Position.Y)
		                    else 
		                        array.name_bold.Visible = false 
		                end
		                else 
		                    array.name.Visible = false 
		                    array.name_bold.Visible = false 
		            end
		            
		            
		            if esp.text_layout['distance'].enabled then
		                array.distance.Transparency = 1 
		                array.distance_bold.Transparency = 0.5
		                array.distance.Visible = true 
		                array.distance.Text = tostring(mfloor(distance))..'s'
		                array.distance.Size = esp.fontsize 
		                array.distance.Font = esp.font 
		                if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
    		                array.distance.Color = esp.highlight_target.color 
    		            else 
    		                array.distance.Color = esp.text.color 
		                end
		                array.distance.Outline = esp.outlines.enabled 
		                array.distance.OutlineColor = esp.outlines.color 
		                array.distance.Position = v2(bottom_offset.X, bottom_offset.Y + bottom_bounds)
		                bottom_bounds += 14
		                if esp.boldtext then 
		                    array.distance_bold.Visible = true 
		                    array.distance_bold.Size = esp.fontsize 
		                    array.distance_bold.Font = esp.font 
		                    if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
    		                    array.distance_bold.Color = esp.highlight_target.color 
    		                    else 
    		                       array.distance_bold.Color = esp.text.color 
		                    end
		                    array.distance_bold.Text = array.distance.Text
		                    array.distance_bold.Position = v2(array.distance.Position.X + 1, array.distance.Position.Y)
		                    else 
		                        array.distance_bold.Visible = false 
		                end
		                else 
		                    array.distance.Visible = false 
		                    array.distance_bold.Visible = false 
		            end
		            
		            if esp.text_layout['health'].enabled then
		                local From = Vector2.new((position.X - 5), position.Y + size.Y)
		                local To = Vector2.new(From.X, From.Y - 1 * size.Y)
		                array.health.Transparency = 1 
		                array.health_bold.Transparency = 0.5
		                array.health.Visible = true 
		                array.health.Text = tostring(mfloor(health))
		                array.health.Size = esp.fontsize 
		                array.health.Font = esp.font 
		                array.health.Color = esp.text.color
		                array.health.Outline = esp.outlines.enabled 
		                array.health.OutlineColor = esp.outlines.color 
		                array.health.Position = Vector2.new(position.X - 30, To.Y)
		                if esp.boldtext then 
		                    array.health_bold.Visible = true 
		                    array.health_bold.Size = esp.fontsize 
		                    array.health_bold.Font = esp.font 
		                    array.health_bold.Color = array.health.Color
		                    array.health_bold.Text = array.health.Text
		                    array.health_bold.Position = v2(array.health.Position.X + 1, array.health.Position.Y)
		                    else 
		                        array.health_bold.Visible = false 
		                end
		                else 
		                    array.health.Visible = false 
		                    array.health_bold.Visible = false 
		            end
		            
		            
		            if esp.text_layout['tool'].enabled then
		                local tool_found = findfirstchildofclass(character,'Tool')
		                array.tool.Transparency = 1 
		                array.tool_bold.Transparency = 0.5
		                array.tool.Visible = true 
		                array.tool.Text = game_client:get_tool(player)
		                array.tool.Size = esp.fontsize 
		                array.tool.Font = esp.font
		                if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
		                    array.tool.Color = esp.highlight_target.color 
		                    else 
		                       array.tool.Color = esp.text.color 
		                end
		                --array.tool.Color = esp.text.color 
		                array.tool.Outline = esp.outlines.enabled 
		                array.tool.OutlineColor = esp.outlines.color 
		                array.tool.Position = v2(bottom_offset.X, bottom_offset.Y + bottom_bounds)
		                bottom_bounds += 14
		                if esp.boldtext then 
		                    array.tool_bold.Visible = true 
		                    array.tool_bold.Size = esp.fontsize 
		                    array.tool_bold.Font = esp.font 
		                    if esp.highlight_target.enabled and esp.highlight_target.target == tostring(character) then
    		                    array.tool_bold.Color = esp.highlight_target.color 
    		                    else 
    		                       array.tool_bold.Color = esp.text.color 
		                    end
		                    array.tool_bold.Text = array.tool.Text
		                    array.tool_bold.Position = v2(array.tool.Position.X + 1, array.tool.Position.Y)
		                    else 
		                        array.tool_bold.Visible = false 
		                end
		                else 
		                    array.tool.Visible = false 
		                    array.tool_bold.Visible = false 
		            end
		            else 
		                array.tool.Visible = false 
		                array.tool_bold.Visible = false 
		                
		                array.health_bold.Visible = false 
		                array.health.Visible = false 
		                
		                array.name.Visible = false 
		                array.name_bold.Visible = false 
		                
		                array.distance.Visible = false 
		                array.distance_bold.Visible = false 
		                
		        end
		    else
		        array.highlight.Enabled = false
		        esp.setall(array,'Visible',false)
		    end
		end)
		if not s and e then
		    printconsole('ESP ERROR: '..tostring(e))
		    esp.setall(array,'Visible',false)
		    array.highlight.Enabled = false
		end
        else
            array.arrow_outline.Visible = false 
            array.arrow.Visible = false
            esp.setall(array,'Visible',false)
            array.highlight.Enabled = false
    end
end


for i,player in next, players:GetPlayers() do
    if player ~= plr then 
        esp.add_plr(player)
    end
end
players.PlayerAdded:Connect(function(player)
    esp.add_plr(player)
end)
players.PlayerRemoving:Connect(function(player)
    esp.remove_plr(player)
end)
getgenv().esp_loop = runservice.RenderStepped:Connect(function()
    for player, drawings in next, esp.cache do
        if drawings and player then
            esp.update_esp(player, drawings);
        end
    end
end)
getgenv().esp = esp
getgenv().game_client = game_client
return esp 
