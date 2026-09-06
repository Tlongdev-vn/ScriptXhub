-- ==============================================================================
--  TLONG HUB - DEOBFUSCATED PAYLOAD & FULL TRANSLATOR FOR ONHUB
--  Link gốc đã được giải mã rõ ràng | Tự bấm Continue to Hub | Việt hóa 100%
-- ==============================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Dọn sạch phiên bản cũ
local cleanList = {
    "TLong_ONhub_DockedMaster",
    "TLong_HeaderDockedMaster",
    "TLong_PerfectDockMaster",
    "TLong_ONhub_CompactMaster",
    "TLong_ONhub_UltimateConfig",
    "TLong_ONhub_AutoBypassMaster",
    "TLong_ONhub_EncryptedMaster",
    "Ronnei_ONhub_DockedMaster",
    "Ronnei_HeaderDockedMaster",
    "Ronnei_PerfectDockMaster",
    "Ronnei_ONhub_CompactMaster",
    "Ronnei_ONhub_UltimateConfig",
    "Ronnei_ONhub_AutoBypassMaster",
    "Ronnei_ONhub_EncryptedMaster"
}
for _, name in ipairs(cleanList) do
    pcall(function()
        if CoreGuiService:FindFirstChild(name) then CoreGuiService[name]:Destroy() end
        if gethui and gethui():FindFirstChild(name) then gethui()[name]:Destroy() end
    end)
end

-- ==================== CƠ CHẾ TỰ BỎ QUA BẢNG DISCORD (AUTO-BYPASS) ====================
local function triggerButtonClick(btn)
    if not btn then return end
    if firesignal then
        pcall(function() firesignal(btn.MouseButton1Click) end)
        pcall(function() firesignal(btn.Activated) end)
    end
    if getconnections then
        pcall(function()
            for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
                conn:Fire()
            end
        end)
        pcall(function()
            for _, conn in ipairs(getconnections(btn.Activated)) do
                conn:Fire()
            end
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
pcall(function() table.insert(guiRoots, CoreGuiService) end)
if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
    table.insert(guiRoots, LocalPlayer.PlayerGui)
end

for _, root in ipairs(guiRoots) do
    pcall(function()
        for _, desc in ipairs(root:GetDescendants()) do
            interceptDiscordModal(desc)
        end
        root.DescendantAdded:Connect(function(child)
            interceptDiscordModal(child)
        end)
    end)
end

task.spawn(function()
    local startT = tick()
    while tick() - startT < 6 do
        for _, root in ipairs(guiRoots) do
            pcall(function()
                for _, desc in ipairs(root:GetDescendants()) do
                    interceptDiscordModal(desc)
                end
            end)
        end
        task.wait(0.05)
    end
end)

-- ==================== KHỐI NẠP SCRIPT GỐC ĐÃ GIẢI MÃ ====================
task.spawn(function()
    pcall(function()
        -- Link gốc đã được giải mã từ byte stream
        local _resolvedTarget = "https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua"
        local _loaderFunc = loadstring or (getgenv and getgenv().loadstring)
        if _loaderFunc then
            _loaderFunc(game:HttpGet(_resolvedTarget, true))()
        end
    end)
end)

-- ==================== CẤU HÌNH GIAO DIỆN TLONG HUB ====================
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

-- ==================== BẢNG TỪ ĐIỂN DỊCH THUẬT TOÀN DIỆN ====================
local RAW_TRANSLATIONS = {
    -- 1. TAB CẤU HÌNH: BỘ LỌC MỤC TIÊU (TARGET FILTER)
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

    -- 2. TAB CẤU HÌNH: TRỌNG SỐ ƯU TIÊN (RANKING WEIGHTS)
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

    -- 3. TAB CẤU HÌNH: DI CHUYỂN & AN TOÀN (MOVEMENT AND SAFETY)
    {"Approach radius (server accepts 9):", "Bán kính tiếp cận (server nhận 9):"},
    {"Approach radius (server accepts 9)", "Bán kính tiếp cận (server nhận 9)"},
    {"Approach radius", "Bán kính tiếp cận"},
    {"server accepts 9", "server nhận 9"},
    {"Max time per trip:", "Thời gian tối đa mỗi chuyến:"},
    {"Max time per trip", "Thời gian tối đa mỗi chuyến"},
    {"Stop the farm on rollback", "Dừng cày khi bị giật lùi (rollback)"},
    {"MOVEMENT AND SAFETY", "DI CHUYỂN & AN TOÀN"},

    -- 4. TAB CẤU HÌNH: DI CHUYỂN NHANH (FAST TRAVEL)
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
    {"The anti-cheat validates distance divided by time. The hop rewinds the timestamp of its samples before every step:", "Chống hack kiểm tra khoảng cách chia cho thời gian. Bước nhảy tua lại mốc thời gian trước mỗi bước:"},
    {"The instant TP needs a ragdoll window opened by the SERVER. It uses a first-area egg as the ticket but does NOT consume it: the strike only DROPS that egg and it returns to its own slot, so the real cost is the ~0.5s to walk over and grab it, not an egg.", "TP tức thì cần khe hở ragdoll do SERVER mở. Nó dùng trứng khu 1 làm vé nhưng KHÔNG mất: đòn đánh chỉ làm RƠI trứng về chỗ cũ, chi phí thực chỉ là ~0.5s đi lại nhặt, không mất trứng."},
    {"One window = ONE leg of the trip. Measured: the server refuses to pick up any egg for the whole ragdoll (cannot carry eggs while knocked down) and the position exemption dies the instant the ragdoll ends - a TP written 51ms after EndRagdoll already gets relocated. So the TP covers the way OUT and the way back with the egg is always the chained hop.", "Một khe hở = 1 lượt đi. Server từ chối nhặt trứng khi đang ragdoll (không thể cầm trứng khi ngã) và quyền miễn trừ vị trí mất ngay khi hết ragdoll. TP dùng cho lượt ĐI, lượt VỀ luôn là nhảy CFrame."},
    {"No metatable hook is used: __namecall got a kick in a direct test.", "Không dùng hook metatable: __namecall đã bị kick khi thử nghiệm."},
    {"Travel speed is step divided by interval. Default 80 / 0.08 = 1000", "Tốc độ di chuyển = bước chia cho thời gian chờ. Mặc định 80 / 0.08 = 1000"},
    {"GETTING ROLLBACK? Raise the rewind first as it inflates the distance the client-side detector allows per step and costs nothing. Only then lower the step, or raise the interval.", "BỊ GIẬT LÙI? Hãy tăng tua ngược thời gian trước vì nó mở rộng khoảng cách cho phép mỗi bước. Sau đó mới giảm bước hoặc tăng thời gian chờ."},
    {"Every revert forces a retry, so a big step is slower in practice.", "Mỗi lần lùi phải thử lại nên bước lớn thực tế lại chậm hơn."},

    -- 5. TAB CẤU HÌNH: RIFT & GIAO DIỆN (INTERFACE)
    {"Count pets you already own", "Tính cả thú cưng bạn đã có"},
    {"Plant recipe eggs on the plot", "Đặt trứng công thức lên khu đất"},
    {"Plant index eggs on the plot", "Đặt trứng sưu tập lên khu đất"},
    {"The machine CONSUMES the 3 pets on trade-in. With the first option on, a pet you already have free in the inventory closes that slot and the hub will not hunt that animal - the bar shows the count (p = pet, o = egg, eq = placed). Turn it off to hunt all three from scratch and keep the pets you have.", "Máy RIFT sẽ TIÊU THỤ 3 thú cưng khi đổi. Bật tùy chọn đầu, thú cưng có sẵn trong túi sẽ lấp ô đó và hub không cần săn con đó nữa. Tắt đi nếu muốn săn mới cả 3 và giữ lại thú cưng đang có."},
    {"Floating button (show/hide)", "Nút tròn nổi (hiện/ẩn)"},
    {"Interface scale:", "Tỷ lệ giao diện:"},
    {"Interface scale", "Tỷ lệ giao diện"},
    {"Platform: mobile (touch, no keyboard). The scale starts automatic from the resolution (base window 620x420 shrunk to fit 92%x 88% of the screen). Touching the slider pins the", "Nền tảng: di động (cảm ứng, không phím). Tỷ lệ tự động theo độ phân giải màn hình (cửa sổ 620x420 thu gọn vừa 92%x 88% màn hình). Chạm thanh trượt để cố định"},
    {"INTERFACE", "GIAO DIỆN"},
    {"RIFT", "MÁY RIFT"},

    -- 6. TAB CÀY TIỀN (FARM) & RUNTIME
    {"no mode: farming by $/s. RIFT hunts the machine recipe. INDEX hunts what your codex is missing", "Cơ bản: cày theo $/s. RIFT: săn công thức máy. SƯU TẬP: săn trứng thiếu"},
    {"no mode: farming by $/s. RIFT hunts the machine. INDEX hunts what your codex is missing", "Cơ bản: cày theo $/s. RIFT: săn máy. SƯU TẬP: săn trứng thiếu"},
    {"hunts what your codex is missing", "săn trứng còn thiếu"},
    {"RIFT hunts the machine recipe", "RIFT săn công thức máy"},
    {"RIFT hunts the machine", "RIFT săn máy"},
    {"no mode: farming by $/s.", "Cơ bản: cày theo $/s."},
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

    -- 7. THANH TABS
    {"FARM", "CÀY TIỀN"},
    {"PETS", "THÚ CƯNG"},
    {"CONFIG", "CẤU HÌNH"},

    -- 8. THÔNG SỐ RUNTIME
    {"heading to Koi", "Đang tới Cá Koi"},
    {"heading to", "Đang tới"},
    {"delivered", "đã giao"},
    {"failed", "thất bại"},
    {"lost", "mất"},
    {"idle", "đang chờ"},
    {"studs", "mét"},

    -- 9. TÊN THÚ CƯNG & KHU VỰC
    {"Burrowing Owl", "Cú Hang"},
    {"Bladehide", "Thằn Lằn Gai"},
    {"Bronto", "Khủng Long Cổ Dài"},
    {"Chicken", "Gà"},
    {"Dog", "Chó"},
    {"Rhinotaur", "Tê Giác Quái"},
    {"Mantaris", "Bọ Ngựa Quái"},
    {"Triceratops", "Khủng Long 3 Sừng"},
    {"Whale Shark", "Cá Mập Voi"},
    {"Beluga Whale", "Cá Voi Trắng"},
    {"Koi", "Cá Koi"},
    {"Common", "Thường"},
    {"Rare", "Hiếm"},
    {"Epic", "Sử Thi"},
    {"Legendary", "Huyền Thoại"},
    {"Mythic", "Thần Thoại"},
    {"Divine", "Thần Thánh"},
    {"Cosmic", "Vũ Trụ"},
    {"Secret", "Bí Mật"},
    {"Cherry Blossom", "Hoa Anh Đào"},
    {"Forest", "Rừng Rậm"},
    {"Desert", "Sa Mạc"},
    {"Titan Temple", "Đền Titan"},
    {"Abyss Ocean", "Biển Vực Sâu"},
    {"Prehistoric", "Tiền Sử"}
}

table.sort(RAW_TRANSLATIONS, function(a, b)
    return #a[1] > #b[1]
end)

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

-- ==================== TẠO THANH GHIM (310PX GỌN GÀNG) ====================
local isVietnamese = true
local OriginalTexts = {}
local targetOnhubWindow = nil
local isApplyingTranslation = false

local PinGui = Instance.new("ScreenGui")
PinGui.Name = "TLong_ONhub_EncryptedMaster"
PinGui.ResetOnSpawn = false
PinGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PinGui.DisplayOrder = 999999
PinGui.Parent = (gethui and gethui()) or CoreGuiService

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
        task.wait(0.04)
    end
end)

-- Nút gạt chuyển đổi ON / OFF
local ControlBox = Instance.new("Frame", PinBar)
ControlBox.Size = UDim2.new(0, 160, 0, 22)
ControlBox.Position = UDim2.new(1, -4, 0.5, 0)
ControlBox.AnchorPoint = Vector2.new(1, 0.5)
ControlBox.BackgroundColor3 = THEME.CardBG
Instance.new("UICorner", ControlBox).CornerRadius = UDim.new(0, 6)

local BoxStroke = Instance.new("UIStroke", ControlBox)
BoxStroke.Color = THEME.Border
BoxStroke.Thickness = 1

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
ControlBox.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        updateLanguage(not isVietnamese)
    end
end)

-- ==================== BỘ QUÉT TẦNG SÂU VÀ DỊCH TỨC THỜI ====================
local function applyElemTranslation(elem)
    if isApplyingTranslation then return end
    if not (elem:IsA("TextLabel") or elem:IsA("TextButton")) then return end
    if elem:IsDescendantOf(PinGui) then return end

    local cur = elem.Text
    if not cur or cur == "" then return end

    local lastApplied = elem:GetAttribute("TLong_LastApplied")
    if cur ~= lastApplied then
        OriginalTexts[elem] = cur
    end

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

-- ==================== BỘ TÌM KIẾM CỬA SỔ ONHUB CHÍNH XÁC 100% ====================
local IDENTIFIERS = {
    "FARM", "CÀY TIỀN",
    "PETS", "THÚ CƯNG",
    "CONFIG", "CẤU HÌNH",
    "START FARM", "BẮT ĐẦU CÀY",
    "TARGET FILTER", "BỘ LỌC MỤC TIÊU"
}

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
                            while p and p.Parent and not p.Parent:IsA("ScreenGui") and p.Parent ~= root do
                                p = p.Parent
                            end
                            if p and (p:IsA("Frame") or p:IsA("CanvasGroup") or p:IsA("GuiObject")) and p.AbsoluteSize.X > 300 and p.AbsoluteSize.Y > 150 then
                                if not isDiscordWindow(p) then
                                    return p
                                end
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
    if not found then found = scanRoot(CoreGuiService) end
    if not found and LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then found = scanRoot(LocalPlayer.PlayerGui) end
    if not found and getinstances then
        for _, ins in ipairs(getinstances()) do
            if (ins:IsA("TextLabel") or ins:IsA("TextButton")) and not ins:IsDescendantOf(PinGui) then
                local t = ins.Text
                if t == "CONFIG" or t == "CẤU HÌNH" or t == "FARM" or t == "CÀY TIỀN" or t == "START FARM" then
                    local p = ins
                    while p and p.Parent and not p.Parent:IsA("ScreenGui") and p.Parent ~= game do
                        p = p.Parent
                    end
                    if p and (p:IsA("Frame") or p:IsA("CanvasGroup") or p:IsA("GuiObject")) and p.AbsoluteSize.X > 300 and p.AbsoluteSize.Y > 150 then
                        if not isDiscordWindow(p) then
                            return p
                        end
                    end
                end
            end
        end
    end
    return found
end

-- ==================== ĐỒNG BỘ HIỂN THỊ TỰ ĐỘNG (KHÔNG BAO GIỜ MẤT NÚT) ====================
RunService.RenderStepped:Connect(function()
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
        task.wait(0.2)
    end
end)