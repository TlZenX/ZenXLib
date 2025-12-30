--// NightX UI Library (Final)
local NightX = {}
NightX.__index = NightX

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

--// GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "NightX_UI"
Gui.ResetOnSpawn = false
Gui.Parent = CoreGui

--// OPEN BUTTON (RedzHub Style)
local OpenBtn = Instance.new("ImageButton")
OpenBtn.Parent = Gui
OpenBtn.Size = UDim2.fromOffset(45,45)
OpenBtn.Position = UDim2.new(1, -55, 0.5, -22)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
OpenBtn.Image = "rbxassetid://130173771089629"
OpenBtn.AutoButtonColor = false
OpenBtn.BorderSizePixel = 0
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0,6)

--// MAIN WINDOW
local Main = Instance.new("Frame")
Main.Parent = Gui
Main.Size = UDim2.fromOffset(430, 300)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(14,14,14)
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

--// TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Text = "NightX Hub"

--// TABS
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.fromOffset(120, 245)
Tabs.Position = UDim2.fromOffset(10, 45)
Tabs.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout", Tabs)
TabLayout.Padding = UDim.new(0,6)

--// CONTENT
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.fromOffset(270, 240)
Content.Position = UDim2.fromOffset(145, 45)
Content.BackgroundTransparency = 1

--// TOGGLE UI
OpenBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--// WINDOW API
function NightX:CreateWindow(text)
	Title.Text = text or "NightX Hub"
	return self
end

--// TAB API
function NightX:CreateTab(name)
	local TabBtn = Instance.new("TextButton", Tabs)
	TabBtn.Size = UDim2.fromOffset(120, 32)
	TabBtn.Text = name
	TabBtn.Font = Enum.Font.GothamBold
	TabBtn.TextSize = 13
	TabBtn.TextColor3 = Color3.new(1,1,1)
	TabBtn.BackgroundColor3 = Color3.fromRGB(45,0,0)
	TabBtn.BorderSizePixel = 0
	Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0,6)

	local Page = Instance.new("Frame", Content)
	Page.Size = UDim2.fromScale(1,1)
	Page.Visible = false
	Page.BackgroundTransparency = 1

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

	local Tab = {}

	function Tab:AddButton(text, callback)
		local Btn = Instance.new("TextButton", Page)
		Btn.Size = UDim2.fromOffset(260, 36)
		Btn.Text = text
		Btn.Font = Enum.Font.Gotham
		Btn.TextSize = 14
		Btn.TextColor3 = Color3.new(1,1,1)
		Btn.BackgroundColor3 = Color3.fromRGB(90,0,0)
		Btn.BorderSizePixel = 0
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

		Btn.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
	end

	function Tab:AddLabel(text)
		local L = Instance.new("TextLabel", Page)
		L.Size = UDim2.fromOffset(260, 28)
		L.BackgroundTransparency = 1
		L.TextWrapped = true
		L.Text = text
		L.TextColor3 = Color3.fromRGB(200,200,200)
		L.Font = Enum.Font.Gotham
		L.TextSize = 13
	end

	return Tab
end

return NightX
