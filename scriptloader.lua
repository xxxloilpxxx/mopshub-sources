--THIS LOADER ISNT USED ANYMORE!!

local writeclipboard,encodeb64,decodeb64,Request = ((syn and syn.write_clipboard) or setclipboard),((syn and syn.crypt.base64.encode) or (Krnl and Krnl.Base64.Encode)),((syn and syn.crypt.base64.decode) or (Krnl and Krnl.Base64.Decode)),(http_request or syn and syn.request or request or nil)

local games, found = {
    [286090429] = false,
    [9759729519] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/9759729519",
    [10950541730] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/9759729519",
    [10950394697] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/9759729519",
    [2988554876] = false,
    [292439477] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/292439477_synactormethod",
    [4787647409] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/4787647409",
    [5041144419] = false,
    [3527629287] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/3527629287",
    [3233893879] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/3233893879",
    [9993529229] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/9993529229",
    [10053187005] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/10053187005",
    [746820961] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/746820961",
    [4716045691] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/4716045691",
    [9520715797] = "https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/9520715797",
}, false
local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
local Notify = AkaliNotif.Notify;

getgenv().gameid = game.PlaceId

for id, scriptstr in pairs(games) do
    if tonumber(id) == getgenv().gameid then
        found = true
        if scriptstr ~= false then
            print(string.format("\n\n[mopsHub Loader]: Found script for gameid [%s]\n\n> Loading script for gameid %s\n\n", getgenv().gameid,id))
            local _s, _e = pcall(function() 
                loadstring(game:HttpGet(scriptstr))()
            end)
            if not _s and _e then
                Notify({Title="<font color='#ff0000'>Error while loading script</font>",Description="Error: ".._e})
                warn(string.format("\n\n[mopsHub Loader Error]: Error while loading script for gameid [%s]\n\n> %s\n\n", getgenv().gameid,_e))
            elseif _s then
                Notify({Title="<font color='#00ff00'>Script loaded!</font>",Description="Enjoy!"})
            end
        else
            Notify({Title="<font color='#ff0000'>Script patched</font>",Description="This script is currently patched! We are working on it."})
        end
    end
end

if not found then
    Notify({Title="<font color='#ff0000'>Not supported</font>",Description="We currently don't have any script for this game!"})
    warn(string.format("[mopsHub Loader]: No script found for gameid [%s]\n> ", getgenv().gameid))
end
