--mopsHub Phantom Forces - Non Synapse Version | 2023

local s,e = pcall(function()
    if not game.PlaceId == 9759729519 then return end
    repeat
        task.wait()
    until game:IsLoaded()
    getgenv().__mpho_1__loaded__ = true

    --MODULES
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
    local Notify = AkaliNotif.Notify;
    local writeclipboard,encodeb64,decodeb64,Request = ((syn and syn.write_clipboard) or setclipboard),((syn and syn.crypt.base64.encode) or (Krnl and Krnl.Base64.Encode)),((syn and syn.crypt.base64.decode) or (Krnl and Krnl.Base64.Decode)),(http_request or syn and syn.request or request or nil)
    local game_client = {}
    local Player = game:GetService("Players").LocalPlayer
    local settings = {
        autoLoadConfigs = nil,
    }
    local Players = game:GetService("Players")
    local Mouse = Player:GetMouse()
    local RunService = game:GetService("RunService")
    local target = nil
    local Ignore = {game.Workspace.CurrentCamera,game.Workspace.Ignore}
    local Blacklisted = {"Flame", "SightMark", "SightMark2A", "Tip", "Trigger"}
	local camera = workspace.CurrentCamera;
    local HitBoxes = {}

    --ENV
    getgenv()._attachshift = 1
    getgenv().weapondata = {}
    getgenv()._hextsize = 4.5
	getgenv()._hexttransparency = 0.5
	getgenv()._hteamcolor = false
    getgenv()._espcolor = Color3.fromRGB(255,0,0)

	getgenv()._hitbox = "Head"
    getgenv()._WINDOW = {
        Tabs = {},
    }

    --STUFF THAT NEEDS TO RUN AT EXECUTE
    if isfile("/mopsHub/settings_phantomforces_nonsyn.mhs") then
        local s,e = pcall(function()
            local file_settings = readfile("/mopsHub/settings_phantomforces_nonsyn.mhs")
            local parsedSettings = {}
            local s,e = pcall(function()
                parsedSettings = game:GetService("HttpService"):JSONDecode(file_settings)
            end)
            if s then
                for _,v in pairs(parsedSettings) do
                    settings[_] = v
                end
            else
                warn("[mopsHub Error]: Unable to parse local saved settings json.\nError:\n\n> ".. e)
            end
        end)
        if not s and e then
            print(e)
        end
    else
        settings.autoLoadConfigs = true
        writefile("/mopsHub/settings_phantomforces_nonsyn.mhs", tostring(game:GetService("HttpService"):JSONEncode(settings)))
        print("[mopsHub Debug]: Created local config file.")
    end

    --WINDOW CONFIG
    local _TABS = {
        "Weapon",
        "Visual",
        "Character",
        "Misc",
        "Settings",
        "Credits"
    }

    local _FUNCTIONS = {
        ["Weapon"] = {
            {
                Function = "CreateSection",
                Args = "━ Silent Aimbot ━",
            },
            {
                Function = "CreateToggle",
                _envState =  false,
                Args = {
                    Name = "Silent Aimbot",
                    Flag = "_slientaimbot",
                    Callback = function(Value)
                        getgenv()._slientaimbot = Value
                    end,
                }
            },
            {
                Function = "CreateDropdown",
                _envState = {"Head"},
                Args = {
                    Name = "Hit Part",
                    Flag = "targetedPart",
                    Options = {"Head","Torso"},
                    CurrentOption = "Head",
                    Callback = function(Value)
                        getgenv().targetedPart = {Value}
                    end,
                }
            },
            {
                Function = "CreateToggle",
                _envState = false,
                Args = {
                    Name = "Draw FOV",
                    Flag = "_drawfov",
                    Callback = function(Value)
                        getgenv()._drawfov = Value
                    end,
                }
            },
            {
                Function = "CreateSlider",
                _envState = 50,
                Args = {
                    Name = "FOV",
                    Flag = "fov",
                    Range = {0, 360},
                    Increment = 1,
                    Suffix = "",
                    CurrentValue = 80,
                    Callback = function(Value)
                        getgenv().fov = Value
                    end,
                }
            },
        },
        ["Visual"] = {
            {
                Function = "CreateSection",
                Args = "━ ESP ━",
            },
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "ESP",
					Flag = "_esp",
					Callback = function(Value)
						getgenv()._esp = Value
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Tracers",
					Flag = "_tracers",
					Callback = function(Value)
						getgenv()._tracers = Value
					end,
				}
			},
            {
				Function = "CreateDropdown",
				_envState = 1,
				Args = {
					Name = "Tracers Orientation",
					Flag = "_attachshift",
					Options = {"Bottom","Middle","Top"},
					CurrentOption = "Bottom",
					Callback = function(Value)
                        if Value == "Bottom" then
                            getgenv()._attachshift = 1
                        elseif Value == "Middle" then
                            getgenv()._attachshift = 2
                        elseif Value == "Top" then
                            getgenv()._attachshift = 1000
                        end
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Chams",
					Flag = "_esphightlight",
					Callback = function(Value)
						getgenv()._esphightlight = Value
					end,
				}
			},
            {
				Function = "CreateSection",
				Args = "━ ESP Customization ━"
			},
            {
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Hightlight Fill Color",
                    Flag = "_esphightlightcolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._esphightlightcolor = Value
                    end
                }
            },
            {
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Chams Outline Color",
                    Flag = "_esphighlightoutlinecolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._esphighlightoutlinecolor = Value
                    end
                }
            },
            {
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Tracer Color",
                    Flag = "_tracercolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._tracercolor = Value
                    end
                }
            },
            {
				Function = "CreateSlider",
				_envState = 0.5,
				Args = {
					Name = "Chams Fill Transparency",
					Flag = "_esphighlightfilltrans",
					Range = {0, 1},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = 0.5,
					Callback = function(Value)
						getgenv()._esphighlightfilltrans = Value
					end,
				}
			},
            {
				Function = "CreateSlider",
				_envState = 0,
				Args = {
					Name = "Chams Outline Transparency",
					Flag = "_esphighlightoutlinetrans",
					Range = {0, 1},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = 0,
					Callback = function(Value)
						getgenv()._esphighlightoutlinetrans = Value
					end,
				}
			},
            {
                Function = "CreateParagraph",
                _envState = false,
                Args = {Title = "Note:",Content = "The ESP is kinda ass now. I'll remake it when I have time and then It will have more options."}
            },
            {
				Function = "CreateSection",
				Args = "━ Hitbox Extender ━"
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Hitbox Extender",
					Flag = "_hitboxext",
					Callback = function(Value)
						getgenv()._hitboxext = Value
					end,
				}
			},
			{
				Function = "CreateDropdown",
				_envState = "Head",
				Args = {
					Name = "Hitbox",
					Flag = "_hitbox",
					Options = {"Head"},
					CurrentOption = getgenv()._hitbox or "Head",
					Callback = function(Value)
						getgenv()._hitbox = Value
						if getgenv()._hitboxext then
							game_client:ReturnHB()
							game_client:UpdateHB(getgenv()._hitbox,getgenv()._hextsize)
						end
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState = 4.5,
				Args = {
					Name = "Hitbox Size",
					Flag = "_hextsize",
					Range = {1, 5},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = getgenv()._hextsize,
					Callback = function(Value)
						getgenv()._hextsize = Value
						if getgenv()._hitboxext then
							game_client:ReturnHB()
							game_client:UpdateHB(getgenv()._hitbox,getgenv()._hextsize)
						end
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState = 0.5,
				Args = {
					Name = "Hitbox Transparency",
					Flag = "_hexttransparency",
					Range = {0, 1},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = 0.5,
					Callback = function(Value)
						getgenv()._hexttransparency = Value
					end,
				}
			},
			{
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Hitbox Color",
                    Flag = "_hextcolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._hextcolor = Value
                    end
                }
            },
            {
                Function = "CreateSection",
                Args = "━ Gun Customization ━"
            },
            {
                Function = "CreateToggle",
                _envState = false,
                Args = {
                    Name = "Rainbow Gun & Arms",
                    Flag = "_rbgaa",
                    Callback = function(Value)
                        getgenv()._rbgaa = Value
                        for _,O in pairs(camera:GetDescendants()) do
							if O:IsA("BasePart") and not table.find(Blacklisted, O.Name) then
								task.spawn(function()
									local oldc = O.Color
									local oldt = O.Transparency
									local oldm = O.Material
									while getgenv()._rbgaa do task.wait()
										O.Color = Color3.fromHSV((tick() % 5 / 5), 1, 1)
										O.Transparency = 0.8
										O.Material = Enum.Material.ForceField
										if not getgenv()._rbgaa then
											O.Color = oldc
											O.Transparency = oldt
											O.Material = oldm or Enum.Material.SmoothPlastic
											break
										end
									end
								end)
							end
						end
                    end,
                }
            },
            {
                Function = "CreateParagraph",
                _envState = false,
                Args = {Title = "Note:",Content = "Sometimes you need to respawn once to disable Rainbow Gun & Arms completely."}
            },
        },
        ["Character"] = {
            {
				Function = "CreateSection",
				Args = "━ Character Modifications ━"
			},
            {
                Function = "CreateToggle",
                _envState =  false,
                Args = {
                    Name = "Walkspeed Modification",
                    Flag = "_wsmod",
                    Callback = function(Value)
                        getgenv()._wsmod = Value
                    end,
                }
            },
            {
				Function = "CreateSlider",
				_envState = 16,
				Args = {
					Name = "Walkspeed",
					Flag = "_walkspeed",
					Range = {0, 50},
					Increment = 1,
					Suffix = "",
					CurrentValue = 16,
					Callback = function(Value)
						getgenv()._walkspeed = Value
					end,
				}
			},
            {
                Function = "CreateToggle",
                _envState =  false,
                Args = {
                    Name = "Infinite Jump",
                    Flag = "_infjump",
                    Callback = function(Value)
                        getgenv()._infjump = Value
                    end,
                }
            },
            {
                Function = "CreateSlider",
                Args = {
                    Name = "Infinite Jump Height",
                    Flag = "_infjumpheight",
                    CurrentValue = 50,
                    Range = {0, 250},
                    Increment = 1,
                    Suffix = "",
                    Callback = function(Value)
                        getgenv()._infjumpheight = Value
                    end
                }
            },
            {
                Function = "CreateToggle",
                _envState =  false,
                Args = {
                    Name = "Bunny Hop",
                    Flag = "_bhop",
                    Callback = function(Value)
                        getgenv()._bhop = Value
                    end,
                }
            },
        },
        ["Misc"] = {
            {
				Function = "CreateSection",
				Args = "━ Automatic Actions ━"
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Auto Respawn",
					Flag = "_autorespawn",
					Callback = function (Value)
						getgenv()._autorespawn = Value
					end
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Join new server on votekick",
					Flag = "_votekickrejoin",
					Callback = function (Value)
						getgenv()._votekickrejoin = Value
					end
				}
			},
        },
        ["Settings"] = {
            {
				Function = "CreateSection",
				Args = "━ Script Settings ━"
			},
			{
				Function = "CreateToggle",
				Args = {
					Name = "Auto Load configs",
					CurrentValue = settings.autoLoadConfigs,
					Callback = function (Value)
						settings.autoLoadConfigs = Value
						writefile("/mopsHub/settings_phantomforces_nonsyn.mhs", tostring(game:GetService("HttpService"):JSONEncode(settings)))
					end
				}
			},
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Note:",Content = "This means, your recently used settings will automatically load when you execute the script."}
			},
        },
    }

    local _CREDITS = {
        ["Special Thanks"] = {
            {"@The3Bakers4565",""},
        },
        ["Developers"] = {
            {"ShyFlooo","Programmer"},
        },
    }

    if writeclipboard then
        writeclipboard("discord.gg/g4EGAwjUAK")
    else
        warn("[mopsHub Loader Error]: Missing function writeclipboard. Your executor might be too bad and doesn't support it!")
    end

    local en, ev = (identifyexecutor and identifyexecutor())
    --CREATE WINDOW
    local Window = Rayfield:CreateWindow({
        Name = string.format("mopsHub - Phantom Forces (%s)", en or "unknown executor"),
        LoadingTitle = string.format("mopsHub - Phantom Forces (%s)", en or "unknown executor"),
        LoadingSubtitle = "by ShyFlooo",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "/mopsHub/.config", -- Create a custom folder for your hub/game
            FileName = "mopshub_phantomforces_nonsyn"
        },
        KeySystem = false, -- Set this to true to use our key system
        KeySettings = {
            Title = "mopsHub - Phantom Forces (non synapse)",
            Subtitle = "Key System",
            Note = "Key here (copied): discord.gg/g4EGAwjUAK",
            FileName = "MOPSHUBKEY",
            SaveKey = true,
            GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
            Key = ""
        }
    })

    --SETUP WINDOW
    for index, name in pairs(_TABS) do
        local w = Window:CreateTab(name)
        getgenv()._WINDOW.Tabs[name] = w
    end

    for index, value in pairs(_CREDITS) do
		local content = ""
		for i,data in pairs(value) do
			if #data[2] > 0 then
				content = content.."\n"..data[1].." - ".. data[2]
			else
				content = content.."\n"..data[1]
			end
		end
		getgenv()._WINDOW.Tabs["Credits"]:CreateSection(index)
		getgenv()._WINDOW.Tabs["Credits"]:CreateParagraph({Title = index, Content = content})
	end

    for index, funcs in pairs(_FUNCTIONS) do
        print("[mopsHub Debug]: Loaded "..#funcs.." function(s) for ".. index)
        for i, func in pairs(funcs) do
            if func.Function and func.Args then
                local Tab = getgenv()._WINDOW.Tabs[index]
                if Tab then
                    local s,e = pcall(function()
                        local f,l = func.Function, true
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
                            l = false
                        end; if l == true then
                        --print("Loaded function "..tostring(func.Args.Flag or func.Args or "unknown").. " for ".. index.. " ["..string.gsub(func.Function, "Create", "").. "]")
                        else
                        --print("Unable to create "..tostring(func.Function).. " function for ".. index .. " ["..i.."]")
                        end

                        if func.Args.Flag then
                            --print("Creating env ".. tostring(func.Args.Flag) .. " with the value ".. tostring(func._envState))
                            getgenv()[func.Args.Flag] = func._envState
                        end
                    end)
                    if not s and e then
                        print("[mopsHub UI Loader Error]: > "..e)
                    end
                end
            end
        end
    end

    --> FUNCTIONS
    local lines = {}
    function game_client:IsAlive()
        if game.Players.LocalPlayer.Character and not game.Workspace:FindFirstChild("MenuLobby")then
            return true
        end
        return false
    end; function game_client:GetR6Parts(all)--get table with r6 parts
        local Parts
        if all then
            Parts={"All","Head","Torso","Right Arm","Left Arm","Right Leg","Left Leg"}
        else
            Parts={"Head","Torso","Right Arm","Left Arm","Right Leg","Left Leg"}
        end
        return Parts
    end; function game_client:FindBrokenModulePenetration(modulescript)
        local gundata = decompile(modulescript)
        local exists,penstart=string.find(gundata,"v1.penetrationdepth = ")
        if not exists then return 0 end
        local pendata=string.sub(gundata,penstart,penstart+4)
        local number=""
        for _,v in pairs(game_client:StringToTable(pendata))do
            if tonumber(v)or v=="."then
                number=number..v
            end
        end
        return tonumber(number)
    end; function game_client:StringToTable(string)
        local a={}
        for i=1,string.len(string)do
            a[#a+1]=string.sub(string,i,i)
        end
        return a
    end; function game_client:GetGunName()
        if not game_client:IsAlive() then return "None" end
        if not camera:FindFirstChild("Main") then return "None" end
        local curdata={Union={},MeshPart={}}
        for _,v in pairs(camera.Main:GetChildren())do
            if v:IsA("MeshPart")then
                curdata.MeshPart[v.MeshId]=v.MeshId
            elseif v:IsA("Union")then
                curdata.Union[v.AssetId]=v.AssetId
            end
        end
        local matches={}
        for i,v in pairs(getgenv().weapondata)do
            for i2,c in pairs(v)do
                for _,x in pairs(c)do
                    if x==curdata[i2][x]then
                        if matches[i]then
                            matches[i]=matches[i]+1
                        else
                            matches[i]=1
                        end
                    end
                end
            end
        end
        local a=0
        local closest="None"
        for i,v in pairs(matches)do
            if v>a then
                a=v
                closest=i
            end
        end
        return closest
    end; function game_client:GetEnemys()
        local players={}
        local characters={}
        local enemyteam
        for _,v in pairs(game.Players:GetChildren())do
            if v.Team~=game.Players.LocalPlayer.Team then
                enemyteam=tostring(v.TeamColor)
                players[#players+1]=v
            end
        end
        if not enemyteam then
            enemyteam="Bright orange"
            if game.Players.LocalPlayer.Team.Name=="Ghosts"then
                enemyteam="Bright blue"
            end
        end
        for _,v in pairs(game.Workspace.Players[enemyteam]:GetChildren())do
            characters[#characters+1]=v
        end
        return{characters,players}
    end; function game_client:GetDirChange()
        local a={}
        if game.Workspace.CurrentCamera:FindFirstChild("Main")then
            for _,v in pairs(game.Workspace.CurrentCamera.Main:GetChildren())do
                if string.find(string.lower(tostring(v)),"flame")or string.find(string.lower(tostring(v)),"sightmark")then
                    a[#a+1]=v
                end
            end
        end
        return a
    end; function game_client:CanSee(Target,Penetrate,PenDepth)
        if not Penetrate then PenDepth=0 end
        local Dir=Target.Position-game.Workspace.CurrentCamera.CFrame.Position
        local InitCast=game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(game.Workspace.CurrentCamera.CFrame.Position,Dir),Ignore,false,true)
        if not InitCast then
            return true
        end
        local Penetrated=0
        for _,v in pairs(game.Workspace.CurrentCamera:GetPartsObscuringTarget({Target.Position},Ignore))do
            if v.CanCollide and v.Transparency~=1 and v.Name~="Window"then
                local MaxExtent=v.Size.Magnitude*Dir.Unit;
                local _,Enter=game.Workspace:FindPartOnRayWithWhitelist(Ray.new(game.Workspace.CurrentCamera.CFrame.Position,Dir),{v},true)
                local _,Exit=game.Workspace:FindPartOnRayWithWhitelist(Ray.new(Enter+MaxExtent,-MaxExtent),{v},true)
                local Depth=(Exit-Enter).Magnitude;
                if Depth>PenDepth then
                    return false;
                else
                    Penetrated=Penetrated+Depth;
                end
            else
                table.insert(Ignore,v)
            end
        end
        return Penetrated<PenDepth
    end; function game_client:inGame()
		local HudScreenGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HudScreenGui")
		if HudScreenGui.Enabled then return true end
		return false
	end; function game_client:inMenu()
		local MenuScreenGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MenuScreenGui")
		if MenuScreenGui.Enabled then return true end
		return false
	end; function game_client:OriginalHB()
		return {["Left Leg"]={radius=0.1,precedence=4,size=Vector3.new(1,2,1)},["Right Arm"]={radius=0.1,precedence=3,size=Vector3.new(1,2,1)},Head={radius=0.1,precedence=1,size=Vector3.new(1,1,1)},Torso={radius=0.1,precedence=2,size=Vector3.new(2,2,1)},["Right Leg"]={radius=0.1,precedence=4,size=Vector3.new(1,2,1)},["Left Arm"]={radius=0.1,precedence=3,size=Vector3.new(1,2,1)}}
	end; function game_client:UpdateHB(target,size)
		for _,v in pairs(HitBoxes) do
			v[target].size = Vector3.new(size,size,size)
			v[target].radius = size
		end
	end; function game_client:ReturnHB()
		for i,v in pairs(HitBoxes)do
			for i2,v2 in pairs(v)do
				for i3 in pairs(v2)do
					HitBoxes[i][i2][i3]=game_client:OriginalHB()[i2][i3]
				end
			end
		end
	end; function game_client:rainbowColor(X)
        return math.acos(math.cos(X*math.pi))/math.pi
    end; function game_client:createHighlight(adornee)
        local torso = adornee:FindFirstChild("Torso")
        if not torso then return end
        local screenpos, onscreen = camera.WorldToViewportPoint(camera, torso.Position)
        if onscreen then
            local hightlight = Instance.new("Highlight")
            hightlight.OutlineTransparency = getgenv()._esphighlightoutlinetrans
            hightlight.FillTransparency = getgenv()._esphighlightfilltrans
            hightlight.Name = "E"
            hightlight.Adornee = adornee
            hightlight.FillColor = getgenv()._esphightlightcolor
            hightlight.OutlineColor = getgenv()._esphighlightoutlinecolor
            hightlight.Parent = game:GetService("CoreGui")
        end
    end; function game_client:createTracer(adornee)
        assert(Drawing, "Missing Drawing. unable to draw line (unsupported executor)")
        local torso = adornee:FindFirstChild("Torso")
        if not torso then return end
        local screenpos, onscreen = camera.WorldToViewportPoint(camera, torso.Position)
        if onscreen then
            local line = Drawing.new("Line")
            line.Visible = true
            line.From = Vector2.new(screenpos.X, screenpos.Y)
            print(getgenv()._attachshift)
            line.To = Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/tonumber(getgenv()._attachshift) or 1)
            line.Color = getgenv()._tracercolor
            table.insert(lines, line)
        end
    end; function game_client:GetEnemyPlayers()
        players = {}
        if #game:GetService("Teams"):GetTeams() > 0 then
            local friendly = Player.Team.Name
            for i,v in pairs(game:GetService("Teams"):GetTeams()) do
                if v.Name ~= friendly and v.Name ~= (game.Teams:FindFirstChild("Spectators") and game.Teams.Spectators.Name) then
                    local enemyPlayers = v:GetPlayers()
                    for i,v in pairs(enemyPlayers) do
                        table.insert(players, v)
                    end
                end
            end
            return players
        end
    end; function game_client:UpdateHighlight()
        for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
        local otherTeamR
        if Player.Team ~= nil then
            if tostring(Player.TeamColor) == "Bright blue" then
                otherTeamR = "Bright orange"
            elseif tostring(Player.TeamColor) == "Bright orange" then
                otherTeamR = "Bright blue"
            end
        end
        local players = game.Workspace:FindFirstChild("Players")
        local otherteam = players:FindFirstChild(otherTeamR)
        for i,v in pairs(otherteam:GetChildren()) do
            if getgenv()._esphightlight then
                game_client:createHighlight(v)
            end
        end
    end; function game_client:UpdateTracers()
        for i,v in pairs(lines) do if v then v:Remove() table.remove(lines, i) end end
        local otherTeamR
        if Player.Team ~= nil then
            if tostring(Player.TeamColor) == "Bright blue" then
                otherTeamR = "Bright orange"
            elseif tostring(Player.TeamColor) == "Bright orange" then
                otherTeamR = "Bright blue"
            end
        end
        local players = game.Workspace:FindFirstChild("Players")
        local otherteam = players:FindFirstChild(otherTeamR)
        for i,v in pairs(otherteam:GetChildren()) do
            if getgenv()._tracers then
                game_client:createTracer(v)
            end
        end
    end

    --> MAIN

    --Silent Aim
    task.spawn(function()
        assert(decompile, "Missing decompile function. Executor might be too bad.")
        local NotGuns={"ONE HAND BLUNT","TWO HAND BLADE","EQUIPMENT","FRAGMENTATION","IMPACT","ONE HAND BLADE","TWO HAND BLUNT","HIGH EXPLOSIVE"}
        local guns={}
        local gunpendepths={None=0,["M14 BR"]=1.8,HK417=1.6,L22=0.9,["HECATE II"]=10,["M79 THUMPER"]=0.5,["AS VAL"]=1,MP1911=0.5,["GI M1"]=1,["TEC-9"]=0.5,GSP=0.1,["GLOCK 18"]=0.5,["GB-22"]=0.5,X95R=1,M16A3=1.2,["SCAR SSR"]=2.6,["STEYR SCOUT"]=3,K2=1,MG36=1.8,["AUTO 9"]=1,MP5SD=0.5,MAC10=0.5,UZI=0.7,["COLT MARS"]=1.5,["SAIGA-12U"]=0.4,["FAL PARA SHORTY"]=1.4,L115A3=3,MP40=1.1,["AN-94"]=1,["ARM PISTOL"]=0.9,BLOCKSON=0.5,MP5K=0.5,["MAKAROV PM"]=0.5,["L86 LSW"]=1.6,AK12=1,["BOXY BUSTER"]=0,["BEOWULF ECR"]=1.9,EXECUTIONER=1,["DRAGUNOV SVU"]=2.8,M16A4=1.2,M1903=5,["TOMMY GUN"]=0.5,["SCAR-H"]=1.5,G36K=1.1,AK74=1,JURY=1,["1858 CARBINE"]=0.5,["GLOCK 40"]=0.8,["BEOWULF TCR"]=3,["1858 NEW ARMY"]=0.5,M4=1,["NTW-20"]=20,HK51B=1,9,C8A2=0.8,MP7=1.5,AK47=1.4,MC51SD=1.5,KRINKOV=0.9,["GOLDEN ZIP 22"]=0.5,["KAC SRR"]=1,["TRG-42"]=3,["KRISS VECTOR"]=0.5,["RAMA 1130"]=0.5,["SR-3M"]=1,["SCAR PDW"]=0.9,["FAL 50.63 PARA"]=2,["E SHOTGUN"]=0.5,M1911=0.5,["AG-3"]=2,M231=1,K7=0.5,AKM=1.4,SKS=1.5,K1A=0.75,["GYROJET MARK I"]=0.5,["M14 DMR"]=2.4,["MICRO UZI"]=0.5,["PPSH-41"]=1,["REMINGTON 870"]=0.5,["VSS VINTOREZ"]=1.5,MK11=1.7,MSG90=2,["SL-8"]=1.3,M3A1=0.5,["GLOCK 17"]=0.5,["SASS 308"]=2,FT300=3,RPK74=1.6,["KS-23M"]=0.7,["AA-12"]=0.3,M7644=0.5,ALIEN=0.5,["TAR-21"]=1.2,["SCAR HAMR"]=1.4,MG3KWS=2,["GOLDEN HK51B"]=0.3,HK21=1.6,MG42=2.5,["AUG A3"]=1,["SA58 SPR"]=2,["BFG 50"]=10,["SAIGA-12"]=.5,AKU12=1,["FAL 50.00"]=2,FAMAS=1,["TYPE 88"]=.9,["REDHAWK 44"]=1,GRIZZLY=1.3,["COLT LMG"]=1.4,MP10=0.5,RAILGUN=200,["HENRY 45-70"]=2,["MP412 REX"]=.5,WA2000=2.8,["DEAGLE 44"]=1,["GLOCK 50"]=1,["GLOCK 21"]=0.7,HARDBALLER=1.2,M4A1=1,M9=0.5,["GOLDEN TOMMY GUN"]=0.5,["GOLDEN REDHAWK 45"]=0.5,["SCAR-L"]=1,["STG-44"]=1.6,P90=2,["DEAGLE 50"]=1.3,MP5=0.5,["AUG A3 PARA"]=0.5,["TOY M1911"]=0,["REMINGTON 700"]=3,["PP-2000"]=1,["MP5/10"]=0.8,AK12BR=2,["KG-99"]=0.5,UMP45=1.4,["ZIP 22"]=0.5,["GLOCK 1"]=0.5,C7A2=0.9,["SERBU SHOTGUN"]=0.6,["AUG A1"]=1,["COLT SMG 635"]=0.5,RPK12=1.6,["FIVE SEVEN"]=1.5,["DT11 PRO"]=.7,["GYROJET CARBINE"]=0.7,["OTs-126"]=1.2,M93R=0.5,DBV12=0.5,M45A1=0.5,["SAWED OFF"]=0.6,G36C=1,["SFG 50"]=10,["E GUN"]=0.5,SKORPION=0.5,OBREZ=2,RPK=1.8,["ROPOD SHOTTY"]=1.5,M41A=1,["GROZA-1"]=1.5,["GOLDEN SHORTY"]=0.1,["GROZA-4"]=1.5,M2011=0.5,["GLOCK 23"]=0.8,["KSG 12"]=0.4,["USAS-12"]=0.3,M60=3,["MOSIN NAGANT"]=4,["HONEY BADGER"]=1.3,["SPAS-12"]=0.6,["AM III"]=1.2,["STEVENS DB"]=0.5,["DRAGUNOV SVDS"]=3.2,["AUG HBAR"]=1.6,K14=3,["CAN CANNON"]=1.2,["AUG A2"]=1,AK103=1.4,AWS=2,INTERVENTION=6,["X95 SMG"]=0.7,["MATEBA 6"]=1,JUDGE=1,G36=1.3,["PP-19 BIZON"]=0.5,M107=10,G3=1.5,["GOLDEN DEAGLE 50"]=1.5,AK12C=1.2,L2A3=1.1,["GOLDEN DEAGLE 2"]=1.5,ASMI=0.5,["IZHEVSK PB"]=0.5,AK105=1,M3822=0.5,L85A2=1.2,["HOWA TYPE 20"]=1.4,HK416=1,M16A1=0.8,G11K2=2}
        for _,v in pairs(game:GetService("ReplicatedStorage").Content.ProductionContent.WeaponDatabase:GetChildren())do
            for _,c in pairs(v:GetChildren())do
                if c:FindFirstChild("Main")then
                    getgenv().weapondata[c.Name]={Union={},MeshPart={}}
                    for _,x in pairs(c.Main:GetChildren())do
                        if x:IsA("MeshPart")then
                            getgenv().weapondata[c.Name].MeshPart[x.MeshId]=x.MeshId
                        elseif x:IsA("Union")then
                            getgenv().weapondata[c.Name].Union[x.AssetId]=x.AssetId
                        end
                    end
                end
            end
            if not table.find(NotGuns,v.Name)then
                for _,c in pairs(v:GetChildren())do
                    guns[c]=c.Name
                end
            end
        end
        for i,v in pairs(guns)do
            if not gunpendepths[v]then
                local depth=game_client:FindBrokenModulePenetration(i[v])
                gunpendepths[v]=depth
            end
        end
        RunService.RenderStepped:Connect(function()
            target = nil
            if getgenv()._slientaimbot and game_client:IsAlive() then
                local a = math.huge
                local penetratrion=gunpendepths[game_client:GetGunName()]
                for _,v in pairs(game_client:GetEnemys()[1])do
                    for _,c in pairs(getgenv().targetedPart)do
                        local main=v[c]
                        local mainmag=(main.Position-game.Workspace.CurrentCamera.CFrame.Position).Magnitude
                        local center=game.Workspace.CurrentCamera:WorldToViewportPoint(game.Workspace.CurrentCamera.CFrame.Position+game.Workspace.CurrentCamera.CFrame.LookVector)
                        local partloc,isvisible=game.Workspace.CurrentCamera:WorldToScreenPoint(main.Position)
                        if(Vector2.new(partloc.X,partloc.Y)-Vector2.new(center.X,center.Y)).Magnitude <= getgenv().fov then
                            if mainmag < a and game_client:CanSee(main,false,penetratrion)then
                                target=main
                                a=mainmag
                            end
                        end
                    end
                end
                if target then
                    for _,v in pairs(game_client:GetDirChange())do
                        v.Position=game.Workspace.CurrentCamera.CFrame.Position
                        v.Velocity=Vector3.new()
                        local weld=v:FindFirstChildWhichIsA("Weld")or v:FindFirstChildWhichIsA("WeldConstraint")
                        if weld then
                            weld:Destroy()
                        end
                        local x,y,z=CFrame.new(v.Position,target.Position+Vector3.new(0,.45,0)):ToEulerAnglesYXZ()
                        v.Orientation=Vector3.new(math.deg(x),math.deg(y),math.deg(z))
                    end
                else
                    local straight=game.Workspace.CurrentCamera.CFrame.LookVector*100000
                    for _,v in pairs(game_client:GetDirChange())do
                        v.Position=game.Workspace.CurrentCamera.CFrame.Position
                        v.Velocity=Vector3.new()
                        local weld=v:FindFirstChildWhichIsA("Weld")or v:FindFirstChildWhichIsA("WeldConstraint")
                        if weld then
                            weld:Destroy()
                        end
                        local x,y,z=CFrame.new(v.Position,straight):ToEulerAnglesYXZ()
                        v.Orientation=Vector3.new(math.deg(x),math.deg(y),math.deg(z))
                    end
                end
            end
        end)
        coroutine.wrap(function()
            while RunService.RenderStepped:Wait() do
                pcall(function()
                    if getgenv()._triggerbot and target and iswindowactive() then
                        mouse1press() task.wait() mouse1release()
                    end
                end)
            end
        end)()
    end)

    --Hitbox Expander New
	task.spawn(function()
		for _,v in pairs(getgc(true))do
			if type(v)=="table"then
				for i,c in pairs(v)do
					if i=="Head"and type(c)=="table"and c.size then
						HitBoxes[#HitBoxes+1] = v
					end
				end
			end
		end
		local GetEnemys = function()--simple ass get enemys
			local players = {}
			local characters = {}
			local enemyteam
			for _,v in pairs(game.Players:GetChildren()) do
				if v.Team ~= game.Players.LocalPlayer.Team then
					enemyteam = tostring(v.TeamColor)
					players[#players+1] = v
				end
			end
			if not enemyteam then
				enemyteam = "Bright orange"
				if game.Players.LocalPlayer.Team.Name == "Ghosts"then
					enemyteam = "Bright blue"
				end
			end
			for _,v in pairs(game.Workspace.Players[enemyteam]:GetChildren()) do
				characters[#characters+1] = v
			end
			return{characters, players}
		end
		RunService.RenderStepped:Connect(function()
			if getgenv()._hitboxext and game_client:inGame() then
				for _,v in pairs(GetEnemys()[1]) do
					warn(v[getgenv()._hitbox])
					local cham = Instance.new("Part")
					cham.Transparency = getgenv()._hexttransparency
					cham.Size = Vector3.new(getgenv()._hextsize,getgenv()._hextsize,getgenv()._hextsize)
					cham.Color = getgenv()._hextcolor or Color3.fromRGB(255,255,255)
					cham.Material = Enum.Material.SmoothPlastic
					cham.CanCollide = false
					cham.CFrame = v[getgenv()._hitbox].CFrame
					cham.Parent = v[getgenv()._hitbox]
					coroutine.wrap(function()
						game.RunService.RenderStepped:Wait()
						cham:Destroy()
					end)()
				end
			end
		end)
	end)

    --ESP
    task.spawn(function()
        Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Wait()
            players = game_client:GetEnemyPlayers()
            if getgenv()._esp then
                task.spawn(function()
                    game_client:UpdateHighlight()
                end)
                task.spawn(function()
                    game_client:UpdateTracers()
                end)
            else
                for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
                for i,v in pairs(lines) do if v then v:Remove() table.remove(lines, i) end end
            end
        end)
        game.Players.PlayerRemoving:Connect(function(plr)
            plr.CharacterRemoving:Wait()
            players = game_client:GetEnemyPlayers()
            if getgenv()._esp then
                task.spawn(function()
                    game_client:UpdateHighlight()
                end)
                task.spawn(function()
                    game_client:UpdateTracers()
                end)
            else
                for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
                for i,v in pairs(lines) do if v then v:Remove() table.remove(lines, i) end end
            end
        end)
        game:GetService('RunService').RenderStepped:Connect(function()
            if getgenv()._esp then
                task.spawn(function()
                    game_client:UpdateHighlight()
                end)
                task.spawn(function()
                    game_client:UpdateTracers()
                end)
            else
                for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "E" then v:Destroy() end end
                for i,v in pairs(lines) do if v then v:Remove() table.remove(lines, i) end end
            end
        end)
    end)

    --FOV Circle Object
    local FOVCircle
    if Drawing then
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Thickness = 2
        FOVCircle.NumSides = 50
        FOVCircle.Filled = false
        FOVCircle.Transparency = 0.6
        FOVCircle.Radius = getgenv().fov;
        FOVCircle.Color = Color3.new(0, 1, 0.298039)
    else
        warn("[mopsHub Loader Error]: Missing function Drawing. Your executor might be too bad and doesn't support it! (Draw FOV disabled)")
    end

    -- Auto Respawn & Join new server on Votekick & Gun Mods | Source: self made

	local MenuScreenGui = Player.PlayerGui:FindFirstChild("MenuScreenGui")
	local DisplayVoteKick = Player.PlayerGui:FindFirstChild("ChatScreenGui").Main.DisplayVoteKick

    local function spawnplr()
        assert(keypress, "[mopsHub Error]: Missing function keypress. Your executor might be too bad and doesn't support it!")
		keypress(0x20)
		task.wait()
		keyrelease(0x20)
	end

	local function getServers()
		local url = "https://games.roblox.com/v1/games/292439477/servers/0?sortOrder=Desc&limit=100&excludeFullGames=true"
		local servers = nil

		local r = Request({
			["Url"] = url,
			["Method"] = "GET",
			["Headers"] = {
				["Content-Type"] = "application/json"
			},
		})

		if r.StatusCode ~= 200 or not r.Success then
			return warn("[mopsHub Error]: Unable to get servers.")
		else
			servers = r.Body
		end
		return game:GetService("HttpService"):JSONDecode(servers)
	end

    RunService.RenderStepped:Connect(function()
        --FOV
        if Drawing and FOVCircle ~= nil then
            FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
            FOVCircle.Radius = getgenv().fov;
            FOVCircle.Visible = getgenv()._drawfov;
        end
        if getgenv()._rainbowgun then
            for _, v in pairs(game.Workspace.Camera.Arms:GetChildren()) do
                if v:IsA("BasePart") then
                    v.Color = Color3.fromHSV(tick() % 5 / 5, 1 + 0, 1)
                    v.Transparency = 0.5
                    v.Material = "ForceField"
                end
            end
        end
        --Join new server on votekick
		if getgenv()._votekickrejoin == true then
			if DisplayVoteKick.Visible == true then
				local str = DisplayVoteKick.TextTitle.Text
				if string.find(str, Player.Name) then
					local servers = getServers()
					if servers then
						local _server = math.random(1,#servers.data)
						local _serverid = servers.data[_server].id
						task.wait(2)
						game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _serverid)
					end
				end
			end
		end
        --Auto Respawn
		if getgenv()._autorespawn == true then
			task.wait(0.5)
			if game_client:inMenu() then
                if not getgenv().__autorespawn_check_enabled_ then
                    getgenv().__autorespawn_check_enabled_ = true
                    repeat
                        task.wait()
                        spawnplr()
                    until MenuScreenGui.Enabled == false
                    getgenv().__autorespawn_check_enabled_ = false
                end
			end
		end
    end)

    --Infinite Jump
    local function Action(Object, Function) if Object ~= nil then Function(Object); end end
    game:GetService('UserInputService').InputBegan:Connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
            if not getgenv()._infjump then return end
            if not Player.Character or not Player.Character:FindFirstChildOfClass("Humanoid") then return end
            Action(Player.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, getgenv()._infjumpheight or 50, 0);
                    end)
                end
            end)
        end
    end)

    --Walkspeed Modification
    RunService.RenderStepped:Connect(function()
        if getgenv()._wsmod then
            local travel = Vector3.new()
            if game:GetService('UserInputService'):IsKeyDown(Enum.KeyCode.W) then
                travel += Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
            end; if game:GetService('UserInputService'):IsKeyDown(Enum.KeyCode.S) then
                travel -= Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
            end; if game:GetService('UserInputService'):IsKeyDown(Enum.KeyCode.D) then
                travel += Vector3.new(-camera.CFrame.LookVector.Z, 0, camera.CFrame.LookVector.X)
            end; if game:GetService('UserInputService'):IsKeyDown(Enum.KeyCode.A) then
                travel += Vector3.new(camera.CFrame.LookVector.Z, 0, -camera.CFrame.LookVector.X)
            end
            travel = travel.Unit
            local newDir = Vector3.new(travel.X * getgenv()._walkspeed, Player.Character:FindFirstChild("HumanoidRootPart").Velocity.y, travel.Z * getgenv()._walkspeed)
            if travel.Unit.X == travel.Unit.X then
                Player.Character:FindFirstChild("HumanoidRootPart").Velocity = newDir
            end
        end
    end)

    --Rainbow Gun / Arms | Source: self made
	workspace.CurrentCamera.DescendantAdded:Connect(function(O)
		if O:IsA("BasePart") and not table.find(Blacklisted, O.Name) then
			task.spawn(function()
				local oldc = O.Color
				local oldt = O.Transparency
				local oldm = O.Material
				while getgenv()._rbgaa do task.wait()
					O.Color = Color3.fromHSV((tick() % 5 / 5), 1, 1)
					O.Transparency = 0.8
					O.Material = Enum.Material.ForceField
					if not getgenv()._rbgaa then
						O.Color = oldc
						O.Transparency = oldt
						O.Material = oldm or Enum.Material.SmoothPlastic
						break
					end
				end
			end)
		end
	end)

    --Bunny Hop
    RunService.RenderStepped:Connect(function()
        if getgenv()._bhop and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            local power = 4
            power = power and (2 * game.Workspace.Gravity * power) ^ 0.5 or 40
            Player.Character.Humanoid.Jump = true
            Player.Character.Humanoid.JumpPower = power
        end
    end)

    if settings.autoLoadConfigs then
        Rayfield:LoadConfiguration()
    end
end)
if not s and e then
    print(e)
end
