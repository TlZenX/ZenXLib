--// ZenX / NightX UI Library v2
--// RedzHub-inspired | By Night

local ZenX = {}
ZenX.__index = ZenX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

--// ScreenGui
local Gui = Instance.new("ScreenGui")
Gui.Name = "ZenX_UI"
Gui.ResetOnSpawn = false
Gui.Parent = CoreGui

--// OPEN BUTTON (RedzHub style)
local OpenBtn = Instance.new("ImageButton")
OpenBtn.Size = UDim2.fromOffset(42, 42)
OpenBtn.Position = UDim2.fromScale(0.01, 0.45)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
OpenBtn.Image = "rbxassetid://130173771089629"
OpenBtn.AutoButtonColor = false
OpenBtn.Parent = Gui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0,8)

--// MAIN WINDOW
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(480, 320)
Main.Position = UDim2.fromScale(-0.6, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(14,14,14)
Main.Visible = false
Main.Parent = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

--// Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,44)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 21
Title.Text = "ZenX Hub"
Title.Parent = Main

--// Tabs Holder
local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.fromOffset(130, 250)
Tabs.Position = UDim2.fromOffset(12, 54)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

local TabsLayout = Instance.new("UIListLayout", Tabs)
TabsLayout.Padding = UDim.new(0,6)

--// Content Holder
local Content = Instance.new("Frame")
Content.Size = UDim2.fromOffset(310, 250)
Content.Position = UDim2.fromOffset(155, 54)
Content.BackgroundTransparency = 1
Content.Parent = Main

--// ANIMATION FUNCTIONS
local function Tween(obj, goal, time, style)
	TweenService:Create(
		obj,
		TweenInfo.new(time or 0.35, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		goal
	):Play()
end

local Opened = false

OpenBtn.MouseButton1Click:Connect(function()
	Opened = not Opened
	Main.Visible = true

	if Opened then
		Tween(Main, {Position = UDim2.fromScale(0.5, 0.5)}, 0.45)
	else
		Tween(Main, {Position = UDim2.fromScale(-0.6, 0.5)}, 0.4)
		task.delay(0.4, function()
			Main.Visible = false
		end)
	end
end)

--// WINDOW API
function ZenX:CreateWindow(title)
	Title.Text = title or "ZenX Hub"
	return self
end

--// TAB API
function ZenX:CreateTab(name)
	local TabBtn = Instance.new("TextButton")
	TabBtn.Size = UDim2.fromOffset(130, 32)
	TabBtn.Text = name
	TabBtn.Font = Enum.Font.GothamBold
	TabBtn.TextSize = 13
	TabBtn.TextColor3 = Color3.new(1,1,1)
	TabBtn.BackgroundColor3 = Color3.fromRGB(45,0,0)
	TabBtn.Parent = Tabs
	Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0,8)

	local Page = Instance.new("Frame")
	Page.Size = UDim2.fromScale(1,1)
	Page.Visible = false
	Page.BackgroundTransparency = 1
	Page.Parent = Content

	local Layout = Instance.new("UIListLayout", Page)
	Layout.Padding = UDim.new(0,8)

	TabBtn.MouseButton1Click:Connect(function()
		for _,v in ipairs(Content:GetChildren()) do
			if v:IsA("Frame") then
				v.Visible = false
			end
		end
		Page.Visible = true
	end)

	if #Content:GetChildren() == 1 then
		Page.Visible = true
	end

	local TabAPI = {}

	function TabAPI:AddButton(text, callback)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.fromOffset(300, 36)
		Btn.Text = text
		Btn.Font = Enum.Font.Gotham
		Btn.TextSize = 14
		Btn.TextColor3 = Color3.new(1,1,1)
		Btn.BackgroundColor3 = Color3.fromRGB(90,0,0)
		Btn.Parent = Page
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,10)

		Btn.MouseEnter:Connect(function()
			Tween(Btn, {BackgroundColor3 = Color3.fromRGB(130,0,0)}, 0.2)
		end)

		Btn.MouseLeave:Connect(function()
			Tween(Btn, {BackgroundColor3 = Color3.fromRGB(90,0,0)}, 0.2)
		end)

		Btn.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
	end

	function TabAPI:AddLabel(text)
		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.fromOffset(300, 30)
		Label.BackgroundTransparency = 1
		Label.TextWrapped = true
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200,200,200)
		Label.Font = Enum.Font.Gotham
		Label.TextSize = 13
		Label.Parent = Page
	end

	return TabAPI
end

return ZenX
