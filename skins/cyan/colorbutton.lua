local ColorButton = {}

ColorButton.Image = love.image.newImageData(1, 20)
for y = 0, 19 do
	ColorButton.Image:setPixel(0, y, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19)
end
ColorButton.Image = love.graphics.newImage(ColorButton.Image)

function ColorButton:Init()
	self.Layout.Color = {unpack(self.Color)}
end

function ColorButton:MouseEnter()
	self.Changed = true
end

function ColorButton:MouseExit()
	self.Changed = true
end

function ColorButton:MouseEnter()
	self.Changed = true
end

function ColorButton:MouseExit()
	self.Changed = true
end

function ColorButton:Render(dt, x, y)
	local Width, Height = self:GetDimensions()
	
	love.graphics.setColor(100, 100, 100, 255)
	love.graphics.rectangle("line", x, y, Width, Height)
	
	if self.IsPressed then
		love.graphics.setColor(self.ColorPressed)
		love.graphics.draw(ColorButton.Image, x, y, 0, Width, Height/20)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, x + math.floor((Width - self.Image:getWidth())/2), y + math.floor((Height - self.Image:getHeight())/2))
		end
	elseif self.IsHover then
		love.graphics.setColor(self.ColorHover)
		love.graphics.draw(ColorButton.Image, x, y, 0, Width, (Height - 1)/20)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, x + math.floor((Width - self.Image:getWidth())/2), y + math.floor((Height - self.Image:getHeight())/2))
		end
	else
		love.graphics.setColor(self.Color)
		love.graphics.draw(ColorButton.Image, x, y, 0, Width, (Height - 1)/20)
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, x + math.floor((Width - self.Image:getWidth())/2), y + math.floor((Height - self.Image:getHeight())/2))
		end
	end
end

return ColorButton