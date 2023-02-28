--mopsHub Phantom Forces | 2022

local s,e = pcall(function()
    if not (game.PlaceId == 292439477) then return end

	repeat
		task.wait()
	until game:IsLoaded()
	getgenv().__mpho_1__loaded__ = true
    local game_client = {}
    
    --Get Client Stuff
    print("e")

    --Get Client Stuff
	local players = {}
	do
		local garbage = getgc(true)
		local loaded_modules = getloadedmodules()

		for i = 1, #garbage do
			local v = garbage[i]
			if typeof(v) == "table" then
				if rawget(v, "send") and rawget(v, "fetch") then 
					game_client.network = v
				elseif rawget(v, 'goingLoud') and rawget(v, 'isInSight') then 
					game_client.spotting_interface = v
				elseif rawget(v, 'setMinimapStyle') and rawget(v, 'setRelHeight') then 
					game_client.radar_interface = v
				elseif rawget(v, "getCharacterModel") and rawget(v, 'popCharacterModel') then 
					game_client.third_person_object = v
				elseif rawget(v, "getCharacterObject") then 
					game_client.character_interface = v
				elseif rawget(v, "isSprinting") and rawget(v, "getArmModels") then 
					game_client.character_object = v
				elseif rawget(v, "updateReplication") and rawget(v, "getThirdPersonObject") then 
					game_client.replication_object = v
				elseif rawget(v, "setHighMs") and rawget(v, "setLowMs") then 
					game_client.replication_interface = v
				elseif rawget(v, 'setSway') and rawget(v, "_applyLookDelta") then 
					game_client.main_camera_object = v
				elseif rawget(v, 'getActiveCamera') and rawget(v, "getCameraType") then 
					game_client.camera_interface = v
				elseif rawget(v, 'getFirerate') and rawget(v, "getFiremode") then 
					game_client.firearm_object = v
				elseif rawget(v, 'canMelee') and rawget(v, "_processMeleeStateChange") then 
					game_client.melee_object = v
				elseif rawget(v, 'canCancelThrow') and rawget(v, "canThrow") then 
					game_client.grenade_object = v
				elseif rawget(v, "vote") then 
					game_client.votekick_interface = v
				elseif rawget(v, "getActiveWeapon") then 
					game_client.weapon_controller_object = v
				elseif rawget(v, "getController") then 
					game_client.weapon_controller_interface = v
				elseif rawget(v, "updateVersion") and rawget(v, "inMenu") then 
					game_client.chat_interface = v
				elseif rawget(v, "trajectory") and rawget(v, "timehit") then
					game_client.physics = v
				elseif rawget(v, "slerp") and rawget(v, "toanglesyx") then 
					game_client.vector = v
				end
			end
		end

		for i = 1, #loaded_modules do
			local v = loaded_modules[i]
			if v.Name == "PlayerSettingsInterface" then
				game_client.player_settings = require(v)
			elseif v.Name == "PublicSettings" then 
				game_client.public_settings = require(v)
			elseif v.Name == "particle" then 
				game_client.particle = require(v)
			elseif v.Name == "BulletCheck" then 
				game_client.bullet_check = require(v)
			end
		end
	end;

	getgenv().game_client = game_client

    --MODULES
	local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
	local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
	local Notify = AkaliNotif.Notify;
	local writeclipboard,encodeb64,decodeb64,Request = ((syn and syn.write_clipboard) or setclipboard),((syn and syn.crypt.base64.encode) or (Krnl and Krnl.Base64.Encode)),((syn and syn.crypt.base64.decode) or (Krnl and Krnl.Base64.Decode)),(http_request or syn and syn.request or request or nil)
	local Player = game:GetService("Players").LocalPlayer
	local settings = {
		autoLoadConfigs = nil,
	}

    --STUFF THAT NEEDS TO RUN AT EXECUTE
	if isfile("/mopsHub/settings_phantomforces.mhs") then
		local s,e = pcall(function()
			local file_settings = readfile("/mopsHub/settings_phantomforces.mhs")
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
		writefile("/mopsHub/settings_phantomforces.mhs", tostring(game:GetService("HttpService"):JSONEncode(settings)))
		print("[mopsHub Debug]: Created local config file.")
	end

    --ENV
	getgenv()._WINDOW = {
		Tabs = {},
	}
    getgenv()._hextsize = 5
	getgenv()._hexttransparency = 0.5
	getgenv()._hteamcolor = false
	getgenv()._hitbox = "Head"

    --ESP
    local plrs = game:GetService("Players")
    local lp   = plrs.LocalPlayer
    local ws   = game:GetService("Workspace")
    local function disableesp()
         for _,v in pairs(game.CoreGui:GetChildren()) do
             if v:IsA("Highlight") then
                 v:Destroy()
             end
         end
     end
     
     local function isEnemy(character)
        if character.Parent.Name == tostring(lp.TeamColor) then
            return false
        else
            return true
        end
     end
     
     local function createChams(player)
        local newChams = Instance.new("Highlight")
        newChams.Adornee = player
        newChams.Parent = game.CoreGui
     end
     
     local function enableesp()
        for i,v in pairs(ws.Players:GetDescendants()) do
            if isEnemy(v) and v.Name == "Player" then
                createChams(v)
            end
        end
     end

    --WINDOW CONFIG
	local _TABS = {
		"Visual",
		"Character",
		"Misc",
		"Settings",
		"Credits"
	}
    local _FUNCTIONS = {
        ["Visual"] = {
            {
				Function = "CreateSection",
				Args = "━ ESP ━",
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "ESP",
					Flag = "_esp",
					Callback = function(Value)
                        getgenv()._esp = Value
						if Value == true then
                            enableesp()
                        else
                            disableesp()
                        end
						--getgenv().esp.enabled = Value
						--getgenv().esp.text.enabled = Value
						--getgenv().esp.highlight_target.enabled = Value
					end,
				}
			},
			--[[{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Boxes",
					Flag = "_espboxes",
					Callback = function(Value)
						getgenv().esp.misc_layout.box.enabled = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Health",
					Flag = "_esphealth",
					Callback = function(Value)
						getgenv().esp.text_layout.health.enabled = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Health Bar",
					Flag = "_esphealthbar",
					Callback = function(Value)
						getgenv().esp.misc_layout.health.enabled = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Names",
					Flag = "_espnames",
					Callback = function(Value)
						getgenv().esp.text_layout.name.enabled = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Distance",
					Flag = "_espdistance",
					Callback = function(Value)
						getgenv().esp.text_layout.distance.enabled = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Tool",
					Flag = "_esptool",
					Callback = function(Value)
						getgenv().esp.text_layout.tool.enabled = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Highlight",
					Flag = "_esphighlight",
					Callback = function(Value)
						getgenv().esp.misc_layout.highlight.enabled = Value
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState = 8,
				Args = {
					Name = "Font Size",
					Flag = "_espfontsize",
					Range = {1, 30},
					Increment = 1,
					Suffix = "",
					CurrentValue = 13,
					Callback = function(Value)
						getgenv().esp.fontsize = Value
					end,
				}
			},]]
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
					Options = {"Head","Torso"},
					CurrentOption = getgenv()._hitbox or "Head",
					Callback = function(Value)
						getgenv()._hitbox = Value
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState = 8,
				Args = {
					Name = "Hitbox Size",
					Flag = "_hextsize",
					Range = {1, 8},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = getgenv()._hextsize,
					Callback = function(Value)
						getgenv()._hextsize = Value
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
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Note:",Content = "Sadly the size can't be bigger than 8 due the anticheat."}
			},
        },
        ["Character"] = {
            {
				Function = "CreateSection",
				Args = "━ Infinite Jump ━"
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Infinite Jump",
					Flag = "_infjump",
					Callback = function(Value)
						getgenv()._infinitejump = Value
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState = 50,
				Args = {
					Name = "Infinite Jump Height",
					Flag = "_infjumpheight",
					Range = {0, 100},
					Increment = 1,
					Suffix = "",
					CurrentValue = 50,
					Callback = function(Value)
						getgenv()._infjumpheight = Value
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
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Note:",Content = "Its recommended to put the script in your auto execute folder of your executor, so the script can auto load after a join."}
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
						writefile("/mopsHub/settings_phantomforces.mhs", tostring(game:GetService("HttpService"):JSONEncode(settings)))
					end
				}
			},
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Note:",Content = "This means, your recently used settings will automatically load when you execute the script."}
			},
		}
    }

    local _CREDITS = {
		["Special Thanks"] = {
			{"@yukihooked",""},
			{"@mickeydev",""},
			{"@LURKLURKLURKLURKLURKLURKLURKLURK",""}
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

	--CREATE WINDOW
	local Window = Rayfield:CreateWindow({
		Name = "mopsHub - Phantom Forces [TEMP]",
		LoadingTitle = "mopsHub - Phantom Forces [TEMP]",
		LoadingSubtitle = "by ShyFlooo",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "/mopsHub/.config", -- Create a custom folder for your hub/game
			FileName = "mopshub_phantomforces"
		}, 
		KeySystem = true, -- Set this to true to use our key system
		KeySettings = {
			Title = "mopsHub - Phantom Forces [TEMP]",
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

	--> MAIN

    --Functions
    function game_client:inGame()
		local HudScreenGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HudScreenGui")
		if HudScreenGui.Enabled then return true end
		return false
	end; function game_client:inMenu()
		local MenuScreenGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MenuScreenGui")
		if MenuScreenGui.Enabled then return true end
		return false
	end;

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

	local Rejoin = coroutine.create(function()
		local Success, ErrorMessage = pcall(function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
		end)
	
		if ErrorMessage and not Success then
			warn(ErrorMessage)
		end
	end)

    --Hitbox Extender | Source: self made

	local hsize = 1
	local htrans = 0
	game:GetService("RunService").Stepped:Connect(function()
		if getgenv()._hitboxext then
			hsize = getgenv()._hextsize
			htrans = getgenv()._hexttransparency
		else
			hsize = 1
			htrans = 0
		end
		for i,v in next, workspace.Players:GetDescendants() do
			if v:FindFirstChild("Head") and v:FindFirstChild("Torso") and not v:FindFirstChildWhichIsA("MeshPart") then
				if getgenv()._hitbox == "Head" then
					sethiddenproperty(v.Torso, "Massless", false)
					v.Torso.Size = Vector3.new(1,1,1)
					v.Torso.Mesh.Scale = Vector3.new(1,1,1)
					v.Torso.BrickColor = BrickColor.new("Cashmere")
					v.Torso.Transparency = 0
				elseif getgenv()._hitbox == "Torso" then
					sethiddenproperty(v.Head, "Massless", false)
					v.Head.Size = Vector3.new(1,1,1)
					v.Head.Mesh.Scale = Vector3.new(1,1,1)
					v.Head.BrickColor = BrickColor.new("Cashmere")
					v.Head.Transparency = 0
				end
				local s,e = pcall(function()
					sethiddenproperty(v[getgenv()._hitbox], "Massless", true)
					v[getgenv()._hitbox].CanCollide = false
					v[getgenv()._hitbox].Transparency = htrans
	
					if getgenv()._hitbox == "Torso" then
						v[getgenv()._hitbox].Shirt.Transparency = htrans
						v[getgenv()._hitbox].Pant.Transparency = htrans
					else
						v.Torso.Shirt.Transparency = 0
						v.Torso.Pant.Transparency = 0
					end
	
					if v[getgenv()._hitbox].Size ~= Vector3.new(hsize,hsize,hsize) and v[getgenv()._hitbox].Mesh.Scale ~= Vector3.new(hsize,hsize,hsize) then
						v[getgenv()._hitbox].Size = Vector3.new(hsize,hsize,hsize)
						v[getgenv()._hitbox].Mesh.Scale = Vector3.new(hsize,hsize,hsize)
					end
					if getgenv()._hitboxext then
						if getgenv()._hteamcolor and v[getgenv()._hitbox].Parent.Parent.Name == "Bright blue" then
							v[getgenv()._hitbox].BrickColor = BrickColor.new("Bright blue")
						else
							v[getgenv()._hitbox].BrickColor = BrickColor.new("Cashmere")
						end
						if getgenv()._hteamcolor and v[getgenv()._hitbox].Parent.Parent.Name == "Bright orange" then
							v[getgenv()._hitbox].BrickColor = BrickColor.new("Bright orange")
						else
							v[getgenv()._hitbox].BrickColor = BrickColor.new("Cashmere")
						end
					else
						v[getgenv()._hitbox].BrickColor = BrickColor.new("Cashmere")
					end
					
				end)
				if not s and e then
					warn(e)
				end
			end
		end
	end)

    --Infinite Jump | Source: idk

	function Action(Object, Function) if Object ~= nil then Function(Object); end end

	game:GetService('UserInputService').InputBegan:Connect(function(UserInput)
		if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
			if not getgenv()._infinitejump then return end
			Action(game:GetService('Players').LocalPlayer.Character.Humanoid, function(self)
				if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
					Action(self.Parent.HumanoidRootPart, function(self)
						self.Velocity = Vector3.new(0, getgenv()._infjumpheight or 50, 0);
					end)
				end
			end)
		end
	end)

    -- Auto Respawn & Join new server on Votekick & Gun Mods | Source: self made

	local MenuScreenGui = Player.PlayerGui:FindFirstChild("MenuScreenGui")
	local DisplayVoteKick = Player.PlayerGui:FindFirstChild("ChatScreenGui").Main.DisplayVoteKick

	function spawnplr()
		if not keypress then
			return warn("[mopsHub Loader Error]: Missing function keypress. Your executor might be too bad and doesn't support it!")
		end
		keypress(0x20)
		task.wait()
		keyrelease(0x20)
	end
    getgenv().__autorespawn_check_enabled_ = false
	game:GetService("RunService").Stepped:Connect(function()
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
    end)

    --[[Silent Aim | Source: https://raw.githubusercontent.com/Spoorloos/scripts/main/silent_aim_v2.lua

    -- variables
    local players = game:GetService("Players");
    local replicated = game:GetService("ReplicatedFirst");
    local localplayer = players.LocalPlayer;
    local camera = workspace.CurrentCamera;


    local visibleCheck = false
    local targetedPart = "Head"
    local headChance = 1
    local fov = 180

    -- functions
    local function isVisible(position, ignore)
        return #camera:GetPartsObscuringTarget({ position }, ignore) == 0;
    end

    local function getClosest(dir, origin, ignore)
        local _angle = fov or 180;
        local _position, _entry;

        game_client.replication_interface.operateOnAllEntries(function(player, entry)
            local tpObject = entry and entry._thirdPersonObject;
            local character = tpObject and tpObject._character;
            if character and player.Team ~= localplayer.Team then
                local position = character[targetedPart == "Random" and
                    (math.random() < (headChance or 0.5) and "Head" or "Torso") or
                    (targetedPart or "Head")].Position;

                if not (visibleCheck and not isVisible(position, ignore)) then
                    local dot = dir.Unit:Dot((position - origin).Unit);
                    local angle = 180 - (dot + 1) * 90;
                    if angle < _angle then
                        _angle = angle;
                        _position = position;
                        _entry = entry;
                    end
                end
            end
        end);

        return _position, _entry;
    end

    local function trajectory(dir, velocity, accel, speed)
        local t1, t2, t3, t4 = game_client.solve(
            accel:Dot(accel) * 0.25,
            accel:Dot(velocity),
            accel:Dot(dir) + velocity:Dot(velocity) - speed^2,
            dir:Dot(velocity) * 2,
            dir:Dot(dir));

        local time = (t1>0 and t1) or (t2>0 and t2) or (t3>0 and t3) or t4;
        local bullet = 0.5*accel*time + dir/time + velocity;
        return bullet, time;
    end

    -- hooks
    local old;
    old = hookfunction(game_client.particle.new, function(args)
        if debug.info(2, "n") == "fireRound" then
            local position, entry = getClosest(args.velocity, args.visualorigin, args.physicsignore);
            if position and entry then
                local index = table.find(debug.getstack(2), args.velocity);

                args.velocity = trajectory(
                    position - args.visualorigin,
                    entry._velspring._p0,
                    -args.acceleration,
                    args.velocity.Magnitude);

                debug.setstack(2, index, args.velocity);
            end
        end
        return old(args);
    end);]]

    --Old ESP | Source: self made
     
     task.spawn(function()
        ws.Players["Bright orange"].ChildAdded:connect(function(child)
            if not getgenv()._esp then return end
            task.wait(1)
            if isEnemy(child) == true then
                local newChams = Instance.new("Highlight")
                newChams.Parent = child
            end
        end)
     end)
     
     task.spawn(function()
        ws.Players["Bright blue"].ChildAdded:connect(function(child)
            if not getgenv()._esp then return end
            task.wait(1)
            if isEnemy(child) == true then
                local newChams = Instance.new("Highlight")
                newChams.Parent = child
            end
        end)
     end)
     
     task.spawn(function()
        ws.Ignore.DeadBody.ChildAdded:connect(function(child)
            if child:FindFirstChildOfClass("Highlight") then
                child:FindFirstChildOfClass("Highlight"):Destroy()
            end
        end)
     end)
     
     task.spawn(function()
        while task.wait() do
            if getgenv()._esp then
                for i,v in next, workspace.Ignore.DeadBody:GetChildren() do
                    v:Destroy()
                end
            end
        end
     end)

    Notify({
        Title="<font color='#0000ff'>Info</font>",
        Description = "Due the recent update, most of the scripts features got patched. You can now only use the functions that aren't patched! (other features will be added back, when i fixed them)",
        Duration = 15,
    })

    if settings.autoLoadConfigs then
        Rayfield:LoadConfiguration()
    end
end)