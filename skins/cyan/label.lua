local Path, gui = ...
local Label = {}

Label.TextFont = love.graphics.newFont(gui.Fonts["Kanit Light"], 13)

function Label:Init()
	self.Text.Font = Label.TextFont
	self.Text.Color = {80, 80, 80, 255}
end

function Label:Render(dt)
	self.Text:Draw(0, 0)
end

return Label