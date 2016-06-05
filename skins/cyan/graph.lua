local Path, gui = ...
local Graph = {}

Graph.BorderColor = {80, 80, 80, 255}
Graph.BackgroundColor = {255, 255, 255, 255}

function Graph:Init()
	self.Layout.BorderColor = Graph.BorderColor
	self.Layout.BackgroundColor = Graph.BackgroundColor
end

function Graph:Render()
	local Width, Height = self:GetDimensions()
	
	love.graphics.setColor(self.Layout.BorderColor)
	love.graphics.rectangle("line", 0, 0, Width, Height)
	
	love.graphics.setColor(self.Layout.BackgroundColor)
	love.graphics.rectangle("fill", 1, 1, Width - 2, Height - 2)
	
	for _, Curve in pairs(self.Curve) do
		love.graphics.setColor(Curve.Color)

		local Success, Points = pcall(Curve.BezierCurve.render, Curve.BezierCurve, math.min(Width, Curve.BezierCurve:getControlPointCount()))
		if Success then
			love.graphics.translate(-Points[1], 0)
			love.graphics.line(Points)
		end
	end
	love.graphics.translate(0, 0)
end

return Graph