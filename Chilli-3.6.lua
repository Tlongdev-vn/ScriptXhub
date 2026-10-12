-- =================================================================
-- HỆ THỐNG GET KEY - TLONG SYSTEM (AUTO-SAVE KEY) - COMPACT + TIKTOK
-- =================================================================

local DOMAIN_VERCEL = "https://keylicensenew2.vercel.app/"
local DISCORD_INVITE = "https://discord.gg/gdxcTDBbb"
local DISCORD_ICON_URL = "rbxassetid://99761773347476"
local TIKTOK_ICON_URL = "rbxassetid://99761773347476"
local TIKTOK_URL = "https://www.tiktok.com/@royah36"
local SAVE_FILE_NAME = "chilli"

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local currentLang = "VI"

local Translations = {
    VI = {
        Title = "TLONG KEY SYSTEM - Chilli Hub",
        Placeholder = "Nhập Key xác thực vào đây...",
        GetKey = "🔗 LẤY LINK KEY",
        CheckKey = "✔ KIỂM TRA KEY",
        Checking = "⏳ Đang duyệt...",
        SuccessBtn = "✔ THÀNH CÔNG",
        DefaultStatus = "⚡ Key tự động làm mới lúc 00:00 hàng ngày",
        DiscordSub = "🟢 Discord Support Server",
        TikTokSub = "🎵 Follow để nhận thêm Script",
        CopyBtn = "Copy",
        CopiedBtn = "✔ ĐÃ COPY",
        GetKeyCopied = "✔ ĐÃ COPY",
        CopyDiscordStatus = "💬 Đã copy link Discord!",
        CopyTikTokStatus = "🎵 Đã copy link TikTok @royah36!",
        CopyKeyStatus = "📋 Đã sao chép Link Web!",
        CheckingStatus = "Đang kiểm tra tính hợp lệ...",
        ValidStatus = "✔ Key hợp lệ! Đang khởi chạy...",
        InvalidStatus = "✖ Key không hợp lệ hoặc đã hết hạn!",
        LangToggleText = "🌐 VI"
    },
    EN = {
        Title = "TLONG KEY SYSTEM - Chilli Hub",
        Placeholder = "Enter verification key here...",
        GetKey = "🔗 GET KEY LINK",
        CheckKey = "✔ CHECK KEY",
        Checking = "⏳ Checking...",
        SuccessBtn = "✔ SUCCESS",
        DefaultStatus = "⚡ Key automatically resets at 00:00 daily",
        DiscordSub = "🟢 Discord Support Server",
        TikTokSub = "🎵 Follow for more awesome scripts",
        CopyBtn = "Copy",
        CopiedBtn = "✔ COPIED",
        GetKeyCopied = "✔ COPIED",
        CopyDiscordStatus = "💬 Discord link copied!",
        CopyTikTokStatus = "🎵 TikTok link copied @royah36!",
        CopyKeyStatus = "📋 Web link copied!",
        CheckingStatus = "Checking key validity...",
        ValidStatus = "✔ Valid Key! Launching...",
        InvalidStatus = "✖ Invalid key or key has expired!",
        LangToggleText = "🌐 EN"
    }
}

local function GetCurrentDateString()
    local date = os.date("!*t", os.time() + (7 * 3600))
    return string.format("%02d%02d%04d", date.day, date.month, date.year)
end

local function LaunchMainScript()
    task.spawn(function()
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/longdepzai297-stack/Tlonghub/refs/heads/main/chillihubv3.lua"))()
        end)
        if not success then
            warn("[Error]:", result)
        end
    end)
end

local todayDateStr = GetCurrentDateString()

local function CheckSavedKeyStatus()
    if readfile and isfile and isfile(SAVE_FILE_NAME) then
        local success, savedData = pcall(readfile, SAVE_FILE_NAME)
        if success and savedData == todayDateStr then
            return true
        end
    end
    return false
end

-- Tự động chạy script chính nếu đã xác thực Key trong ngày
if CheckSavedKeyStatus() then
    print("[TLong System]: Key hôm nay đã được xác thực trước đó. Đang vào game...")
    LaunchMainScript()
    return
end

-- Xác định Nơi chứa GUI phù hợp với mọi loại Executor
local parentGui = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Xóa UI cũ nếu đang tồn tại
if parentGui:FindFirstChild("TLongHub_GetKeyUI") then
    parentGui.TLongHub_GetKeyUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TLongHub_GetKeyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = parentGui

-- Khung chính
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 360, 0, 265)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 8, 19)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local RainbowStroke = Instance.new("UIStroke")
RainbowStroke.Thickness = 1.5
RainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RainbowStroke.Parent = MainFrame

RunService.RenderStepped:Connect(function()
    if MainFrame and MainFrame.Parent then
        local hue = (tick() * 0.2) % 1
        RainbowStroke.Color = Color3.fromHSV(hue, 0.75, 1)
    end
end)

-- Tiêu đề
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -70, 0, 22)
TitleLabel.Position = UDim2.new(0, 12, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = Translations[currentLang].Title
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
TitleLabel.TextSize = 12
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- Nút Ngôn Ngữ
local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.new(0, 48, 0, 20)
LangBtn.Position = UDim2.new(1, -58, 0, 9)
LangBtn.BackgroundColor3 = Color3.fromRGB(26, 20, 45)
LangBtn.Text = Translations[currentLang].LangToggleText
LangBtn.TextColor3 = Color3.fromRGB(255, 215, 100)
LangBtn.TextSize = 10
LangBtn.Font = Enum.Font.GothamBold
LangBtn.Parent = MainFrame

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 5)
LangCorner.Parent = LangBtn

-- Ô nhập Key
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -24, 0, 32)
InputBox.Position = UDim2.new(0, 12, 0, 36)
InputBox.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
InputBox.TextColor3 = Color3.fromRGB(245, 245, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(120, 115, 140)
InputBox.PlaceholderText = Translations[currentLang].Placeholder
InputBox.Text = ""
InputBox.TextSize = 11
InputBox.Font = Enum.Font.GothamMedium
InputBox.ClearTextOnFocus = false
InputBox.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = InputBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(45, 38, 70)
InputStroke.Thickness = 1
InputStroke.Parent = InputBox

-- Nút Get Key & Check Key
local ButtonsRow = Instance.new("Frame")
ButtonsRow.Size = UDim2.new(1, -24, 0, 32)
ButtonsRow.Position = UDim2.new(0, 12, 0, 74)
ButtonsRow.BackgroundTransparency = 1
ButtonsRow.Parent = MainFrame

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -4, 1, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
GetKeyBtn.Text = Translations[currentLang].GetKey
GetKeyBtn.TextColor3 = Color3.fromRGB(8, 8, 12)
GetKeyBtn.TextSize = 11
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = ButtonsRow

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 6)
GetKeyCorner.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0.5, -4, 1, 0)
CheckKeyBtn.Position = UDim2.new(0.5, 4, 0, 0)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(38, 30, 62)
CheckKeyBtn.Text = Translations[currentLang].CheckKey
CheckKeyBtn.TextColor3 = Color3.fromRGB(245, 245, 255)
CheckKeyBtn.TextSize = 11
CheckKeyBtn.Font = Enum.Font.GothamBold
CheckKeyBtn.AutoButtonColor = false
CheckKeyBtn.Parent = ButtonsRow

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 6)
CheckCorner.Parent = CheckKeyBtn

-- Banner Trạng Thái
local StatusBanner = Instance.new("Frame")
StatusBanner.Size = UDim2.new(1, -24, 0, 24)
StatusBanner.Position = UDim2.new(0, 12, 0, 112)
StatusBanner.BackgroundColor3 = Color3.fromRGB(16, 12, 28)
StatusBanner.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 5)
StatusCorner.Parent = StatusBanner

local StatusMsg = Instance.new("TextLabel")
StatusMsg.Size = UDim2.new(1, -10, 1, 0)
StatusMsg.Position = UDim2.new(0, 5, 0, 0)
StatusMsg.BackgroundTransparency = 1
StatusMsg.Text = Translations[currentLang].DefaultStatus
StatusMsg.TextColor3 = Color3.fromRGB(180, 175, 205)
StatusMsg.TextSize = 9
StatusMsg.Font = Enum.Font.GothamMedium
StatusMsg.TextWrapped = true
StatusMsg.Parent = StatusBanner

-- Card Discord
local DiscordCard = Instance.new("Frame")
DiscordCard.Size = UDim2.new(1, -24, 0, 38)
DiscordCard.Position = UDim2.new(0, 12, 0, 142)
DiscordCard.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
DiscordCard.Parent = MainFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordCard

local DiscordStroke = Instance.new("UIStroke")
DiscordStroke.Color = Color3.fromRGB(88, 101, 242)
DiscordStroke.Parent = DiscordCard

local DiscordAvatar = Instance.new("ImageLabel")
DiscordAvatar.Size = UDim2.new(0, 24, 0, 24)
DiscordAvatar.Position = UDim2.new(0, 7, 0.5, -12)
DiscordAvatar.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordAvatar.Image = DISCORD_ICON_URL
DiscordAvatar.Parent = DiscordCard

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = DiscordAvatar

local ServerName = Instance.new("TextLabel")
ServerName.Size = UDim2.new(0, 160, 0, 14)
ServerName.Position = UDim2.new(0, 38, 0, 4)
ServerName.BackgroundTransparency = 1
ServerName.Text = "TLong Community"
ServerName.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerName.TextSize = 10
ServerName.Font = Enum.Font.GothamBold
ServerName.TextXAlignment = Enum.TextXAlignment.Left
ServerName.Parent = DiscordCard

local ServerSub = Instance.new("TextLabel")
ServerSub.Size = UDim2.new(0, 160, 0, 12)
ServerSub.Position = UDim2.new(0, 38, 0, 20)
ServerSub.BackgroundTransparency = 1
ServerSub.Text = Translations[currentLang].DiscordSub
ServerSub.TextColor3 = Color3.fromRGB(80, 255, 140)
ServerSub.TextSize = 8.5
ServerSub.Font = Enum.Font.GothamMedium
ServerSub.TextXAlignment = Enum.TextXAlignment.Left
ServerSub.Parent = DiscordCard

local JoinDiscordBtn = Instance.new("TextButton")
JoinDiscordBtn.Size = UDim2.new(0, 75, 0, 22)
JoinDiscordBtn.Position = UDim2.new(1, -82, 0.5, -11)
JoinDiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
JoinDiscordBtn.Text = Translations[currentLang].CopyBtn
JoinDiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinDiscordBtn.TextSize = 9.5
JoinDiscordBtn.Font = Enum.Font.GothamBold
JoinDiscordBtn.Parent = DiscordCard

local JoinCorner = Instance.new("UICorner")
JoinCorner.CornerRadius = UDim.new(0, 5)
JoinCorner.Parent = JoinDiscordBtn

-- Card TikTok (@royah36)
local TikTokCard = Instance.new("Frame")
TikTokCard.Size = UDim2.new(1, -24, 0, 38)
TikTokCard.Position = UDim2.new(0, 12, 0, 186)
TikTokCard.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
TikTokCard.Parent = MainFrame

local TikTokCorner = Instance.new("UICorner")
TikTokCorner.CornerRadius = UDim.new(0, 6)
TikTokCorner.Parent = TikTokCard

local TikTokStroke = Instance.new("UIStroke")
TikTokStroke.Color = Color3.fromRGB(254, 44, 85)
TikTokStroke.Parent = TikTokCard

local TikTokIcon = Instance.new("ImageLabel")
TikTokIcon.Size = UDim2.new(0, 24, 0, 24)
TikTokIcon.Position = UDim2.new(0, 7, 0.5, -12)
TikTokIcon.BackgroundTransparency = 1
TikTokIcon.Image = TIKTOK_ICON_URL
TikTokIcon.Parent = TikTokCard

local TikTokName = Instance.new("TextLabel")
TikTokName.Size = UDim2.new(0, 160, 0, 14)
TikTokName.Position = UDim2.new(0, 38, 0, 4)
TikTokName.BackgroundTransparency = 1
TikTokName.Text = "TikTok: @royah36"
TikTokName.TextColor3 = Color3.fromRGB(255, 255, 255)
TikTokName.TextSize = 10
TikTokName.Font = Enum.Font.GothamBold
TikTokName.TextXAlignment = Enum.TextXAlignment.Left
TikTokName.Parent = TikTokCard

local TikTokSub = Instance.new("TextLabel")
TikTokSub.Size = UDim2.new(0, 160, 0, 12)
TikTokSub.Position = UDim2.new(0, 38, 0, 20)
TikTokSub.BackgroundTransparency = 1
TikTokSub.Text = Translations[currentLang].TikTokSub
TikTokSub.TextColor3 = Color3.fromRGB(254, 44, 85)
TikTokSub.TextSize = 8.5
TikTokSub.Font = Enum.Font.GothamMedium
TikTokSub.TextXAlignment = Enum.TextXAlignment.Left
TikTokSub.Parent = TikTokCard

local CopyTikTokBtn = Instance.new("TextButton")
CopyTikTokBtn.Size = UDim2.new(0, 75, 0, 22)
CopyTikTokBtn.Position = UDim2.new(1, -82, 0.5, -11)
CopyTikTokBtn.BackgroundColor3 = Color3.fromRGB(254, 44, 85)
CopyTikTokBtn.Text = Translations[currentLang].CopyBtn
CopyTikTokBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyTikTokBtn.TextSize = 9.5
CopyTikTokBtn.Font = Enum.Font.GothamBold
CopyTikTokBtn.Parent = TikTokCard

local TikTokBtnCorner = Instance.new("UICorner")
TikTokBtnCorner.CornerRadius = UDim.new(0, 5)
TikTokBtnCorner.Parent = CopyTikTokBtn

-- Cập nhật Ngôn ngữ
local function UpdateLanguage()
    local t = Translations[currentLang]
    TitleLabel.Text = t.Title
    InputBox.PlaceholderText = t.Placeholder
    GetKeyBtn.Text = t.GetKey
    CheckKeyBtn.Text = t.CheckKey
    StatusMsg.Text = t.DefaultStatus
    ServerSub.Text = t.DiscordSub
    TikTokSub.Text = t.TikTokSub
    JoinDiscordBtn.Text = t.CopyBtn
    CopyTikTokBtn.Text = t.CopyBtn
    LangBtn.Text = t.LangToggleText
end

LangBtn.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "VI") and "EN" or "VI"
    UpdateLanguage()
end)

-- Hiệu ứng & Sự kiện
local function PlayBounce(btn)
    local origSize = btn.Size
    local origPos = btn.Position
    local shrinkSize = UDim2.new(origSize.X.Scale, origSize.X.Offset - 2, origSize.Y.Scale, origSize.Y.Offset - 2)
    local shrinkPos = UDim2.new(origPos.X.Scale, origPos.X.Offset + 1, origPos.Y.Scale, origPos.Y.Offset + 1)
    
    local t1 = TweenService:Create(btn, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = shrinkSize, Position = shrinkPos})
    local t2 = TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize, Position = origPos})
    t1:Play()
    t1.Completed:Connect(function() t2:Play() end)
end

local function SetClipboardSafe(text)
    if setclipboard then setclipboard(text) elseif toclipboard then toclipboard(text) end
end

local function PlaySuccessFadeOut()
    local duration = 0.35
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

    TweenService:Create(MainFrame, tweenInfo, {
        Position = UDim2.new(0.5, 0, 0.55, 0),
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

CopyTikTokBtn.MouseButton1Click:Connect(function()
    PlayBounce(CopyTikTokBtn)
    SetClipboardSafe(TIKTOK_URL)
    
    StatusBanner.BackgroundColor3 = Color3.fromRGB(60, 20, 35)
    StatusMsg.TextColor3 = Color3.fromRGB(254, 100, 130)
    StatusMsg.Text = Translations[currentLang].CopyTikTokStatus
    
    CopyTikTokBtn.Text = Translations[currentLang].CopiedBtn
    task.delay(2, function()
        if CopyTikTokBtn and CopyTikTokBtn.Parent then
            CopyTikTokBtn.Text = Translations[currentLang].CopyBtn
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
