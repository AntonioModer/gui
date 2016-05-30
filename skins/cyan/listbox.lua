local Path, gui = ...
local ListBox = {}

ListBox.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)

local function RoundedScissor()
	gui.graphics.roundedbox("fill", 4, 0, 0, ListBox.Width, ListBox.Height)
end

local function SliderMoved(Slider)
	Slider.Parent.Changed = true
end

function ListBox:MouseMoved()
	self.Changed = true
end

function ListBox:MouseExit()
	self.Changed = true
end

function ListBox:WheelMoved(x, y)
	self.Layout.Slider:SetValue(self.Layout.Slider.Value - y * 5)
	self.Changed = true
end

function ListBox:MousePressed(MouseX, MouseY, Button, IsTouch)
	if Button == 1 then
		local Width, Height = self:GetDimensions()
		local HeightOffset = -self.Layout.Slider:GetValue() + 2.5
		for i, Item in pairs(self.Item) do
			local ItemHeight = Item:getHeight()
			if HeightOffset >= -ItemHeight then
				if HeightOffset > Height then
					break
				elseif MouseY > HeightOffset and MouseY <= HeightOffset + ItemHeight then
					self:OnSelect(i)
					self.Selected = i
					self.Changed = true
					break
				end
			end
			HeightOffset = HeightOffset + ItemHeight
		end
	end
end

function ListBox:Init()
	local Width, Height = self:GetDimensions()
	
	self.Layout.Slider = gui.create("VSlider", Width - 15, 0, 15, Height, self)
	self.Layout.Slider.OnValue = SliderMoved
end

function ListBox:UpdateLayout()
	local Width, Height = self:GetDimensions()
	
	self.Layout.Slider:SetDimensions(15, Height)
	self.Layout.Slider:SetPosition(Width - 15, 0)
	self.Layout.Slider.Hidden = self.Layout.Slider.Min >= self.Layout.Slider.Max
end

function ListBox:UpdateItems()
	local HeightOffset = 0
	for i, Item in pairs(self.Item) do
		HeightOffset = HeightOffset + Item:getHeight()
	end
	
	self.Layout.Slider.Min = self:GetHeight()
	self.Layout.Slider.Max = math.max(self.Layout.Slider.Min, HeightOffset - self.Layout.Slider.Min + 4.5)
	self.Changed = true
end

function ListBox:Render()
	local Width, Height = self:GetDimensions()
	ListBox.Width, ListBox.Height = Width, Height
	
	love.graphics.setColor(80, 80, 80, 255)
	gui.graphics.roundedbox("line", 4, 1, 1, Width - 2, Height - 2)
	
	love.graphics.setColor(255, 255, 255, 255)
	gui.graphics.roundedbox("fill", 4, 1, 1, Width - 2, Height - 2)
	
	love.graphics.stencil(RoundedScissor)
	love.graphics.setStencilTest("greater", 0)
	
	local HeightOffset = -self.Layout.Slider:GetValue() + 2.5
	for i, Item in pairs(self.Item) do
		local ItemHeight = Item:getHeight()
		
		if HeightOffset > -ItemHeight then
			if HeightOffset > Height then
				break
			end
			
			Item:Draw(5, HeightOffset)
			
			if self.Selected == i then
				love.graphics.setColor(0, 0, 0, 70)
				love.graphics.rectangle("fill", 0, HeightOffset, Width, ItemHeight)
			elseif self.IsHover and self.IsHover.y > HeightOffset and self.IsHover.y <= HeightOffset + ItemHeight then
				love.graphics.setColor(75, 75, 75, 70)
				love.graphics.rectangle("fill", 0, HeightOffset, Width, ItemHeight)
			end
		end
		
		HeightOffset = HeightOffset + ItemHeight
	end
	love.graphics.setStencilTest()
end

return ListBox