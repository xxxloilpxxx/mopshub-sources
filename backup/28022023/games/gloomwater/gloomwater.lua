local s,e = pcall(function()
    --if not (game.PlaceId == 9520715797) then return end
    repeat
		task.wait()
	until game:IsLoaded()
    --if getgenv().__mpho_1__loaded__ == true then return warn("[mopsHub Loader]: mopsHub is already loaded.") end
	getgenv().__mpho_1__loaded__ = true

    getgenv = getgenv
	_G.KeyCode = "X"

    --MODULES & VARIABLES
	local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
	local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
	local Notify = AkaliNotif.Notify;
    local ESPFramework = loadstring(game:HttpGet("https://raw.githubusercontent.com/NougatBitz/Femware-Leak/main/ESP.lua", true))()
	loadstring(game:HttpGet("https://shattered-gang.lol/scripts/fe/touch_fling.lua"))()
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
        ESPColor = Color3.fromRGB(0, 0, 0),
        ToolColor = Color3.fromRGB(255, 255, 255)
    }

	--> Get Client Stuff
    function loadClientStuff()
		local garbage = getgc(true)
		local loaded_modules = getloadedmodules()
		
		for i = 1, #garbage do
			local v = garbage[i]
			if typeof(v) == "table" then
				if rawget(v, "")  then
					
                end
			end
		end
	end; loadClientStuff()

    local Players = game:GetService("Players")
    local Mouse = Player:GetMouse()
    local RunService = game:GetService("RunService")

    --STUFF THAT NEEDS TO RUN AT EXECUTE
	if isfile("/mopsHub/settings_gloomwater.mhs") then
		local s,e = pcall(function()
			local file_settings = readfile("/mopsHub/settings_gloomwater.mhs")
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
		writefile("/mopsHub/settings_gloomwater.mhs", tostring(game:GetService("HttpService"):JSONEncode(settings)))
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
		"Misc",
		"Credits"
	}

    local _FUNCTIONS = {
		["Weapon"] = {
			{
                Function = "CreateSection",
                Args = "━ Kill All ━",
            },
			{
				Function = "CreateButton",
				_envState =  false,
				Args = {
					Name = "Kill All",
					Callback = function()
						game_client:killall()
					end,
				}
			},
			{
				Function = "CreateDropdown",
				_envState = "Baton",
				Args = {
					Name = "Kill All Method",
					CurrentOption = "Baton",
					Options = {"Baton", "Machete", "Pocket Knife"},
					Flag = "_killallmethod",
					Callback = function(Option)
						getgenv()._killallmethod = Option
					end
				},
			},
			{
                Function = "CreateSection",
                Args = "━ Give Tool ━",
            },
			{
				Function = "CreateDropdown",
				_envState = "Pocket Knife",
				Args = {
					Name = "Steal Item Tool",
					CurrentOption = "Pocket Knife",
					Options = {"Baton", "Machete", "Pocket Knife"},
					Flag = "_stealitem",
					Callback = function(Option)
						getgenv()._stealitem = Option
					end
				},
			},
			{
				Function = "CreateButton",
				_envState =  false,
				Args = {
					Name = "Try steal selected Tool",
					Callback = function()
						game_client:give_item(getgenv()._stealitem)
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
				Args = "━ Walspeed Changer ━",
			},
			{
                Function = "CreateSlider",
                _envState = 16,
                Args = {
                    Name = "Walkspeed",
                    Flag = "_walkspeed",
                    CurrentValue = 16,
                    Range = {0, 200},
					Increment = 1,
					Suffix = "",
                    Callback = function(Value)
                        getgenv()._walkspeed = Value
                    end
                }
            },
			{
				Function = "CreateSection",
				Args = "━ Fling ━",
			},
			{
				Function = "CreateInput",
				_envState =  "X",
				Args = {
					Name = "Fling Toggle Keybind",
					PlaceholderText = "Keybind",
					Flag = "_togglekeybind",
					Callback = function(Value)
						_G.KeyCode = tostring(Value)
					end,
				}
			},
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Notes:",Content = "Default Keybind is X."}
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Fling All [ENABLE FLING]",
					Flag = "_flingall",
					Callback = function(Value)
						getgenv()._flingall = Value
					end,
				}
			},
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
		["Misc"] = {
			{
				Function = "CreateSection",
				Args = "━ Chat Spammer ━",
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Chat Spammer",
					Flag = "_chatspam",
					Callback = function(Value)
						getgenv()._chatspam = Value
					end,
				}
			},
			{
				Function = "CreateInput",
				_envState = "SHYFLOOO AND DELU ON TOP",
				Args = {
					Name = "Chat Spam Message",
					Flag = "_chatspammsg",
					PlaceholderText = "Spam Message",
					Callback = function(Text)
						getgenv()._chatspammsg = Text
					end
				}
			},
			{
                Function = "CreateSlider",
                _envState = 1,
                Args = {
                    Name = "Spam Interval",
                    Flag = "_spaminterval",
                    CurrentValue = 0.1,
                    Range = {0, 5},
					Increment = 1,
					Suffix = "",
                    Callback = function(Value)
                        getgenv()._spaminterval = Value
                    end
                }
            },
			{
				Function = "CreateSection",
				Args = "━ Other Useless Stuff ━",
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Spam Random Roleplay Name",
					Flag = "_spamrpname",
					Callback = function(Value)
						getgenv()._spamrpname = Value
					end,
				}
			},
		}
    }

    local _CREDITS = {
		["Developers"] = {
			{"ShyFlooo","mopsHub Lead Programmer"},
			{"Delu#1000/FraudGoat","mopsHub Programmer"},
			{"Anonymous User", "Contributor"}
		},
	}

    --Functions | Source: some self made

    --CREATE WINDOW
	local Window = Rayfield:CreateWindow({
		Name = "mopsHub - LEP : Gloom Water",
		LoadingTitle = "mopsHub - LEP : Gloom Water",
		LoadingSubtitle = "by ShyFlooo and FraudGoat",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "/mopsHub/.config", -- Create a custom folder for your hub/game
			FileName = "mopshub_gloomwater"
		}, 
		KeySystem = false, -- Set this to true to use our key system
		KeySettings = {
			Title = "mopsHub - LEP : Gloom Water",
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
	end; function game_client:hasTool(toolName: string)
		if Player.Character:FindFirstChild(toolName) and Player.Character:FindFirstChild(toolName):IsA("Tool") then
			return true
		end
    end; function game_client:teleportPlayer(cframe, yield)
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
	end; function game_client:killall()
		if game_client:hasTool(getgenv()._killallmethod) then
			for _,v in pairs(game.Players:GetPlayers()) do
				if not (v == game.Players.LocalPlayer) and v.Character and v.Character.Humanoid and not (v.Character.Humanoid.Health > 500) and game.Players.LocalPlayer.Character then
					repeat task.wait()
						local Args = {v.Character.Humanoid, 12}
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
						game:GetService("Players").LocalPlayer.Character[getgenv()._killallmethod].LocalScript.Damage:FireServer(unpack(Args))
						if not v and not v.Character then break end
						if not game:GetService("Players").LocalPlayer.Character:FindFirstChild(getgenv()._killallmethod) then break end;
					until v.Character.Humanoid.Health < 2
				end
				task.wait()
			end
		else
			return Rayfield:Notify({
				Title = "Error Occured",
				Content = string.format("Equip %s to use this kill all method.", getgenv()._killallmethod),
				Duration = 6.5,
			})
		end
	end; function game_client:give_item(item)
		for i,v in pairs (game.Players:GetChildren()) do
			task.wait()
			for _,v in pairs (v.Backpack:GetChildren()) do
				if v.Name == item then
					v.Parent = game.Players.LocalPlayer.Backpack
				end
			end
		end
	end

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

	--> WalkSpeed & JumpPower Changer

	task.spawn(function()
		while task.wait() do
			pcall(function()
				Player.Character.Humanoid.WalkSpeed = getgenv()._walkspeed
			end)
		end
	end)
	
	--> Random Roleplay Name
	
	task.spawn(function()
		while task.wait() do
			if getgenv()._spamrpname then
				local Args = {"Penis", "Penis", "GayBoy",0,1,0}
				game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.RemoteEvent:FireServer(unpack(Args))
			end
		end
	end)

	--Fling All

	task.spawn(function()
		while task.wait() do
			if getgenv()._flingall then
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						Player.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,1,0)
						task.wait(1)
					end
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

	--Chat Spam lol bozos delu on top faggots

	task.spawn(function()
		while task.wait(getgenv()._spaminterval) do
			if getgenv()._chatspam then
				if getgenv()._chatspammsg then
					print(getgenv()._chatspammsg)
					game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv()._chatspammsg, "All")
				end
			end
		end
	end)

	--Fly | Source: Random nerd Lol

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
		return vec * (getgenv()._flyspeed / vec.Magnitude)
	end
	
	game:GetService("RunService").Heartbeat:Connect(function (step) -- The actual fly function, called every frame
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