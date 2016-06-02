local gui = ...
local Element = gui.register("Label", "Element")

function Element:Create(Text, x, y, Parent)
	Parent = Parent or gui.Desktop

	self:SetParent(Parent)
	self:SetPosition(x, y)
	self:SetText(Text)
	self:Init()
	
	return self
end

function Element:GetWidth()
	return self.Text:getWidth()
end

function Element:GetHeight()
	return self.Text:getHeight()
end

function Element:SetText(Text)
	self.Base.SetText(self, Text)
	self.Parent:AdviseChildDimensions(self, self:GetWidth(), self:GetHeight())
	return self
end