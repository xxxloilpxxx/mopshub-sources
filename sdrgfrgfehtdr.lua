local _=loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))() local a=loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))() local c=a.Notify local _=_:CreateWindow({Name="mopsHub - All Of Us Are Dead",LoadingTitle="mopsHub - All Of Us Are Dead",LoadingSubtitle="by ShyFlooo",ConfigurationSaving={Enabled=true,FolderName="mopsHubConfig",FileName="mopshub_allofusaredead"},KeySystem=false,KeySettings={Title="mopsHub",Subtitle="Key System",Note="Join the discord (discord.gg/sirius)",FileName="SiriusKey",SaveKey=true,GrabKeyFromSite=false,Key="lol"}}) local a=_:CreateTab("Kill All") local b=_:CreateTab("Gun Mods") local _=_:CreateTab("Credits") _:CreateSection("Developers") local _=_:CreateParagraph({Title="Main Developer",Content="ShyFlooo"}) getgenv()._norecoil=false local _=b:CreateButton({Name="No Recoil",Flag="_norecoil",Callback=function(_)getgenv()._norecoil=_ local _=game:GetService('Players').LocalPlayer game.Players.LocalPlayer.Character.Humanoid:UnequipTools() for _,a in pairs(_.Backpack:GetChildren())do if a:FindFirstChild("WeaponType")then print("found gun "..a.Name) local _=a:FindFirstChild("Configuration") if not _ then return warn("Unable to modify "..a.Name.." because it doesnt have a Configuration instance")end _.RecoilMin.Value=0 _.RecoilDecay.Value=0 _.RecoilMax.Value=0 _.TotalRecoilMax.Value=0 print("set recoil for "..a.Name.." to 0")end end c({Title="<font color='#00ff00'>Recoil</font>";Description="Your guns recoil were set to 0.";Duration=5})end}) getgenv()._nospread=false local _=b:CreateButton({Name="No Spread",Flag="_nospread",Callback=function(_)getgenv()._nospread=_ local _=game:GetService('Players').LocalPlayer game.Players.LocalPlayer.Character.Humanoid:UnequipTools() for _,a in pairs(_.Backpack:GetChildren())do if a:FindFirstChild("WeaponType")then print("found gun "..a.Name) local _=a:FindFirstChild("Configuration") if not _ then return warn("Unable to modify "..a.Name.." because it doesnt have a Configuration instance")end if _:FindFirstChild("MaxSpread")then _.MaxSpread.Value=0 print("set spread for "..a.Name.." to 0")end if _:FindFirstChild("MinSpread")then _.MinSpread.Value=0 end end end c({Title="<font color='#00ff00'>Spread</font>";Description="Your guns spread were set to 0.";Duration=5})end}) getgenv()._infammo=false local _=b:CreateButton({Name="Infinite Ammo",Flag="_infammo",Callback=function(_)local b local _=game.Players.LocalPlayer.Backpack b=hookmetamethod(_,"__index",function(a,_)if tostring(a)=="CurrentAmmo"and _=="Value"then return math.huge end return b(a,_)end) c({Title="<font color='#00ff00'>Infinite Ammo</font>";Description="You now have infinite ammo for all guns.";Duration=5})end}) getgenv()._firerate=false local _=b:CreateButton({Name="Firerate",Flag="_firerate",Callback=function(_)getgenv()._firerate=_ local _=game:GetService('Players').LocalPlayer game.Players.LocalPlayer.Character.Humanoid:UnequipTools() for _,a in pairs(_.Backpack:GetChildren())do if a:FindFirstChild("WeaponType")then print("found gun "..a.Name) local _=a:FindFirstChild("Configuration") if not _ then return warn("Unable to modify "..a.Name.." because it doesnt have a Configuration instance")end if _:FindFirstChild("ShotCooldown")then _.ShotCooldown.Value=0 print("set shot cooldown for "..a.Name.." to 0")end end end c({Title="<font color='#00ff00'>Firerate</font>";Description="Your guns firerate were set to 0.";Duration=5})end}) getgenv()._killall=false local _=a:CreateButton({Name="Kill All (equip a gun and click this)",Flag="_killall",Callback=function(_)getgenv()._killall=_ if not getgenv().__12____2 then getgenv().__12____2=false end local a for _,_ in pairs(game.Players.LocalPlayer.Character:GetChildren())do if _:IsA("Tool")and _:FindFirstChild("Configuration")then print(_) a=_ end end if not a then c({Title="<font color='#ff0000'>No weapon equipped</font>";Description="Please equip a weapon!";Duration=5}) return print("no equipped weapon found")end if a then c({Title="<font color='#00ff00'>Kill all enabled</font>";Description="To disable, unequip your weapon once.";Duration=3}) while a.Parent~=game.Players.LocalPlayer.Backpack do task.wait(.1) for _,_ in pairs(workspace.Enemies:GetChildren())do if _:FindFirstChild("Head")or _:FindFirstChild("UpperTorso")then local a=a local _={["p"]=Vector3.new(-9030.994140625,-18.28540802001953,-202.16648864746094),["pid"]=1,["part"]=_:FindFirstChild("Head")or _:FindFirstChild("UpperTorso"),["d"]=204.1572723388672,["maxDist"]=204.08331298828125,["h"]=_.Humanoid,["m"]=Enum.Material.Plastic,["sid"]=55,["t"]=0.205522199488169,["n"]=Vector3.new(-0.5452762246131897,0.03474240377545357,-0.8375362157821655)} local b=game:GetService("ReplicatedStorage").WeaponsSystem.Network.WeaponHit b:FireServer(a,_)end end if a.Parent==game.Players.LocalPlayer.Backpack then c({Title="<font color='#ff0000'>Kill all disabled</font>";Description="Kill all has been disabled.";Duration=3})end end else c({Title="<font color='#ff0000'>No weapon equipped</font>";Description="Please equip a weapon!";Duration=5}) return print("no equipped weapon found")end end})