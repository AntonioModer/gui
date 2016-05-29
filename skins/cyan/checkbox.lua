local Path, gui = ...
local CheckBox = {}

CheckBox.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)
CheckBox.Checked = love.graphics.newImage(Path.."/Checked Checkbox-24.png")
CheckBox.Unchecked = love.graphics.newImage(Path.."/Unchecked Checkbox-24.png")

function CheckBox:Init()
	self.Text:SetColor(80, 80, 80, 255)
	self.Text:SetFont(CheckBox.TextFont)
end

function CheckBox:MousePressed()
	if not self.Disabled then
		self.Status = not self.Status
		self.Changed = true
	end
end

function CheckBox:MouseEnter()
	self.Changed = true
end

function CheckBox:MouseExit()
	self.Changed = true
end

function CheckBox:Render()
	local Width, Height = self:GetDimensions()

	if self.IsHover then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(220, 220, 220, 255)
	end
	
	if self.Status then
		love.graphics.draw(CheckBox.Checked, 0, 0, 0, Height/24, Height/24)
	else
		love.graphics.draw(CheckBox.Unchecked, 0, 0, 0, Height/24, Height/24)
	end
	
	self.Text:Draw(Height + 3, (Height - self.Text:getHeight())/2)
end

return CheckBox