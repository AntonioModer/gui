local gui = ...
local Element = gui.register("RoundedButton", "Element")

Element.Color = {255, 255, 255, 255}
Element.ColorHover = {240, 240, 240, 255}
Element.ColorPressed = {220, 220, 220, 255}

function Element:Create(Text, x, y, Width, Height, Radius, Parent)
	Parent = Parent or gui.Desktop

	self:SetParent(Parent)
	self:SetPosition(x, y)
	self:SetDimensions(Width, Height, Radius)
	self:SetText(Text)
	self:Init()
	
	return self
end

function Element:SetDimensions(Width, Height, Radius)
	self.Radius = Radius or self.Radius
	self.Base.SetDimensions(self, Width, Height)
end

function Element:GetDimensions()
	return self:GetWidth(), self:GetHeight(), self.Radius
end

function Element:SetColor(R, G, B, A)
	self.Color = {R or 255, G or 255, B or 255, A or 255}
	self.Changed = true
end

function Element:SetColorHover(R, G, B, A)
	self.ColorHover = {R or 240, G or 240, B or 240, A or 255}
	self.Changed = true
end

function Element:SetColorPressed(R, G, B, A)
	self.ColorPressed = {R or 220, G or 220, B or 220, A or 255}
	self.Changed = true
end

function Element:SetIcon(Image)
	self.Image = Image
	self.Changed = true
end