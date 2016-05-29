local Path, gui = ...
local Slider = {}

Slider.Up = love.graphics.newImage(Path.."/Up-14.png")
Slider.Down = love.graphics.newImage(Path.."/Down-14.png")

local function SliderButtonDrag(Button, x, y, dx, dy)
	local Slider = Button.Parent
	if not Slider.Disabled then
		local Height = Slider:GetHeight()
		local Max = math.max(Height - (Height -  32) * Slider.Min / Slider.Max - 32, 1)
		local Position = math.min(math.max(Button:GetVerticalPosition() + dy, 16), Max + 16)
		
		Button:SetVerticalPosition(math.floor(Position))
		Slider.Value = (Position - 16) / Max * Slider.Max
		Slider:OnValue(Slider.Value)
	end
	Button:OnMouseDrag(x, y, dx, dy)
end

local function SliderButtonUP(Button)
	if Button.IsPressed then
		local Slider = Button.Parent
		if not Slider.Disabled then
			local Button = Slider.Layout.Button
			local Height = Slider:GetHeight()
			local Max = math.max(Height - (Height -  32) * Slider.Min / Slider.Max - 32, 1)
			local Position = math.min(math.max(Button:GetVerticalPosition() - 2, 16), Max + 16)
			
			Button:SetVerticalPosition(math.floor(Position))
			Slider.Value = (Position - 16) / Max * Slider.Max
			Slider:OnValue(Slider.Value)
		end
	end
end

local function SliderButtonDown(Button)
	if Button.IsPressed then
		local Slider = Button.Parent
		if not Slider.Disabled then
			local Button = Slider.Layout.Button
			local Height = Slider:GetHeight()
			local Max = math.max(Height - (Height -  32) * Slider.Min / Slider.Max - 32, 1)
			local Position = math.min(math.max(Button:GetVerticalPosition() + 2, 16), Max + 16)
			
			Button:SetVerticalPosition(math.floor(Position))
			Slider.Value = (Position - 16) / Max * Slider.Max
			Slider:OnValue(Slider.Value)
		end
	end
end

function Slider:Init()
	local Width, Height = self:GetDimensions()
	
	self.Layout.Up = gui.create("RoundedButton", "", 0, 0, Width, 16, 4, self)
	self.Layout.Up:SetIcon(Slider.Up)
	self.Layout.Up.Update = SliderButtonUP
	
	self.Layout.Down = gui.create("RoundedButton", "", 0, 0, Width, 16, 4, self)
	self.Layout.Down:SetIcon(Slider.Down)
	self.Layout.Down.Update = SliderButtonDown
	
	self.Layout.Button = gui.create("RoundedButton", "", 0, 16, Width, Height - 32, 4, self)
	self.Layout.Button.Layout.Image = nil
	self.Layout.Button.MouseDrag = SliderButtonDrag
end

function Slider:UpdateValue(Value)
	self.Layout.Button:SetVerticalPosition(16 + Value * (self:GetHeight() - 32 - self.Layout.Button:GetHeight()) / self.Max)
end

function Slider:UpdateLayout()
	local Width, Height = self:GetDimensions()
	
	self.Layout.Up:SetDimensions(Width, 16)
	self.Layout.Down:SetDimensions(Width, 16)
	self.Layout.Down:SetPosition(0, Height - 16)
	self.Layout.Button:SetDimensions(Width, math.floor((Height - 32) * self.Min/self.Max))
end

function Slider:Render(dt)
	local Width, Height = self:GetDimensions()
	
	love.graphics.setColor(80, 80, 80, 255)
	gui.graphics.roundedbox("line", 4, 1, 1, Width - 2, Height - 2)
	
	love.graphics.setColor(200, 200, 200, 255)
	gui.graphics.roundedbox("fill", 4, 1, 1, Width - 2, Height - 2)
end

return Slider