local Path, gui = ...
local Button = {}

Button.Image = love.image.newImageData(1, 20)
for y = 0, 19 do
	Button.Image:setPixel(0, y, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19)
end
Button.Image = love.graphics.newImage(Button.Image)
Button.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)

local function DrawButton()
	gui.graphics.roundedbox("fill", Button.Radius, 1, 1, Button.Width - 2, Button.Height - 2)
end

function Button:Init()
	self.Layout.Color = {unpack(self.Color)}
	self.Layout.Image = Button.Image
	
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

function Button:Render(dt)
	local Width, Height, Radius = self:GetDimensions()
	Button.Width, Button.Height, Button.Radius = Width, Height, Radius
	
	love.graphics.setColor(100, 100, 100, 255)
	gui.graphics.roundedbox("line", self.Radius, 1, 1, Width - 2, Height - 2)
	
	love.graphics.stencil(DrawButton)
	
	if self.IsPressed then
		love.graphics.setColor(self.ColorPressed)
		if self.Layout.Image then
			love.graphics.setStencilTest("greater", 0)
			love.graphics.draw(self.Layout.Image, 0, 0, 0, Button.Width, Button.Height/20)
			love.graphics.setStencilTest()
		else
			gui.graphics.roundedbox("fill", Radius, 1, 1, Width - 2, Height - 2)
		end
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2))
	elseif self.IsHover then
		love.graphics.setColor(self.ColorHover)
		if self.Layout.Image then
			love.graphics.setStencilTest("greater", 0)
			love.graphics.draw(self.Layout.Image, 0, 0, 0, Button.Width, Button.Height/20)
			love.graphics.setStencilTest()
		else
			gui.graphics.roundedbox("fill", Radius, 1, 1, Width - 2, Height - 2)
		end
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw(math.floor((Width - self.Text:getWidth())/2), math.floor((Height - self.Text:getHeight())/2) - 1)
	else
		love.graphics.setColor(self.Color)
		if self.Layout.Image then
			love.graphics.setStencilTest("greater", 0)
			love.graphics.draw(self.Layout.Image, 0, 0, 0, Button.Width, Button.Height/20)
			love.graphics.setStencilTest()
		else
			gui.graphics.roundedbox("fill", Radius, 1, 1, Width - 2, Height - 2)
		end
		
		if self.Image then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(self.Image, math.floor((Width - self.Image:getWidth() - self.Text:getWidth())/2), math.floor((Height - self.Image:getHeight())/2))
		end
		
		self.Text:Draw((Width - self.Text:getWidth())/2, (Height - self.Text:getHeight())/2 - 1)
	end
end

return Button