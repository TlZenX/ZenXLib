--// ZenX / NightX UI Library
--// Final Version (RedzHub-style)
--// Made for Night

local NightX = {}
NightX.__index = NightX

--// Services
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

--// ScreenGui
local Gui = Instance.new("ScreenGui")
Gui.Name = "NightX_UI"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = CoreGui

--// OPEN BUTTON (RedzHub Style)
local OpenBtn = Instance.new("ImageButton")
OpenBtn.Size = UDim2.fromOffset(42, 42)
OpenBtn.Position = UDim2.new(1, -52, 0.5, -21)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
OpenBtn.Image = "rbxassetid://130173771089629"
OpenBtn.AutoButtonColor = false
OpenBtn.Parent = Gui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0,6)

local Stroke = Instance.new("UIStroke", OpenBtn)
Stroke.Color = Color3.fromRGB(180,0,0)
Stroke.Thickness = 1.5

--// MAIN WINDOW
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(440, 300)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(12,12,12)
Main.Visible = false
Main.Parent = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

--// WINDOW STROKE
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(150,0,0)
MainStroke.Thickness = 1

--// TITLE BAR
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "NightX Hub"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Main

--// TAB HOLDER
local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.fromOffset(120, 245)
Tabs.Position = UDim2.fromOffset(10, 45)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

local TabsLayout = Instance.new("UIListLayout", Tabs)
TabsLayout.Padding = UDim.new(0,6)

--// CONTENT HOLDER
local Content = Instance.new("Frame")
Content.Size = UDim2.fromOffset(290, 245)
Content.Position = UDim2.fromOffset(140, 45)
Content.BackgroundTransparency = 1
Content.Parent = Main

--// OPEN / CLOSE ANIMATION
local function ToggleUI()
	Main.Visible = not Main.Visible
	if Main.Visible then
		Main.Size = UDim2.fromOffset(0, 0)
		TweenService:Create(
			Main,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Size = UDim2.fromOffset(440, 300)}
		):Play()
	end
end

OpenBtn.MouseButton1Click:Connect(ToggleUI)

--// WINDOW API
function NightX:CreateWindow(title)
	Title.Text = title or "NightX Hub"
	return self
end

--// TAB API
function NightX:CreateTab(name)
	local TabButton = Instance.new("TextButton")
	TabButton.Size = UDim2.fromOffset(120, 32)
	TabButton.BackgroundColor3 = Color3.fromRGB(35,0,0)
	TabButton.Text = name
	TabButton.TextColor3 = Color3.new(1,1,1)
	TabButton.Font = Enum.Font.GothamBold
	TabButton.TextSize = 13
	TabButton.Parent = Tabs
	Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0,6)

	local Page = Instance.new("Frame")
	Page.Size = UDim2.fromScale(1,1)
	Page.Visible = false
	Page.BackgroundTransparency = 1
	Page.Parent = Content

	local PageLayout = Instance.new("UIListLayout", Page)
	PageLayout.Padding = UDim.new(0,8)

	TabButton.MouseButton1Click:Connect(function()
		for _,v in pairs(Content:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		Page.Visible = true
	end)

	if #Content:GetChildren() == 1 then
		Page.Visible = true
	end

	local Tab = {}

	function Tab:AddButton(text, callback)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.fromOffset(280, 36)
		Btn.BackgroundColor3 = Color3.fromRGB(90,0,0)
		Btn.Text = text
		Btn.TextColor3 = Color3.new(1,1,1)
		Btn.Font = Enum.Font.Gotham
		Btn.TextSize = 14
		Btn.Parent = Page
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

		Btn.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
	end

	function Tab:AddLabel(text)
		local L = Instance.new("TextLabel")
		L.Size = UDim2.fromOffset(280, 30)
		L.BackgroundTransparency = 1
		L.TextWrapped = true
		L.TextXAlignment = Left
		L.Text = text
		L.TextColor3 = Color3.fromRGB(200,200,200)
		L.Font = Enum.Font.Gotham
		L.TextSize = 13
		L.Parent = Page
	end

	return Tab
end

return NightX
