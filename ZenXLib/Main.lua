--// NightX UI Library
local NightX = {}
NightX.__index = NightX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

--// Create ScreenGui
local Gui = Instance.new("ScreenGui")
Gui.Name = "NightX_UI"
Gui.ResetOnSpawn = false
Gui.Parent = CoreGui

--// Toggle Button
local Toggle = Instance.new("TextButton", Gui)
Toggle.Size = UDim2.fromOffset(110, 32)
Toggle.Position = UDim2.fromScale(0, 0.45)
Toggle.Text = "NightX"
Toggle.BackgroundColor3 = Color3.fromRGB(120,0,0)
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 14
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,8)

--// Window
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(420, 300)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

--// Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Text = "NightX Hub"

--// Tabs Holder
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.fromOffset(110, 250)
Tabs.Position = UDim2.fromOffset(10, 45)
Tabs.BackgroundTransparency = 1

local UIListTabs = Instance.new("UIListLayout", Tabs)
UIListTabs.Padding = UDim.new(0,6)

--// Content Holder
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.fromOffset(270, 240)
Content.Position = UDim2.fromOffset(140, 45)
Content.BackgroundTransparency = 1

--// Toggle UI
Toggle.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--// Window API
function NightX:CreateWindow(text)
	Title.Text = text or "NightX Hub"
	return self
end

--// Create Tab
function NightX:CreateTab(name)
	local TabBtn = Instance.new("TextButton", Tabs)
	TabBtn.Size = UDim2.fromOffset(110, 30)
	TabBtn.Text = name
	TabBtn.Font = Enum.Font.GothamBold
	TabBtn.TextSize = 13
	TabBtn.TextColor3 = Color3.new(1,1,1)
	TabBtn.BackgroundColor3 = Color3.fromRGB(40,0,0)
	Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0,6)

	local Page = Instance.new("Frame", Content)
	Page.Size = UDim2.fromScale(1,1)
	Page.Visible = false
	Page.BackgroundTransparency = 1

	local Layout = Instance.new("UIListLayout", Page)
	Layout.Padding = UDim.new(0,8)

	TabBtn.MouseButton1Click:Connect(function()
		for _,v in pairs(Content:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		Page.Visible = true
	end)

	-- Auto open first tab
	if #Content:GetChildren() == 1 then
		Page.Visible = true
	end

	local TabAPI = {}

	function TabAPI:AddButton(text, callback)
		local Btn = Instance.new("TextButton", Page)
		Btn.Size = UDim2.fromOffset(260, 34)
		Btn.Text = text
		Btn.Font = Enum.Font.Gotham
		Btn.TextSize = 14
		Btn.TextColor3 = Color3.new(1,1,1)
		Btn.BackgroundColor3 = Color3.fromRGB(90,0,0)
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

		Btn.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
	end

	function TabAPI:AddLabel(text)
		local Label = Instance.new("TextLabel", Page)
		Label.Size = UDim2.fromOffset(260, 30)
		Label.BackgroundTransparency = 1
		Label.TextWrapped = true
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200,200,200)
		Label.Font = Enum.Font.Gotham
		Label.TextSize = 13
	end

	return TabAPI
end

return NightX
