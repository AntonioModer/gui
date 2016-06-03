local Path, gui = ...
local Console = {}
local Font = love.graphics.newFont(gui.Fonts["Mode Nine"], 14)

local function CanDelete(TextArea, Position, Length, Line)
	if Line >= #TextArea.Text.Line then
		return true
	end
end

function Console:Init()
	local Width, Height = self:GetDimensions()
	
	self.Layout.TextArea = gui.create("TextArea", 0, 0, Width, Height, self)
	self.Layout.TextArea.Layout.BackgroundColor = {0, 0, 0, 255}
	self.Layout.TextArea.Text.Font = Font
	self.Layout.TextArea.Text.Color = {200, 200, 200, 255}
	self.Layout.TextArea.CanDelete = CanDelete
end

function Console:UpdateLayout()
	local Width, Height = self:GetDimensions()
	self.Layout.TextArea:SetDimensions(Width, Height)
end

function Console:Render()
end

return Console