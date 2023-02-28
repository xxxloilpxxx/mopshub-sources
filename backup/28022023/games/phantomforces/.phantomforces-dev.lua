--mopsHub Phantom Forces [DEV] | 2022
local s,e = pcall(function()
	getgenv = getgenv

	repeat
		task.wait()
	until game:IsLoaded()
	getgenv().__mpho_1__loaded__ = true
	
	--MODULES
	local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
	local Notify = AkaliNotif.Notify;
	local writeclipboard,encodeb64,decodeb64,Request = ((syn and syn.write_clipboard) or setclipboard),((syn and syn.crypt.base64.encode) or (Krnl and Krnl.Base64.Encode)),((syn and syn.crypt.base64.decode) or (Krnl and Krnl.Base64.Decode)),(http_request or syn and syn.request or request or nil)
	local game_client = {}
	local _players = {}
	local Players = game:GetService("Players")
	local Player = Players.LocalPlayer
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local settings = {
		autoLoadConfigs = nil,
	}
	local fake_rep_object = nil
	local Blacklisted = {"Flame", "SightMark", "SightMark2A", "Tip", "Trigger"}
	local camera = workspace.CurrentCamera;

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
	getgenv().camera = {
		no_sway = false,
		no_shake = false,
	}
	getgenv()._hextsize = 5
	getgenv()._hexttransparency = 0.5
	getgenv()._hteamcolor = false

	getgenv()._hitbox = "Head"

	--CHECK GAME CLIENT PATCH
	--Get Client Stuff
	do
		local garbage = getgc(true)
		local loaded_modules = getloadedmodules()

		for i = 1, #garbage do
			local v = garbage[i]
			if typeof(v) == "table" then
				if rawget(v, "send") then 
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

		if game_client.particle and game_client.replication_interface then
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
		end
	end;
	if not game_client.particle and not game_client.replication_interface and not game_client.replication_object and not game_client.main_camera_object and not game_client.physics then
		if writeclipboard then
			writeclipboard("discord.gg/g4EGAwjUAK")
		else
			warn("[mopsHub Loader Error]: Missing function writeclipboard. Your executor might be too bad and doesn't support it!")
		end
		warn("Unable to get client modules on actor.\n\nJoin the discord for help: ".. "discord.gg/g4EGAwjUAK")
		return Notify({
			Title = "<font color='#ff0000'>Actor error.</font>",
			Description = "Unable to get client modules on actor.<br /><br />Join our discord server for help: <font color='#7289da'>discord.gg/g4EGAwjUAK</font> (copied)",
			Duration = 60,
		})
	end

	local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

	--WINDOW CONFIG
	local _TABS = {
		"Weapon",
		"Visual",
		"Character",
		"Misc",
		"Testing",
		"Settings",
		"Credits"
	}

	local _FUNCTIONS = {
		["Testing"] = {
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Note:",Content = "Everything here is being tested and might not work or even crash ur game lol"}
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Fast Equip",
					Flag = "_fastequip",
					Callback = function(Value)
						getgenv()._fastequip = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "lol",
					Flag = "_lol",
					Callback = function(Value)
						getgenv()._lol = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Auto Spot (dont use it kicks you)",
					Flag = "_autospot",
					Callback = function(Value)
						getgenv()._autospot = Value
						local s,e = pcall(function()
							local function getEnemies()
								local plrs = {}
								for i,v in pairs(game.Players:GetPlayers()) do
									local char = game_client:get_character(v)
									
									if v ~= Player and char and v.Team ~= Player.Team then
										table.insert(plrs,v)
									end
								end
								return plrs
							end
							RunService.RenderStepped:Connect(function(...)
								game_client.network:send("spotplayers", getEnemies())
							end)
						end)
						if not s then print(e) end
					end,
				}
			},
		},
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
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Trigger Bot",
					Flag = "_triggerbot",
					Callback = function(Value)
						getgenv()._triggerbot = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState =  false,
				Args = {
					Name = "Visible Check",
					Flag = "visibleCheck",
					Callback = function(Value)
						getgenv().visibleCheck = Value
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState =  0,
				Args = {
					Name = "Hit Randomization",
					Flag = "randomization",
                    Range = {0, 1},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = 0,
					Callback = function(Value)
						getgenv().randomization = Value
					end,
				}
			},
			{
				Function = "CreateDropdown",
				_envState = "Random",
				Args = {
					Name = "Hit Part",
					Flag = "targetedPart",
					Options = {"Random","Head","Torso"},
					CurrentOption = getgenv().targetedPart or "Random",
					Callback = function(Value)
						getgenv().targetedPart = Value
					end,
				}
			},
			{
				Function = "CreateSlider",
				_envState = 50,
				Args = {
					Name = "Head Hit Chance",
					Flag = "headChance",
					Range = {0, 100},
					Increment = 1,
					Suffix = "%",
					CurrentValue = 50,
					Callback = function(Value)
						getgenv().headChance = math.clamp(Value/100, 0, 100)
					end,
				}
			},
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Note:",Content = "Head Hit Chance only works, if Hit Part is set to 'Random'."}
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
				_envState = false,
				Args = {
					Name = "Automatic",
					Flag = "_automatic",
					Callback = function(Value)
						getgenv()._automatic = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Instant Reload",
					Flag = "_instreload",
					Callback = function(Value)
						getgenv()._instreload = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Instant Equip",
					Flag = "_instequip",
					Callback = function(Value)
						getgenv()._instequip = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "No Sway",
					Flag = "_nosway",
					Callback = function(Value)
						getgenv().camera.no_sway = Value
					end,
				}
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "No Camera Shake",
					Flag = "_nocamshake",
					Callback = function(Value)
						getgenv().camera.no_shake = Value
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
				_envState = false,
				Args = {
					Name = "ESP",
					Flag = "_esp",
					Callback = function(Value)
						getgenv().esp.enabled = Value
						getgenv().esp.text.enabled = Value
						getgenv().esp.highlight_target.enabled = Value
					end,
				}
			},
			{
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
					Name = "Chams",
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
			},
            {
				Function = "CreateSection",
				Args = "━ ESP Customization ━"
			},
            {
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Box Color",
                    Flag = "_espboxcolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._espboxcolor = Value
                        getgenv().esp.misc_layout.box.color = Value
                    end
                }
            },
            {
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Chams Fill Color",
                    Flag = "_espchamsfillcolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._espchamsfillcolor = Value
                        getgenv().esp.misc_layout.highlight.fill = Value
                    end
                }
            },
            {
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Chams Outline Color",
                    Flag = "_espchamsoutlinecolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._espchamsoutlinecolor = Value
                        getgenv().esp.misc_layout.highlight.outline = Value
                    end
                }
            },
            {
				Function = "CreateSlider",
				_envState = 1,
				Args = {
					Name = "Chams Fill Transparency",
					Flag = "_espchamsfilltrans",
					Range = {0, 1},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = 1,
					Callback = function(Value)
						getgenv()._espchamsfilltrans = Value
                        getgenv().esp.misc_layout.highlight.filltrans = Value
					end,
				}
			},
            {
				Function = "CreateSlider",
				_envState = 0,
				Args = {
					Name = "Chams Outline Transparency",
					Flag = "_espchamsoutlinetrans",
					Range = {0, 1},
					Increment = 0.1,
					Suffix = "",
					CurrentValue = 0,
					Callback = function(Value)
						getgenv()._espchamsoutlinetrans = Value
                        getgenv().esp.misc_layout.highlight.outlinetrans = Value
					end,
				}
			},
            {
                Function = "CreateColorPicker",
                _envState = Color3.fromRGB(255,255,255),
                Args = {
                    Name = "Text Color",
                    Flag = "_esptextcolor",
                    Color = Color3.fromRGB(255,255,255),
                    Callback = function(Value)
						getgenv()._esptextcolor = Value
                        getgenv().esp.text.color = Value
                    end
                }
            },
            {
                Function = "CreateToggle",
                _envState = false,
                Args = {
                    Name = "Rainbow Colors",
                    Flag = "_esprainbowcolors",
                    CurrentValue = false,
                    Callback = function(Value)
                        getgenv()._esprainbowcolors = Value
                        if Value == true then game_client:enableESPRainbow() end
                    end
                }
            },
            {
				Function = "CreateSection",
				Args = "━ Radar Hack ━"
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Show enemies on radar",
					Flag = "_enemiesonradar",
					Callback = function(Value)
						getgenv()._enemiesonradar = Value
						game_client:toggleShowEnemiesOnRadar()
					end,
				}
			},
			{
				Function = "CreateSection",
				Args = "━ Hitbox Extender ━"
			},
			--[[{
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
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Head Team Color",
					Flag = "_hteamcolor",
					Callback = function(Value)
						getgenv()._hteamcolor = Value
					end,
				}
			},]]
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Note:",Content = "Currently patched. :("}
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
				Args = "━ Walkspeed Changer ━"
			},
			{
				Function = "CreateSlider",
				_envState = 16,
				Args = {
					Name = "Walkspeed Modifier",
					Flag = "_walkspeed",
					Range = {0, 40},
					Increment = 1,
					Suffix = "",
					CurrentValue = 16,
					Callback = function(Value)
						getgenv()._walkspeed = Value
					end,
				}
			},
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Notes:",Content = "! Switch your weapon once to apply the walkspeed !\nSadly the walkspeed can't be higher than 40 due the anticheat."}
			},
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
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "Bunny Hop",
					Flag = "_bhop",
					Callback = function(Value)
						getgenv()._bhop = Value
					end,
				}
			},
			{
				Function = "CreateParagraph",
				_envState = false,
				Args = {Title = "Notes:",Content = "Hold the spacebar to Bunny Hop!"}
			},
			{
				Function = "CreateSection",
				Args = "━ Other ━"
			},
			{
				Function = "CreateToggle",
				_envState = false,
				Args = {
					Name = "No Fall Damage",
					Flag = "_nofalldamage",
					Callback = function(Value)
						getgenv()._nofalldamage = Value
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
			{
				Function = "CreateSection",
				Args = "━ Other ━"
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
		Name = "mopsHub - Phantom Forces [DEV BUILD]",
		LoadingTitle = "mopsHub - Phantom Forces [DEV BUILD]",
		LoadingSubtitle = "by ShyFlooo",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "/mopsHub/.config", -- Create a custom folder for your hub/game
			FileName = "mopshub_phantomforces_dev"
		}, 
		KeySystem = true, -- Set this to true to use our key system
		KeySettings = {
			Title = "mopsHub - Phantom Forces [DEV BUILD]",
			Subtitle = "Key System",
			Note = "only devs or testers can get a key",
			FileName = "MOPSHUBKEY_DEV",
			SaveKey = true,
			GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
			Key = "mopshubdevbuild_pf_f2iyRkdExzyVLJRc"
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

	--> MAIN

	local old_set_sway = game_client.main_camera_object.setSway
	local old_shake = game_client.main_camera_object.shake

	--Client Functions
	function game_client:setWalkspeed(walkspeed)
		walkspeed = math.clamp(walkspeed,0,40)
		if game_client.weapon_controller_interface.getController() then
			local activeWeaponReg =  game_client.weapon_controller_interface.getController()._activeWeaponRegistry
			for _, reg in pairs(activeWeaponReg) do
				for _, v in pairs(reg) do
					reg._weaponData.walkspeed = walkspeed
				end
			end
		end
	end; function game_client:isEnemy(character)
		if character.Parent.Name == tostring(game.Players.LocalPlayer.TeamColor) then
			return false
		else
			return true
		end
	end; function game_client:setHeadSize(character, headSize)
		sethiddenproperty(character.Head, "Massless", true)
		character.Head.CanCollide = false
		if character.Head.Size ~= Vector3.new(headSize,headSize,headSize) and character.Head.Mesh.Scale ~= Vector3.new(headSize,headSize,headSize) then
			character.Head.Size = Vector3.new(headSize,headSize,headSize)
			character.Head.Mesh.Scale = Vector3.new(headSize,headSize,headSize)
		end
	end; function game_client:addPlayer(plr)
		if plr then
			_players[plr] = plr
		end
	end; function game_client:removePlayer(plr)
		if rawget(_players, plr) then
			_players[plr] = nil
		end
	end; function game_client:giveAlotAmmo()
		--DETECTED
		local weaponObject = game_client:getActiveWeaponObject()
		if weaponObject then
			weaponObject.addAmmo(weaponObject,9999)
		end
	end; function game_client:inGame()
		local HudScreenGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HudScreenGui")
		if HudScreenGui.Enabled then return true end
		return false
	end; function game_client:inMenu()
		local MenuScreenGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MenuScreenGui")
		if MenuScreenGui.Enabled then return true end
		return false
	end; function game_client:get_character(plr)
		local player  = game_client.replication_interface.getEntry(plr)

		if player then 
			local tp_object = player._thirdPersonObject
			if tp_object then
				return tp_object._character
			end
		end
	end; function game_client:get_health(plr)
		local player = game_client.replication_interface.getEntry(plr)
		if player then
			return player._healthstate.health0, player._healthstate.maxhealth
		end
	end; function game_client:check_status(plr)
		local player = game_client.replication_interface.getEntry(plr)
		
		if player then
			return player._alive
		end
	end; function game_client:get_tool(plr)
		local player = game_client.replication_interface.getEntry(plr)
		if player then 
			local tp_object = player._thirdPersonObject 
			if tp_object then 
				return tp_object._weaponname or ''
			end
		end
	end; function game_client:getPlayerInfo(plr)
		local character = game_client:get_character(plr)
		return {
			character = character,
			health = game_client:get_health(plr),
			tool = game_client:get_tool(plr),
			status = game_client:check_status(plr)
		}
	end; function game_client:getCurrentWeaponRegistry()
		if game_client.weapon_controller_interface.getController() then
			return game_client.weapon_controller_interface.getController()._activeWeaponRegistry or {}
		end
	end; function game_client:getActiveWeaponIndex()
		if game_client.weapon_controller_object and game_client.weapon_controller_interface.getController() then
			return game_client.weapon_controller_object.getActiveWeaponIndex(game_client.weapon_controller_interface.getController())
		end
	end; function game_client:getActiveWeapon()
		if game_client.weapon_controller_object and game_client.weapon_controller_interface.getController() then
			return game_client.weapon_controller_object.getActiveWeapon(game_client.weapon_controller_interface.getController())
		end
	end; function game_client:getActiveWeaponData()
		local weaponObject = game_client:getActiveWeaponObject()

		if weaponObject then
			return weaponObject._weaponData
		else
			return {}
		end
	end; function game_client:toggleShowEnemiesOnRadar()
		local old_is_spotted = game_client.spotting_interface.isSpotted
			game_client.spotting_interface.isSpotted = function(character)
				if game_client.character_interface.isAlive() and getgenv()._enemiesonradar then
					return true
				else
					return old_is_spotted(character)
				end
			end
	end; function game_client:enableESPRainbow()
        task.spawn(function()
            while getgenv()._esprainbowcolors do task.wait()
                getgenv().esp.misc_layout.box.color = Color3.fromHSV((tick() % 5 / 5), 1, 1)
                getgenv().esp.text.color = Color3.fromHSV((tick() % 5 / 5), 1, 1)
                getgenv().esp.misc_layout.highlight.outline = Color3.fromHSV((tick() % 5 / 5), 1, 1)
                if not getgenv()._esprainbowcolors then
                    getgenv().esp.misc_layout.box.color = getgenv()._espboxcolor
                    getgenv().esp.text.color = getgenv()._esptextcolor
                    getgenv().esp.misc_layout.highlight.outline = getgenv()._espchamsoutlinecolor
                    break
                end
            end
        end)
    end;

	--Other Functions
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

	--Silent Aim | Source: https://raw.githubusercontent.com/Spoorloos/scripts/main/silent_aim_v2.lua

	task.spawn(function()
		-- modules
		local newParticle, solveQuartic, entryTable;
		local garbageCollection = getgc(false);

		for i = 1, #garbageCollection do
			local object = garbageCollection[i];
			local source, name = debug.info(object, "sn");
			local script = string.match(source, "%w+$");

			if name == "new" and script == "particle" then
				newParticle = object;
			elseif name == "solve" and script == "physics" then
				solveQuartic = object;
			elseif name == "getEntry" and script == "ReplicationInterface" then
				entryTable = debug.getupvalue(object, 1);
			end
			
			if newParticle and solveQuartic and entryTable then
				break;
			end
		end

		assert(newParticle and solveQuartic and entryTable, "Failed to find module(s)");

		-- functions

		local function getClosest(dir, origin, ignore)
			local _angle = getgenv().fov or 180;
			local _position, _entry;

			for player, entry in next, entryTable do
				local tpObject = entry and entry._thirdPersonObject;
				local character = tpObject and tpObject._character;
				if character and player.Team ~= Player.Team then
					local part = character[getgenv().targetedPart == "Random" and
						(math.random() < (getgenv().headChance or 0.5) and "Head" or "Torso") or
						(getgenv().targetedPart or "Head")];

					local position = part.Position + (part.Size * 0.5 * (math.random() * 2 - 1)) * (getgenv().randomization or 0);
					local s, visible = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, position)

					if not (getgenv().visibleCheck and not isVisible(position, ignore)) and not (getgenv().visibleCheck and not visible) and (getgenv()._slientaimbot or getgenv()._triggerbot) then
						local dot = dir.Unit:Dot((position - origin).Unit);
						local angle = 180 - (dot + 1) * 90;
						if angle < _angle then
							_angle = angle;
							_position = position;
							_entry = entry;
						end
					end
				end
			end
			return _position, _entry;
		end

		local function getTrajectory(dir, velocity, accel, speed)
			local r1, r2, r3, r4 = solveQuartic(
				accel:Dot(accel) * 0.25,
				accel:Dot(velocity),
				accel:Dot(dir) + velocity:Dot(velocity) - speed^2,
				dir:Dot(velocity) * 2,
				dir:Dot(dir));

			local time = (r1>0 and r1) or (r2>0 and r2) or (r3>0 and r3) or r4;
			local bullet = dir/time + velocity + 0.5*accel*time;
			return bullet, time;
		end

		-- hooks
		local old;
		old = hookfunction(newParticle, function(args)
			if debug.info(2, "n") == "fireRound" then
				local position, entry = getClosest(args.velocity, args.visualorigin, args.physicsignore);
				if position and entry then
					local index = table.find(debug.getstack(2), args.velocity);

					args.velocity = getTrajectory(
						position - args.visualorigin,
						entry._velspring._p0,
						-args.acceleration,
						args.velocity.Magnitude);

					debug.setstack(2, index, args.velocity);
				end
			end
			return old(args);
		end);
	end)

	--Rage Bot | Source: self made
	
	task.spawn(function()
		UserInputService.InputBegan:Connect(function(_,typing)
			typing = typing
		end); UserInputService.InputEnded:Connect(function(_,typing)
			typing = typing
		end)
		RunService.RenderStepped:Connect(function()
			if getgenv()._triggerbot and game_client:inGame() and game_client:getActiveWeapon() ~= nil then
				game_client.replication_interface.operateOnAllEntries(function(player, entry)
					local tpObject = entry and entry._thirdPersonObject;
					local character = tpObject and tpObject._character;

					if character and player.Team ~= Player.Team then
						local part = character[getgenv().targetedPart == "Random" and
						(math.random() < (getgenv().headChance or 0.5) and "Head" or "Torso") or
						(getgenv().targetedPart or "Head")];

						local position = part.Position;
						local s, visible = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, position)

						if (isVisible(position, {game.Workspace.Terrain, game.Workspace.Ignore, game.Workspace.CurrentCamera, game.Workspace.Players}) and visible) and character and iswindowactive() and game_client:check_status(player) then
							coroutine.wrap(function()
								game_client.firearm_object.shoot(game_client:getActiveWeapon(), true)
								task.wait(0.1)
								game_client.firearm_object.shoot(game_client:getActiveWeapon(), false)
							end)()
						end
					end
				end)
			end
		end)
	end)

	--ESP | Source: https://raw.githubusercontent.com/LURKLURKLURKLURKLURKLURKLURKLURK/pf/main/esp.lua

	loadstring(game:HttpGet("https://raw.githubusercontent.com/LURKLURKLURKLURKLURKLURKLURKLURK/pf/main/esp.lua"))()

	--Hitbox Extender | Source: self made - PATCHED

	--[[local hsize = 1
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
	end)]]

	--Set Walkspeed | Source: self made

	local HudScreenGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HudScreenGui")

	game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
		if game_client:inGame() then
			game_client:setWalkspeed(getgenv()._walkspeed)
		end
	end)

	HudScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
		if HudScreenGui.Enabled == true then
			game_client:setWalkspeed(getgenv()._walkspeed)
		end
	end)

	--No Fall Damage | Source: self made

	task.spawn(function()
		local Old = game_client.network.send
		game_client.network.send = function(self,Name, ...)
			local args = {...}
			if Name == "falldamage" and getgenv()._nofalldamage then
				return
			end
			return Old(self, Name, unpack(args))
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

	--Bunny Hop | Source Code: https://raw.githubusercontent.com/yukihooked/phantom_forces/main/pf_bhop.lua

	game:GetService("RunService").RenderStepped:Connect(function()
		if getgenv()._bhop and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
			local character_object = game_client.character_interface.getCharacterObject()
			local weapon_controller = game_client.weapon_controller_interface.getController()
			local power = 4 -- This is the hardcoded value for jumping
			if character_object and weapon_controller then
				if character_object._floorMaterial == Enum.Material.Air then
					return
				end

				local active_weapon = weapon_controller:getActiveWeapon()
				if active_weapon:getWeaponType() == "Melee" then
					power = power * 1.15
				end

				local velocity_y = character_object._rootPart.Velocity.y
				power = power and (2 * game.Workspace.Gravity * power) ^ 0.5 or 40
				local jump_power = power
				if velocity_y < 0 then
					jump_power = power
				end

				if character_object._movementMode == "prone" or character_object._movementMode == "crouch" then
					character_object:setMovementMode("stand")
					return
				end

				if active_weapon:getWeaponType() == "Firearm" and active_weapon:isAiming() then
					character_object._humanoid.JumpPower = jump_power
					character_object._humanoid.Jump = true
					return true
				end
				character_object._humanoid.JumpPower = jump_power
				character_object._humanoid.Jump = true
			end
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
		
		--Gun Mods
		if game_client:inMenu() then
			game_client.main_camera_object.setSway = function(self, amount)
				local sway = amount
				
				return old_set_sway(self, sway)
			end
			game_client.main_camera_object.shake = function(self, amount)
				local shake = amount
		
				return old_shake(self, shake)
			end
		elseif game_client:inGame() then
			if getgenv().camera.no_sway then
				game_client.main_camera_object.setSway = function(self, amount)
					local sway = getgenv().camera.no_sway and 0 or amount
					
					return old_set_sway(self, sway)
				end
			else
				game_client.main_camera_object.setSway = function(self, amount)
					local sway = amount
					
					return old_set_sway(self, sway)
				end
			end
			if getgenv().camera.no_shake then
				game_client.main_camera_object.shake = function(self, amount)
					local shake = getgenv().camera.no_shake and Vector3.zero or amount
			
					return old_shake(self, shake)
				end
			else
				game_client.main_camera_object.shake = function(self, amount)
					local shake = amount
			
					return old_shake(self, shake)
				end
			end

			--Automatic Weapon
			if getgenv()._automatic and game_client:getActiveWeapon() ~= nil then
				for _,v in pairs(game_client:getCurrentWeaponRegistry()) do
					pcall(function()
						if(v._weaponData and v._weaponData.firemodes) then
							v._weaponData.firemodes = { true }
						end
					end)
				end
			end

			--Instant Equip
			if getgenv()._instequip and game_client:getActiveWeapon() ~= nil then
				for _,v in pairs(game_client:getCurrentWeaponRegistry()) do
					pcall(function()
						if(v._weaponData and v._weaponData.equipspeed) then
							v._weaponData.equipspeed = tick()
						end
					end)
				end
			end

			--Instant Reload
			if getgenv()._instreload and game_client:getActiveWeapon() ~= nil then
				for _,v in pairs(game_client:getCurrentWeaponRegistry()) do
					pcall(function()
						if(v._weaponData and v._weaponData.animations) then
							for _,animation in pairs(v._weaponData.animations) do
								if typeof(animation) == "table" then
									if string.find(string.lower(_), "reload") then
										animation.timescale = 0
									end
								end
							end
						end
					end)
				end
			end
		end
	end)

	getgenv().game_client = game_client
	
	if settings.autoLoadConfigs then
		Rayfield:LoadConfiguration()
	end
end)
if not s and e then
	error("[mopsHub Error]: "..e)
end