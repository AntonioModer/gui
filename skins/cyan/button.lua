local Path, gui = ...
local Button = {}

Button.Image = love.image.newImageData(1, 20)
for y = 0, 19 do
	Button.Image:setPixel(0, y, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19)
end
Button.Image = love.graphics.newImage(Button.Image)
Button.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)

function Button:Init()
	self.Layout.Color = {unpack(self.Color)}
	self.Text:SetColor(80, 80, 80, 255)
	self.Text:SetFont(Button.TextFont)
end

function Button:MouseEnter()
	self.Changed = true
end

function Button:MouseExit()
	self.Changed = true
end

function Button:MousePressed()
	self.Changed = true
end

function Button:MouseReleased()
	self.Changed = true
end

function Button:Render()
	local Width, Height = self:GetDimensions()
	
	love.graphics.setColor(100, 100, 100, 255)
	love.graphics.rectangle("line", 1, 1, Width - 2, Height - 2)
	
	if self.IsPressed then
		love.graphics.setColor(self.ColorPressed)
		love.graphics.draw(Button.Image, 1, 1, 0, Width - 2, (Height - 2)/20)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2))
	elseif self.IsHover then
		love.graphics.setColor(self.ColorHover)
		love.graphics.draw(Button.Image, 1, 1, 0, Width - 2, (Height - 3)/20)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2) - 1)
	else
		love.graphics.setColor(self.Color)
		love.graphics.draw(Button.Image, 1, 1, 0, Width - 2, (Height - 3)/20)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2) - 1)
	end
end

return Button