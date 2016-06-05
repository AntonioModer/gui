local Path, gui = ...
local TreeView = {}

TreeView.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)
TreeView.TextColor = {80, 80, 80, 255}

TreeView.BorderColor = {80, 80, 80, 255}
TreeView.BackgroundColor = {255, 255, 255, 255}

function TreeView:Init()
	self.Layout.TextFont = TreeView.TextFont
	self.Layout.TextColor = TreeView.TextColor
	
	self.Layout.BorderColor = TreeView.BorderColor
	self.Layout.BackgroundColor = TreeView.BackgroundColor
end

function TreeView:UpdateLayout()
	local HeightOffset = 2
	for Index, Child in pairs(self.ChildrenRender) do
		Child.x = 5
		Child.y = HeightOffset

		HeightOffset = HeightOffset + Child:GetHeight() + 2
	end
end

function TreeView:Render()
	local Width, Height = self:GetDimensions()
	
	love.graphics.setColor(self.Layout.BorderColor)
	love.graphics.rectangle("line", 0, 0, Width, Height)
	
	love.graphics.setColor(self.Layout.BackgroundColor)
	love.graphics.rectangle("fill", 1, 1, Width - 2, Height - 2)
end

return TreeView