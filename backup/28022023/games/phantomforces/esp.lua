--Variables

local players = {}
local Players = game:GetService("Players")
local Player = game:GetService("Players").LocalPlayer

enabled = getgenv().enabled or true
fillcolor = getgenv().fillcolor or Color3.fromRGB(255,255,255)
outlinecolor = getgenv().outlinecolor or Color3.fromRGB(255,255,255)

--Functions
function createHighlight(adornee)
    local hightlight = Instance.new("Highlight")
    hightlight.OutlineTransparency = 0.5
    hightlight.FillTransparency = 0.05
    hightlight.Name = "E"
    hightlight.Adornee = adornee
    hightlight.FillColor = fillcolor
    hightlight.OutlineColor = outlinecolor
    hightlight.Parent = game:GetService("CoreGui")
end; function GetEnemyPlayers()
    players = {}
    if #game:GetService("Teams"):GetTeams() > 0 then
        local friendly = Player.Team.Name
        for i,v in pairs(game:GetService("Teams"):GetTeams()) do
            if v.Name ~= friendly and v.Name ~= (game.Teams:FindFirstChild("Spectators") and game.Teams.Spectators.Name) then
                local enemyPlayers = v:GetPlayers()
                for _,p in pairs(enemyPlayers) do
                    table.insert(players, p)
                end
            end
        end
        return players
    end
end; function InsertHightlightToPlayers()
    for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
    local otherTeamR
    if Player.Team ~= nil then
        if tostring(Player.TeamColor) == "Bright blue" then
            otherTeamR = "Bright orange"
        elseif tostring(Player.TeamColor) == "Bright orange" then
            otherTeamR = "Bright blue"
        end
    end
    local otherteam = game.Workspace:FindFirstChild("Players"):FindFirstChild(otherTeamR)
    for _,v in pairs(otherteam:GetChildren()) do
        createHighlight(v)
    end
end

--Update

task.spawn(function()
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Wait()
        players = GetEnemyPlayers()
        if enabled then
            InsertHightlightToPlayers()
        else
            for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
        end
    end)
    game.Players.PlayerRemoving:Connect(function(plr)
        plr.CharacterRemoving:Wait()
        players = GetEnemyPlayers()
        if enabled then
            InsertHightlightToPlayers()
        else
            for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
        end
    end)
    game:GetService('RunService').Stepped:Connect(function()
        if enabled then
            InsertHightlightToPlayers()
        else
            for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
        end
    end)
end)