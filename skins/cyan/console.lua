local Path, gui = ...
local Console = {}
local Font = love.graphics.newFont(gui.Fonts["Mode Nine"], 14)

function Console:Init()
	local Width, Height = self:GetDimensions()
	
	self.Layout.TextArea = gui.create("TextArea", 0, 0, Width, Height, self)
	self.Layout.TextArea:SetBackgroundColor(0, 0, 0, 255)
	self.Layout.TextArea.Text.Font = Font
	self.Layout.TextArea.Text.Color = {200, 200, 200, 255}
end

function Console:UpdateLayout()
	local Width, Height = self:GetDimensions()
	self.Layout.TextArea:SetDimensions(Width, Height)
end

function Console:Render()
end

return Console