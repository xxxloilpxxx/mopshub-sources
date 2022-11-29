local s,e = pcall(function()
    --keyformat: mmddyyyy
    local writeclipboard,encodeb64,decodeb64,Request = ((syn and syn.write_clipboard) or setclipboard),((syn and syn.crypt.base64.encode) or (Krnl and Krnl.Base64.Encode)),((syn and syn.crypt.base64.decode) or (Krnl and Krnl.Base64.Decode)),(http_request or syn and syn.request or request or nil)
    local SavedKey = isfile('MOPSHUB.key') and readfile('MOPSHUB.key') or nil
    local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))().Notify
    local Invite = "g4EGAwjUAK"

    local function startMainLoader()
        local games, found = {
            [286090429] = "https://raw.githubusercontent.com/mopsfl/rbxmopshub/main/arsenal.lua",
            [9759729519] = "https://raw.githubusercontent.com/mopsfl/rbxmopshub/main/allofusaredead.lua",
            [10950541730] = "https://raw.githubusercontent.com/mopsfl/rbxmopshub/main/allofusaredead.lua",
            [10950394697] = "https://raw.githubusercontent.com/mopsfl/rbxmopshub/main/allofusaredead.lua",
            [2988554876] = "https://raw.githubusercontent.com/mopsfl/rbxmopshub/main/militarysimulator.lua",
            [292439477] = "https://raw.githubusercontent.com/mopsfl/rbxmopshub/main/phantomforces.lua",
        }, false
        local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
        local Notify = AkaliNotif.Notify;
        
        getgenv().gameid = game.PlaceId
        
        for id, scriptstr in pairs(games) do
            if tonumber(id) == getgenv().gameid then
                found = true
                print(string.format("\n\n[mopsHub Loader]: Found script for gameid [%s]\n\n> Loading script from %s\n\n", getgenv().gameid,scriptstr))
                local _s, _e = pcall(function() 
                    loadstring(game:HttpGet(scriptstr))()
                end)
                if not _s and _e then
                    Notify({Title="<font color='#ff0000'>Error while loading script</font>",Description="Error: ".._e})
                    warn(string.format("\n\n[mopsHub Loader Error]: Error while loading script for gameid [%s]\n\n> %s\n\n", getgenv().gameid,_e))
                elseif _s then
                    Notify({Title="<font color='#00ff00'>Script loaded!</font>",Description="Enjoy!"})
                end
            end
        end
        
        if not found then
            Notify({Title="<font color='#ff0000'>Not supported</font>",Description="We currently don't have any script for this game!"})
            warn(string.format("[mopsHub Loader]: No script found for gameid [%s]\n> ", getgenv().gameid))
        end
    end

    local function encrypt(data)
        local CryptoKey = "loFRfpiVXLZcWdrdYBOeJGjaIgsFto3kAHKQlMoNbCEnuSqyxvmPO1234567890+/"
        return ((data:gsub('.', function(x) 
            local r,CryptoKey='',x:byte()
            for i=8,1,-1 do r=r..(CryptoKey%2^i-CryptoKey%2^(i-1)>0 and '1' or '0') end
            return r;
        end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
            if (#x < 6) then return '' end
            local c=0
            for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
            return CryptoKey:sub(c+1,c+1)
        end)..({ '', 'jv', 'j' })[#data%3+1])
    end; local function decrypt(data)
        local CryptoKey = "loFRfpiVXLZcWdrdYBOeJGjaIgsFto3kAHKQlMoNbCEnuSqyxvmPO1234567890+/"
        data = string.gsub(data, '[^'..CryptoKey..'j]', '')
        return (data:gsub('.', function(x)
            if (x == 'j') then return '' end
            local r,f='',(CryptoKey:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
        end))
    end; local function parseKeyData(Key)
        local k = Key
        local c = os.date("!*t")
        local r = {}
        k = string.gsub(k, "mhk","")
        k = string.split(k,"")
        k = { key = { month = k[1]..k[2], day = k[3]..k[4], year=k[5]..k[6]..k[7]..k[8] }, now = { month = c.month, day = c.day, year = c.year } }

        if not k["key"] or not tonumber(k.key["month"]) or not tonumber(k.key["day"]) or not tonumber(k.key["year"]) or not #tostring(k.key["month"]) == 2 or not #tostring(k.key["day"]) == 2 or not #tostring(k.key["year"]) == 4 then
            r.valid = false
            return r
        end
        --print(k.now.day - k.key.day, k.now.month - k.key.month, k.now.year - k.key.year)
        if (k.now.day - k.key.day) > 0 or (k.now.month - k.key.month) > 0 or (k.now.year - k.key.year) > 0 then
            r.expired = true
            r.valid = false
        else
            r.valid = true
            r.expired = false
        end

        r.data = k
        r.expireddays = tonumber(k.key.day) - tonumber(k.now.day)
        return r

    end; local function checkKey(savedKey, Key)
        if #savedKey < 30 or #string.gsub(decrypt(decodeb64(savedKey)), "mhk.*", "mhk") < 10 or #decrypt(savedKey) == 0 or savedKey == nil or savedKey == "" then
            return { valid = false, expired = false }
        end
        local dec = string.gsub(decrypt(decodeb64(savedKey)), "mhk.*", "mhk")
        local keyData = parseKeyData(dec)

        if keyData.valid then
            if not keyData.expired then
                if dec == Key then
                    return keyData
                else
                    return keyData, { msg="Incorrect Key", msgid="incorrectkey" }
                end
            else
                return keyData, { msg="Key expired", msgid="keyexpired" }
            end
        else
            return keyData, { msg="Invalid Key", msgid="invalidkey" }
        end
        return keyData
    end; local function saveKey(Key)
        if Key then
            writefile("MOPSHUB.key", Key)
        end
    end; local function openDiscordInvite()
        if Request then
            local r = Request(
                {
                    ['Method'] = 'POST',
                    ['Headers'] = {
                        ["origin"] = 'https://discord.com',
                        ["Content-Type"] = "application/json"
                    },
                    ['Url'] = 'http://127.0.0.1:6463/rpc?v=1',
                    ['Body'] = game:GetService('HttpService'):JSONEncode({cmd="INVITE_BROWSER",args={code=Invite},nonce=game:GetService('HttpService'):GenerateGUID(false):lower()})
                }
            )
            if r.StatusCode ~= 200 or not r.Success then
                return warn("[mopsHub Loader]: Unable to open open discord invite. ("..r.StatusCode..")")
            else
                for _,v in pairs(r) do
                    print(_,v)
                end
            end
        end
    end; local function createPrompt(Key)
        for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v:IsA("ScreenGui") and v.Name == "mopshubkeyprompt" then
                v:Destroy()
            end
        end
        task.wait(2)
        local ui = {}
        local function _create()
            for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
                if v:IsA("ScreenGui") and v.Name == "mopshubkeyprompt" then
                    v:Destroy()
                end
            end
            local mopshubkeyprompt = Instance.new("ScreenGui")
            mopshubkeyprompt.Name = "mopshubkeyprompt"
            mopshubkeyprompt.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            local frame = Instance.new("Frame")
            frame.Name = "Frame"
            frame.Visible = false
            frame.ClipsDescendants = true
            frame.AnchorPoint = Vector2.new(0.5, 0.5)
            frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            frame.BorderSizePixel = 0
            frame.Position = UDim2.fromScale(0.5, 0.544)
            frame.Size = UDim2.fromOffset(0, 152)--472,152

            local uIPadding = Instance.new("UIPadding")
            uIPadding.Name = "UIPadding"
            uIPadding.PaddingBottom = UDim.new(0, 5)
            uIPadding.PaddingLeft = UDim.new(0, 5)
            uIPadding.PaddingRight = UDim.new(0, 5)
            uIPadding.PaddingTop = UDim.new(0, 5)
            uIPadding.Parent = frame

            local uICorner = Instance.new("UICorner")
            uICorner.Name = "UICorner"
            uICorner.CornerRadius = UDim.new(0, 4)
            uICorner.Parent = frame

            local btns = Instance.new("Frame")
            btns.Name = "btns"
            btns.AnchorPoint = Vector2.new(0.5, 1)
            btns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            btns.BackgroundTransparency = 1
            btns.BorderSizePixel = 0
            btns.Position = UDim2.fromScale(0.5, 1)
            btns.Size = UDim2.fromOffset(462, 36)

            local get = Instance.new("TextButton")
            get.Name = "get"
            get.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            get.Text = "Get Key"
            get.TextColor3 = Color3.fromRGB(255, 255, 255)
            get.TextSize = 12
            get.AutoButtonColor = false
            get.AnchorPoint = Vector2.new(0.5, 1)
            get.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            get.BorderSizePixel = 0
            get.Position = UDim2.fromOffset(231, 36)
            get.Size = UDim2.fromOffset(228, 29)

            local uICorner1 = Instance.new("UICorner")
            uICorner1.Name = "UICorner"
            uICorner1.CornerRadius = UDim.new(0, 2)
            uICorner1.Parent = get

            get.Parent = btns

            local uIListLayout = Instance.new("UIListLayout")
            uIListLayout.Name = "UIListLayout"
            uIListLayout.Padding = UDim.new(0, 5)
            uIListLayout.FillDirection = Enum.FillDirection.Horizontal
            uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
            uIListLayout.Parent = btns

            local check = Instance.new("TextButton")
            check.Name = "check"
            check.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            check.Text = "Check Key"
            check.TextColor3 = Color3.fromRGB(255, 255, 255)
            check.TextSize = 12
            check.AutoButtonColor = false
            check.AnchorPoint = Vector2.new(0.5, 1)
            check.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            check.BorderSizePixel = 0
            check.Position = UDim2.fromOffset(231, 36)
            check.Size = UDim2.fromOffset(228, 29)

            local uICorner2 = Instance.new("UICorner")
            uICorner2.Name = "UICorner"
            uICorner2.CornerRadius = UDim.new(0, 2)
            uICorner2.Parent = check

            check.Parent = btns

            btns.Parent = frame

            local key = Instance.new("TextBox")
            key.Name = "key"
            key.CursorPosition = -1
            key.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            key.PlaceholderColor3 = Color3.fromRGB(95, 95, 95)
            key.PlaceholderText = "Key"
            key.Text = ""
            key.TextColor3 = Color3.fromRGB(255, 255, 255)
            key.TextSize = 12
            key.AnchorPoint = Vector2.new(0.5, 0.5)
            key.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            key.BorderSizePixel = 0
            key.Position = UDim2.fromScale(0.5, 0.641)
            key.Size = UDim2.fromOffset(462, 30)

            local uICorner3 = Instance.new("UICorner")
            uICorner3.Name = "UICorner"
            uICorner3.CornerRadius = UDim.new(0, 2)
            uICorner3.Parent = key

            key.Parent = frame

            local title = Instance.new("TextLabel")
            title.Name = "title"
            title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            title.Text = "mopsHub Loader - Key System"
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.AnchorPoint = Vector2.new(0.5, 0)
            title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            title.BackgroundTransparency = 1
            title.BorderSizePixel = 0
            title.Position = UDim2.fromScale(0.5, 0)
            title.Size = UDim2.fromScale(1, 0.204)

            local uIPadding1 = Instance.new("UIPadding")
            uIPadding1.Name = "UIPadding"
            uIPadding1.PaddingLeft = UDim.new(0, 10)
            uIPadding1.PaddingRight = UDim.new(0, 10)
            uIPadding1.Parent = title

            local div = Instance.new("Frame")
            div.Name = "div"
            div.AnchorPoint = Vector2.new(0.5, 1)
            div.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
            div.BorderSizePixel = 0
            div.Position = UDim2.fromScale(0.5, 1)
            div.Size = UDim2.new(1.02, 0, 0, 1)
            div.Parent = title

            title.Parent = frame

            local uIStroke = Instance.new("UIStroke")
            uIStroke.Name = "UIStroke"
            uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            uIStroke.Color = Color3.fromRGB(65, 65, 65)
            uIStroke.Parent = frame

            local info = Instance.new("TextLabel")
            info.Name = "info"
            info.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            info.RichText = true
            info.Text = "How to get the key?<br/>Join <discordlink>                                                 </discordlink> and go to <font color=\"#7289da\">#mopshub</font>"
            info.TextColor3 = Color3.fromRGB(255, 255, 255)
            info.TextSize = 12
            info.TextYAlignment = Enum.TextYAlignment.Bottom
            info.AnchorPoint = Vector2.new(0.5, 0)
            info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            info.BackgroundTransparency = 1
            info.BorderSizePixel = 0
            info.Position = UDim2.fromScale(0.5, 0.197)
            info.Size = UDim2.fromScale(1, 0.254)

            local uIPadding2 = Instance.new("UIPadding")
            uIPadding2.Name = "UIPadding"
            uIPadding2.PaddingLeft = UDim.new(0, 10)
            uIPadding2.PaddingRight = UDim.new(0, 10)
            uIPadding2.Parent = info

            info.Parent = frame

            local discord = Instance.new("TextButton")
            discord.Name = "discord"
            discord.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            discord.RichText = true
            discord.Text = "<u><font color=\"#7289da\">discord.gg/g4EGAwjUAK</font></u>"
            discord.TextColor3 = Color3.fromRGB(255, 255, 255)
            discord.TextSize = 12
            discord.TextYAlignment = Enum.TextYAlignment.Bottom
            discord.Active = false
            discord.AnchorPoint = Vector2.new(0.5, 0)
            discord.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            discord.BackgroundTransparency = 1
            discord.BorderSizePixel = 0
            discord.Position = UDim2.fromScale(0.398, 0.366)
            discord.Selectable = false
            discord.Size = UDim2.fromScale(0.333, 0.0845)
            discord.ZIndex = 8

            local uIPadding3 = Instance.new("UIPadding")
            uIPadding3.Name = "UIPadding"
            uIPadding3.PaddingLeft = UDim.new(0, 10)
            uIPadding3.PaddingRight = UDim.new(0, 10)
            uIPadding3.Parent = discord

            discord.Parent = frame

            local close = Instance.new("TextButton")
            close.Name = "close"
            close.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            close.RichText = true
            close.Text = "X"
            close.TextColor3 = Color3.fromRGB(255, 255, 255)
            close.TextSize = 12
            close.TextXAlignment = Enum.TextXAlignment.Right
            close.TextYAlignment = Enum.TextYAlignment.Top
            close.Active = false
            close.AnchorPoint = Vector2.new(1, 0)
            close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            close.BackgroundTransparency = 1
            close.BorderSizePixel = 0
            close.Position = UDim2.fromScale(1, 0)
            close.Selectable = false
            close.Size = UDim2.fromOffset(20, 20)
            close.ZIndex = 8
            close.Parent = frame

            frame.Parent = mopshubkeyprompt
            mopshubkeyprompt.Parent = game:GetService("CoreGui")

            ui =  {
                ui = mopshubkeyprompt,
                frame = frame,
                input = key,
                btns = {
                    getKey = get,
                    checkKey = check,
                    closeUI = close,
                    openDiscord = discord
                },
            }
        end

        if Invite and tostring(Invite) ~= "" then
            writeclipboard("discord.gg/"..Invite)
            print("Copied discord invite to clipboard")
        end

        task.spawn(_create)
        task.wait(0.5)

        if Invite and tostring(Invite) ~= "" and ui.ui and ui.frame and ui.btns then
            ui.btns.openDiscord.Text = "<u><font color=\"#7289da\">discord.gg/"..Invite.."</font></u>"
            ui.frame.Visible = true
            game:GetService("TweenService"):Create(ui.frame, TweenInfo.new(.5), {Size = UDim2.fromOffset(472,152)}):Play()
            ui.btns.openDiscord.MouseButton1Click:Connect(function()
                if Invite and tostring(Invite) ~= "" then
                    openDiscordInvite()
                else
                    warn("No discord invite found.")
                end
            end)
            ui.btns.openDiscord.MouseEnter:Connect(function()
                ui.btns.openDiscord.Text = "<u><font color=\"#7289da\">(click to join discord)</font></u>"
            end)
            ui.btns.openDiscord.MouseLeave:Connect(function()
                ui.btns.openDiscord.Text = "<u><font color=\"#7289da\">discord.gg/"..Invite.."</font></u>"
            end)
            ui.btns.closeUI.MouseButton1Click:Connect(function()
                ui.ui:Destroy()
            end)
            local checking = false
            ui.btns.checkKey.MouseButton1Click:Connect(function()
                if checking then return end
                local input = ui.input.Text
                checking = true
                ui.input.Text = ""
                ui.input.PlaceholderText = "Checking Key..."
                task.wait(math.random(1.5,3))
                
                local inputKey = string.gsub(decrypt(decodeb64(input)), "mhk.*", "mhk")
                local key = string.gsub(decrypt(decodeb64(Key)), "mhk.*", "mhk")
                --print("=============")
                --print(Key,key)
                --print(input,inputKey)
                --print("=============")

                if inputKey == key then
                    ui.input.PlaceholderText = "Correct Key!"
                    ui.input.PlaceholderColor3 = Color3.fromRGB(0, 146, 7)
                    writefile("MOPSHUB.key",Key)
                    task.wait(1)
                    startMainLoader()
                    ui.ui:Destroy()
                else
                    ui.input.PlaceholderText = "Invalid Key!"
                    ui.input.PlaceholderColor3 = Color3.fromRGB(146, 0, 0)
                    task.wait(1)
                    ui.input.PlaceholderColor3 = Color3.fromRGB(95, 95, 95)
                    ui.input.PlaceholderText = "Key"
                    checking = false
                end
            end)
            ui.btns.getKey.MouseButton1Click:Connect(function()
                if checking then return end
                checking = true
                openDiscordInvite()
                if Invite and tostring(Invite) ~= "" then
                    writeclipboard("discord.gg/"..Invite)
                    print("Copied discord invite to clipboard")
                    ui.input.PlaceholderText = "Copied discord invite to clipboard!"
                    ui.input.PlaceholderColor3 = Color3.fromRGB(0, 146, 7)
                    ui.input.PlaceholderColor3 = Color3.fromRGB(95, 95, 95)
                    ui.input.PlaceholderText = "Key"
                    task.wait(3)
                    checking = false
                end
            end)
        end
    end; local function createKey(String)
            return encodeb64(encrypt(String.."mhk_mopshubkey"))
    end;
    --writeclipboard(createKey(""))
    if Request then
        local Key = nil
        local r = Request({
            ['Url'] = 'https://raw.githubusercontent.com/xxxloilpxxx/56u8vnbdfg3wrn-jfasd-6-/main/key.json',
            
        })
        if r.StatusCode ~= 200 or not r.Success then
            return warn("[mopsHub Loader]: Unable to fetch key.")
        else
            Key = game:GetService("HttpService"):JSONDecode(r.Body).key
        end
        if not SavedKey then
            createPrompt(Key)
            print("creating key prompt > callbackid:nosavedkeyfound")
        else
            --local keyCheck = checkKey(SavedKey, Key)
            if string.gsub(decrypt(decodeb64(SavedKey)), "mhk.*", "mhk") == string.gsub(decrypt(decodeb64(Key)), "mhk.*", "mhk") then
                saveKey(Key)
                --print(keyCheck.data.key.day,keyCheck.data.now.day)
                startMainLoader()
                for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
                    if v:IsA("ScreenGui") and v.Name == "mopshubkeyprompt" then
                        v:Destroy()
                    end
                end
            else
                --[[if keyCheck.expired then
                    createPrompt(Key, "expired", keyCheck.expireddays)
                    print("key expired. (expired for "..string.gsub(keyCheck.expireddays, "-","").. " days)")
                    print("creating key prompt > callbackid:keyexpired")
                    print(keyCheck.data.key.day.."/"..keyCheck.data.key.month.."/"..keyCheck.data.key.year,keyCheck.data.now.day.."/"..keyCheck.data.now.month.."/"..keyCheck.data.now.year)
                else
                    createPrompt(Key, "incorrect")
                    print("creating key prompt > callbackid:keyincorrect")
                end]]
                createPrompt(Key, "incorrect")
                print("creating key prompt > callbackid:keyincorrectorexpired")
            end
        end
    else
        warn("[mopsHub Loader Error]: Missing function Request. Your executor might be too bad and doesn't support it!")
    end
end)
if not s and e then
    warn("[mopsHub Loader Error]: Unable to load\nError:\n\n> "..e)
end
