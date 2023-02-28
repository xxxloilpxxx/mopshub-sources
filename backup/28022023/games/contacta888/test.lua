-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__RenderStepped__2 = game:GetService("RunService").RenderStepped;
local l__remotes__3 = workspace.mainGame.remotes;
local v4 = require(game.ReplicatedStorage.shared_modules.bFunctions);
local v5 = require(game.ReplicatedStorage.shared_modules.visualEffects);
local v6 = require(game.ReplicatedStorage.shared_modules.weaponVisuals);
local v7 = require(game.ReplicatedStorage.shared_modules.standings);
local v8 = require(game.ReplicatedStorage.shared_modules.baseValues);
local l__UserInputService__9 = game:GetService("UserInputService");
local l__mouse__10 = l__LocalPlayer__1:GetMouse();
local l__anomaly_loadout__11 = l__LocalPlayer__1:WaitForChild("anomaly_loadout", 50);
local l__player_loadout__12 = l__LocalPlayer__1:WaitForChild("player_loadout", 50);
while true do
	l__RenderStepped__2:wait();
	if l__LocalPlayer__1.Character then
		break;
	end;
end;
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
l__remotes__3.audio_relay.OnClientEvent:connect(function(p1)
	v4:soundHandler(p1, true);
end);
l__remotes__3.effects_relay.OnClientEvent:connect(function(p2, p3, p4)
	v5(p2, p3, true, p4);
end);
_G.disable_weaponvfx = false;
l__remotes__3.weapons_vfx_relay.OnClientEvent:connect(function(p5, p6)
	if _G.disable_weaponvfx == false or p5 == "weapon_visibility" then
		v6.vfx(p5, p6, true);
	end;
end);
local l__game__1 = game;
local u2 = true;
local l__Parent__3 = script.Parent;
local l__workspace__4 = workspace;
local l__CurrentCamera__5 = workspace.CurrentCamera;
local function u6()
	if l__LocalPlayer__1.Character:WaitForChild("character_role").Value == "anomaly" and u2 == false then
		return;
	end;
	local v13 = { { "rbxassetid://396983823", Color3.fromRGB(102, 102, 102) }, { "rbxassetid://1483727717", Color3.fromRGB(255, 255, 255) }, { "rbxassetid://7276343317", Color3.fromRGB(124, 55, 55) }, { "rbxassetid://2630738539", Color3.fromRGB(103, 103, 103) }, { "rbxassetid://2630742998", Color3.fromRGB(148, 30, 30) } };
	for v14 = 1, math.random(2, 3) do
		local v15 = l__Parent__3.splatterOverlay.ex:Clone();
		local v16 = v13[math.random(1, #v13)];
		v15.Image = v16[1];
		v15.ImageColor3 = v16[2];
		local v17 = math.random(0, 40);
		if math.random(1, 2) == 1 then
			v17 = math.random(60, 100);
		end;
		local v18 = math.random(0, 40);
		if math.random(1, 2) == 1 then
			v18 = math.random(60, 100);
		end;
		v15.Position = UDim2.new(v17 / 100, 0, v18 / 100, 0);
		local v19 = math.random(20, 50) * 10;
		v15.Size = v15.Size + UDim2.new(0, v19, 0, v19);
		v15.ImageTransparency = 0.025;
		v15.Visible = true;
		v15.Parent = l__Parent__3.splatterOverlay;
		delay(3, function()
			while true do
				v15.ImageTransparency = v15.ImageTransparency + 0.035;
				l__RenderStepped__2:wait();
				if v15.ImageTransparency >= 1 then
					break;
				end;			
			end;
			v15:Destroy();
		end);
	end;
end;
local l__gui__7 = workspace.screen.gui;
local function u8(p7)
	if p7.name == "Fists" then
		return;
	end;
	local v20 = l__Parent__3.human_frame;
	if l__LocalPlayer__1.Character:WaitForChild("character_role").Value == "anomaly" then
		v20 = l__Parent__3.anomaly_frame;
	end;
	local v21 = #v20.inv:GetChildren();
	local v22 = v20.inv.ex:Clone();
	if v21 >= 10 then
		v21 = 0;
	end;
	v22.Name = v21;
	v22.item.Text = "[ " .. v21 .. " ] " .. p7.name;
	v22.assigned.Value = p7.name;
	local v23, v24, v25 = ipairs(v20.inv:GetChildren());
	while true do
		v23(v24, v25);
		if not v23 then
			break;
		end;
		v25 = v23;
		if v24.Name ~= "ex" then
			v24.Position = v24.Position + UDim2.new(0, 0, 0, -30);
		end;	
	end;
	v22.Visible = true;
	v22.Parent = v20.inv;
end;
local function u9()
	local l__human_frame__26 = l__Parent__3.human_frame;
	local v27 = #l__human_frame__26.inv:GetChildren();
	local v28 = l__human_frame__26.inv.ex:Clone();
	v28.Name = v27;
	v28.item.Text = "[ " .. v27 .. " ] EMPTY";
	v28.assigned.Value = "Fists";
	local v29, v30, v31 = ipairs(l__human_frame__26.inv:GetChildren());
	while true do
		v29(v30, v31);
		if not v29 then
			break;
		end;
		v31 = v29;
		if v30.Name ~= "ex" then
			v30.Position = v30.Position + UDim2.new(0, 0, 0, -30);
		end;	
	end;
	v28.Visible = true;
	v28.Parent = l__human_frame__26.inv;
end;
local u10 = false;
l__remotes__3.game_handler.OnClientEvent:connect(function(p8, p9, p10)
	if p8 == "mid_screen" then
		local l__text__32 = p9.text;
		l__Parent__3.mid_screen.Text = p9.text;
		l__Parent__3.mid_screen.Visible = true;
		local v33 = tick();
		while true do
			l__RenderStepped__2:wait();
			if l__Parent__3.mid_screen.Text ~= l__text__32 then
				return;
			end;
			if p9.duration <= tick() - v33 then
				break;
			end;		
		end;
		l__Parent__3.mid_screen.Visible = false;
		return;
	end;
	if p8 == "force_tp_location" and l__LocalPlayer__1.Character then
		spawn(function()
			while l__LocalPlayer__1.Character ~= nil and l__LocalPlayer__1.Character:FindFirstChild("HumanoidRootPart") ~= nil and p9 ~= nil do
				l__LocalPlayer__1.Character.HumanoidRootPart.CFrame = p9;
				l__RenderStepped__2:wait();
				if (l__LocalPlayer__1.Character.HumanoidRootPart.Position - p9.Position).magnitude <= 1 then
					return;
				end;			
			end;
		end);
		return;
	end;
	if p8 == "darkplane_flash" then
		local v34 = l__Parent__3.blackOverlay:Clone();
		v34.BackgroundTransparency = 0;
		v34.BackgroundColor3 = Color3.new(0.2, 0, 0);
		v34.Visible = true;
		v34.Parent = l__Parent__3;
		if p9 == "enter" then
			v4:soundHandler({
				directory = { "abilities" }, 
				soundfile = "teleport_start", 
				location = l__workspace__4
			}, true);
			v4:soundHandler({
				directory = { "terrors" }, 
				soundfile = "shift_ready", 
				location = l__workspace__4
			}, true);
			v4:soundHandler({
				directory = { "abilities" }, 
				soundfile = "teleport_speak", 
				location = l__workspace__4
			}, true);
		else
			v4:soundHandler({
				directory = { "abilities" }, 
				soundfile = "teleport_end", 
				location = l__workspace__4
			}, true);
			v4:soundHandler({
				directory = { "abilities" }, 
				soundfile = "repulsion_cast", 
				location = l__workspace__4
			}, true);
			v4:soundHandler({
				directory = { "abilities", "grave" }, 
				soundfile = "cast", 
				location = l__workspace__4
			}, true);
		end;
		local v35 = tick();
		while true do
			v34.BackgroundTransparency = v34.BackgroundTransparency + 0.01;
			local v36 = tick();
			while true do
				l__RenderStepped__2:wait();
				if tick() - v36 >= 0.03 then
					break;
				end;			
			end;
			if v34.BackgroundTransparency >= 1 then
				break;
			end;		
		end;
	else
		if p8 == "center_flash" then
			local v37 = nil;
			if p9.sound_use then
				v4:soundHandler({
					directory = { "exfil_sounds" }, 
					soundfile = p9.sound_use, 
					location = l__workspace__4
				}, true);
			end;
			local v38 = l__Parent__3.middle_flasher:Clone();
			v38.Text = p9.text;
			v38.Visible = true;
			v38.Parent = l__Parent__3;
			local v39 = 0.05;
			local v40 = 5;
			if p9.sound_use == "exfil_finalcountdown" then
				v38.Position = UDim2.new(0.5, 0, 0.4, 0);
				v39 = 0.15;
				v40 = 0.2;
				v38.Size = UDim2.new(0.085, 0, 0.15, 0);
			end;
			local v41 = tick();
			while true do
				v38.flash.Size = v38.flash.Size + UDim2.new(0, 5, 0, 5);
				v38.flash.BackgroundTransparency = v38.flash.BackgroundTransparency + v39;
				v37 = tick();
				while true do
					l__RenderStepped__2:wait();
					if tick() - v37 >= 0.03 then
						break;
					end;				
				end;
				if v38.flash.BackgroundTransparency >= 1 then
					break;
				end;			
			end;
			local u11 = v37;
			delay(v40, function()
				u11 = tick();
				while true do
					v38.TextTransparency = v38.TextTransparency + 0.1;
					v38.TextStrokeTransparency = v38.TextTransparency;
					u11 = tick();
					while true do
						l__RenderStepped__2:wait();
						if tick() - u11 >= 0.03 then
							break;
						end;					
					end;
					if v38.TextTransparency >= 1 then
						break;
					end;				
				end;
				v38:Destroy();
			end);
			return;
		end;
		if p8 == "exfil_success" or p8 == "exfil_failed" then
			local v42 = nil;
			v4:soundHandler({
				directory = { "exfil_sounds" }, 
				soundfile = p8, 
				location = l__workspace__4
			}, true);
			local v43 = l__Parent__3.exfilOverlay:Clone();
			v43.Name = "exfil_overlay";
			local v44 = "RETURNING TO BASE OF OPERATIONS";
			v43.Visible = true;
			local l__flash__45 = v43.maintext.flash;
			v43.Parent = l__Parent__3;
			v43.maintext.Visible = true;
			if p8 == "exfil_failed" then
				v43.maintext.Text = "EXFILTRATION FAILED";
				v44 = "BODY RECOVERY ETA: UNKNOWN";
			end;
			local v46 = tick();
			while true do
				l__flash__45.Size = l__flash__45.Size + UDim2.new(0, 5, 0, 5);
				l__flash__45.BackgroundTransparency = l__flash__45.BackgroundTransparency + 0.075;
				v42 = tick();
				while true do
					l__RenderStepped__2:wait();
					if tick() - v42 >= 0.03 then
						break;
					end;				
				end;
				if l__flash__45.BackgroundTransparency >= 1 then
					break;
				end;			
			end;
			delay(1, function()
				local v47 = tick();
				for v48 = 1, string.len(v44) do
					local v49 = tick();
					v43.subtext.Text = string.sub(v44, 1, v48);
					v4:soundHandler({
						directory = { "ui" }, 
						soundfile = "text", 
						location = l__CurrentCamera__5
					}, true);
					while true do
						l__RenderStepped__2:wait();
						if tick() - v49 >= 0.05 then
							break;
						end;					
					end;
				end;
				v43.subtext.Text = v44;
			end);
			local u12 = v42;
			delay(4, function()
				u12 = tick();
				while true do
					v43.BackgroundTransparency = v43.BackgroundTransparency + 0.05;
					u12 = tick();
					while true do
						l__RenderStepped__2:wait();
						if tick() - u12 >= 0.03 then
							break;
						end;					
					end;
					if v43.BackgroundTransparency >= 1 then
						break;
					end;				
				end;
				delay(3, function()
					u12 = tick();
					while true do
						v43.maintext.TextTransparency = v43.maintext.TextTransparency + 0.1;
						v43.maintext.TextStrokeTransparency = v43.maintext.TextTransparency;
						v43.subtext.TextTransparency = v43.maintext.TextTransparency;
						v43.subtext.TextStrokeTransparency = v43.maintext.TextTransparency;
						u12 = tick();
						while true do
							l__RenderStepped__2:wait();
							if tick() - u12 >= 0.03 then
								break;
							end;						
						end;
						if v43.maintext.TextTransparency >= 1 then
							break;
						end;					
					end;
					v43:Destroy();
				end);
			end);
			return;
		end;
		if p8 == "mutation_rising" then
			v4:soundHandler({
				directory = { "ui" }, 
				soundfile = "mutation_raise", 
				location = l__workspace__4
			}, true);
			local l__mutation_up__50 = l__Parent__3.mutation_up;
			local v51 = tick();
			for v52 = 1, 20 do
				local v53 = tick();
				l__mutation_up__50.mutationtext.TextTransparency = l__mutation_up__50.mutationtext.TextTransparency - 0.05;
				l__mutation_up__50.mutationicon.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
				l__mutation_up__50.iconright.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
				l__mutation_up__50.iconleft.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
				l__mutation_up__50.mutationicon.Position = l__mutation_up__50.mutationicon.Position - UDim2.new(0, 0, 0, 4);
				l__mutation_up__50.iconright.Position = l__mutation_up__50.iconright.Position - UDim2.new(0, 0, 0, 4);
				l__mutation_up__50.iconleft.Position = l__mutation_up__50.iconleft.Position - UDim2.new(0, 0, 0, 4);
				while true do
					l__RenderStepped__2:Wait();
					if tick() - v53 >= 0.03 then
						break;
					end;				
				end;
			end;
			l__mutation_up__50.mutationtext.TextTransparency = 0;
			l__mutation_up__50.iconright.ImageTransparency = 0;
			l__mutation_up__50.iconleft.ImageTransparency = 0;
			l__mutation_up__50.mutationicon.ImageTransparency = 0;
			if p9[1] then
				l__mutation_up__50.mutation_upgrade1.Text = p9[1];
			end;
			if p9[2] then
				l__mutation_up__50.mutation_upgrade2.Text = p9[2];
			end;
			if p9[3] then
				l__mutation_up__50.mutation_upgrade3.Text = p9[3];
			end;
			local v54 = tick();
			for v55 = 1, 100 do
				local v56 = tick();
				if v55 == 15 and p9[1] then
					v4:soundHandler({
						directory = { "ui" }, 
						soundfile = "mutation_beep", 
						location = l__workspace__4
					}, true);
					l__mutation_up__50.mutation_upgrade1.TextTransparency = 0;
					spawn(function()
						local v57 = tick();
						for v58 = 1, 3 do
							local v59 = tick();
							while true do
								l__RenderStepped__2:wait();
								if tick() - v59 >= 0.05 then
									break;
								end;							
							end;
							l__mutation_up__50.mutation_upgrade1.TextTransparency = 1;
							local v60 = tick();
							while true do
								l__RenderStepped__2:wait();
								if tick() - v60 >= 0.05 then
									break;
								end;							
							end;
							l__mutation_up__50.mutation_upgrade1.TextTransparency = 0;
						end;
					end);
				end;
				if v55 == 25 and p9[2] then
					v4:soundHandler({
						directory = { "ui" }, 
						soundfile = "mutation_beep", 
						location = l__workspace__4
					}, true);
					l__mutation_up__50.mutation_upgrade2.TextTransparency = 0;
					spawn(function()
						local v61 = tick();
						for v62 = 1, 3 do
							local v63 = tick();
							while true do
								l__RenderStepped__2:wait();
								if tick() - v63 >= 0.05 then
									break;
								end;							
							end;
							l__mutation_up__50.mutation_upgrade2.TextTransparency = 1;
							local v64 = tick();
							while true do
								l__RenderStepped__2:wait();
								if tick() - v64 >= 0.05 then
									break;
								end;							
							end;
							l__mutation_up__50.mutation_upgrade2.TextTransparency = 0;
						end;
					end);
				end;
				if v55 == 35 and p9[3] then
					v4:soundHandler({
						directory = { "ui" }, 
						soundfile = "mutation_beep", 
						location = l__workspace__4
					}, true);
					l__mutation_up__50.mutation_upgrade3.TextTransparency = 0;
					spawn(function()
						local v65 = tick();
						for v66 = 1, 3 do
							local v67 = tick();
							while true do
								l__RenderStepped__2:wait();
								if tick() - v67 >= 0.05 then
									break;
								end;							
							end;
							l__mutation_up__50.mutation_upgrade3.TextTransparency = 1;
							local v68 = tick();
							while true do
								l__RenderStepped__2:wait();
								if tick() - v68 >= 0.05 then
									break;
								end;							
							end;
							l__mutation_up__50.mutation_upgrade3.TextTransparency = 0;
						end;
					end);
				end;
				while true do
					l__RenderStepped__2:Wait();
					if tick() - v56 >= 0.03 then
						break;
					end;				
				end;
			end;
			local v69 = tick();
			while true do
				local v70 = tick();
				l__mutation_up__50.mutationtext.TextTransparency = l__mutation_up__50.mutationtext.TextTransparency + 0.05;
				l__mutation_up__50.mutationicon.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
				l__mutation_up__50.iconright.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
				l__mutation_up__50.iconleft.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
				local v71, v72, v73 = ipairs(p9);
				while true do
					v71(v72, v73);
					if not v71 then
						break;
					end;
					v73 = v71;
					l__mutation_up__50["mutation_upgrade" .. v71].TextTransparency = l__mutation_up__50.mutationtext.TextTransparency;				
				end;
				while true do
					l__RenderStepped__2:Wait();
					if tick() - v70 >= 0.03 then
						break;
					end;				
				end;
				if l__mutation_up__50.mutationtext.TextTransparency >= 1 then
					break;
				end;			
			end;
			l__mutation_up__50.iconright.Position = UDim2.new(0.5, 150, 0.5, 0);
			l__mutation_up__50.iconleft.Position = UDim2.new(0.5, -150, 0.5, 0);
			l__mutation_up__50.mutationicon.Position = UDim2.new(0.5, 0, 0.5, 0);
			l__mutation_up__50.mutationtext.TextTransparency = 1;
			l__mutation_up__50.mutationicon.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
			l__mutation_up__50.iconright.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
			l__mutation_up__50.iconleft.ImageTransparency = l__mutation_up__50.mutationtext.TextTransparency;
			l__mutation_up__50.mutation_upgrade1.TextTransparency = l__mutation_up__50.mutationtext.TextTransparency;
			l__mutation_up__50.mutation_upgrade2.TextTransparency = l__mutation_up__50.mutationtext.TextTransparency;
			l__mutation_up__50.mutation_upgrade3.TextTransparency = l__mutation_up__50.mutationtext.TextTransparency;
			return;
		else
			if p8 == "hazard_up" then
				v4:soundHandler({
					directory = { "ui" }, 
					soundfile = "mutation_round", 
					location = l__workspace__4
				}, true);
				delay(1, function()
					local v74 = l__Parent__3.mutator_overlay.gradient:Clone();
					v74.mutatorname.Text = "Hazard Level Increased To: " .. p9;
					v74.Name = "current_mutation";
					v74.Parent = l__Parent__3.mutator_overlay;
					local v75 = tick();
					while true do
						v74.Size = v74.Size:Lerp(UDim2.new(0.5, 0, 0.125, 0), 0.025);
						l__RenderStepped__2:wait();
						if tick() - v75 >= 0.6 then
							break;
						end;					
					end;
					local v76 = tick();
					while true do
						if v74.mutatorname.TextTransparency > 0 then
							v74.mutatorname.TextTransparency = v74.mutatorname.TextTransparency - 0.05;
						else
							v74.mutatorname.TextTransparency = 0;
						end;
						v74.mutatortitle.TextTransparency = v74.mutatorname.TextTransparency;
						v74.Size = v74.Size + UDim2.new(0, 5, 0, 0);
						l__RenderStepped__2:wait();
						if tick() - v76 >= 5 then
							break;
						end;					
					end;
					while true do
						v74.ImageTransparency = v74.ImageTransparency + 0.03;
						v74.mutatortitle.TextTransparency = v74.ImageTransparency;
						v74.mutatorname.TextTransparency = v74.ImageTransparency;
						v74.Size = v74.Size + UDim2.new(0, 20, 0, 0);
						l__RenderStepped__2:wait();
						if v74.ImageTransparency >= 1 then
							break;
						end;					
					end;
					v74:Destroy();
				end);
				return;
			end;
			if p8 == "hitmarker" then
				_G.hitmarker(p9, p10);
				return;
			end;
			if p8 == "splatter" then
				if l__player_loadout__12:FindFirstChild("tactical") and l__player_loadout__12.tactical.Value ~= "plate" then
					u6();
					return;
				end;
			else
				if p8 == "update_gui" then
					l__gui__7.menu.topline.readyup.check.img.Visible = l__LocalPlayer__1.ready_merc.Value;
					l__gui__7.menu.topline.playanomaly.check.img.Visible = l__LocalPlayer__1.vote_anomaly.Value;
					return;
				end;
				if p8 == "make_slot" then
					u8(p9);
					return;
				end;
				if p8 == "replace_slot" then
					local l__human_frame__77 = l__Parent__3.human_frame;
					local v78 = l__human_frame__77.inv:FindFirstChild(p10);
					local v79 = p9.name;
					local v80 = p9.name;
					if p9.name == "Fists" then
						v79 = "EMPTY";
						v80 = "Fists";
					end;
					v78.item.Text = "[ " .. p10 .. " ] " .. v79;
					v78.assigned.Value = v80;
					v78.Visible = true;
					v78.Parent = l__human_frame__77.inv;
					return;
				end;
				if p8 == "emptyslot" then
					u9();
					return;
				end;
				if p8 == "black_fade" then
					if p9 == true then
						while true do
							l__Parent__3.blackOverlay.BackgroundTransparency = l__Parent__3.blackOverlay.BackgroundTransparency - 0.075;
							l__RenderStepped__2:wait();
							if l__Parent__3.blackOverlay.BackgroundTransparency <= 0 then
								break;
							end;						
						end;
					else
						while true do
							l__Parent__3.blackOverlay.BackgroundTransparency = l__Parent__3.blackOverlay.BackgroundTransparency + 0.075;
							l__RenderStepped__2:wait();
							if l__Parent__3.blackOverlay.BackgroundTransparency >= 1 then
								break;
							end;						
						end;
					end;
				elseif p8 == "check_mute" and p9 and u10 == true then
					p9:Stop();
					p9.Volume = 0;
				end;
			end;
		end;
	end;
end);
local l__bg__81 = l__Parent__3.shop_frame.bg;
local u13 = tick();
l__workspace__4.firing_range.clicker.MouseClick:Connect(function()
	if tick() - u13 <= 3 then
		return;
	end;
	u13 = tick();
	l__remotes__3.game_handler:FireServer("firing_range");
end);
local u14 = nil;
l__bg__81.exit.MouseButton1Click:Connect(function()
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	u13 = tick();
	l__Parent__3.shop_frame.Visible = false;
end);
local function u15()
	if tick() - u13 <= 0.45 or l__Parent__3.shop_frame.Visible == true then
		return;
	end;
	v4:soundHandler({
		directory = { "qm" }, 
		soundfile = "shopopen", 
		location = l__CurrentCamera__5
	}, true);
	u14();
	l__Parent__3.shop_frame.Visible = true;
	l__workspace__4.standing_shop.qm:Stop();
	if l__workspace__4.Quartermasterstuff:FindFirstChild("qmguy") then
		l__workspace__4.standing_shop.qm.SoundId = l__game__1.ReplicatedStorage.sound_library.qm:FindFirstChild("open" .. math.random(1, 7)).SoundId;
		l__workspace__4.standing_shop.qm:Play();
	end;
end;
l__workspace__4.standing_shop.clicker.MouseClick:Connect(function()
	u15();
end);
local v82 = {
	armoury = { { "[ Controls & Anomalies ]", "controls" }, { "[ Gear Selection ]", "selection" } }, 
	subject = { { "[ Career ]", "mutations" }, { "[ Skill Decks ]", "terrors" } }, 
	settings = { { "[ MERC Controls ]", "shared" }, { "[ Operation Guide ]", "operation" } }, 
	qm = { { "[ Glossary ]", "glossary" } }
};
local l__game_values__16 = workspace.mainGame.game_values;
local u17 = 0;
local u18 = "home";
local l__menucampos__19 = l__workspace__4.menucampos;
local u20 = CFrame.new(0, 0, 0);
local function u21()
	if l__game_values__16.state.Value == "preparing_game" or l__LocalPlayer__1.Character.Parent ~= l__workspace__4 or l__CurrentCamera__5.CameraType ~= Enum.CameraType.Scriptable then
		return;
	end;
	if tick() - u17 <= 0.5 then
		return;
	end;
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_closed", 
		location = l__CurrentCamera__5
	}, true);
	u17 = tick();
	l__Parent__3.blackOverlay.BackgroundTransparency = 0;
	spawn(function()
		while true do
			l__Parent__3.blackOverlay.BackgroundTransparency = l__Parent__3.blackOverlay.BackgroundTransparency + 0.02;
			l__RenderStepped__2:wait();
			if l__Parent__3.blackOverlay.BackgroundTransparency >= 1 then
				break;
			end;		
		end;
	end);
	l__Parent__3.outcam_menu.Visible = true;
	l__Parent__3.incam_menu.Visible = false;
	l__CurrentCamera__5.CameraType = Enum.CameraType.Custom;
	l__CurrentCamera__5.CameraSubject = l__LocalPlayer__1.Character.Humanoid;
end;
l__Parent__3.incam_menu.main.returnchar.MouseButton1Click:Connect(function()
	u21();
end);
local function u22()
	if l__game_values__16.state.Value == "preparing_game" or l__LocalPlayer__1.Character.Parent ~= l__workspace__4 then
		return;
	end;
	if tick() - u17 <= 0.5 then
		return;
	end;
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_open", 
		location = l__CurrentCamera__5
	}, true);
	u17 = tick();
	l__Parent__3.blackOverlay.BackgroundTransparency = 0;
	spawn(function()
		while true do
			l__Parent__3.blackOverlay.BackgroundTransparency = l__Parent__3.blackOverlay.BackgroundTransparency + 0.02;
			l__RenderStepped__2:wait();
			if l__Parent__3.blackOverlay.BackgroundTransparency >= 1 then
				break;
			end;		
		end;
	end);
	u18 = "home";
	l__Parent__3.shop_frame.Visible = false;
	l__Parent__3.outcam_menu.Visible = false;
	l__Parent__3.incam_menu.Visible = true;
	l__Parent__3.incam_menu.selections.Visible = false;
	l__Parent__3.incam_menu.main.Visible = true;
	l__CurrentCamera__5.CameraType = Enum.CameraType.Scriptable;
	l__CurrentCamera__5.CFrame = l__menucampos__19.home.CFrame;
	u20 = l__menucampos__19.home.CFrame;
end;
l__Parent__3.outcam_menu.menu.MouseButton1Click:Connect(function()
	u22();
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_open", 
		location = l__CurrentCamera__5
	}, true);
end);
local v83, v84, v85 = ipairs(l__Parent__3.incam_menu.main:GetChildren());
while true do
	v83(v84, v85);
	if not v83 then
		break;
	end;
	v85 = v83;
	if l__menucampos__19:FindFirstChild(v84.Name) then
		v84.MouseButton1Click:connect(function()
			if tick() - u17 <= 0.5 or l__Parent__3.incam_menu.selections.Visible == true or v82[v84.Name] == nil then
				return;
			end;
			v4:soundHandler({
				directory = { "ui", "menu" }, 
				soundfile = "ui_confirm", 
				location = l__CurrentCamera__5
			}, true);
			u18 = v84.Name;
			u17 = tick();
			l__Parent__3.blackOverlay.BackgroundTransparency = 0;
			spawn(function()
				while true do
					l__Parent__3.blackOverlay.BackgroundTransparency = l__Parent__3.blackOverlay.BackgroundTransparency + 0.02;
					l__RenderStepped__2:wait();
					if l__Parent__3.blackOverlay.BackgroundTransparency >= 1 then
						break;
					end;				
				end;
			end);
			l__CurrentCamera__5.CFrame = l__menucampos__19:FindFirstChild(v84.Name).CFrame;
			u20 = l__menucampos__19:FindFirstChild(v84.Name).CFrame;
			l__Parent__3.incam_menu.selections.Visible = true;
			l__Parent__3.incam_menu.selections.main.Text = v84.Text;
			l__Parent__3.incam_menu.main.Visible = false;
			local v86, v87, v88 = ipairs(l__Parent__3.incam_menu.selections:GetChildren());
			while true do
				v86(v87, v88);
				if not v86 then
					break;
				end;
				v88 = v86;
				if v87.Name ~= "returnmenu" and v87.Name ~= "main" then
					v87.Visible = false;
				end;			
			end;
			local v89, v90, v91 = ipairs(v82[v84.Name]);
			while true do
				v89(v90, v91);
				if not v89 then
					break;
				end;
				v91 = v89;
				local v92 = l__Parent__3.incam_menu.selections:FindFirstChild(v89);
				if v92 then
					v92.Text = v90[1];
					v92.Visible = true;
					v92.to.Value = v90[2];
				end;			
			end;
			if v84.Name == "qm" then
				u13 = 0;
				u15();
			end;
		end);
	end;
end;
local v93, v94, v95 = ipairs(l__Parent__3.incam_menu.selections:GetChildren());
while true do
	v93(v94, v95);
	if not v93 then
		break;
	end;
	v95 = v93;
	if v94.Name ~= "flash" then
		if v94.Name ~= "returnmenu" then
			v94.MouseButton1Click:connect(function()
				if tick() - u17 <= 0.5 then
					return;
				end;
				if v94.Name == "main" then
					if u20 == l__menucampos__19:FindFirstChild(u18).CFrame then
						return;
					end;
				elseif u20 == l__menucampos__19:FindFirstChild(v94.to.Value).CFrame then
					return;
				end;
				l__Parent__3.shop_frame.Visible = false;
				v4:soundHandler({
					directory = { "ui", "menu" }, 
					soundfile = "ui_click", 
					location = l__CurrentCamera__5
				}, true);
				u17 = tick();
				local v96 = l__Parent__3.incam_menu.selections.flash:Clone();
				l__game__1:GetService("Debris"):AddItem(v96, 2);
				v96.Visible = true;
				v96.BackgroundTransparency = 0;
				v96.Parent = v94;
				spawn(function()
					for v97 = 1, 20 do
						v96.BackgroundTransparency = v96.BackgroundTransparency + 0.05;
						l__RenderStepped__2:Wait();
					end;
					v96:Destroy();
				end);
				if v94.Name == "main" then
					u20 = l__menucampos__19:FindFirstChild(u18).CFrame;
					if u18 ~= "qm" then
						return;
					end;
				else
					u20 = l__menucampos__19:FindFirstChild(v94.to.Value).CFrame;
					return;
				end;
				u13 = 0;
				u15();
			end);
		else
			v94.MouseButton1Click:connect(function()
				if tick() - u17 <= 0.5 then
					return;
				end;
				v4:soundHandler({
					directory = { "ui", "menu" }, 
					soundfile = "ui_closed", 
					location = l__CurrentCamera__5
				}, true);
				u22();
			end);
		end;
	end;
end;
local l__Ambient__98 = l__game__1.Lighting.Ambient;
local l__FogEnd__99 = l__game__1.Lighting.FogEnd;
local l__FogColor__100 = l__game__1.Lighting.FogColor;
local l__Brightness__101 = l__game__1.Lighting.Brightness;
_G.indoors = true;
l__Parent__3.trader_frame.bg.exit.MouseButton1Click:Connect(function()
	v4:soundHandler({
		directory = { "trader_sounds" }, 
		soundfile = "menu_close", 
		location = l__LocalPlayer__1
	}, true);
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	l__Parent__3.trader_frame.Visible = false;
	l__UserInputService__9.MouseIconEnabled = false;
	if l__LocalPlayer__1.PlayerGui:FindFirstChild("Chat") then
		l__LocalPlayer__1.PlayerGui.Chat.Frame.Visible = true;
	end;
end);
local function u23(p11)
	if l__LocalPlayer__1.PlayerGui:FindFirstChild("Chat") and l__LocalPlayer__1.PlayerGui.Chat:FindFirstChild("Frame") then
		local v102, v103, v104 = ipairs(l__LocalPlayer__1.PlayerGui.Chat:FindFirstChild("Frame"):GetChildren());
		while true do
			v102(v103, v104);
			if not v102 then
				break;
			end;
			v104 = v102;
			if v103.Name ~= "ChatBarParentFrame" then
				v103.Visible = p11;
			end;		
		end;
		if l__LocalPlayer__1.PlayerGui.Chat.Frame:FindFirstChild("ChatBarParentFrame") then
			if p11 == true then
				l__game__1:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
				l__LocalPlayer__1.PlayerGui.Chat.Frame:FindFirstChild("ChatBarParentFrame").Position = UDim2.new(0, 0, 1, -42);
				return;
			end;
			l__game__1:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
			l__LocalPlayer__1.PlayerGui.Chat.Frame:FindFirstChild("ChatBarParentFrame").Position = UDim2.new(0, 0, 0, 0);
		end;
	end;
end;
local u24 = false;
l__remotes__3.player_respawn.OnClientEvent:connect(function()
	local v105, v106, v107 = ipairs(l__Parent__3.human_frame.inv:GetChildren());
	while true do
		v105(v106, v107);
		if not v105 then
			break;
		end;
		v107 = v105;
		if v106.Name ~= "ex" then
			v106:Destroy();
		end;	
	end;
	local v108, v109, v110 = ipairs(l__Parent__3.anomaly_frame.inv:GetChildren());
	while true do
		v108(v109, v110);
		if not v108 then
			break;
		end;
		v110 = v108;
		if v109.Name ~= "ex" then
			v109:Destroy();
		end;	
	end;
	l__mouse__10.Icon = "";
	l__UserInputService__9.MouseIconEnabled = true;
	l__Parent__3.crosshair.Visible = false;
	l__Parent__3.anomaly_frame.Visible = false;
	l__Parent__3.human_frame.Visible = false;
	l__LocalPlayer__1.CameraMode = Enum.CameraMode.Classic;
	l__UserInputService__9.MouseBehavior = Enum.MouseBehavior.Default;
	l__CurrentCamera__5.CameraType = Enum.CameraType.Custom;
	l__CurrentCamera__5.CameraSubject = l__LocalPlayer__1.Character.Humanoid;
	l__UserInputService__9.MouseDeltaSensitivity = 1;
	l__CurrentCamera__5.FieldOfView = 70;
	u23(true);
	l__Parent__3.trader_frame.Visible = false;
	l__Parent__3.outcam_menu.Visible = true;
	l__Parent__3.incam_menu.Visible = false;
	l__Parent__3.blackOverlay.BackgroundTransparency = 0;
	spawn(function()
		while true do
			l__Parent__3.blackOverlay.BackgroundTransparency = l__Parent__3.blackOverlay.BackgroundTransparency + 0.02;
			l__RenderStepped__2:wait();
			if l__Parent__3.blackOverlay.BackgroundTransparency >= 1 then
				break;
			end;		
		end;
	end);
	if u24 == false then
		u24 = true;
		u22();
	end;
end);
local v111 = tick();
local u25 = tick();
l__game_values__16.boss_humanoid.Changed:Connect(function(p12)
	if p12 then
		if p12.Health > 0 then
			local v112 = require(l__game__1.ReplicatedStorage.enemy_types:FindFirstChild(l__game_values__16.boss_humanoid.append.Value));
			u25 = tick();
			l__Parent__3.boss_healthbar.bar.boss_name.Text = v112.name;
			l__Parent__3.boss_healthbar.bar.boss_subtext.Text = "< " .. v112.name_label .. " >";
			l__Parent__3.boss_healthbar.bar.inner.Size = UDim2.new(0, 0, 0.7, 0);
		end;
		l__Parent__3.boss_healthbar.Visible = true;
		if not (p12.Health <= 0) then
			return;
		end;
	else
		l__Parent__3.boss_healthbar.Visible = false;
		return;
	end;
	l__Parent__3.boss_healthbar.Visible = false;
end);
local u26 = v111;
local l__gui__27 = l__workspace__4.career_menu.gui;
local u28 = 0;
local v113 = l__RenderStepped__2:Connect(function()
	if l__game_values__16.boss_humanoid.Value then
		if l__game_values__16.boss_humanoid.Value.Health <= 0 then
			l__Parent__3.boss_healthbar.Visible = false;
		end;
		if l__Parent__3.boss_healthbar.Visible == true then
			if tick() - u26 >= 0.03 then
				u26 = tick();
				local v114 = 0.1;
				if tick() - u25 <= 5 then
					v114 = 0.05;
				end;
				l__Parent__3.boss_healthbar.bar.barhealth.Text = math.ceil(l__game_values__16.boss_humanoid.Value.Health) .. " / " .. math.ceil(l__game_values__16.boss_humanoid.Value.MaxHealth);
				l__Parent__3.boss_healthbar.bar.inner.Size = l__Parent__3.boss_healthbar.bar.inner.Size:Lerp(UDim2.new(l__game_values__16.boss_humanoid.Value.Health / l__game_values__16.boss_humanoid.Value.MaxHealth, 0, 0.7, 0), v114);
			end;
			if l__game_values__16.boss_humanoid.Value and l__game_values__16.boss_humanoid.Value.Parent and l__game_values__16.boss_humanoid.Value.Parent:FindFirstChild("invuln") then
				l__Parent__3.boss_healthbar.bar.inner.baroverlay.Visible = true;
				l__Parent__3.boss_healthbar.bar.inner.baroverlaygradient.Visible = true;
			else
				l__Parent__3.boss_healthbar.bar.inner.baroverlay.Visible = false;
				l__Parent__3.boss_healthbar.bar.inner.baroverlaygradient.Visible = false;
			end;
		end;
	end;
	local v115 = 255;
	local v116 = 255;
	local v117 = 255;
	if tonumber(l__gui__27.highlight_R.Text) ~= nil then
		local v118 = tonumber(l__gui__27.highlight_R.Text);
		if v118 >= 0 and v118 <= 255 then
			v115 = v118;
		end;
	end;
	if tonumber(l__gui__27.highlight_G.Text) ~= nil then
		local v119 = tonumber(l__gui__27.highlight_G.Text);
		if v119 >= 0 and v119 <= 255 then
			v116 = v119;
		end;
	end;
	if tonumber(l__gui__27.highlight_B.Text) ~= nil then
		local v120 = tonumber(l__gui__27.highlight_B.Text);
		if v120 >= 0 and v120 <= 255 then
			v117 = v120;
		end;
	end;
	l__gui__27.highlightpreview.BackgroundColor3 = Color3.fromRGB(v115, v116, v117);
	l__Parent__3.timer_top.TextColor3 = Color3.new(1, 1, 1);
	if l__game_values__16.state.Value == "lobby" then
		local l__Value__121 = l__game_values__16.timer.Value;
		l__Parent__3.timer_top.Text = "LOBBY\n" .. string.format("%02i:%02i", l__Value__121 / 60 % 60, l__Value__121 % 60);
	elseif l__game_values__16.state.Value == "waitingplayers" then
		if tonumber(l__game_values__16.timer.Value) >= 28 then
			local v122 = "NO MERCENARIES";
		else
			local l__Value__123 = l__game_values__16.timer.Value;
			v122 = "DEPARTING IN: " .. string.format("%02i:%02i", l__Value__123 / 60 % 60, l__Value__123 % 60);
		end;
		l__Parent__3.timer_top.Text = "WAITING FOR ALL MERCENARIES TO READY UP\n" .. v122;
	elseif l__game_values__16.state.Value == "preparing_game" then
		l__Parent__3.timer_top.Text = "PREPARING OPERATION";
	elseif l__game_values__16.state.Value == "ingame" then
		local l__Value__124 = l__game_values__16.rein_client_timer.Value;
		local v125 = "REINFORCEMENTS: " .. string.format("%02i:%02i", l__Value__124 / 60 % 60, l__Value__124 % 60);
		if l__game_values__16.rein_client_timer.Value <= 0 then
			v125 = "REINFORCEMENTS READY";
		end;
		if l__game_values__16.state.append.Value == "exfil_beginning" then
			v125 = "HAZARD LEVEL " .. l__game_values__16.hazard_level.Value .. " BEGINNING IN";
		elseif l__game_values__16.state.append.Value == "exfil_start" then
			v125 = "EXFILTRATION IN";
		elseif l__game_values__16.state.append.Value == "bossbattle" then
			v125 = "REALITY SEVERANCE IN";
			l__Parent__3.timer_top.TextColor3 = Color3.new(0.9, 0, 0);
		end;
		local l__Value__126 = l__game_values__16.timer.Value;
		l__Parent__3.timer_top.Text = v125 .. "\n" .. string.format("%02i:%02i", l__Value__126 / 60 % 60, l__Value__126 % 60);
	elseif l__game_values__16.state.Value == "endgame" then
		l__Parent__3.timer_top.TextColor3 = Color3.new(0.8, 0, 0);
		local l__Value__127 = l__game_values__16.timer.Value;
		l__Parent__3.timer_top.Text = string.format("%02i:%02i", l__Value__127 / 60 % 60, l__Value__127 % 60);
	elseif l__game_values__16.state.Value == "gameover" then
		l__Parent__3.timer_top.Text = "GAME ENDED";
	end;
	if tick() - u28 <= 8 then
		l__Parent__3.standing.Position = l__Parent__3.standing.Position:Lerp(UDim2.new(0.75, 300, 0.4, 0), 0.2);
	else
		l__Parent__3.standing.Position = l__Parent__3.standing.Position:Lerp(UDim2.new(1, 320, 0.4, 0), 0.2);
	end;
	if v4:raycastline({
		point = l__CurrentCamera__5.CFrame.Position, 
		destination = CFrame.new(l__CurrentCamera__5.CFrame.Position).upVector, 
		range = 500, 
		layermask = { l__LocalPlayer__1.Character, l__workspace__4.mainGame.noTarget, l__workspace__4.mainGame.active_anomaly, l__workspace__4.mainGame.active_humans, l__workspace__4.mainGame.active_bodies, l__workspace__4.mainGame.active_equipments }
	}) then
		l__game__1.SoundService.AmbientReverb = "Plain";
		_G.indoors = true;
	else
		l__game__1.SoundService.AmbientReverb = "Mountains";
		_G.indoors = false;
	end;
	if l__CurrentCamera__5.CameraType == Enum.CameraType.Scriptable and l__CurrentCamera__5.CameraSubject ~= nil then
		local v128 = true;
		if l__LocalPlayer__1.Character and l__LocalPlayer__1.Character:FindFirstChild("just_spawned") then
			v128 = false;
		end;
		if v128 == true then
			l__CurrentCamera__5.CFrame = l__CurrentCamera__5.CFrame:Lerp(u20, 0.1);
		end;
	end;
end);
l__game_values__16.hazard_level.Changed:Connect(function()
	l__Parent__3.haz_num.Text = l__game_values__16.hazard_level.Value;
end);
l__Parent__3.haz_num.Text = l__game_values__16.hazard_level.Value;
local u29 = tick();
l__gui__7.menu.topline.readyup.MouseButton1Click:connect(function()
	if tick() - u29 <= 0.5 then
		return;
	end;
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_ready_merc", 
		location = l__CurrentCamera__5
	}, true);
	u29 = tick();
	l__remotes__3.game_handler:FireServer("lock_merc");
end);
l__gui__7.menu.topline.playanomaly.MouseButton1Click:connect(function()
	if tick() - u29 <= 0.5 then
		return;
	end;
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_ready_subject", 
		location = l__CurrentCamera__5
	}, true);
	u29 = tick();
	l__remotes__3.game_handler:FireServer("lock_anomaly");
end);
local function u30()
	if l__Parent__3.outcam_menu.spectate.Text ~= "Close" then
		return;
	end;
	local v129, v130, v131 = ipairs(l__Parent__3.outcam_menu.spectate:GetChildren());
	while true do
		v129(v130, v131);
		if not v129 then
			break;
		end;
		v131 = v129;
		if v130.Name ~= "ex" then
			v130:Destroy();
		end;	
	end;
	local v132, v133, v134 = ipairs(l__game__1.Players:GetPlayers());
	while true do
		v132(v133, v134);
		if not v132 then
			break;
		end;
		v134 = v132;
		if not (not v133.Character) and (v133.Character.Parent == l__workspace__4.mainGame.active_humans or v133.Character.Parent == l__workspace__4.mainGame.active_squads) and not (not v133.Character:FindFirstChild("HumanoidRootPart")) or v133 == l__LocalPlayer__1 and l__LocalPlayer__1.Character and l__LocalPlayer__1.Character:FindFirstChild("Humanoid") then
			local v135 = l__Parent__3.outcam_menu.spectate.ex:Clone();
			v135.Name = v133.Name;
			v135.Position = UDim2.new(0.5, 0, 0 - 0.8 * #l__Parent__3.outcam_menu.spectate:GetChildren(), 0);
			v135.Visible = true;
			v135.Text = "[ " .. v133.Name .. " ]";
			v135.Parent = l__Parent__3.outcam_menu.spectate;
			if l__CurrentCamera__5.CameraSubject == v133.Character.HumanoidRootPart or l__CurrentCamera__5.CameraSubject == v133.Character.Humanoid then
				v135.BackgroundTransparency = 0.5;
				v135.Text = v133.Name;
			else
				v135.MouseButton1Click:Connect(function()
					v4:soundHandler({
						directory = { "ui", "menu" }, 
						soundfile = "ui_confirm", 
						location = l__CurrentCamera__5
					}, true);
					if v133 ~= l__LocalPlayer__1 then
						l__CurrentCamera__5.CameraType = Enum.CameraType.Follow;
						l__CurrentCamera__5.CameraSubject = v133.Character.HumanoidRootPart;
					elseif l__LocalPlayer__1.Character then
						l__CurrentCamera__5.CameraType = Enum.CameraType.Custom;
						l__CurrentCamera__5.CameraSubject = l__LocalPlayer__1.Character.Humanoid;
					end;
					u30();
				end);
			end;
		end;	
	end;
end;
l__Parent__3.outcam_menu.spectate.MouseButton1Click:Connect(function()
	if tick() - u29 <= 0.5 then
		return;
	end;
	u29 = tick();
	if l__Parent__3.outcam_menu.spectate.Text == "[ Spectate ]" then
		v4:soundHandler({
			directory = { "ui", "menu" }, 
			soundfile = "ui_open", 
			location = l__CurrentCamera__5
		}, true);
		l__Parent__3.outcam_menu.spectate.Text = "Close";
		l__Parent__3.outcam_menu.spectate.BackgroundTransparency = 0.5;
		u30();
		return;
	end;
	local v136, v137, v138 = ipairs(l__Parent__3.outcam_menu.spectate:GetChildren());
	while true do
		v136(v137, v138);
		if not v136 then
			break;
		end;
		v138 = v136;
		if v137.Name ~= "ex" then
			v137:Destroy();
		end;	
	end;
	l__Parent__3.outcam_menu.spectate.BackgroundTransparency = 1;
	l__Parent__3.outcam_menu.spectate.Text = "[ Spectate ]";
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_closed", 
		location = l__CurrentCamera__5
	}, true);
end);
l__workspace__4.mainGame.active_humans.ChildAdded:Connect(function()
	u30();
end);
l__workspace__4.mainGame.active_humans.ChildRemoved:Connect(function()
	u30();
end);
l__workspace__4.mainGame.active_squads.ChildAdded:Connect(function()
	u30();
end);
l__workspace__4.mainGame.active_squads.ChildRemoved:Connect(function()
	u30();
end);
l__workspace__4.mainGame.active_anomaly.ChildAdded:Connect(function()
	u30();
end);
l__workspace__4.mainGame.active_anomaly.ChildRemoved:Connect(function()
	u30();
end);
l__remotes__3.arm_handler.OnClientEvent:connect(function(p13, p14, p15)
	if p15 == l__LocalPlayer__1 then
		return;
	end;
	if p13 ~= nil and p13:FindFirstChild("Left Shoulder") ~= nil and p13:FindFirstChild("Right Shoulder") ~= nil and p13:FindFirstChild("Neck") ~= nil then
		l__RenderStepped__2:wait();
		if p13 == nil or p13:FindFirstChild("Left Shoulder") == nil or p13:FindFirstChild("Right Shoulder") == nil or p13:FindFirstChild("Neck") == nil then
			return;
		elseif p13.Parent:FindFirstChild("just_spawned") then
			return;
		else
			p13["Left Shoulder"].C0 = CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0) * CFrame.Angles(0, 0, -p14);
			p13["Right Shoulder"].C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0) * CFrame.Angles(0, 0, p14);
			p13.Neck.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0) * CFrame.Angles(-p14 - 0.05235987755982989, 0, 0);
			return;
		end;
	end;
end);
l__Parent__3.outcam_menu.teleport.MouseButton1Click:Connect(function()
	if l__Parent__3.outcam_menu.teleport.Text == "[ Fast Travels ]" then
		v4:soundHandler({
			directory = { "ui", "menu" }, 
			soundfile = "ui_open", 
			location = l__CurrentCamera__5
		}, true);
		l__Parent__3.outcam_menu.teleport.Text = "Close";
		l__Parent__3.outcam_menu.teleport.BackgroundTransparency = 0.5;
		local v139, v140, v141 = ipairs(l__Parent__3.outcam_menu.teleport:GetChildren());
		while true do
			v139(v140, v141);
			if not v139 then
				break;
			end;
			v141 = v139;
			v140.Visible = true;		
		end;
		return;
	end;
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_closed", 
		location = l__CurrentCamera__5
	}, true);
	l__Parent__3.outcam_menu.teleport.Text = "[ Fast Travels ]";
	l__Parent__3.outcam_menu.teleport.BackgroundTransparency = 1;
	local v142, v143, v144 = ipairs(l__Parent__3.outcam_menu.teleport:GetChildren());
	while true do
		v142(v143, v144);
		if not v142 then
			break;
		end;
		v144 = v142;
		v143.Visible = false;	
	end;
end);
local v145, v146, v147 = ipairs(l__Parent__3.outcam_menu.teleport:GetChildren());
while true do
	v145(v146, v147);
	if not v145 then
		break;
	end;
	v147 = v145;
	if l__workspace__4.teleports:FindFirstChild(v146.Name) then
		v146.MouseButton1Click:Connect(function()
			if l__game_values__16.state.Value ~= "preparing_game" and l__LocalPlayer__1.Character and l__LocalPlayer__1.Character:FindFirstChild("Torso") and (l__LocalPlayer__1.Character:FindFirstChild("Humanoid") and l__LocalPlayer__1.Character.Humanoid.Health > 0 and l__LocalPlayer__1.Character.Parent ~= l__workspace__4.mainGame.active_anomaly and l__LocalPlayer__1.Character.Parent ~= l__workspace__4.mainGame.active_humans) then
				v4:soundHandler({
					directory = { "ui", "menu" }, 
					soundfile = "ui_confirm", 
					location = l__CurrentCamera__5
				}, true);
				l__LocalPlayer__1.Character.Torso.CFrame = l__workspace__4.teleports:FindFirstChild(v146.Name).CFrame;
				l__LocalPlayer__1.Character.Humanoid.Sit = false;
				local v148 = l__Parent__3.outcam_menu.teleport.flash:Clone();
				l__game__1:GetService("Debris"):AddItem(v148, 2);
				v148.Visible = true;
				v148.BackgroundTransparency = 0;
				v148.Parent = v146;
				spawn(function()
					l__LocalPlayer__1.Character.Humanoid.Sit = false;
					for v149 = 1, 20 do
						l__LocalPlayer__1.Character.Humanoid.Sit = false;
						v148.BackgroundTransparency = v148.BackgroundTransparency + 0.05;
						l__RenderStepped__2:Wait();
					end;
					v148:Destroy();
				end);
			end;
		end);
	end;
end;
l__LocalPlayer__1.CharacterAdded:Connect(function()
	l__Parent__3.death_screen.Visible = false;
end);
local l__gui__31 = l__workspace__4.merc_voices.gui;
local u32 = {
	merc = { "MERC", l__game__1.ReplicatedStorage.sound_library.voices.merc }
};
local u33 = tick();
l__gui__27.playername.Text = "'" .. l__LocalPlayer__1.Name .. "'";
local u34 = nil;
l__Parent__3.shop_frame.bg.purchase.MouseButton1Click:Connect(function()
	if tick() - u13 <= 0.5 then
		return;
	end;
	u13 = tick();
	l__remotes__3.standing_handler:FireServer("buy", u34);
end);
local v150 = Instance.new("Camera");
v150.Name = "viewcam";
l__bg__81.viewport.CurrentCamera = v150;
v150.Parent = l__bg__81.viewport;
l__bg__81.viewport.voicepack.MouseButton1Click:Connect(function()
	if u34 and l__bg__81.viewport.voicepack.Visible == true and l__game__1.ReplicatedStorage.sound_library.voices:FindFirstChild(u34) then
		local v151 = l__game__1.ReplicatedStorage.sound_library.voices:FindFirstChild(u34);
		local v152 = v151:GetChildren()[math.random(1, #v151:GetChildren())];
		v4:soundHandler({
			directory = { "voices", u34, v152.Name }, 
			soundfile = v152:GetChildren()[math.random(1, #v152:GetChildren())].Name, 
			volume_adjust = 4, 
			location = l__CurrentCamera__5
		}, true);
	end;
end);
u14 = function()
	local v153, v154, v155 = ipairs(l__bg__81.scroll:GetChildren());
	while true do
		v153(v154, v155);
		if not v153 then
			break;
		end;
		v155 = v153;
		if v154.Name ~= "ex" then
			v154:Destroy();
		end;	
	end;
	if u34 and l__LocalPlayer__1.unlocks:FindFirstChild(u34) then
		l__bg__81.purchase.Visible = false;
	end;
	for v156, v157 in pairs(v7.voices_unlock) do
		if v157[1] <= l__LocalPlayer__1.standing_rank.Value then
			local v158 = l__bg__81.scroll.ex:Clone();
			v158.Name = v156;
			v158.Text = "Voice Pack - " .. v7.merc_voices[v156][1];
			v158.Position = UDim2.new(0.5, 0, 0, -40 + 60 * #l__bg__81.scroll:GetChildren());
			v158.Visible = true;
			if l__LocalPlayer__1.unlocks:FindFirstChild(v156) then
				v158.BackgroundColor3 = Color3.new(0, 1, 0);
			end;
			v158.Parent = l__bg__81.scroll;
			local u35 = v157[3];
			local u36 = v7.merc_voices[v156][1];
			local u37 = v157[2];
			local u38 = "voice";
			v158.MouseButton1Click:connect(function()
				v4:soundHandler({
					directory = { "ui", "menu" }, 
					soundfile = "ui_click", 
					location = l__CurrentCamera__5
				}, true);
				local v159, v160, v161 = ipairs(l__bg__81.scroll:GetChildren());
				while true do
					v159(v160, v161);
					if not v159 then
						break;
					end;
					v161 = v159;
					if l__LocalPlayer__1.unlocks:FindFirstChild(v160.Name) then
						v160.BackgroundColor3 = Color3.new(0, 1, 0);
					else
						v160.BackgroundColor3 = Color3.new(0, 0, 0);
					end;				
				end;
				v158.BackgroundColor3 = Color3.new(1, 1, 1);
				u34 = v158.Name;
				l__bg__81.price.Text = "Cost: " .. u35 .. " Tokens";
				l__bg__81.itemname.Text = u36;
				l__bg__81.itemdesc.Text = u37;
				l__bg__81.itemdesc.Visible = true;
				l__bg__81.itemname.Visible = true;
				l__bg__81.price.Visible = true;
				if l__LocalPlayer__1.unlocks:FindFirstChild(v158.Name) then
					l__bg__81.purchase.Visible = false;
				else
					l__bg__81.purchase.Visible = true;
				end;
				if u38 ~= nil then
					l__bg__81.viewport.voicepack.Visible = false;
					local v162, v163, v164 = ipairs(l__bg__81.viewport:GetChildren());
					while true do
						v162(v163, v164);
						if not v162 then
							break;
						end;
						v164 = v162;
						if v163.Name ~= "voicepack" and v163.Name ~= "viewcam" then
							v163:Destroy();
						end;					
					end;
					if u38 == "clothing" then
						local v165 = l__game__1.ReplicatedStorage.misc_effects.clothhanger:Clone();
						v165.Parent = l__bg__81.viewport;
						v165:SetPrimaryPartCFrame(v150.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0));
						if l__game__1.ReplicatedStorage.outfits.mercs:FindFirstChild(u34) then
							local v166 = l__game__1.ReplicatedStorage.outfits.mercs:FindFirstChild(u34):Clone();
							local v167, v168, v169 = ipairs(v166:GetChildren());
							while true do
								v167(v168, v169);
								if not v167 then
									break;
								end;
								v169 = v167;
								v168.Parent = v165;							
							end;
							v166:Destroy();
							return;
						end;
					elseif u38 == "blade" then
						if l__game__1.ReplicatedStorage.weapon_model:FindFirstChild(u34) then
							local v170 = l__game__1.ReplicatedStorage.weapon_model:FindFirstChild(u34).default:Clone();
							v170.PrimaryPart = v170.weld;
							local v171, v172, v173 = ipairs(v170.model:GetChildren());
							while true do
								v171(v172, v173);
								if not v171 then
									break;
								end;
								v173 = v171;
								v172.Transparency = 0;							
							end;
							v170:SetPrimaryPartCFrame(v150.CFrame * CFrame.new(1, 0, -4) * CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966));
							v170.Parent = l__bg__81.viewport;
							return;
						end;
					elseif u38 == "voice" then
						l__bg__81.viewport.voicepack.Visible = true;
					end;
				end;
			end);
		end;
	end;
	for v174, v175 in pairs(v7.outfit_unlock) do
		if v175[1] <= l__LocalPlayer__1.standing_rank.Value then
			local v176 = l__bg__81.scroll.ex:Clone();
			v176.Name = v174;
			v176.Text = "MERC Outfit - " .. v175[2];
			v176.Position = UDim2.new(0.5, 0, 0, -40 + 60 * #l__bg__81.scroll:GetChildren());
			v176.Visible = true;
			if l__LocalPlayer__1.unlocks:FindFirstChild(v174) then
				v176.BackgroundColor3 = Color3.new(0, 1, 0);
			end;
			v176.Parent = l__bg__81.scroll;
			local u39 = v175[4];
			local u40 = v175[2];
			local u41 = v175[3];
			local u42 = "clothing";
			v176.MouseButton1Click:connect(function()
				v4:soundHandler({
					directory = { "ui", "menu" }, 
					soundfile = "ui_click", 
					location = l__CurrentCamera__5
				}, true);
				local v177, v178, v179 = ipairs(l__bg__81.scroll:GetChildren());
				while true do
					v177(v178, v179);
					if not v177 then
						break;
					end;
					v179 = v177;
					if l__LocalPlayer__1.unlocks:FindFirstChild(v178.Name) then
						v178.BackgroundColor3 = Color3.new(0, 1, 0);
					else
						v178.BackgroundColor3 = Color3.new(0, 0, 0);
					end;				
				end;
				v176.BackgroundColor3 = Color3.new(1, 1, 1);
				u34 = v176.Name;
				l__bg__81.price.Text = "Cost: " .. u39 .. " Tokens";
				l__bg__81.itemname.Text = u40;
				l__bg__81.itemdesc.Text = u41;
				l__bg__81.itemdesc.Visible = true;
				l__bg__81.itemname.Visible = true;
				l__bg__81.price.Visible = true;
				if l__LocalPlayer__1.unlocks:FindFirstChild(v176.Name) then
					l__bg__81.purchase.Visible = false;
				else
					l__bg__81.purchase.Visible = true;
				end;
				if u42 ~= nil then
					l__bg__81.viewport.voicepack.Visible = false;
					local v180, v181, v182 = ipairs(l__bg__81.viewport:GetChildren());
					while true do
						v180(v181, v182);
						if not v180 then
							break;
						end;
						v182 = v180;
						if v181.Name ~= "voicepack" and v181.Name ~= "viewcam" then
							v181:Destroy();
						end;					
					end;
					if u42 == "clothing" then
						local v183 = l__game__1.ReplicatedStorage.misc_effects.clothhanger:Clone();
						v183.Parent = l__bg__81.viewport;
						v183:SetPrimaryPartCFrame(v150.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0));
						if l__game__1.ReplicatedStorage.outfits.mercs:FindFirstChild(u34) then
							local v184 = l__game__1.ReplicatedStorage.outfits.mercs:FindFirstChild(u34):Clone();
							local v185, v186, v187 = ipairs(v184:GetChildren());
							while true do
								v185(v186, v187);
								if not v185 then
									break;
								end;
								v187 = v185;
								v186.Parent = v183;							
							end;
							v184:Destroy();
							return;
						end;
					elseif u42 == "blade" then
						if l__game__1.ReplicatedStorage.weapon_model:FindFirstChild(u34) then
							local v188 = l__game__1.ReplicatedStorage.weapon_model:FindFirstChild(u34).default:Clone();
							v188.PrimaryPart = v188.weld;
							local v189, v190, v191 = ipairs(v188.model:GetChildren());
							while true do
								v189(v190, v191);
								if not v189 then
									break;
								end;
								v191 = v189;
								v190.Transparency = 0;							
							end;
							v188:SetPrimaryPartCFrame(v150.CFrame * CFrame.new(1, 0, -4) * CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966));
							v188.Parent = l__bg__81.viewport;
							return;
						end;
					elseif u42 == "voice" then
						l__bg__81.viewport.voicepack.Visible = true;
					end;
				end;
			end);
		end;
	end;
end;
local v192, v193, v194 = ipairs(l__LocalPlayer__1:WaitForChild("player_career"):GetChildren());
while true do
	v192(v193, v194);
	if not v192 then
		break;
	end;
	v194 = v192;
	if l__gui__27:FindFirstChild(v193.Name) then
		l__gui__27:FindFirstChild(v193.Name).Text = v8.careerstats[v193.Name] .. ": " .. v193.Value;
		v193.Changed:Connect(function()
			l__gui__27:FindFirstChild(v193.Name).Text = v8.careerstats[v193.Name] .. ": " .. v193.Value;
		end);
	end;
end;
local u43 = tick();
l__gui__27.applybutton.MouseButton1Click:Connect(function()
	if tick() - u43 >= 0.5 then
		u43 = tick();
		v4:soundHandler({
			directory = { "ui", "menu" }, 
			soundfile = "ui_confirm", 
			location = l__CurrentCamera__5
		}, true);
		l__remotes__3.change_equipped:FireServer("change_highlight", { l__gui__27.highlight_R.Text, l__gui__27.highlight_G.Text, l__gui__27.highlight_B.Text });
	end;
end);
local l__skills_system__195 = l__game__1.ReplicatedStorage.skills_system;
local v196 = { "Sharpshooter" };
local v197 = tick();
local v198 = require(l__game__1.ReplicatedStorage.shared_modules.skillBase);
local v199 = l__skills_system__195:GetChildren();
table.sort(v199, function(p16, p17)
	return p16.Name:lower() < p17.Name:lower();
end);
local v200, v201, v202 = ipairs(v199);
while true do
	v200(v201, v202);
	if not v200 then
		break;
	end;
	v202 = v200;
	if v201.Name ~= "CORE" and v201.Name ~= "Sharpshooter" then
		table.insert(v196, v201.Name);
	end;
end;
local u44 = nil;
local l__gui__45 = l__workspace__4.skills_menu.gui;
local l__skillslot_equipped__46 = l__LocalPlayer__1.skillslot_equipped;
local function u47()
	if u44 then
		l__gui__45.skill_req.Visible = true;
		if not l__LocalPlayer__1.unlocked_skills:FindFirstChild(u44) then
			l__gui__45.skill_req.Text = "Click to buy Skill for 1 Requisition Token.";
			return;
		end;
	else
		return;
	end;
	if l__LocalPlayer__1:FindFirstChild("equipped_skills" .. l__skillslot_equipped__46.Value):FindFirstChild(u44) then
		l__gui__45.skill_req.Visible = false;
		return;
	end;
	l__gui__45.skill_req.Text = "Click to enable.";
end;
local u48 = l__LocalPlayer__1.max_skill_points.Value;
local u49 = v197;
local function u50()
	l__gui__45.skillslot1.BackgroundTransparency = 0.9;
	l__gui__45.skillslot2.BackgroundTransparency = 0.9;
	l__gui__45.skillslot3.BackgroundTransparency = 0.9;
	if l__gui__45:FindFirstChild("skillslot" .. tostring(l__skillslot_equipped__46.Value)) then
		l__gui__45:FindFirstChild("skillslot" .. tostring(l__skillslot_equipped__46.Value)).BackgroundTransparency = 0.5;
	end;
	local v203, v204, v205 = ipairs(l__gui__45.skillslist:GetChildren());
	while true do
		v203(v204, v205);
		if not v203 then
			break;
		end;
		v205 = v203;
		if v204.Name ~= "ex" then
			v204.bg.Visible = false;
			if l__LocalPlayer__1:FindFirstChild("equipped_skills" .. tostring(l__skillslot_equipped__46.Value)) and l__LocalPlayer__1:FindFirstChild("equipped_skills" .. tostring(l__skillslot_equipped__46.Value)):FindFirstChild(v204.Name) then
				v204.bg.Visible = true;
			end;
			if l__LocalPlayer__1.unlocked_skills:FindFirstChild(v204.Name) then
				v204.icon.ImageColor3 = Color3.new(1, 1, 1);
			else
				v204.icon.ImageColor3 = Color3.new(1, 0, 0);
			end;
			u47();
		end;	
	end;
	u48 = l__LocalPlayer__1.max_skill_points.Value;
	local v206, v207, v208 = ipairs(l__LocalPlayer__1:FindFirstChild("equipped_skills" .. l__skillslot_equipped__46.Value):GetChildren());
	while true do
		v206(v207, v208);
		if not v206 then
			break;
		end;
		v208 = v206;
		local v209 = 1;
		if v198.set_prices[v207.Name] then
			v209 = v198.set_prices[v207.Name];
		end;
		u48 = u48 - v209;	
	end;
	l__gui__45.skillmax.Text = u48 .. " / " .. l__LocalPlayer__1.max_skill_points.Value;
	l__gui__45.skilltip.Text = "YOU ARE ABLE TO ALLOCATE UP TO " .. l__LocalPlayer__1.max_skill_points.Value .. " SKILL POINTS FOR SKILLS.";
end;
local function v210(p18)
	if v196[p18] and l__skills_system__195:FindFirstChild(v196[p18]) then
		local v211 = l__skills_system__195:FindFirstChild(v196[p18]);
		l__gui__45.category.Text = string.upper(v196[p18]);
		l__gui__45.category_desc.Text = string.upper(v211.desc.Value);
		local v212, v213, v214 = ipairs(l__gui__45.skillslist:GetChildren());
		while true do
			v212(v213, v214);
			if not v212 then
				break;
			end;
			v214 = v212;
			if v213.Name ~= "ex" then
				v213:Destroy();
			end;		
		end;
		local v215 = v211:GetChildren();
		table.sort(v215, function(p19, p20)
			return p19.Name:lower() < p20.Name:lower();
		end);
		local v216, v217, v218 = ipairs(v215);
		while true do
			v216(v217, v218);
			if not v216 then
				break;
			end;
			v218 = v216;
			if v217.Name ~= "desc" then
				local v219 = require(v217);
				local v220 = l__gui__45.skillslist.ex:Clone();
				v220.Name = v217.Name;
				v220.icon.Image = "rbxassetid://" .. v219.icon;
				v220.icon.ImageColor3 = Color3.new(1, 0, 0);
				local v221 = 0;
				if #l__gui__45.skillslist:GetChildren() >= 9 then
					v221 = 0.45;
				end;
				v220.Visible = true;
				v220.Position = UDim2.new(0, 40 + 120 * (#l__gui__45.skillslist:GetChildren() - 1), v221, 20);
				v220.Parent = l__gui__45.skillslist;
				v220.MouseLeave:Connect(function()
					v220.BackgroundTransparency = 1;
				end);
				v220.MouseEnter:Connect(function()
					v220.BackgroundTransparency = 0.9;
					if u44 ~= v217.Name then
						v4:soundHandler({
							directory = { "ui" }, 
							soundfile = "skill_hover", 
							location = l__CurrentCamera__5
						}, true);
						u44 = v217.Name;
						l__gui__45.skill_name.Text = v219.name;
						l__gui__45.skill_desc.Text = v219.desc;
						local v222 = 1;
						if v198.set_prices[v217.Name] then
							v222 = v198.set_prices[v217.Name];
						end;
						l__gui__45.skill_cost.Text = "Requires " .. v222 .. " Skill Points.";
						u47();
					end;
				end);
				v220.MouseButton1Click:Connect(function()
					if tick() - u49 <= 0.1 then
						return;
					end;
					u49 = tick();
					if not l__LocalPlayer__1.unlocked_skills:FindFirstChild(v217.Name) then
						if l__LocalPlayer__1.req_tokens.Value < 1 then
							v4:soundHandler({
								directory = { "ui" }, 
								soundfile = "skill_blocked", 
								location = l__CurrentCamera__5
							}, true);
							return;
						else
							v4:soundHandler({
								directory = { "ui" }, 
								soundfile = "skill_get", 
								location = l__CurrentCamera__5
							}, true);
							l__remotes__3.skills_handler:FireServer("buy", v217.Name);
							return;
						end;
					end;
					local v223 = "skill_click";
					if l__LocalPlayer__1:FindFirstChild("equipped_skills" .. l__skillslot_equipped__46.Value):FindFirstChild(v217.Name) then
						l__remotes__3.skills_handler:FireServer("unequip", v217.Name);
					else
						local v224 = 1;
						if v198.set_prices[v217.Name] then
							v224 = v198.set_prices[v217.Name];
						end;
						if tonumber(string.sub(l__gui__45.skillmax.Text, 1, 2)) < v224 then
							v223 = "skill_blocked";
							spawn(function()
								local v225 = l__gui__45.skillmax:Clone();
								l__game__1:GetService("Debris"):AddItem(v225, 1);
								v225.Name = "fakeflash";
								v225.TextColor3 = Color3.new(1, 0, 0);
								v225.ZIndex = 3;
								v225.Parent = l__gui__45;
								local v226 = tick();
								while true do
									local v227 = tick();
									v225.TextTransparency = v225.TextTransparency + 0.05;
									v225.TextStrokeTransparency = v225.TextTransparency;
									while true do
										l__RenderStepped__2:wait();
										if tick() - v227 >= 0.03 then
											break;
										end;									
									end;
									if v225.TextTransparency >= 1 then
										break;
									end;								
								end;
								v225:Destroy();
							end);
						else
							l__remotes__3.skills_handler:FireServer("equip", v217.Name);
						end;
					end;
					v4:soundHandler({
						directory = { "ui" }, 
						soundfile = v223, 
						location = l__CurrentCamera__5
					}, true);
				end);
			end;		
		end;
		u50();
	end;
end;
v210(1);
local u51 = 1;
l__gui__45.prev.MouseButton1Click:Connect(function()
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	u51 = u51 - 1;
	if u51 <= 0 then
		u51 = #v196;
	end;
	v210(u51);
end);
l__gui__45.forward.MouseButton1Click:Connect(function()
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	u51 = u51 + 1;
	if #v196 < u51 then
		u51 = 1;
	end;
	v210(u51);
end);
l__gui__45.skillslot1.MouseButton1Click:Connect(function()
	if tick() - u49 <= 0.1 and l__gui__45.skillslot1.BackgroundTransparency == 0.9 then
		return;
	end;
	u49 = tick();
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	l__remotes__3.skills_handler:FireServer("changeslot", 1);
end);
l__gui__45.skillslot2.MouseButton1Click:Connect(function()
	if tick() - u49 <= 0.1 and l__gui__45.skillslot2.BackgroundTransparency == 0.9 then
		return;
	end;
	u49 = tick();
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	l__remotes__3.skills_handler:FireServer("changeslot", 2);
end);
l__gui__45.skillslot3.MouseButton1Click:Connect(function()
	if tick() - u49 <= 0.1 and l__gui__45.skillslot3.BackgroundTransparency == 0.9 then
		return;
	end;
	u49 = tick();
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	l__remotes__3.skills_handler:FireServer("changeslot", 3);
end);
local l__specs_system__228 = l__game__1.ReplicatedStorage.specs_system;
local v229 = { "ammobox" };
local v230, v231, v232 = ipairs(l__specs_system__228:GetChildren());
while true do
	v230(v231, v232);
	if not v230 then
		break;
	end;
	v232 = v230;
	if v231.Name ~= "CORE" and v231.Name ~= "ammobox" then
		table.insert(v229, v231.Name);
	end;
end;
local l__spec_levels__52 = l__LocalPlayer__1.spec_levels;
local u53 = nil;
local l__gui__54 = l__workspace__4.spec_menu.gui;
local l__spec_equipped__55 = l__LocalPlayer__1.spec_equipped;
local function u56(p21)
	local v233 = l__spec_levels__52:FindFirstChild(u53);
	l__gui__54.classlevel.Text = "CLASS TIER: 0";
	local v234 = l__spec_levels__52:FindFirstChild(u53);
	if v234 then
		l__gui__54.classlevel.Text = "CLASS TIER: " .. v234.Value;
		if #v198.specialisation_rank_reqs <= v234.Value then
			l__gui__54.classlevel.Text = "CLASS MAXED";
			l__gui__54.class_req.Text = "CLASS CANNOT BE RANKED UP FURTHER";
			l__gui__54.rankup.Visible = false;
		else
			l__gui__54.rankup.Visible = true;
			l__gui__54.class_req.Text = v198.specialisation_rank_reqs[v234.Value + 1] .. " TOKEN REQUIRED FOR RANK UP";
		end;
	end;
	for v235 = 1, 4 do
		local v236 = l__gui__54:FindFirstChild(v235);
		if v234.Value < v235 then
			v236.blocked.Visible = true;
		else
			if v236.blocked.Visible == true and p21 == true then
				v4:soundHandler({
					directory = { "ui" }, 
					soundfile = "spec_levelup", 
					location = l__CurrentCamera__5
				}, true);
				local v237 = v236.blocked:Clone();
				l__game__1:GetService("Debris"):AddItem(v237, 2);
				v237.Name = "flash";
				v237.Text = "";
				v237.BackgroundColor3 = Color3.new(1, 1, 1);
				v237.BackgroundTransparency = 0;
				v237.ZIndex = 4;
				v237.Parent = v236;
				spawn(function()
					local v238 = tick();
					while true do
						local v239 = tick();
						v237.BackgroundTransparency = v237.BackgroundTransparency + 0.05;
						while true do
							l__RenderStepped__2:wait();
							if tick() - v239 >= 0.03 then
								break;
							end;						
						end;
						if v237.BackgroundTransparency >= 1 then
							break;
						end;					
					end;
					v237:Destroy();
				end);
			end;
			v236.blocked.Visible = false;
			local v240, v241, v242 = ipairs(v236:GetChildren());
			while true do
				v240(v241, v242);
				if not v240 then
					break;
				end;
				v242 = v240;
				if v241.Name ~= "blocked" and v241.Name ~= "flash" then
					if l__spec_equipped__55:FindFirstChild(u53 .. v241.tier.Value .. "_" .. v241.spec.Value) then
						v241.BackgroundColor3 = Color3.fromRGB(9, 137, 207);
						v241.BorderColor3 = Color3.fromRGB(9, 150, 255);
						v241.BackgroundTransparency = 0.5;
					else
						v241.BackgroundColor3 = Color3.new(1, 1, 1);
						v241.BorderColor3 = Color3.new(1, 1, 1);
						v241.BackgroundTransparency = 0.9;
					end;
				end;			
			end;
		end;
	end;
end;
l__remotes__3.skills_handler.OnClientEvent:Connect(function(p22)
	if p22 == "levelupflash" then
		u56(true);
	end;
end);
local l__weapon_modules__57 = game.ReplicatedStorage.weapon_modules;
local u58 = {};
local u59 = nil;
local function v243(p23)
	u53 = p23;
	local v244 = l__spec_levels__52:FindFirstChild(p23);
	l__gui__54.category.Text = string.upper(require(l__weapon_modules__57:FindFirstChild(p23)).name);
	local v245, v246, v247 = ipairs(u58);
	while true do
		v245(v246, v247);
		if not v245 then
			break;
		end;
		v247 = v245;
		v246:Disconnect();	
	end;
	for v248 = 1, 4 do
		local v249 = l__gui__54:FindFirstChild(v248);
		local v250 = l__specs_system__228:FindFirstChild(p23):FindFirstChild(v248):GetChildren();
		table.sort(v250, function(p24, p25)
			return p24.Name:lower() < p25.Name:lower();
		end);
		local v251, v252, v253 = ipairs(v250);
		while true do
			v251(v252, v253);
			if not v251 then
				break;
			end;
			v253 = v251;
			local v254 = require(v252);
			local v255 = v249:FindFirstChild("move" .. v251);
			v255.tier.Value = v248;
			v255.spec.Value = v252.Name;
			v255.Text = v254.name;
			local v256 = v255.MouseEnter:Connect(function()
				if v249.blocked.Visible == true then
					return;
				end;
				if v255.BackgroundColor3 == Color3.new(1, 1, 1) then
					v255.BackgroundTransparency = 0.8;
				end;
				if u59 ~= v252.Name then
					v4:soundHandler({
						directory = { "ui" }, 
						soundfile = "skill_hover", 
						location = l__CurrentCamera__5
					}, true);
					u59 = v252.Name;
					l__gui__54.spec_name.Text = v254.name;
					l__gui__54.spec_desc.Text = v254.desc;
				end;
			end);
			local v257 = v255.MouseButton1Click:Connect(function()
				if tick() - u49 <= 0.2 then
					return;
				end;
				if v249.blocked.Visible == true then
					return;
				end;
				if v255.BackgroundColor3 == Color3.new(1, 1, 1) then
					u49 = tick();
					v4:soundHandler({
						directory = { "ui" }, 
						soundfile = "skill_click", 
						location = l__CurrentCamera__5
					}, true);
					l__remotes__3.skills_handler:FireServer("equip_spec", v252);
				end;
			end);
			table.insert(u58, (v255.MouseLeave:Connect(function()
				if v249.blocked.Visible == true or v255.BackgroundColor3 ~= Color3.new(1, 1, 1) then
					return;
				end;
				v255.BackgroundTransparency = 0.9;
			end)));
			table.insert(u58, v256);
			table.insert(u58, v257);		
		end;
		if v244.Value < v248 then
			v249.blocked.Visible = true;
			local v258, v259, v260 = ipairs(v249:GetChildren());
			while true do
				v258(v259, v260);
				if not v258 then
					break;
				end;
				v260 = v258;
				if v259.Name ~= "blocked" and v259.Name ~= "flash" then
					v259.BackgroundColor3 = Color3.new(1, 1, 1);
					v259.BorderColor3 = Color3.new(1, 1, 1);
					v259.BackgroundTransparency = 0.9;
				end;			
			end;
		else
			v249.blocked.Visible = false;
		end;
	end;
	u56();
end;
l__gui__54.rankup.MouseButton1Click:Connect(function()
	if tick() - u49 <= 0.2 then
		return;
	end;
	u49 = tick();
	if l__LocalPlayer__1.req_tokens.Value < v198.specialisation_rank_reqs[l__spec_levels__52:FindFirstChild(u53).Value + 1] then
		v4:soundHandler({
			directory = { "ui" }, 
			soundfile = "skill_blocked", 
			location = l__CurrentCamera__5
		}, true);
		spawn(function()
			local v261 = l__gui__54.class_req:Clone();
			l__game__1:GetService("Debris"):AddItem(v261, 1);
			v261.Name = "fakeflash";
			v261.TextColor3 = Color3.new(1, 0, 0);
			v261.ZIndex = 3;
			v261.Parent = l__gui__54;
			local v262 = tick();
			while true do
				local v263 = tick();
				v261.TextTransparency = v261.TextTransparency + 0.05;
				v261.TextStrokeTransparency = v261.TextTransparency;
				while true do
					l__RenderStepped__2:wait();
					if tick() - v263 >= 0.03 then
						break;
					end;				
				end;
				if v261.TextTransparency >= 1 then
					break;
				end;			
			end;
			v261:Destroy();
		end);
		return;
	end;
	v4:soundHandler({
		directory = { "ui" }, 
		soundfile = "skill_click", 
		location = l__CurrentCamera__5
	}, true);
	l__remotes__3.skills_handler:FireServer("rankup_spec", u53);
end);
v243("ammobox");
local u60 = 1;
l__gui__54.prev.MouseButton1Click:Connect(function()
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	u60 = u60 - 1;
	if u60 <= 0 then
		u60 = #v229;
	end;
	v243(v229[u60]);
end);
l__gui__54.forward.MouseButton1Click:Connect(function()
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	u60 = u60 + 1;
	if #v229 < u60 then
		u60 = 1;
	end;
	v243(v229[u60]);
end);
local l__gui__61 = l__workspace__4.merc_customisation.gui;
local u62 = { "default" };
local u63 = 1;
local l__merc_voices__64 = v7.merc_voices;
local function u65()
	local v264, v265, v266 = ipairs(l__gui__31.selection_list:GetChildren());
	while true do
		v264(v265, v266);
		if not v264 then
			break;
		end;
		v266 = v264;
		if v265.Name ~= "ex" then
			v265:Destroy();
		end;	
	end;
	for v267, v268 in pairs(u32) do
		local v269 = l__gui__31.selection_list.ex:Clone();
		v269.Name = v267;
		v269.Visible = true;
		v269.Position = UDim2.new(0, 0, 0, -60 + 70 * #l__gui__31.selection_list:GetChildren());
		v269.Text = v268[1];
		v269.Parent = l__gui__31.selection_list;
		v269.MouseButton1Click:Connect(function()
			if tick() - u33 <= 0.5 then
				return;
			end;
			v4:soundHandler({
				directory = { "ui", "menu" }, 
				soundfile = "ui_confirm", 
				location = l__CurrentCamera__5
			}, true);
			u33 = tick();
			l__remotes__3.change_equipped:FireServer("merc_voice", {
				voice = v267
			});
		end);
		v269.preview.MouseButton1Click:Connect(function()
			if tick() - u33 <= 0.5 then
				return;
			end;
			u33 = tick();
			local v270 = v268[2]:GetChildren()[math.random(1, #v268[2]:GetChildren())];
			v4:soundHandler({
				directory = { "voices", v268[2].Name, v270.Name }, 
				soundfile = v270:GetChildren()[math.random(1, #v270:GetChildren())].Name, 
				volume_adjust = 4, 
				location = l__CurrentCamera__5
			}, true);
		end);
	end;
end;
local function u66()
	local v271 = v7.standing_caps[l__LocalPlayer__1.standing_rank.Value];
	if v271 == nil then
		v271 = v7.standing_caps[#v7.standing_caps];
	end;
	l__Parent__3.standing.standingxp.Text = l__LocalPlayer__1.standing_xp.Value .. " / " .. v271;
	l__Parent__3.standing.rank.Text = "STANDING RANK: " .. "[" .. l__LocalPlayer__1.standing_rank.Value .. "]";
	l__gui__27.totalstanding.Text = "STANDING RANK: " .. "[" .. l__LocalPlayer__1.standing_rank.Value .. "]";
	if l__LocalPlayer__1.standing_xp.Value == v271 then
		l__Parent__3.standing.standingxp.Text = "MAXED STANDING";
		l__Parent__3.standing.rank.Text = "RANK UP TO: " .. "[" .. l__LocalPlayer__1.standing_rank.Value + 1 .. "] AVAILABLE";
	end;
	l__Parent__3.standing.bar.inner.Size = UDim2.new(l__LocalPlayer__1.standing_xp.Value / v271, -10, 1, -5);
	l__Parent__3.shop_frame.bg.standingprogress.Text = l__LocalPlayer__1.standing_xp.Value .. " / " .. v271;
	l__Parent__3.shop_frame.bg.standingbar.inner.Size = UDim2.new(l__LocalPlayer__1.standing_xp.Value / v271, 0, 1, -10);
	l__Parent__3.shop_frame.bg.standingbutton.Text = "Requisition Tokens: " .. l__LocalPlayer__1.req_tokens.Value;
	l__Parent__3.shop_frame.bg.standingrank.Text = "Standing Rank: " .. l__LocalPlayer__1.standing_rank.Value;
end;
local function u67()
	local v272, v273, v274 = ipairs(l__player_loadout__12:GetChildren());
	while true do
		v272(v273, v274);
		if not v272 then
			break;
		end;
		v274 = v272;
		if not (not l__weapon_modules__57:FindFirstChild(v273.Value)) or not (not l__game__1.ReplicatedStorage.weapon_variants:FindFirstChild(v273.Value)) or l__game__1.ReplicatedStorage.weapon_auxes:FindFirstChild(v273.Value) then
			local v275 = require(l__weapon_modules__57:FindFirstChild(v273.Value) or (l__game__1.ReplicatedStorage.weapon_variants:FindFirstChild(v273.Value) or l__game__1.ReplicatedStorage.weapon_auxes:FindFirstChild(v273.Value)));
			if l__gui__61:FindFirstChild(v273.Name) then
				l__gui__61:FindFirstChild(v273.Name).Text = v275.name;
			end;
		end;	
	end;
	u62 = {};
	u63 = 1;
	local v276, v277, v278 = ipairs(l__game__1.ReplicatedStorage.outfits.mercs:GetChildren());
	while true do
		v276(v277, v278);
		if not v276 then
			break;
		end;
		v278 = v276;
		if v277.Name ~= "default" and l__LocalPlayer__1.unlocks:FindFirstChild(v277.Name) then
			table.insert(u62, v277.Name);
		end;	
	end;
	table.insert(u62, "default");
	u32 = {
		merc = { "MERC", l__game__1.ReplicatedStorage.sound_library.voices.merc }
	};
	local v279, v280, v281 = ipairs(l__LocalPlayer__1.unlocks:GetChildren());
	while true do
		v279(v280, v281);
		if not v279 then
			break;
		end;
		v281 = v279;
		if v280.Name ~= "merc" and l__merc_voices__64[v280.Name] then
			u32[v280.Name] = { l__merc_voices__64[v280.Name][1], l__merc_voices__64[v280.Name][2] };
		end;	
	end;
	u65();
	u14();
	u66();
	u50();
	u56();
	local v282, v283, v284 = ipairs(l__gui__31.selection_list:GetChildren());
	while true do
		v282(v283, v284);
		if not v282 then
			break;
		end;
		v284 = v282;
		v283.BackgroundColor3 = Color3.new(1, 1, 1);	
	end;
	if l__gui__31.selection_list:FindFirstChild(l__LocalPlayer__1.voice.Value) then
		l__gui__31.selection_list:FindFirstChild(l__LocalPlayer__1.voice.Value).BackgroundColor3 = Color3.new(0, 0, 0);
	end;
	l__gui__45.token_count.Text = "REQUISITION TOKENS: " .. l__LocalPlayer__1.req_tokens.Value;
	l__gui__54.reqtokens.Text = "REQUISITION TOKENS: " .. l__LocalPlayer__1.req_tokens.Value;
	l__gui__27.highlight.TextColor3 = Color3.fromRGB(l__LocalPlayer__1.player_highlight_R.Value, l__LocalPlayer__1.player_highlight_G.Value, l__LocalPlayer__1.player_highlight_B.Value);
end;
l__remotes__3.change_equipped.OnClientEvent:connect(function(p26)
	if p26 == "global_refresh" then
		u67();
		return;
	end;
	if p26 == "refresh_clothes" then
		if l__workspace__4.clothes:FindFirstChild("Pants") then
			l__workspace__4.clothes.Pants:Destroy();
		end;
		if l__workspace__4.clothes:FindFirstChild("Shirt") then
			l__workspace__4.clothes.Shirt:Destroy();
		end;
		local v285 = l__game__1.ReplicatedStorage.outfits.mercs:FindFirstChild(l__LocalPlayer__1.outfit.Value);
		if v285 then
			local v286 = v285:Clone();
			v286.Shirt.Parent = l__workspace__4.clothes;
			v286.Pants.Parent = l__workspace__4.clothes;
			v286:Destroy();
		end;
	end;
end);
l__gui__31.outfit.next.MouseButton1Click:connect(function()
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	u63 = u63 + 1;
	if #u62 < u63 then
		u63 = 1;
	end;
	l__remotes__3.change_equipped:FireServer("merc_clothes", {
		outfit = u62[u63]
	});
end);
l__gui__31.outfit.prev.MouseButton1Click:connect(function()
	v4:soundHandler({
		directory = { "ui", "menu" }, 
		soundfile = "ui_click", 
		location = l__CurrentCamera__5
	}, true);
	u63 = u63 - 1;
	if u63 <= 0 then
		u63 = #u62;
	end;
	l__remotes__3.change_equipped:FireServer("merc_clothes", {
		outfit = u62[u63]
	});
end);
local l__gui__68 = l__workspace__4.merc_selections.gui;
local l__gui__69 = l__workspace__4.merc_glossary_bars.gui;
local l__gui__70 = l__workspace__4.merc_glossary.gui;
local u71 = nil;
local function u72()
	local v287, v288, v289 = ipairs(l__gui__68.statbars:GetChildren());
	while true do
		v287(v288, v289);
		if not v287 then
			break;
		end;
		v289 = v287;
		v288.Visible = false;	
	end;
	local v290, v291, v292 = ipairs(l__gui__69.statbars:GetChildren());
	while true do
		v290(v291, v292);
		if not v290 then
			break;
		end;
		v292 = v290;
		v291.Visible = false;	
	end;
end;
local function u73(p27, p28, p29, p30, p31)
	local v293 = l__gui__68.statbars;
	if p31 then
		v293 = p31;
	end;
	local v294 = v293:FindFirstChild("stat" .. p27);
	if v294 and p30 then
		v294.title.Text = p28;
		v294.num.Text = math.ceil(p30);
		v294.bar.Size = UDim2.new(math.clamp(p29, 0.01, 1), 0, 1, 0);
		v294.Visible = true;
	end;
end;
local function u74(p32, p33)
	if p33 == l__gui__70.free then
		p33.CanvasSize = p33.CanvasSize + UDim2.new(0, 0, 0.145, 0);
	else
		p33.CanvasSize = p33.CanvasSize + UDim2.new(0, 0, 0.11, 0);
	end;
	local v295 = require(p32);
	local v296 = p33.ex:Clone();
	v296.Name = p32.Name;
	v296.Text = v295.name;
	if p33 == l__gui__70.free then
		v296.Position = UDim2.new(0.5, 0, 0, -40 + 50 * #p33:GetChildren());
	else
		v296.Position = UDim2.new(0.5, 0, 0, -60 + 70 * #p33:GetChildren());
	end;
	v296.Visible = true;
	v296.Parent = p33;
	v296.MouseButton1Click:Connect(function()
		if tick() - u33 <= 0.25 then
			return;
		end;
		local v297 = "ui_equip_merc_gun";
		if v295.equipment == true then
			if v295.special_attributes and v295.special_attributes.regen then
				v297 = "ui_equip_merc_tac";
			else
				v297 = "ui_equip_merc_gear";
			end;
		elseif v295.large == false then
			v297 = "ui_equip_merc_pistol";
		end;
		u33 = tick();
		if p33 == l__gui__68.selection_list or p33 == l__gui__68.variants then
			l__remotes__3.change_equipped:FireServer("merc", {
				gui = u71, 
				item = p32
			});
		else
			v297 = "ui_click";
		end;
		v4:soundHandler({
			directory = { "ui", "menu" }, 
			soundfile = v297, 
			location = l__CurrentCamera__5
		}, true);
		local v298 = true;
		if p33 == l__gui__70.free then
			v298 = false;
		end;
		u72();
		local v299 = l__gui__68.statbars;
		if v298 == false then
			local v300, v301, v302 = ipairs(l__gui__70.free:GetChildren());
			while true do
				v300(v301, v302);
				if not v300 then
					break;
				end;
				v302 = v300;
				if v301.Name == v296.Name then
					v301.BackgroundColor3 = Color3.new(0, 0, 0);
				else
					v301.BackgroundColor3 = Color3.new(1, 1, 1);
				end;			
			end;
			l__gui__70.desc.Text = v295.desc;
			l__gui__70.desctag.Text = "[ " .. v295.name .. " ]";
			v299 = l__gui__69.statbars;
		else
			local v303, v304, v305 = ipairs(l__gui__68.selection_list:GetChildren());
			while true do
				v303(v304, v305);
				if not v303 then
					break;
				end;
				v305 = v303;
				if v304.Name == v296.Name then
					v304.BackgroundColor3 = Color3.new(0, 0, 0);
				else
					v304.BackgroundColor3 = Color3.new(1, 1, 1);
				end;			
			end;
			local v306, v307, v308 = ipairs(l__gui__68.variants:GetChildren());
			while true do
				v306(v307, v308);
				if not v306 then
					break;
				end;
				v308 = v306;
				if v307.Name == v296.Name then
					v307.BackgroundColor3 = Color3.new(0, 0, 0);
				else
					v307.BackgroundColor3 = Color3.new(1, 1, 1);
				end;			
			end;
			l__gui__68.desc.Text = v295.desc;
			l__gui__68.desctag.Text = "[ " .. v295.name .. " ]";
			if p33 == l__gui__68.selection_list then
				l__gui__68.variants.CanvasSize = UDim2.new(0, 0, 0, 0);
				local v309, v310, v311 = ipairs(l__gui__68.variants:GetChildren());
				while true do
					v309(v310, v311);
					if not v309 then
						break;
					end;
					v311 = v309;
					if v310.Name ~= "ex" then
						v310:Destroy();
					end;				
				end;
				local v312 = false;
				local v313 = {};
				local v314, v315, v316 = ipairs(l__game__1.ReplicatedStorage.weapon_variants:GetChildren());
				while true do
					v314(v315, v316);
					if not v314 then
						break;
					end;
					v316 = v314;
					if string.sub(v315.Name, 1, string.len(p32.Name)) == p32.Name and require(v315).special_attributes.not_shown ~= true then
						v312 = true;
						table.insert(v313, v315);
					end;				
				end;
				if v312 == false then
					l__gui__68.viewvariants.Text = "NO DERIVATIVES";
					l__gui__68.tutsegmentA.Visible = true;
					l__gui__68.variants.Visible = false;
					l__gui__68.deriv_sign.Visible = false;
				else
					table.sort(v313, function(p34, p35)
						return p34.Name:lower() < p35.Name:lower();
					end);
					local v317, v318, v319 = ipairs(v313);
					while true do
						v317(v318, v319);
						if not v317 then
							break;
						end;
						v319 = v317;
						u74(v318, l__gui__68.variants);					
					end;
					l__gui__68.viewvariants.Text = "SELECT DERIVATIVES";
					l__gui__68.tutsegmentA.Visible = false;
					l__gui__68.variants.Visible = true;
					l__gui__68.deriv_sign.Visible = true;
				end;
			end;
		end;
		if v295.equipment == false then
			u73(1, "Damage On Hit", v295.damage * v295.pellets / 150, v295.damage * v295.pellets, v299);
			u73(2, "Drop Off Range", v295.falloff / 150, v295.falloff, v299);
			u73(3, "Drop Off Damage", v295.falloff_damage * v295.pellets / 150, v295.falloff_damage * v295.pellets, v299);
			u73(4, "Firerate / RPM", 60 / v295.fire_rate / 1000, 60 / v295.fire_rate, v299);
			u73(5, "Recoil Control", 1 - v295.base_recoil / 60, 60 - v295.base_recoil, v299);
			if p32.Name == "knife" then
				u72();
				u73(1, "Damage On Hit", v295.damage * v295.pellets / 150, v295.damage * v295.pellets, v299);
				u73(2, "Swing Rate (RPM)", 60 / v295.fire_rate / 1000, 60 / v295.fire_rate, v299);
				u73(3, "Chadness", 100, 999, v299);
				return;
			end;
		else
			if v295.special_attributes.regen then
				u73(5, "Cooldown (Seconds)", 1 - v295.special_attributes.regen / 190, v295.special_attributes.regen, v299);
			end;
			u73(1, "Item Capacity", v295.magazine / 5, v295.magazine, v299);
			if p32.Name == "sentry" then
				u73(2, "Damage On Hit", v295.special_attributes.sentry_damage / 150, v295.special_attributes.sentry_damage, v299);
				u73(3, "Firerate / RPM", 60 / v295.special_attributes.sentry_firerate / 1000, 60 / v295.special_attributes.sentry_firerate, v299);
				u73(4, "Detection Range (Studs)", 0.4, v295.special_attributes.sentry_front, v299);
				return;
			end;
			if p32.Name == "ammobox" then
				u73(2, "Ammo Refills", 1, v295.special_attributes.refill_uses, v299);
				u73(3, "Refill Range", 0.3, v295.special_attributes.refill_range, v299);
				return;
			end;
			if p32.Name == "camera" then
				u73(2, "Camera Range (Studs)", 0.8, v295.special_attributes.alarm_radius, v299);
				u73(3, "Self Flash Range (Studs)", 0.3, v295.special_attributes.flash_detect_range, v299);
				return;
			end;
			if p32.Name == "plate" then
				u73(2, "Extra Health", 0.35, v295.special_attributes.health_boost, v299);
				u73(3, "Slow HP Regen (Seconds)", 0.1, 3, v299);
				u73(4, "Plates Per Bag", 1, 3, v299);
				return;
			end;
			if p32.Name == "medic" then
				u73(2, "Heal Range (Studs)", 0.5, v295.special_attributes.heal_range, v299);
				u73(3, "Heal Amount", v295.special_attributes.heal_amt / 100, v295.special_attributes.heal_amt, v299);
				return;
			end;
			if p32.Name == "mine" then
				u73(2, "Explosion Damage", 0.8, v295.special_attributes.mine_damage, v299);
				u73(3, "Laser Range (Studs)", 0.5, v295.special_attributes.mine_max_laser, v299);
				return;
			end;
			if p32.Name == "smoke" then
				u73(2, "Nanite Damage", v295.special_attributes.smoke_damage / 150, v295.special_attributes.smoke_damage, v299);
				u73(3, "Duration (Seconds)", v295.special_attributes.smoke_damage / 60, v295.special_attributes.smoke_duration, v299);
				return;
			end;
			if p32.Name == "stim" then
				u73(2, "Heal Amount", v295.special_attributes.stim_heal / 100, v295.special_attributes.stim_heal, v299);
				return;
			end;
			if p32.Name == "speedshot" then
				u73(2, "Speed Boost (Seconds)", v295.special_attributes.speed_boost_duration / 4, v295.special_attributes.speed_boost_duration, v299);
				u73(3, "Fatigue (Seconds)", v295.special_attributes.slowdown_duration / 6, v295.special_attributes.slowdown_duration, v299);
				return;
			end;
			if p32.Name == "syringe" then
				u73(2, "Reload Boost (Percent)", v295.special_attributes.speed_increase, v295.special_attributes.speed_increase * 100, v299);
				u73(3, "Recoil Boost (Percent)", v295.special_attributes.speed_increase, v295.special_attributes.speed_increase * 100, v299);
				u73(4, "Duration (Seconds)", 0.9, v295.special_attributes.boost_duration, v299);
				return;
			end;
			if p32.Name == "flare" then
				u73(2, "Flare Duration", 1, v295.special_attributes.flare_duration, v299);
				return;
			end;
			if p32.Name == "throwing" then
				u73(2, "Damage On Hit", v295.special_attributes.axe_damage / 600, v295.special_attributes.axe_damage, v299);
				u73(3, "Velocity (Studs per Seconds)", 0.75, v295.special_attributes.throw_velocity, v299);
				return;
			end;
			if p32.Name == "throwaxe" then
				u73(2, "Damage On Hit", 1, v295.special_attributes.knife_damage, v299);
				u73(3, "Velocity (Studs per Seconds)", 1, v295.special_attributes.throw_velocity, v299);
				u73(4, "Chadness", 1, 999, v299);
				return;
			end;
			if p32.Name == "frag" then
				u73(2, "Explosion Damage", 1, v295.special_attributes.frag_damage, v299);
				u73(3, "Radius (Studs)", v295.special_attributes.frag_radius / 50, v295.special_attributes.frag_radius, v299);
				u73(4, "Fuse (Seconds)", v295.special_attributes.frag_det / 6, v295.special_attributes.frag_det, v299);
				return;
			end;
			if p32.Name == "pipe" then
				u73(2, "Explosion Damage", 0.4, v295.special_attributes.frag_damage, v299);
				u73(3, "Radius (Studs)", v295.special_attributes.frag_radius / 50, v295.special_attributes.frag_radius, v299);
				u73(4, "Fuse (Seconds)", v295.special_attributes.frag_det / 6, v295.special_attributes.frag_det, v299);
				return;
			end;
			if p32.Name == "shrap" then
				u73(2, "Shrapnel Damage", 0.2, v295.special_attributes.impact_damage, v299);
				u73(3, "Radius (Studs)", v295.special_attributes.frag_radius / 50, v295.special_attributes.impact_radius, v299);
				local v320 = v295.special_attributes.frag_det / 6;
				u73(4, "Incendiary", 1, 1, v299);
				return;
			end;
			if p32.Name == "flash" then
				u73(2, "Radius (Studs)", v295.special_attributes.radius_hit / 50, v295.special_attributes.radius_hit, v299);
				u73(3, "Fuse (Seconds)", v295.special_attributes.det_time / 6, v295.special_attributes.det_time, v299);
			end;
		end;
	end);
end;
local v321, v322, v323 = ipairs(l__weapon_modules__57:GetChildren());
while true do
	v321(v322, v323);
	if not v321 then
		break;
	end;
	v323 = v321;
	local v324 = require(v322);
	if v322.Name ~= "hidden" and v324.special_attributes.hidden_equipment ~= true and v324.special_attributes.hidden ~= true then
		u74(v322, l__gui__70.free);
	end;
end;
local v325, v326, v327 = ipairs(l__game__1.ReplicatedStorage.weapon_variants:GetChildren());
while true do
	v325(v326, v327);
	if not v325 then
		break;
	end;
	v327 = v325;
	local v328 = require(v326);
	u74(v326, l__gui__70.free);
end;
local v329, v330, v331 = ipairs(l__gui__61:GetChildren());
while true do
	v329(v330, v331);
	if not v329 then
		break;
	end;
	v331 = v329;
	if v330:IsA("TextButton") then
		v330.MouseButton1Click:Connect(function()
			if tick() - u33 <= 0.5 then
				return;
			end;
			v4:soundHandler({
				directory = { "ui", "menu" }, 
				soundfile = "ui_click", 
				location = l__CurrentCamera__5
			}, true);
			u33 = tick();
			local v332, v333, v334 = ipairs(l__gui__61:GetChildren());
			while true do
				v332(v333, v334);
				if not v332 then
					break;
				end;
				v334 = v332;
				if v333:IsA("TextButton") then
					v333.BackgroundColor3 = Color3.new(1, 1, 1);
				end;			
			end;
			u71 = v330;
			u71.BackgroundColor3 = Color3.new(0, 0, 0);
			local v335, v336, v337 = ipairs(l__gui__68.selection_list:GetChildren());
			while true do
				v335(v336, v337);
				if not v335 then
					break;
				end;
				v337 = v335;
				if v336.Name ~= "ex" then
					v336:Destroy();
				end;			
			end;
			l__gui__68.selection_list.CanvasPosition = Vector2.new(0, 0, 0);
			l__gui__68.selection_list.CanvasSize = UDim2.new(0, 0, 0, 0);
			local v338 = l__weapon_modules__57:GetChildren();
			local v339, v340, v341 = ipairs(l__game__1.ReplicatedStorage.weapon_auxes:GetChildren());
			while true do
				v339(v340, v341);
				if not v339 then
					break;
				end;
				v341 = v339;
				table.insert(v338, v340);			
			end;
			table.sort(v338, function(p36, p37)
				return p36.Name:lower() < p37.Name:lower();
			end);
			local v342, v343, v344 = ipairs(v338);
			while true do
				v342(v343, v344);
				if not v342 then
					break;
				end;
				v344 = v342;
				if v343.Name ~= "hidden" and v343.Name ~= "classic" then
					local v345 = require(v343);
					local v346 = true;
					if v345.special_attributes.hidden_equipment == true then
						v346 = false;
					end;
					if v345.special_attributes.hidden == true then
						v346 = false;
					end;
					if v345.special_attributes.not_shown == true then
						v346 = false;
					end;
					if v346 == true then
						if u20 == l__menucampos__19.armoury.CFrame and l__CurrentCamera__5.CameraType == Enum.CameraType.Scriptable then
							u20 = l__menucampos__19.selection.CFrame;
						end;
						local v347 = {};
						if v330.Name == "primary" or v330.Name == "secondary" then
							if v345.equipment == false and v345.large == true and v345.special ~= "melee" or v345.special_attributes.sparemag == true then
								u74(v343, l__gui__68.selection_list);
							end;
						elseif v330.Name == "pistol" then
							if v345.equipment == false and v345.large == false and v345.special ~= "melee" then
								u74(v343, l__gui__68.selection_list);
							end;
						elseif v330.Name == "tactical" then
							if v345.equipment == true and v345.special_attributes.regen ~= nil and v345.aux ~= true then
								u74(v343, l__gui__68.selection_list);
							end;
						elseif string.sub(v330.Name, 1, 9) == "equipment" then
							if v345.equipment == true and v345.special_attributes.regen == nil and v345.special_attributes.sparemag == nil and v345.aux ~= true then
								u74(v343, l__gui__68.selection_list);
							end;
						elseif v330.Name == "aux" and v345.equipment == true and v345.special_attributes.regen == nil and v345.special_attributes.sparemag == nil and v345.aux == true then
							u74(v343, l__gui__68.selection_list);
						end;
					end;
				end;			
			end;
		end);
	end;
end;
local l__gui__75 = l__workspace__4.terror_menu.gui;
local function v348(p38)
	l__gui__75.selection_list.CanvasSize = l__gui__75.selection_list.CanvasSize + UDim2.new(0, 0, 0.11, 0);
	local v349 = require(p38);
	local v350 = l__gui__75.selection_list.ex:Clone();
	v350.Name = p38.Name;
	v350.Text = v349.name;
	v350.Position = UDim2.new(0.5, 0, 0, -60 + 70 * #l__gui__75.selection_list:GetChildren());
	v350.Visible = true;
	v350.Parent = l__gui__75.selection_list;
	v350.MouseButton1Click:Connect(function()
		if tick() - u33 <= 0.5 then
			return;
		end;
		v4:soundHandler({
			directory = { "ui", "menu" }, 
			soundfile = "ui_click", 
			location = l__CurrentCamera__5
		}, true);
		u33 = tick();
		local v351, v352, v353 = ipairs(l__gui__75.selection_list:GetChildren());
		while true do
			v351(v352, v353);
			if not v351 then
				break;
			end;
			v353 = v351;
			if v352.Name == v350.Name then
				v352.BackgroundColor3 = Color3.new(0, 0, 0);
			else
				v352.BackgroundColor3 = Color3.new(1, 1, 1);
			end;		
		end;
		l__gui__75.terrorname.Text = "The " .. v349.name;
		l__gui__75.lore.Visible = true;
		l__gui__75.lore.scroll.CanvasPosition = Vector2.new(0, 0);
		l__gui__75.lore.scroll.loretext.Text = v349.desc;
	end);
end;
local v354, v355, v356 = ipairs(l__game__1.ReplicatedStorage.enemy_types:GetChildren());
while true do
	v354(v355, v356);
	if not v354 then
		break;
	end;
	v356 = v354;
	if v355.Name ~= "CORE" and v355.Name ~= "nightdemon" and v355.Name ~= "king" then
		v348(v355);
	end;
end;
u67();
local v357 = tick();
local v358 = {};
if l__game__1:GetService("RunService"):IsStudio() == true then
	l__workspace__4.backgroundMusic.Volume = 0;
	u10 = true;
end;
_G.mute_music = false;
function v358.mutemusic(p39)
	if u10 == false then
		u10 = true;
		p39.BackgroundColor3 = Color3.new(0, 0, 0);
		l__workspace__4.backgroundMusic.Volume = 0;
		_G.mute_music = true;
		return;
	end;
	if u10 == true then
		u10 = false;
		_G.mute_music = false;
		p39.BackgroundColor3 = Color3.new(1, 1, 1);
		l__workspace__4.backgroundMusic.Volume = l__workspace__4.backgroundMusic.def.Value;
	end;
end;
function v358.disablesplatter(p40)
	if u2 == true then
		u2 = false;
		p40.BackgroundColor3 = Color3.new(0, 0, 0);
		return;
	end;
	if u2 == false then
		u2 = true;
		p40.BackgroundColor3 = Color3.new(1, 1, 1);
	end;
end;
local u76 = false;
function v358.mutevoices(p41)
	if u76 == false then
		u76 = true;
		p41.BackgroundColor3 = Color3.new(0, 0, 0);
		return;
	end;
	if u76 == true then
		u76 = false;
		p41.BackgroundColor3 = Color3.new(1, 1, 1);
	end;
end;
_G.disable_pings = false;
function v358.disableping(p42)
	if _G.disable_pings == false then
		_G.disable_pings = true;
		p42.BackgroundColor3 = Color3.new(0, 0, 0);
		return;
	end;
	if _G.disable_pings == true then
		_G.disable_pings = false;
		p42.BackgroundColor3 = Color3.new(1, 1, 1);
	end;
end;
function v358.disablevisuals(p43)
	if _G.disable_weaponvfx == false then
		_G.disable_weaponvfx = true;
		p43.BackgroundColor3 = Color3.new(0, 0, 0);
		return;
	end;
	if _G.disable_weaponvfx == true then
		_G.disable_weaponvfx = false;
		p43.BackgroundColor3 = Color3.new(1, 1, 1);
	end;
end;
_G.disable_physcasings = false;
function v358.disablecasings(p44)
	if _G.disable_physcasings == false then
		_G.disable_physcasings = true;
		p44.BackgroundColor3 = Color3.new(0, 0, 0);
		return;
	end;
	if _G.disable_physcasings == true then
		_G.disable_physcasings = false;
		p44.BackgroundColor3 = Color3.new(1, 1, 1);
	end;
end;
local u77 = false;
function v358.mutemenu(p45)
	if u77 == false then
		u77 = true;
		p45.BackgroundColor3 = Color3.new(0, 0, 0);
		if l__workspace__4.backgroundMusic.SoundId ~= "rbxassetid://10135739060" then
			return;
		end;
	else
		if u77 == true then
			u77 = false;
			p45.BackgroundColor3 = Color3.new(1, 1, 1);
		end;
		return;
	end;
	l__workspace__4.backgroundMusic.Volume = 0;
end;
_G.disable_alerts = false;
function v358.disablealert(p46)
	if _G.disable_alerts == false then
		_G.disable_alerts = true;
		p46.BackgroundColor3 = Color3.new(0, 0, 0);
		return;
	end;
	if _G.disable_alerts == true then
		_G.disable_alerts = false;
		p46.BackgroundColor3 = Color3.new(1, 1, 1);
	end;
end;
_G.disable_sens = false;
function v358.disablesens(p47)
	if _G.disable_sens == false then
		_G.disable_sens = true;
		p47.BackgroundColor3 = Color3.new(0, 0, 0);
		return;
	end;
	if _G.disable_sens == true then
		_G.disable_sens = false;
		p47.BackgroundColor3 = Color3.new(1, 1, 1);
	end;
end;
local u78 = tick();
function _G.hitmarker(p48, p49)
	if p48 == "kill" and p49 and l__Parent__3.hitmarkers:FindFirstChild(p49) then
		return;
	end;
	if tick() - u78 <= 0.03 then
		return;
	end;
	u78 = tick();
	local v359 = 0;
	local v360 = l__Parent__3.hitmarkers.ex:Clone();
	if p49 and p48 == "kill" then
		v360.Name = p49;
	end;
	local v361 = false;
	v360.Rotation = math.random(-10, 10);
	if p48 == "kill" then
		v360.Size = UDim2.new(0, 35, 0, 35);
		v360.ZIndex = 3;
		v360.ImageColor3 = Color3.new(1, 0.1, 0.1);
		v359 = 1;
		v360.Rotation = 0;
	elseif p48 == "falloff" then
		v360.Size = UDim2.new(0, 20, 0, 20);
		v360.ZIndex = 3;
		v360.ImageColor3 = Color3.new(0.8, 0.8, 0.8);
		v360.Rotation = math.random(-5, 5);
	elseif p48 == "armour" then
		v361 = true;
		v360.Size = UDim2.new(0, 20, 0, 20);
		v360.ZIndex = 3;
		v360.ImageColor3 = Color3.new(1, 1, 0.3);
	end;
	if v361 == false then
		v4:soundHandler({
			directory = { "game_sounds" }, 
			soundfile = "hitsound", 
			location = l__CurrentCamera__5, 
			volume_adjust = v359
		}, true);
	end;
	l__game__1:GetService("Debris"):AddItem(v360, 2);
	v360.Name = "hitmark";
	v360.Visible = true;
	v360.Parent = l__Parent__3.hitmarkers;
	spawn(function()
		local v362 = tick();
		while true do
			local v363 = tick();
			v360.ImageTransparency = v360.ImageTransparency + 0.1;
			while true do
				l__RenderStepped__2:wait();
				if tick() - v363 >= 0.03 then
					break;
				end;			
			end;
			if v360.ImageTransparency >= 1 then
				break;
			end;		
		end;
		v360:Destroy();
	end);
end;
local v364, v365, v366 = ipairs(l__workspace__4.settings.gui:GetChildren());
while true do
	v364(v365, v366);
	if not v364 then
		break;
	end;
	v366 = v364;
	if v358[v365.Name] ~= nil then
		local u79 = v357;
		v365.MouseButton1Click:Connect(function()
			if tick() - u79 <= 0.5 then
				return;
			end;
			v4:soundHandler({
				directory = { "ui", "menu" }, 
				soundfile = "ui_confirm", 
				location = l__CurrentCamera__5
			}, true);
			u79 = tick();
			v358[v365.Name](v365);
			l__remotes__3.change_equipped:FireServer("player_settings", {
				setting = v365
			});
		end);
		delay(1, function()
			if l__LocalPlayer__1:WaitForChild("player_settings", 5) and l__LocalPlayer__1.player_settings:FindFirstChild(v365.Name) and l__LocalPlayer__1.player_settings:FindFirstChild(v365.Name).Value == true then
				u79 = tick();
				v358[v365.Name](v365);
			end;
		end);
	end;
end;
local u80 = nil;
local function u81()
	l__workspace__4.backgroundMusic.Volume = l__workspace__4.backgroundMusic.def.Value;
	if u10 == true and l__workspace__4.backgroundMusic.SoundId ~= "rbxassetid://11148585327" then
		l__workspace__4.backgroundMusic.Volume = 0;
	end;
	if u77 == true and l__workspace__4.backgroundMusic.SoundId == "rbxassetid://10135739060" then
		l__workspace__4.backgroundMusic.Volume = 0;
	end;
	u80:Disconnect();
	u80 = l__workspace__4.backgroundMusic.Changed:Connect(u81);
end;
u80 = l__workspace__4.backgroundMusic.Changed:Connect(u81);
l__workspace__4.mainGame.game_values.classic_mode.Changed:Connect(function()
	l__Parent__3.anomaly_frame.abilities.Visible = false;
	l__Parent__3.early.Text = "CLASSIC MODE IS ENABLED ON THIS SERVER";
end);
l__remotes__3.voices_handler.OnClientEvent:connect(function(p50, p51)
	if (u76 == false or p51 == "anomaly") and p50 then
		p50:Play();
	end;
end);
wait();
if u10 == false then
	if l__workspace__4.backgroundMusic.SoundId == "rbxassetid://10135739060" then
		l__workspace__4.backgroundMusic.TimePosition = 0;
	end;
	l__workspace__4.backgroundMusic.Volume = l__workspace__4.backgroundMusic.def.Value;
end;
local v367 = Instance.new("BindableEvent");
v367.Event:connect(function()
	l__remotes__3.game_handler:FireServer("reset");
end);
l__game__1:GetService("StarterGui"):SetCore("ResetButtonCallback", v367);
l__remotes__3.standing_handler.OnClientEvent:Connect(function(p52, p53)
	if p52 == "add_xp" then
		u66();
		u28 = tick();
		local v368 = l__Parent__3.standing.new.ex:Clone();
		v368.Visible = true;
		v368.standingtext.Text = p53.reason .. " +" .. p53.xp .. " XP";
		local v369 = 1;
		local v370, v371, v372 = ipairs(l__Parent__3.standing.new:GetChildren());
		while true do
			v370(v371, v372);
			if not v370 then
				break;
			end;
			v372 = v370;
			if l__Parent__3.standing.new:FindFirstChild(v370) == nil then
				v369 = v370;
			end;		
		end;
		v368.Name = v369;
		v368.Position = v368.Position + UDim2.new(1.2, 0, 0, -25 + 25 * v369);
		v368.Parent = l__Parent__3.standing.new;
		local u82 = UDim2.new(0, 0, 0, -25 + 25 * v369);
		spawn(function()
			local v373 = tick();
			while true do
				v368.Position = v368.Position:Lerp(u82, 0.1);
				l__RenderStepped__2:wait();
				if tick() - v373 >= 6 then
					break;
				end;			
			end;
			local v374 = math.random(30, 80) / 1000;
			for v375 = 1, 5 do
				local v376 = tick();
				while true do
					l__RenderStepped__2:wait();
					if v374 <= tick() - v376 then
						break;
					end;				
				end;
				v368.Visible = not v368.Visible;
			end;
			v368:Destroy();
		end);
		return;
	end;
	if p52 == "showbar" then
		u66();
		u28 = tick();
		return;
	end;
	if p52 == "rank_up" then
		v4:soundHandler({
			directory = { "ui" }, 
			soundfile = "levelup", 
			location = l__CurrentCamera__5
		}, true);
		u66();
		local v377 = l__Parent__3.levelupoverlay:Clone();
		v377.Name = "levelup";
		v377.Visible = true;
		spawn(function()
			v377.Parent = l__Parent__3;
			local v378 = tick();
			while true do
				v377.gradient.Size = v377.gradient.Size + UDim2.new(0, 15, 0, 0);
				v377.gradient.ImageTransparency = v377.gradient.ImageTransparency + 0.03;
				l__RenderStepped__2:wait();
				if tick() - v378 >= 8 then
					break;
				end;			
			end;
			while true do
				v377.mid_one.TextTransparency = v377.mid_one.TextTransparency + 0.05;
				v377.mid_one.TextStrokeTransparency = v377.mid_one.TextTransparency;
				v377.mid_two.TextTransparency = v377.mid_one.TextTransparency;
				v377.mid_two.TextStrokeTransparency = v377.mid_one.TextTransparency;
				l__RenderStepped__2:wait();
				if v377.mid_one.TextTransparency >= 1 then
					break;
				end;			
			end;
			v377:Destroy();
		end);
		return;
	end;
	if p52 == "bought" then
		v4:soundHandler({
			directory = { "qm" }, 
			soundfile = "shopbuy", 
			location = l__CurrentCamera__5
		}, true);
		l__workspace__4.standing_shop.qm:Stop();
		l__workspace__4.standing_shop.qm.SoundId = l__game__1.ReplicatedStorage.sound_library.qm:FindFirstChild("buy" .. math.random(1, 9)).SoundId;
		l__workspace__4.standing_shop.qm:Play();
	end;
end);
l__remotes__3.game_handler:FireServer("player_join");
l__game__1:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
l__game__1:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
u23(true);
