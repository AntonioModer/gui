local Path, gui = ...
local TreeViewNode = {}

function TreeViewNode:Init()
	self.Layout.TextFont = self.Parent.Layout.TextFont
	self.Layout.TextColor = self.Parent.Layout.TextColor
	self.Layout.HeightOffset = self.Text:getHeight()
	
	self.Text:SetColor(unpack(self.Layout.TextColor))
	self.Text:SetFont(self.Layout.TextFont)
end

function TreeViewNode:UpdateLayout()
	self.Layout.HeightOffset = self.Text:getHeight() + 2
	for Index, Child in pairs(self.ChildrenRender) do
		Child.x = 5
		Child.y = self.Layout.HeightOffset
		
		self.Layout.HeightOffset = self.Layout.HeightOffset + Child:GetHeight() + 2
	end
	
	self.Text:SetColor(unpack(self.Layout.TextColor))
	self.Text:SetFont(self.Layout.TextFont)
end

function TreeViewNode:Render()
	love.graphics.setColor(self.Layout.TextColor)
	love.graphics.setFont(self.Layout.TextFont)
	love.graphics.print("+", 0, 0)
	self.Text:Draw(10, 0)
end

return TreeViewNode