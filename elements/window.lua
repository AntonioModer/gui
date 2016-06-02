local gui = ...
local Element = gui.register("Window", "Container")

Element.Closeable = true

function Element:Create(Text, x, y, Width, Height, Parent)
	Parent = Parent or gui.Desktop
	
	self:SetParent(Parent)
	self:SetPosition(x, y)
	self:SetDimensions(Width, Height)
	self:SetText(Text)
	self:Init()
	
	return self
end

function Element:MouseDrag(x, y, dx, dy)
	if self.Grab and not self.Disabled then
		self:SetPosition(self:GetHorizontalPosition() + dx, self:GetVerticalPosition() + dy)
	end
	self:OnMouseDrag(x, y, dx, dy)
end

function Element:CanGrab(x, y, Button, IsTouch)
	local Skin = self:GetSkin()
	if Skin.CanGrab then
		return Skin.CanGrab(x, y, Button, IsTouch)
	end
	return y < 24
end

function Element:MousePressed(x, y, Button, IsTouch)
	if not self.Disabled then
		if self:CanGrab(x, y, Button, IsTouch) then
			self.Grab = true
		end
	end
	self:OnMousePressed(x, y, Button, IsTouch)
end

function Element:MouseReleased(x, y, Button, IsTouch)
	self.Grab = nil
	self:OnMouseReleased(x, y, Button, IsTouch)
end

function Element:SetCloseable(Closeable)
	self.Closeable = Closeable
end

function Element:GetCloseable()
	return self.Closeable
end