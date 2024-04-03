local Workspace = game:GetService("Workspace")
local s,e = pcall(function()
    if not (game.PlaceId == 4716045691) then return end
    repeat
		task.wait()
	until game:IsLoaded()
    --if getgenv().__mpho_1__loaded__ == true then return warn("[mopsHub Loader]: mopsHub is already loaded.") end
	getgenv().__mpho_1__loaded__ = true

    getgenv = getgenv

    --MODULES & VARIABLES
	local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
	local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
	local Notify = AkaliNotif.Notify;
    local ESPFramework = loadstring(game:HttpGet("https://raw.githubusercontent.com/NougatBitz/Femware-Leak/main/ESP.lua", true))()
	local writeclipboard,encodeb64,decodeb64,Request = ((syn and syn.write_clipboard) or setclipboard),((syn and syn.crypt.base64.encode) or (Krnl and Krnl.Base64.Encode)),((syn and syn.crypt.base64.decode) or (Krnl and Krnl.Base64.Decode)),(http_request or syn and syn.request or request or nil)
	local Player = game:GetService("Players").LocalPlayer
	local settings = {
		autoLoadConfigs = nil,
	}
    local game_client = {}

	local flying,bv,bav,h,c,cam,nc,Clip,rstr
	local p = game.Players.LocalPlayer
	local buttons = {W = false, S = false, A = false, D = false, Moving = false}

    local ESPSettings = {
        PlayerESP = {
            Enabled = getgenv()._esp,
            TracersOn = getgenv()._esptracers,
            BoxesOn = getgenv()._espboxes,
            NamesOn = getgenv()._espnames,
            DistanceOn = getgenv()._espdistance,
            AttachShift = getgenv()._esptracerattachshift,
            HealthOn = getgenv()._esphealth,
            ToolOn = getgenv()._esptool,
            TeamMates = getgenv()._espteamcheck,
            FaceCamOn = false,
            Distance = 2000,
        },
        ScrapESP = {
            Enabled = false,
            Distance = 2000,
            LegendaryOnly = true,
            RareOnly = true,
            GoodOnly = true,
            BadOnly = true
        },
        SafeESP = {
            Enabled = false,
            Distance = 2000,
            BigOnly = true,
            SmallOnly = true
        },
        RegisterESP = {
            Enabled = false,
            Distance = 2000
        },
        ESPColor = Color3.fromRGB(255, 255, 255),
        ToolColor = Color3.fromRGB(255, 255, 255)
    }

    local Players = game:GetService("Players")
    local Mouse = Player:GetMouse()
    local RunService = game:GetService("RunService")

    --STUFF THAT NEEDS TO RUN AT EXECUTE
	if isfile("/mopsHub/settings_polybattle.mhs") then
		local s,e = pcall(function()
			local file_settings = readfile("/mopsHub/settings_polybattle.mhs")
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
		autoLoadConfigs = true
		writefile("/mopsHub/settings_polybattle.mhs", tostring(game:GetService("HttpService"):JSONEncode(settings)))
		print("[mopsHub Debug]: Created local config file.")
	end

    getgenv()._esptracerattachshift = 1
    getgenv()._WINDOW = {
		Tabs = {},
	}

	--WINDOW CONFIG
	local _TABS = {
		"Weapon",
		"Visual",
		"Character",
		"Credits"
	}
    local _FUNCTIONS = {
        ["Weapon"] = {
			{
				Function = "CreateSection",
				Args = "━ Aimbot ━",
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
            {
                Function = "CreateSection",
                Args = "━ Gun Mods ━",
            },
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Infinite Ammo",
					Flag = "_infammo",
					Callback = function(Value)
						getgenv()._infammo = Value
                        for _,v in pairs(game_client:getWeapons()) do print(v) if v.AMMO then v.AMMO = math.huge; v.MAX_AMMO = math.huge end end
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "No Recoil",
					Flag = "_norecoil",
					Callback = function(Value)
						getgenv()._norecoil = Value
                        for _,v in pairs(game_client:getWeapons()) do print(v) if v.RECOIL then v.RECOIL = 0 end end
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Rapid Fire",
					Flag = "_rapidfire",
					Callback = function(Value)
						getgenv()._rapidfire = Value
                        for _,v in pairs(game_client:getWeapons()) do print(v) if v.RPM then v.RPM = 10000 end end
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Automatic",
					Flag = "_auto",
					Callback = function(Value)
						getgenv()._auto = Value
                        for _,v in pairs(game_client:getWeapons()) do print(v) if v.SHOOT_MODE then v.SHOOT_MODE = 2 end end
					end,
				}
			},
            {
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Notes:",Content = "Toggling an option might cause a short lag spike.\nTo disable it you need to respawn once."}
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
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Boxes",
					Flag = "_espboxes",
					Callback = function(Value)
						getgenv()._espboxes = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Tracers",
					Flag = "_esptracers",
					Callback = function(Value)
						getgenv()._esptracers = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateDropdown",
				_envState = "Bottom",
				Args = {
					Name = "Tracers Orientation",
					Flag = "_tracersorientation",
					Options = {"Bottom","Middle","Top"},
					CurrentOption = "Bottom",
					Callback = function(Value)
                        local v = 0

                        if Value == "Bottom" then
                            v = 1
                        elseif Value == "Middle" then
                            v = 2
                        elseif Value == "Top" then
                            v = 1000
                        end
						getgenv()._esptracerattachshift = v or 0
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Names",
					Flag = "_espnames",
					Callback = function(Value)
						getgenv()._espnames = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Health",
					Flag = "_esphealth",
					Callback = function(Value)
						getgenv()._esphealth = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Distance",
					Flag = "_espdistance",
					Callback = function(Value)
						getgenv()._espdistance = Value
                        getgenv().updateespvalues()
					end,
				}
			},
            {
				Function = "CreateToggle",
				_envState = true,
				Args = {
					Name = "Team Check",
					Flag = "_espteamcheck",
					Callback = function(Value)
						getgenv()._espteamcheck = not Value
                        getgenv().updateespvalues()
					end,
				}
			},
        },
		["Character"] = {
			{
				Function = "CreateSection",
				Args = "━ Fly ━",
			},
            {
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Fly",
					Flag = "_fly",
					Callback = function(Value)
						getgenv()._fly = Value
						if Value == true then
							game_client:fly()
						else
							game_client:unfly()
						end
					end,
				}
			},
            {
                Function = "CreateSlider",
                _envState = 50,
                Args = {
                    Name = "Fly Speed",
                    Flag = "_flyspeed",
                    CurrentValue = 50,
                    Range = {0, 200},
					Increment = 1,
					Suffix = "",
                    Callback = function(Value)
                        getgenv()._flyspeed = Value
                    end
                }
            },
			{
				Function = "CreateSection",
				Args = "━ NoClip ━",
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "NoClip",
					Flag = "_noclip",
					Callback = function(Value)
						getgenv()._noclip = Value
						if Value == true then
							game_client:noclip()
						else
							game_client:clip()
						end
					end,
				}
			},
            {
				Function = "CreateSection",
				Args = "━ Infinite Jump ━"
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
                    CurrentValue = 30,
                    Range = {0, 60},
					Increment = 1,
					Suffix = "",
                    Callback = function(Value)
                        getgenv()._infjumpheight = Value
                    end
                }
            },
			{
				Function = "CreateSection",
				Args = "━ Other ━"
			},
			
        },
    }

    local _CREDITS = {
		["Developers"] = {
			{"ShyFlooo","Programmer"},
		},
	}

    --Functions | Source: some self made

    --CREATE WINDOW
	local Window = Rayfield:CreateWindow({
		Name = "mopsHub - POLYBATTLE",
		LoadingTitle = "mopsHub - POLYBATTLE",
		LoadingSubtitle = "by ShyFlooo",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "/mopsHub/.config", -- Create a custom folder for your hub/game
			FileName = "mopshub_blacksitezeta"
		}, 
		KeySystem = false, -- Set this to true to use our key system
		KeySettings = {
			Title = "mopsHub - POLYBATTLE",
			Subtitle = "Key System",
			Note = "Key here (copied): discord.gg/g4EGAwjUAK",
			FileName = "MOPSHUBKEY",
			SaveKey = true,
			GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
			Key = "bUftwfaTxaoD8Pf2iExzyyRkdVLJRcmyT"
		}
	})

	--SETUP WINDOW
	for index, name in pairs(_TABS) do
		local w = Window:CreateTab(name)
		getgenv()._WINDOW.Tabs[name] = w
	end
    getgenv()._WINDOW.Tabs["Credits"]:CreateSection("━ Credits ━")
	for index, value in pairs(_CREDITS) do
		local content = ""
		for i,data in pairs(value) do
			if #data[2] > 0 then
				content = content.."\n"..data[1].." - ".. data[2]
			else
				content = content.."\n"..data[1]
			end
		end
		getgenv()._WINDOW.Tabs["Credits"]:CreateParagraph({Title = index, Content = content})
	end

	for index, funcs in pairs(_FUNCTIONS) do
		print("Loaded "..#funcs.." function(s) for ".. index)
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
						else
							l = false
						end; if l == true then
							--print("Created function "..tostring(func.Args.Flag or func.Args or "unknown").. " for ".. index.. " ["..string.gsub(func.Function, "Create", "").. "]")
						else
							print("Unable to create "..tostring(func.Function).. " function for ".. index .. " ["..i.."]")
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
    
    --> Functions
	local function randomString()
		local length = math.random(10,20)
		local array = {}
		for i = 1, length do
			array[i] = string.char(math.random(32, 126))
		end
		return table.concat(array)
	end;  function game_client:teleportPlayer(cframe, yield)
		if not Player.Character and not Player.Character.HumanoidRootPart and not typeof(cframe) == "CFrame" then return end
		local hrp = Player.Character.HumanoidRootPart
		local t = game:GetService("TweenService"):Create(hrp, TweenInfo.new(1), {CFrame = cframe})
		t:Play()
		if yield then
			t.Completed:Wait()
		end
	end; function game_client:fly()
		if not p.Character or not p.Character.Head or flying then return end
		c = p.Character
		h = c.Humanoid
		h.PlatformStand = true
		cam = workspace:WaitForChild('Camera')
		bv = Instance.new("BodyVelocity")
		bav = Instance.new("BodyAngularVelocity")
		bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
		bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
		bv.Parent = c.Head
		bav.Parent = c.Head
		flying = true
		h.Died:Connect(function() flying = false end)
	end; function game_client:unfly()
		if not p.Character or not flying then return end
		h.PlatformStand = false
		bv:Destroy()
		bav:Destroy()
		flying = false
	end; function game_client:noclip()
		Clip = false
		local function ncl()
			if Clip == false and Player.Character ~= nil then
				for _, child in pairs(Player.Character:GetDescendants()) do
					if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= rstr then
						child.CanCollide = false
					end
				end
			end
		end
		nc = RunService.Stepped:Connect(ncl)
	end; function game_client:clip()
		if nc then
			nc:Disconnect()
		end
	end; function game_client:getWeapons()
        local weapons = {}
        for _,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "AMMO") and rawget(v, "MAX_AMMO") then
                table.insert(weapons,v)
            end
        end
        return weapons
    end;


	getgenv().game_client = game_client

	rstr = randomString()
    getgenv().updateespvalues = function()
        ESPFramework.Color = ESPSettings.ESPColor
        ESPFramework.ToolColor = ESPSettings.ToolColor
        ESPFramework.Tracers = getgenv()._esptracers
        ESPFramework.Names = getgenv()._espnames
        ESPFramework.Health = getgenv()._esphealth
        ESPFramework.Distance = getgenv()._espdistance
        ESPFramework.Tool = getgenv()._esptool
        ESPFramework.Boxes = getgenv()._espboxes
        ESPFramework.FaceCamera = ESPSettings.PlayerESP.FaceCamOn
        ESPFramework.TeamMates = getgenv()._espteamcheck
        ESPFramework.AttachShift = getgenv()._esptracerattachshift
        ESPFramework:Toggle(getgenv()._esp)
    end; getgenv().updateespvalues()

	--> MAIN

    --Gun Mods | Source: self made

    RunService.RenderStepped:Connect(function()
        local gun = nil
		if not Player.Character then return end
        for _,v in pairs(Player.Character:GetChildren()) do
            if v:FindFirstChild("config") then
                gun = require(v:FindFirstChild("config"))
            end
        end
        if getgenv()._infammo then
            if gun.AMMO then gun.AMMO = math.huge; gun.MAX_AMMO = math.huge end
        end
        if getgenv()._norecoil then
            if gun.RECOIL then gun.RECOIL = 0 end
        end
        if getgenv()._rapidfire then
            if gun.RPM then gun.RPM = 10000 end
        end
        if getgenv()._auto then
           if gun.SHOOT_MODE then gun.SHOOT_MODE = 2 end
        end
    end)

	--Silent Aim

	local function ClosestPlayerToCursor()
		local MaxDistance, Closest = math.huge
		for i,v in pairs(Players.GetPlayers(Players)) do
			if v ~= Player and v.Character and v.TeamColor ~= Player.TeamColor then
				local Head = v.Character.FindFirstChild(v.Character, "Head")
				if Head then
					local Pos, Vis = Workspace.CurrentCamera.WorldToScreenPoint(Workspace.CurrentCamera, Head.Position)
					if Vis then
						local A1, A2 = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
						local Dist = (A2 - A1).Magnitude
						if Dist < getgenv().fov and Dist <= math.huge and getgenv()._slientaimbot then
							MaxDistance = Dist
							Closest = v
						end
					end
				end
			end
		end
		return Closest
	end


	local OldNameCall = nil
	OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
		local Args = {...}
		if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() then
			local target = ClosestPlayerToCursor()
			if target and target.Character and target.Character.FindFirstChild(target.Character, "HumanoidRootPart") then
				Args[1] = Ray.new(Workspace.CurrentCamera.CFrame.Position, (target.Character.HumanoidRootPart.Position - Workspace.CurrentCamera.CFrame.Position).Unit * 1000)
				return OldNameCall(self, unpack(Args))
			end
		end
		return OldNameCall(self, ...)
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

	RunService.Stepped:Connect(function()
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
	end)

    --Infinite Jump | Source: idk

	local function Action(Object, Function) if Object ~= nil then Function(Object); end end

	game:GetService('UserInputService').InputBegan:Connect(function(UserInput)
		if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
			if not getgenv()._infjump then return end
			Action(game:GetService('Players').LocalPlayer.Character.Humanoid, function(self)
				if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
					Action(self.Parent.HumanoidRootPart, function(self)
						self.Velocity = Vector3.new(0, getgenv()._infjumpheight or 50, 0);
					end)
				end
			end)
		end
	end)

    --Walkspeed Hook | Source: self made, well its just a simple hook

	task.spawn(function()
		local gmt = getrawmetatable(game)
		setreadonly(gmt, false)
		local oldindex = gmt.__index
		gmt.__index = newcclosure(function(self,b)
			if b == "WalkSpeed" then
				return 16
			end
			return oldindex(self,b)
		end)
	end)

	--Fly | Source: idk

	game:GetService("UserInputService").InputBegan:connect(function (input, GPE)
		if GPE then return end
		for i, e in pairs(buttons) do
			if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
				buttons[i] = true
				buttons.Moving = true
			end
		end
	end)

	game:GetService("UserInputService").InputEnded:connect(function (input, GPE)
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
		return vec * (getgenv()._flyspeed / vec.Magnitude)
	end
	
	game:GetService("RunService").Heartbeat:connect(function (step) -- The actual fly function, called every frame
		if flying and c and c.PrimaryPart then
			local p = c.PrimaryPart.Position
			local cf = cam.CFrame
			local ax, ay, az = cf:toEulerAnglesXYZ()
			c:SetPrimaryPartCFrame(CFrame.new(p.X, p.Y, p.Z) * CFrame.Angles(ax, ay, az))
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
end)
if not s and e then
    print("[mopsHub Error]: "..e)
end
