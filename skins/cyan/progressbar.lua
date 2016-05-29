local Path, gui = ...
local Progress = {}

Progress.Image = love.image.newImageData(1, 20)
for y = 0, 19 do
	Progress.Image:setPixel(0, y, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19, 255 * 9/11 + 255 * (19 - y) * 2/11 * 1/19)
end
Progress.Image = love.graphics.newImage(Progress.Image)
Progress.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)

local function DrawProgress()
	if Progress.Width > 0 then
		gui.graphics.roundedbox("fill", 4, 1, 1, math.max(Progress.Width - 2, 0), Progress.Height - 2)
	end
end

function Progress:Render(dt)
	local Width, Height = self:GetDimensions()
	Progress.Width, Progress.Height = Width * self.Progress, Height
	
	love.graphics.setColor(100, 100, 100, 255)
	gui.graphics.roundedbox("line", 4, 1, 1, Width - 2, Height - 2)
	
	love.graphics.setColor(220, 220, 220, 255)
	gui.graphics.roundedbox("fill", 4, 1, 1, Width - 2, Height - 2)
	
	love.graphics.stencil(DrawProgress)
	love.graphics.setStencilTest("greater", 0)
	
	love.graphics.setColor(80, 180, 255, 255)
	love.graphics.draw(Progress.Image, 1, 1, 0, (Width - 2), (Height - 2)/20)
	love.graphics.setStencilTest()
	
	love.graphics.setColor(80, 80, 80, 255)
	love.graphics.setFont(Progress.TextFont)
	
	local Text = (self.Progress * 100).." %"
	love.graphics.print(Text,  math.floor((Width - Progress.TextFont:getWidth(Text))/2), math.floor((Height - Progress.TextFont:getHeight(Text))/2))
end

return Progress