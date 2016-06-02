local Path, gui = ...
local Button = {}

Button.Image = love.image.newImageData(1, 20)
for y = 0, 19 do
	Button.Image:setPixel(0, y, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19)
end
Button.Image = love.graphics.newImage(Button.Image)
Button.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)

Button.Color = {255, 255, 255, 255}
Button.ColorHover = {240, 240, 240, 255}
Button.ColorPressed = {220, 220, 220, 255}
Button.BorderColor = {100, 100, 100, 255}
Button.ImageColor = {255, 255, 255, 255}
Button.TextColor = {80, 80, 80, 255}

function Button:Init()
	self.Layout.Color = Button.Color
	self.Layout.ColorHover = Button.ColorHover
	self.Layout.ColorPressed = Button.ColorPressed
	self.Layout.BorderColor = Button.BorderColor
	self.Layout.ImageColor = Button.ImageColor
	self.Layout.TextColor = Button.TextColor
	self.Layout.TextFont = Button.TextFont
	
	self.Text:SetColor(self.Layout.TextColor)
	self.Text:SetFont(self.Layout.TextFont)
end

function Button:UpdateLayout()
	self.Text:SetColor(self.Layout.TextColor)
	self.Text:SetFont(self.Layout.TextFont)
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
	
	love.graphics.setColor(self.Layout.BorderColor)
	love.graphics.rectangle("line", 1, 1, Width - 2, Height - 2)
	
	if self.IsPressed then
		love.graphics.setColor(self.Layout.ColorPressed)
		love.graphics.draw(Button.Image, 1, 1, 0, Width - 2, (Height - 2)/20)
		
		if self.Image then
			love.graphics.setColor(self.Layout.ImageColor)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2))
	elseif self.IsHover then
		love.graphics.setColor(self.ColorHover)
		love.graphics.draw(Button.Image, 1, 1, 0, Width - 2, (Height - 3)/20)
		
		if self.Image then
			love.graphics.setColor(self.Layout.ImageColor)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2) - 1)
	else
		love.graphics.setColor(self.Color)
		love.graphics.draw(Button.Image, 1, 1, 0, Width - 2, (Height - 3)/20)
		
		if self.Image then
			love.graphics.setColor(self.Layout.ImageColor)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2) - 1)
	end
end

return Button