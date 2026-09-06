-- =================================================================
-- HỆ THỐNG GET KEY - TLONG SYSTEM (AUTO-SAVE KEY) - OPTIMIZED FOR OBF
-- =================================================================
local DOMAIN_VERCEL = "https://keylicensenew2.vercel.app/"
local DISCORD_INVITE = "https://discord.gg/TvwRC4tba"
local DISCORD_ICON_URL = "rbxassetid://99761773347476"
local SAVE_FILE_NAME = "TlongkeySystem_OnHub.txt"

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local currentLang = "EN"
local Translations = {
    VI = {
        Title = "TLONG KEY SYSTEM - ON Hub",
        Placeholder = "Nhập Key xác thực vào đây...",
        GetKey = "🔗 LẤY LINK KEY",
        CheckKey = "✔ KIỂM TRA KEY",
        Checking = "⏳ Đang duyệt...",
        SuccessBtn = "✔ THÀNH CÔNG",
        DefaultStatus = "⚡ Key tự động làm mới lúc 00:00 hàng ngày",
        DiscordSub = "🟢 Join Server Discord Support",
        CopyBtn = "Coppy",
        CopiedBtn = "✔ ĐÃ COPY",
        GetKeyCopied = "✔ ĐÃ SAO CHÉP",
        CopyDiscordStatus = "💬 Đã copy link Discord! Đã mở ứng dụng Discord (nếu có).",
        CopyKeyStatus = "📋 Đã sao chép Link Web! Hãy dán lên trình duyệt để Get Key.",
        CheckingStatus = "Đang kiểm tra tính hợp lệ...",
        ValidStatus = "✔ Key hợp lệ! Đang khởi chạy OnHub...",
        InvalidStatus = "✖ Key không hợp lệ hoặc đã hết hạn ngày hôm nay!",
        LangToggleText = "🌐 VI",
        NoteText = "📌 Lưu ý quan trọng:\n• Truy cập link web để lấy Key trong ngày.\n• Mỗi Key chỉ áp dụng cho 1 thiết bị duy nhất.\n• Key tự động làm mới vào 00:00 (Giờ Việt Nam).\n• Tham gia Discord để nhận trợ giúp khi gặp lỗi Script.\n• TikTok: Royah Roblox or @python_c3 \n• Hãy follow để nhận nhiều script xịn"
    },
    EN = {
        Title = "TLONG KEY SYSTEM - On Hub",
        Placeholder = "Enter verification key here...",
        GetKey = "🔗 GET KEY LINK",
        CheckKey = "✔ CHECK KEY",
        Checking = "⏳ Checking...",
        SuccessBtn = "✔ SUCCESS",
        DefaultStatus = "⚡ Key automatically resets at 00:00 daily",
        DiscordSub = "🟢 Join Discord Support Server",
        CopyBtn = "Copy",
        CopiedBtn = "✔ COPIED",
        GetKeyCopied = "✔ COPIED",
        CopyDiscordStatus = "💬 Discord link copied! Opened Discord app if available.",
        CopyKeyStatus = "📋 Web link copied! Paste it into your browser to Get Key.",
        CheckingStatus = "Checking key validity...",
        ValidStatus = "✔ Valid Key! Launching OnHub...",
        InvalidStatus = "✖ Invalid key or key has expired today!",
        LangToggleText = "🌐 EN",
        NoteText = "📌 Important Notes:\n• Access the website link to get today's key.\n• Each Key applies to 1 device only.\n• Keys auto-reset at 00:00 (Vietnam Time).\n• Join Discord for support if you encounter script errors.\n• TikTok: Royah Roblox or @python_c3 \n• Follow for more awesome scripts"
    }
}

local function GetCurrentDateString()
    local date = os.date("!*t", os.time() + (7 * 3600))
    return string.format("%02d%02d%04d", date.day, date.month, date.year)
end

-- ==============================================================================
--  TLONG HUB - PAYLOAD & FULL TRANSLATOR FOR ONHUB (ANTI-LAG LOAD)
-- ==============================================================================
local function LaunchMainScript()
    task.spawn(function()
        -- Dọn sạch phiên bản cũ
        local cleanList = {
            "TLong_ONhub_DockedMaster", "TLong_HeaderDockedMaster", "TLong_PerfectDockMaster",
            "TLong_ONhub_CompactMaster", "TLong_ONhub_UltimateConfig", "TLong_ONhub_AutoBypassMaster",
            "TLong_ONhub_EncryptedMaster", "Ronnei_ONhub_DockedMaster", "Ronnei_HeaderDockedMaster",
            "Ronnei_PerfectDockMaster", "Ronnei_ONhub_CompactMaster", "Ronnei_ONhub_UltimateConfig",
            "Ronnei_ONhub_AutoBypassMaster", "Ronnei_ONhub_EncryptedMaster"
        }
        for _, name in ipairs(cleanList) do
            pcall(function()
                if CoreGui:FindFirstChild(name) then CoreGui[name]:Destroy() end
                if gethui and gethui():FindFirstChild(name) then gethui()[name]:Destroy() end
            end)
        end

        -- CƠ CHẾ TỰ BỎ QUA BẢNG DISCORD (AUTO-BYPASS)
        local function triggerButtonClick(btn)
            if not btn then return end
            if firesignal then
                pcall(function() firesignal(btn.MouseButton1Click) end)
                pcall(function() firesignal(btn.Activated) end)
            end
            if getconnections then
                pcall(function()
                    for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do conn:Fire() end
                    for _, conn in ipairs(getconnections(btn.Activated)) do conn:Fire() end
                end)
            end
        end

        local function interceptDiscordModal(inst)
            if not inst then return end
            pcall(function()
                if (inst:IsA("TextLabel") or inst:IsA("TextButton")) then
                    local txt = inst.Text
                    if txt and (txt:find("CONTINUE TO HUB", 1, true) or txt:find("JOIN OUR DISCORD", 1, true)) then
                        local topModal = inst
                        while topModal.Parent and not topModal.Parent:IsA("ScreenGui") and topModal.Parent ~= game do
                            topModal = topModal.Parent
                        end
                        
                        if topModal and topModal:IsA("GuiObject") then
                            topModal.Visible = false
                            topModal.Position = UDim2.new(0, -99999, 0, -99999)

                            for _, child in ipairs(topModal:GetDescendants()) do
                                if (child:IsA("TextButton") or child:IsA("TextLabel")) and child.Text:find("CONTINUE TO HUB", 1, true) then
                                    local realBtn = child:IsA("TextButton") and child or child:FindFirstAncestorOfClass("TextButton")
                                    if realBtn then
                                        task.spawn(function()
                                            for _ = 1, 5 do
                                                triggerButtonClick(realBtn)
                                                task.wait(0.04)
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end

        local guiRoots = {}
        if gethui then pcall(function() table.insert(guiRoots, gethui()) end) end
        pcall(function() table.insert(guiRoots, CoreGui) end)
        if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
            table.insert(guiRoots, LocalPlayer.PlayerGui)
        end

        for _, root in ipairs(guiRoots) do
            pcall(function()
                for _, desc in ipairs(root:GetDescendants()) do interceptDiscordModal(desc) end
                root.DescendantAdded:Connect(function(child) interceptDiscordModal(child) end)
            end)
        end

        task.spawn(function()
            local startT = tick()
            while tick() - startT < 6 do
                for _, root in ipairs(guiRoots) do
                    pcall(function()
                        for _, desc in ipairs(root:GetDescendants()) do interceptDiscordModal(desc) end
                    end)
                end
                task.wait(0.1)
            end
        end)

        -- KHỐI NẠP SCRIPT GỐC ONHUB
        task.spawn(function()
            pcall(function()
                local _resolvedTarget = "https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua"
                local _loaderFunc = loadstring or (getgenv and getgenv().loadstring)
                if _loaderFunc then
                    _loaderFunc(game:HttpGet(_resolvedTarget, true))()
                end
            end)
        end)

        -- BẢNG DỊCH THUẬT & CẤU HÌNH GIAO DIỆN
        local THEME = {
            BarBG      = Color3.fromRGB(15, 25, 18),
            CardBG     = Color3.fromRGB(20, 36, 26),
            Border     = Color3.fromRGB(40, 80, 50),
            AccentMint = Color3.fromRGB(0, 230, 120),
            ToggleOff  = Color3.fromRGB(38, 43, 56),
            TextMain   = Color3.fromRGB(245, 248, 255),
            TextSub    = Color3.fromRGB(150, 180, 160),
            FontB      = Enum.Font.GothamBold,
            FontM      = Enum.Font.GothamMedium
        }

        local RAW_TRANSLATIONS = {
            {"Fast mode (grab the closest)", "Chế độ nhanh (nhặt trứng gần nhất)"},
            {"Selected pets only", "Chỉ nhặt thú cưng đã chọn"},
            {"Mutated eggs only", "Chỉ nhặt trứng đột biến"},
            {"Skip eggs with a player within [PvP]:", "Bỏ qua trứng có người gần [PvP]:"},
            {"Skip eggs with a player within [PvP]", "Bỏ qua trứng có người gần [PvP]"},
            {"Minimum rarity:", "Độ hiếm tối thiểu:"},
            {"Minimum rarity", "Độ hiếm tối thiểu"},
            {"Maximum target distance:", "Khoảng cách mục tiêu tối đa:"},
            {"Maximum target distance", "Khoảng cách mục tiêu tối đa"},
            {"TARGET FILTER", "BỘ LỌC MỤC TIÊU"},
            {"On, the ranking is $/s by the game's own formula and the weights above are inert (distance only counts when the instant TP is unusable).", "Khi bật, mục tiêu xếp theo $/s theo công thức của game và các trọng số trên sẽ tắt (khoảng cách chỉ tính khi không thể dùng TP tức thì)."},
            {"Rank by pure $/s", "Ưu tiên thuần theo $/giây"},
            {"Rarity weight:", "Trọng số độ hiếm:"},
            {"Rarity weight", "Trọng số độ hiếm"},
            {"Mutation weight:", "Trọng số đột biến:"},
            {"Mutation weight", "Trọng số đột biến"},
            {"Size weight:", "Trọng số kích thước:"},
            {"Size weight", "Trọng số kích thước"},
            {"Distance penalty:", "Phạt khoảng cách:"},
            {"Distance penalty", "Phạt khoảng cách"},
            {"RANKING WEIGHTS", "TRỌNG SỐ ƯU TIÊN MỤC TIÊU"},
            {"Approach radius (server accepts 9):", "Bán kính tiếp cận (server nhận 9):"},
            {"Approach radius (server accepts 9)", "Bán kính tiếp cận (server nhận 9)"},
            {"Approach radius", "Bán kính tiếp cận"},
            {"server accepts 9", "server nhận 9"},
            {"Max time per trip:", "Thời gian tối đa mỗi chuyến:"},
            {"Max time per trip", "Thời gian tối đa mỗi chuyến"},
            {"Stop the farm on rollback", "Dừng cày khi bị giật lùi (rollback)"},
            {"MOVEMENT AND SAFETY", "DI CHUYỂN & AN TOÀN"},
            {"Fast hop (chained CFrame steps)", "Nhảy nhanh (bước CFrame liên tục)"},
            {"Instant TP (uses the ragdoll window)", "TP tức thì (dùng khe hở ragdoll)"},
            {"Minimum distance for TP:", "Khoảng cách tối thiểu để TP:"},
            {"Minimum distance for TP", "Khoảng cách tối thiểu để TP"},
            {"Hop step (lower = safer):", "Độ dài bước nhảy (thấp = an toàn):"},
            {"Hop step (lower = safer)", "Độ dài bước nhảy (thấp = an toàn)"},
            {"Hop interval (higher = safer):", "Thời gian chờ mỗi bước (cao = an toàn):"},
            {"Hop interval (higher = safer)", "Thời gian chờ mỗi bước (cao = an toàn)"},
            {"Timestamp rewind per step:", "Tua ngược thời gian mỗi bước:"},
            {"Timestamp rewind per step", "Tua ngược thời gian mỗi bước"},
            {"FAST TRAVEL", "DI CHUYỂN NHANH (TELEPORT)"},
            {"Count pets you already own", "Tính cả thú cưng bạn đã có"},
            {"Plant recipe eggs on the plot", "Đặt trứng công thức lên khu đất"},
            {"Plant index eggs on the plot", "Đặt trứng sưu tập lên khu đất"},
            {"Floating button (show/hide)", "Nút tròn nổi (hiện/ẩn)"},
            {"Interface scale:", "Tỷ lệ giao diện:"},
            {"Interface scale", "Tỷ lệ giao diện"},
            {"INTERFACE", "GIAO DIỆN"},
            {"RIFT", "MÁY RIFT"},
            {"START FARM", "BẮT ĐẦU CÀY"},
            {"STOP FARM", "DỪNG CÀY"},
            {"BEST TARGETS RIGHT NOW", "MỤC TIÊU TỐT NHẤT HIỆN TẠI"},
            {"CLEAR TARGET", "HỦY MỤC TIÊU"},
            {"click to lock", "bấm để khóa"},
            {"locked", "đã khóa"},
            {"per second", "/giây"},
            {"RIFT: OFF", "RIFT: TẮT"},
            {"RIFT: ON", "RIFT: BẬT"},
            {"INDEX: OFF", "SƯU TẬP: TẮT"},
            {"INDEX: ON", "SƯU TẬP: BẬT"},
            {"FARM", "CÀY TIỀN"},
            {"PETS", "THÚ CƯNG"},
            {"CONFIG", "CẤU HÌNH"}
        }

        table.sort(RAW_TRANSLATIONS, function(a, b) return #a[1] > #b[1] end)

        local function replacePlain(str, findStr, repStr)
            if typeof(str) ~= "string" or typeof(findStr) ~= "string" or str == "" or findStr == "" then return str end
            local s, e = string.find(str, findStr, 1, true)
            if not s then return str end
            local res = {}
            while s do
                table.insert(res, string.sub(str, 1, s - 1))
                table.insert(res, repStr)
                str = string.sub(str, e + 1)
                s, e = string.find(str, findStr, 1, true)
            end
            table.insert(res, str)
            return table.concat(res)
        end

        local function translateText(raw)
            if typeof(raw) ~= "string" or raw == "" then return raw end
            local res = raw
            for _, item in ipairs(RAW_TRANSLATIONS) do
                res = replacePlain(res, item[1], item[2])
            end
            return res
        end

        -- THANH NÚT BẤM VÀ BẢNG ĐIỀU KHIỂN
        local isVietnamese = true
        local OriginalTexts = {}
        local targetOnhubWindow = nil
        local isApplyingTranslation = false

        local PinGui = Instance.new("ScreenGui")
        PinGui.Name = "TLong_ONhub_EncryptedMaster"
        PinGui.ResetOnSpawn = false
        PinGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        PinGui.DisplayOrder = 999999
        PinGui.Parent = (gethui and gethui()) or CoreGui

        local PinBar = Instance.new("Frame", PinGui)
        PinBar.Name = "TLongCompactBar"
        PinBar.Size = UDim2.new(0, 310, 0, 28)
        PinBar.Position = UDim2.new(0, 0, 0, -100)
        PinBar.BackgroundColor3 = THEME.BarBG
        PinBar.BorderSizePixel = 0
        PinBar.Visible = false

        Instance.new("UICorner", PinBar).CornerRadius = UDim.new(0, 6)
        local BarStroke = Instance.new("UIStroke", PinBar)
        BarStroke.Color = THEME.AccentMint
        BarStroke.Thickness = 1.2

        local dragging, dragStart, startWinPos = false, nil, nil
        PinBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if targetOnhubWindow and targetOnhubWindow.Parent then
                    dragging = true
                    dragStart = input.Position
                    startWinPos = targetOnhubWindow.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then dragging = false end
                    end)
                end
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                if targetOnhubWindow and targetOnhubWindow.Parent then
                    local delta = input.Position - dragStart
                    targetOnhubWindow.Position = UDim2.new(startWinPos.X.Scale, startWinPos.X.Offset + delta.X, startWinPos.Y.Scale, startWinPos.Y.Offset + delta.Y)
                end
            end
        end)

        -- TikTok Badge
        local TikTokBadge = Instance.new("Frame", PinBar)
        TikTokBadge.Size = UDim2.new(0, 135, 0, 20)
        TikTokBadge.Position = UDim2.new(0, 4, 0.5, 0)
        TikTokBadge.AnchorPoint = Vector2.new(0, 0.5)
        TikTokBadge.BackgroundColor3 = THEME.CardBG
        Instance.new("UICorner", TikTokBadge).CornerRadius = UDim.new(1, 0)

        local BadgeStroke = Instance.new("UIStroke", TikTokBadge)
        BadgeStroke.Color = THEME.AccentMint
        BadgeStroke.Thickness = 1.2

        local BadgeGrad = Instance.new("UIGradient", BadgeStroke)
        BadgeGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 120)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 230, 120))
        })

        local TikTokText = Instance.new("TextLabel", TikTokBadge)
        TikTokText.Size = UDim2.new(1, 0, 1, 0)
        TikTokText.BackgroundTransparency = 1
        TikTokText.Text = "TikTok: @royah36"
        TikTokText.Font = THEME.FontB
        TikTokText.TextSize = 10
        TikTokText.TextColor3 = THEME.TextMain

        task.spawn(function()
            local rot = 0
            while TikTokBadge.Parent do
                rot = (rot + 3) % 360
                BadgeGrad.Rotation = rot
                task.wait(0.08) -- Tối ưu CPU cho vòng quay Gradient
            end
        end)

        -- Control Box
        local ControlBox = Instance.new("Frame", PinBar)
        ControlBox.Size = UDim2.new(0, 160, 0, 22)
        ControlBox.Position = UDim2.new(1, -4, 0.5, 0)
        ControlBox.AnchorPoint = Vector2.new(1, 0.5)
        ControlBox.BackgroundColor3 = THEME.CardBG
        Instance.new("UICorner", ControlBox).CornerRadius = UDim.new(0, 6)

        local StatusLabel = Instance.new("TextLabel", ControlBox)
        StatusLabel.Size = UDim2.new(1, -40, 1, 0)
        StatusLabel.Position = UDim2.new(0, 6, 0, 0)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "Tiếng Việt (ON)"
        StatusLabel.Font = THEME.FontB
        StatusLabel.TextSize = 10
        StatusLabel.TextColor3 = THEME.AccentMint
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

        local SwitchBtn = Instance.new("TextButton", ControlBox)
        SwitchBtn.Size = UDim2.new(0, 30, 0, 14)
        SwitchBtn.Position = UDim2.new(1, -34, 0.5, 0)
        SwitchBtn.AnchorPoint = Vector2.new(0, 0.5)
        SwitchBtn.BackgroundColor3 = THEME.AccentMint
        SwitchBtn.Text = ""
        SwitchBtn.AutoButtonColor = false
        Instance.new("UICorner", SwitchBtn).CornerRadius = UDim.new(1, 0)

        local Knob = Instance.new("Frame", SwitchBtn)
        Knob.Size = UDim2.new(0, 10, 0, 10)
        Knob.Position = UDim2.new(1, -12, 0.5, 0)
        Knob.AnchorPoint = Vector2.new(0, 0.5)
        Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Knob.BorderSizePixel = 0
        Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

        local function updateLanguage(state)
            isVietnamese = state
            if isVietnamese then
                StatusLabel.Text = "Tiếng Việt (ON)"
                StatusLabel.TextColor3 = THEME.AccentMint
                TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.AccentMint}):Play()
                TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -12, 0.5, 0)}):Play()
            else
                StatusLabel.Text = "English (OFF)"
                StatusLabel.TextColor3 = THEME.TextSub
                TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ToggleOff}):Play()
                TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
            end
        end

        SwitchBtn.MouseButton1Click:Connect(function() updateLanguage(not isVietnamese) end)

        local function applyElemTranslation(elem)
            if isApplyingTranslation then return end
            if not (elem:IsA("TextLabel") or elem:IsA("TextButton")) then return end
            if elem:IsDescendantOf(PinGui) then return end

            local cur = elem.Text
            if not cur or cur == "" then return end

            local lastApplied = elem:GetAttribute("TLong_LastApplied")
            if cur ~= lastApplied then OriginalTexts[elem] = cur end

            local orig = OriginalTexts[elem] or cur

            if isVietnamese then
                local vi = translateText(orig)
                if elem.Text ~= vi then
                    isApplyingTranslation = true
                    elem:SetAttribute("TLong_LastApplied", vi)
                    elem.Text = vi
                    isApplyingTranslation = false
                end
            else
                if elem.Text ~= orig then
                    isApplyingTranslation = true
                    elem:SetAttribute("TLong_LastApplied", nil)
                    elem.Text = orig
                    isApplyingTranslation = false
                end
            end
        end

        local function hookElement(elem)
            if (elem:IsA("TextLabel") or elem:IsA("TextButton")) and not elem:IsDescendantOf(PinGui) then
                applyElemTranslation(elem)
                if not elem:GetAttribute("TLong_Hooked") then
                    elem:SetAttribute("TLong_Hooked", true)
                    elem:GetPropertyChangedSignal("Text"):Connect(function()
                        applyElemTranslation(elem)
                    end)
                end
            end
        end

        local IDENTIFIERS = {"FARM", "CÀY TIỀN", "PETS", "THÚ CƯNG", "CONFIG", "CẤU HÌNH", "START FARM", "BẮT ĐẦU CÀY", "TARGET FILTER", "BỘ LỌC MỤC TIÊU"}

        local function isDiscordWindow(win)
            for _, d in ipairs(win:GetDescendants()) do
                if (d:IsA("TextLabel") or d:IsA("TextButton")) and (d.Text:find("CONTINUE TO HUB", 1, true) or d.Text:find("JOIN OUR DISCORD", 1, true)) then
                    return true
                end
            end
            return false
        end

        local function findOnhubWindow()
            local function scanRoot(root)
                if not root then return nil end
                local ok, descs = pcall(function() return root:GetDescendants() end)
                if not ok or not descs then return nil end
                for _, obj in ipairs(descs) do
                    if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and not obj:IsDescendantOf(PinGui) then
                        local t = obj.Text
                        if t and #t > 0 then
                            for _, id in ipairs(IDENTIFIERS) do
                                if t == id or t:find(id, 1, true) then
                                    local p = obj
                                    while p and p.Parent and not p.Parent:IsA("ScreenGui") and p.Parent ~= root do p = p.Parent end
                                    if p and (p:IsA("Frame") or p:IsA("CanvasGroup") or p:IsA("GuiObject")) and p.AbsoluteSize.X > 300 and p.AbsoluteSize.Y > 150 then
                                        if not isDiscordWindow(p) then return p end
                                    end
                                end
                            end
                        end
                    end
                end
                return nil
            end

            local found = nil
            if gethui then found = scanRoot(gethui()) end
            if not found then found = scanRoot(CoreGui) end
            if not found and LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then found = scanRoot(LocalPlayer.PlayerGui) end
            return found
        end

        -- Tối ưu luồng RenderStepped bằng nhịp task.wait() 0.03s để chống giật
        task.spawn(function()
            while true do
                if targetOnhubWindow and targetOnhubWindow.Parent then
                    local winSize = targetOnhubWindow.AbsoluteSize
                    local winPos = targetOnhubWindow.AbsolutePosition

                    local isShowing = targetOnhubWindow.Visible and winSize.Y > 100 and winPos.Y > -100 and winPos.Y < 2000

                    if isShowing then
                        PinBar.Visible = true
                        PinBar.Position = UDim2.new(0, winPos.X + 4, 0, winPos.Y + 3)
                        PinBar.Size = UDim2.new(0, 310, 0, 28)
                    else
                        PinBar.Visible = false
                    end
                else
                    PinBar.Visible = false
                end
                task.wait(0.03)
            end
        end)

        -- Vòng lặp duy trì dịch
        task.spawn(function()
            while true do
                pcall(function()
                    if not targetOnhubWindow or not targetOnhubWindow.Parent then
                        targetOnhubWindow = findOnhubWindow()
                    end

                    if targetOnhubWindow then
                        for _, elem in ipairs(targetOnhubWindow:GetDescendants()) do
                            hookElement(elem)
                        end
                    end
                end)
                task.wait(0.25)
            end
        end)
    end)
end

-- =================================================================
-- ⚡ KIỂM TRA KEY ĐÃ SỬ DỤNG TRƯỚC ĐÓ CHƯA (TỰ ĐỘNG BỎ QUA UI)
-- =================================================================
local todayDateStr = GetCurrentDateString()
local function CheckSavedKeyStatus()
    if readfile and isfile and isfile(SAVE_FILE_NAME) then
        local savedData = readfile(SAVE_FILE_NAME)
        if savedData == todayDateStr then
            return true
        end
    end
    return false
end

if CheckSavedKeyStatus() then
    print("[TLong System]: Key hôm nay đã được xác thực trước đó. Đang vào game...")
    LaunchMainScript()
    return
end

-- =================================================================
-- KHỞI TẠO UI (Nếu chưa Get Key hoặc Key đã hết hạn ngày mới)
-- =================================================================
if CoreGui:FindFirstChild("TLongHub_GetKeyUI") then
    CoreGui.TLongHub_GetKeyUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TLongHub_GetKeyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 390, 0, 380)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 8, 19)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local RainbowStroke = Instance.new("UIStroke")
RainbowStroke.Thickness = 1.8
RainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RainbowStroke.Parent = MainFrame

-- Tối ưu hóa hiệu ứng Cầu vồng bằng Task Loop tần số thấp thay vì RenderStepped
task.spawn(function()
    while MainFrame and MainFrame.Parent do
        local hue = (tick() * 0.2) % 1
        RainbowStroke.Color = Color3.fromHSV(hue, 0.75, 1)
        task.wait(0.04)
    end
end)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -90, 0, 22)
TitleLabel.Position = UDim2.new(0, 15, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = Translations[currentLang].Title
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.new(0, 55, 0, 22)
LangBtn.Position = UDim2.new(1, -70, 0, 8)
LangBtn.BackgroundColor3 = Color3.fromRGB(26, 20, 45)
LangBtn.Text = Translations[currentLang].LangToggleText
LangBtn.TextColor3 = Color3.fromRGB(255, 215, 100)
LangBtn.TextSize = 10.5
LangBtn.Font = Enum.Font.GothamBold
LangBtn.Parent = MainFrame

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 6)
LangCorner.Parent = LangBtn

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -30, 0, 34)
InputBox.Position = UDim2.new(0, 15, 0, 33)
InputBox.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
InputBox.TextColor3 = Color3.fromRGB(245, 245, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(120, 115, 140)
InputBox.PlaceholderText = Translations[currentLang].Placeholder
InputBox.Text = ""
InputBox.TextSize = 12
InputBox.Font = Enum.Font.GothamMedium
InputBox.ClearTextOnFocus = false
InputBox.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(45, 38, 70)
InputStroke.Thickness = 1
InputStroke.Parent = InputBox

local ButtonsRow = Instance.new("Frame")
ButtonsRow.Size = UDim2.new(1, -30, 0, 34)
ButtonsRow.Position = UDim2.new(0, 15, 0, 72)
ButtonsRow.BackgroundTransparency = 1
ButtonsRow.Parent = MainFrame

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
GetKeyBtn.Text = Translations[currentLang].GetKey
GetKeyBtn.TextColor3 = Color3.fromRGB(8, 8, 12)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = ButtonsRow

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
CheckKeyBtn.Position = UDim2.new(0.5, 5, 0, 0)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(38, 30, 62)
CheckKeyBtn.Text = Translations[currentLang].CheckKey
CheckKeyBtn.TextColor3 = Color3.fromRGB(245, 245, 255)
CheckKeyBtn.TextSize = 12
CheckKeyBtn.Font = Enum.Font.GothamBold
CheckKeyBtn.AutoButtonColor = false
CheckKeyBtn.Parent = ButtonsRow

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckKeyBtn

local StatusBanner = Instance.new("Frame")
StatusBanner.Size = UDim2.new(1, -30, 0, 28)
StatusBanner.Position = UDim2.new(0, 15, 0, 112)
StatusBanner.BackgroundColor3 = Color3.fromRGB(16, 12, 28)
StatusBanner.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 6)
StatusCorner.Parent = StatusBanner

local StatusMsg = Instance.new("TextLabel")
StatusMsg.Size = UDim2.new(1, -12, 1, 0)
StatusMsg.Position = UDim2.new(0, 6, 0, 0)
StatusMsg.BackgroundTransparency = 1
StatusMsg.Text = Translations[currentLang].DefaultStatus
StatusMsg.TextColor3 = Color3.fromRGB(180, 175, 205)
StatusMsg.TextSize = 9.5
StatusMsg.Font = Enum.Font.GothamMedium
StatusMsg.TextWrapped = true
StatusMsg.Parent = StatusBanner

local DiscordCard = Instance.new("Frame")
DiscordCard.Size = UDim2.new(1, -30, 0, 48)
DiscordCard.Position = UDim2.new(0, 15, 0, 146)
DiscordCard.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
DiscordCard.Parent = MainFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 8)
DiscordCorner.Parent = DiscordCard

local DiscordAvatar = Instance.new("ImageLabel")
DiscordAvatar.Size = UDim2.new(0, 34, 0, 34)
DiscordAvatar.Position = UDim2.new(0, 8, 0.5, -17)
DiscordAvatar.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordAvatar.Image = DISCORD_ICON_URL
DiscordAvatar.Parent = DiscordCard

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = DiscordAvatar

local ServerName = Instance.new("TextLabel")
ServerName.Size = UDim2.new(0, 180, 0, 18)
ServerName.Position = UDim2.new(0, 48, 0, 8)
ServerName.BackgroundTransparency = 1
ServerName.Text = "TLong System Community"
ServerName.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerName.TextSize = 11.5
ServerName.Font = Enum.Font.GothamBold
ServerName.TextXAlignment = Enum.TextXAlignment.Left
ServerName.Parent = DiscordCard

local ServerSub = Instance.new("TextLabel")
ServerSub.Size = UDim2.new(0, 180, 0, 14)
ServerSub.Position = UDim2.new(0, 48, 0, 25)
ServerSub.BackgroundTransparency = 1
ServerSub.Text = Translations[currentLang].DiscordSub
ServerSub.TextColor3 = Color3.fromRGB(80, 255, 140)
ServerSub.TextSize = 9.5
ServerSub.Font = Enum.Font.GothamMedium
ServerSub.TextXAlignment = Enum.TextXAlignment.Left
ServerSub.Parent = DiscordCard

local JoinDiscordBtn = Instance.new("TextButton")
JoinDiscordBtn.Size = UDim2.new(0, 100, 0, 28)
JoinDiscordBtn.Position = UDim2.new(1, -108, 0.5, -14)
JoinDiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
JoinDiscordBtn.Text = Translations[currentLang].CopyBtn
JoinDiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinDiscordBtn.TextSize = 10.5
JoinDiscordBtn.Font = Enum.Font.GothamBold
JoinDiscordBtn.Parent = DiscordCard

local JoinCorner = Instance.new("UICorner")
JoinCorner.CornerRadius = UDim.new(0, 6)
JoinCorner.Parent = JoinDiscordBtn

local NoteCard = Instance.new("Frame")
NoteCard.Size = UDim2.new(1, -30, 0, 160)
NoteCard.Position = UDim2.new(0, 15, 0, 202)
NoteCard.BackgroundColor3 = Color3.fromRGB(17, 13, 29)
NoteCard.Parent = MainFrame

local NoteCardCorner = Instance.new("UICorner")
NoteCardCorner.CornerRadius = UDim.new(0, 8)
NoteCardCorner.Parent = NoteCard

local NoteLabel = Instance.new("TextLabel")
NoteLabel.Size = UDim2.new(1, -16, 1, -10)
NoteLabel.Position = UDim2.new(0, 8, 0, 5)
NoteLabel.BackgroundTransparency = 1
NoteLabel.TextColor3 = Color3.fromRGB(242, 160, 120)
NoteLabel.TextSize = 9.5
NoteLabel.Font = Enum.Font.Gotham
NoteLabel.TextWrapped = true
NoteLabel.TextYAlignment = Enum.TextYAlignment.Top
NoteLabel.TextXAlignment = Enum.TextXAlignment.Left
NoteLabel.Text = Translations[currentLang].NoteText
NoteLabel.Parent = NoteCard

local function UpdateLanguage()
    local t = Translations[currentLang]
    TitleLabel.Text = t.Title
    InputBox.PlaceholderText = t.Placeholder
    GetKeyBtn.Text = t.GetKey
    CheckKeyBtn.Text = t.CheckKey
    StatusMsg.Text = t.DefaultStatus
    ServerSub.Text = t.DiscordSub
    JoinDiscordBtn.Text = t.CopyBtn
    NoteLabel.Text = t.NoteText
    LangBtn.Text = t.LangToggleText
end

LangBtn.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "VI") and "EN" or "VI"
    UpdateLanguage()
end)

local function PlayBounce(btn)
    local origSize = btn.Size
    local origPos = btn.Position
    local shrinkSize = UDim2.new(origSize.X.Scale, origSize.X.Offset - 4, origSize.Y.Scale, origSize.Y.Offset - 4)
    local shrinkPos = UDim2.new(origPos.X.Scale, origPos.X.Offset + 2, origPos.Y.Scale, origPos.Y.Offset + 2)
        
    local t1 = TweenService:Create(btn, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = shrinkSize, Position = shrinkPos})
    local t2 = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize, Position = origPos})
    t1:Play()
    t1.Completed:Connect(function() t2:Play() end)
end

local function SetClipboardSafe(text)
    if setclipboard then setclipboard(text) elseif toclipboard then toclipboard(text) end
end

local function PlaySuccessFadeOut()
    local duration = 0.45
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    TweenService:Create(MainFrame, tweenInfo, {
        Position = UDim2.new(0.5, 0, 0.58, 0),
        Size = UDim2.new(0, 360, 0, 350),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(RainbowStroke, tweenInfo, {Transparency = 1}):Play()
    for _, desc in ipairs(MainFrame:GetDescendants()) do
        if desc:IsA("Frame") then
            TweenService:Create(desc, tweenInfo, {BackgroundTransparency = 1}):Play()
        elseif desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            TweenService:Create(desc, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        elseif desc:IsA("ImageLabel") then
            TweenService:Create(desc, tweenInfo, {BackgroundTransparency = 1, ImageTransparency = 1}):Play()
        elseif desc:IsA("UIStroke") then
            TweenService:Create(desc, tweenInfo, {Transparency = 1}):Play()
        end
    end
    task.wait(duration)
    ScreenGui:Destroy()
end

JoinDiscordBtn.MouseButton1Click:Connect(function()
    PlayBounce(JoinDiscordBtn)
    SetClipboardSafe(DISCORD_INVITE)
        
    if request then
        pcall(function()
            request({
                Url = "http://127.0.0.1:6463/rpc?v=1",
                Method = "POST",
                Headers = {["Content-Type"] = "application/json", ["Origin"] = "https://discord.com"},
                Body = game:GetService("HttpService"):JSONEncode({
                    cmd = "INVITE_BROWSER",
                    args = {code = "TvwRC4tba"},
                    nonce = game:GetService("HttpService"):GenerateGUID(false)
                })
            })
        end)
    end
        
    StatusBanner.BackgroundColor3 = Color3.fromRGB(30, 35, 75)
    StatusMsg.TextColor3 = Color3.fromRGB(120, 150, 255)
    StatusMsg.Text = Translations[currentLang].CopyDiscordStatus
        
    JoinDiscordBtn.Text = Translations[currentLang].CopiedBtn
    task.delay(2, function()
        if JoinDiscordBtn and JoinDiscordBtn.Parent then
            JoinDiscordBtn.Text = Translations[currentLang].CopyBtn
        end
    end)
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    PlayBounce(GetKeyBtn)
    SetClipboardSafe(DOMAIN_VERCEL)
        
    StatusBanner.BackgroundColor3 = Color3.fromRGB(0, 50, 60)
    StatusMsg.TextColor3 = Color3.fromRGB(0, 240, 255)
    StatusMsg.Text = Translations[currentLang].CopyKeyStatus
        
    GetKeyBtn.Text = Translations[currentLang].GetKeyCopied
    task.delay(2, function()
        if GetKeyBtn and GetKeyBtn.Parent then
            GetKeyBtn.Text = Translations[currentLang].GetKey
        end
    end)
end)

local isChecking = false
CheckKeyBtn.MouseButton1Click:Connect(function()
    if isChecking then return end
    isChecking = true
    PlayBounce(CheckKeyBtn)
        
    CheckKeyBtn.Text = Translations[currentLang].Checking
    StatusBanner.BackgroundColor3 = Color3.fromRGB(26, 20, 45)
    StatusMsg.TextColor3 = Color3.fromRGB(240, 240, 255)
    StatusMsg.Text = Translations[currentLang].CheckingStatus
        
    task.wait(0.35)
    local enteredKey = string.gsub(InputBox.Text, "%s+", "")
        
    if enteredKey:find("TLong%-" .. todayDateStr) then
        StatusBanner.BackgroundColor3 = Color3.fromRGB(15, 60, 30)
        StatusMsg.TextColor3 = Color3.fromRGB(80, 255, 140)
        StatusMsg.Text = Translations[currentLang].ValidStatus
        CheckKeyBtn.Text = Translations[currentLang].SuccessBtn
        CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 70)
                
        if writefile then
            pcall(function()
                writefile(SAVE_FILE_NAME, todayDateStr)
            end)
        end
                
        LaunchMainScript()
                
        task.wait(0.3)
        PlaySuccessFadeOut()
    else
        isChecking = false
        CheckKeyBtn.Text = Translations[currentLang].CheckKey
        StatusBanner.BackgroundColor3 = Color3.fromRGB(65, 15, 20)
        StatusMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
        StatusMsg.Text = Translations[currentLang].InvalidStatus
                
        InputStroke.Color = Color3.fromRGB(255, 70, 70)
        task.wait(0.6)
        InputStroke.Color = Color3.fromRGB(45, 38, 70)
    end
end)