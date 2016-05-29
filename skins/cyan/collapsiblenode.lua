local Path, gui = ...
local CollapsibleNode = {}

CollapsibleNode.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)

function CollapsibleNode:Init()
	self.Layout.Color = {unpack(self.Color)}
	self.Layout.Image = CollapsibleNode.Image
	
	self.Text:SetColor(80, 80, 80, 255)
	self.Text:SetFont(CollapsibleNode.TextFont)
end

function CollapsibleNode:MouseEnter()
	self.Changed = true
end

function CollapsibleNode:MouseExit()
	self.Changed = true
end

function CollapsibleNode:MouseMoved(x, y, dx, dy)
	if (y - dy <= self.Parent.NodeHeight and y > self.Parent.NodeHeight) or (y - dy > self.Parent.NodeHeight and y <= self.Parent.NodeHeight) then
		self.Changed = true
	end
end

function CollapsibleNode:MousePressed()
	self.Changed = true
end

function CollapsibleNode:MouseReleased()
	self.Changed = true
end

function CollapsibleNode:Render()
	local Width, Height, Radius = self:GetWidth(), self.Parent.NodeHeight, self.Radius
	CollapsibleNode.Width, CollapsibleNode.Height, CollapsibleNode.Radius = Width, Height, Radius
	
	if self.Open then
		love.graphics.setColor(130, 130, 130, 255)
		gui.graphics.roundedbox("line", self.Radius, 1, Height, Width - 2, self:GetHeight() - Height - 1)
		
		love.graphics.setColor(200, 200, 200, 255)
		gui.graphics.roundedbox("fill", self.Radius, 1, Height, Width - 2, self:GetHeight() - Height - 1)
	end
	
	love.graphics.setColor(100, 100, 100, 255)
	gui.graphics.roundedbox("line", self.Radius, 1, 1, Width - 2, Height - 2)
	
	if self.IsPressed then
		love.graphics.setColor(self.ColorPressed)
		gui.graphics.roundedbox("fill", Radius, 1, 1, Width - 2, Height - 2)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2))
	elseif self.IsHover and self.IsHover.y <= Height then
		love.graphics.setColor(self.ColorHover)
		gui.graphics.roundedbox("fill", Radius, 1, 1, Width - 2, Height - 2)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2) - 1)
	else
		love.graphics.setColor(self.Color)
		gui.graphics.roundedbox("fill", Radius, 1, 1, Width - 2, Height - 2)

		if self.Image then
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw((Width - self.Text:getWidth())/2, (Height - self.Text:getHeight())/2 - 1)
	end
end

return CollapsibleNode